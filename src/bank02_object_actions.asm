; Object Action jump tables (one for each object)
data_02_4ddb:                        ;; Object_CollectibleSpawn
    dw   call_02_51b7, data_02_7cce
data_02_4ddf:                        ;; Object_TVButton
    dw   call_02_51ea, data_02_7945
    dw   call_02_5252, data_02_794b
data_02_4de7:                        ;; Object_RedRemote
    dw   $5253, data_02_7690
    dw   $526a, data_02_769d
data_02_4def:                        ;; Object_SilverRemote
    dw   $5284, data_02_769d
    dw   $528d, data_02_769d
data_02_4df7:                        ;; Object_GoldRemote
    dw   $528e, data_02_76a8
    dw   $5297, data_02_769d
data_02_4dff:                        ;; Object_unk_02
    dw   $52aa, data_02_768a
data_02_4e03:                        ;; Object_EnemyDefeated
    dw   $52ab, data_02_7cd4
data_02_4e07:                        ;; Object_unk_08
    dw   $52e7, data_02_76b5
data_02_4e0b:                        ;; Object_ScreamTV_FallingPlatform
    dw   $52e8, data_02_7963
data_02_4e0f:                        ;; Object_ScreamTV_MovingPlatform
    dw   $5348, data_02_7969
data_02_4e13:                        ;; Object_ScreamTV_PushBlock
    dw   $5373, data_02_796f
data_02_4e17:                        ;; Object_ScreamTV_Pumpkin
    dw   $538b, data_02_76b5
    dw   $5399, data_02_76bf
data_02_4e1f:                        ;; Object_ScreamTV_Frankie
    dw   $53aa, data_02_76c7
data_02_4e23:                        ;; Object_ScreamTV_HeadGhost
    dw   $53ad, data_02_7920
    dw   $53d9, data_02_792d
data_02_4e2b:                        ;; Object_ScreamTV_HeadGhostHead
    dw   $53e2, data_02_7933
data_02_4e2f:                        ;; Object_ScreamTV_FloatingSkull
    dw   $5434, data_02_76d0
    dw   $5440, data_02_76d9
    dw   $545b, data_02_76df
data_02_4e3b:                        ;; Object_ScreamTV_FloatingSkullProjectile
    dw   $5464, data_02_7b0f
    dw   $546e, data_02_7ce6
data_02_4e43:                        ;; Object_ScreamTV_Zombie
    dw   $5480, data_02_76e5
    dw   $5480, data_02_76ee
    dw   $54b4, data_02_76f7
data_02_4e4f:                        ;; Object_ScreamTV_ZombieHead
    dw   $54c6, data_02_768a
    dw   $54df, data_02_768a
    dw   $54fc, data_02_768a
data_02_4e5b:                        ;; Object_ScreamTV_FallingAxe
    dw   $54ff, data_02_7939
    dw   $5513, data_02_7939
    dw   $552c, data_02_793f
    dw   $5535, data_02_7939
data_02_4e6b:                        ;; Object_ScreamTV_Lantern
    dw   $5544, data_02_7951
    dw   $5551, data_02_7957
data_02_4e73:                        ;; Object_ScreamTV_Bat
    dw   $557c, data_02_76fd
data_02_4e77:                        ;; Object_ScreamTV_OrangeMovingPlatform
    dw   $5589, data_02_7975
data_02_4e7b:                        ;; Object_ScreamTV_DoorOpening
    dw   $559b, data_02_7706
    dw   $559c, data_02_770f
data_02_4e83:                        ;; Object_ScreamTV_Ghost
    dw   $55a3, data_02_7718
    dw   $55e8, data_02_7722
    dw   $55f1, data_02_772c
    dw   $5612, data_02_7733
data_02_4e93:                        ;; Object_ScreamTV_ClimbWallSunEnemy
    dw   $5628, data_02_795d
data_02_4e97:                        ;; Object_ScreamTV_VanishingPlatform
    dw   $563a, data_02_797b
    dw   $5652, data_02_797b
    dw   $56a1, data_02_7981
data_02_4ea3:                        ;; Object_ScreamTV_MonaLisaElevator
    dw   $56af, data_02_7987
data_02_4ea7:                        ;; Object_ToonTV_HardHeadAreaObject
    dw   $56dc, data_02_798d
    dw   $576e, data_02_7993
    dw   $576e, data_02_7999
data_02_4eb3:                        ;; Object_ToonTV_StationaryBearTrap
    dw   $57f3, data_02_79a6
    dw   $5803, data_02_79ac
data_02_4ebb:                        ;; Object_ToonTV_MovingBearTrap
    dw   $5812, data_02_79b3
    dw   $5830, data_02_79b9
data_02_4ec3:                        ;; Object_ToonTV_Bumblebee
    dw   $5843, data_02_799f
    dw   $585e, data_02_799f
data_02_4ecb:                        ;; Object_ToonTV_FallingBowlingBall
    dw   $5871, data_02_79c5
data_02_4ecf:                        ;; Object_ToonTV_Cactus
    dw   $58d3, data_02_79d6
    dw   $58e8, data_02_79dc
    dw   $58fa, data_02_79e3
data_02_4edb:                        ;; Object_ToonTV_Domino
    dw   $590b, data_02_79e9
data_02_4edf:                        ;; Object_ToonTV_Shark
    dw   $591c, data_02_79ef
data_02_4ee3:                        ;; Object_ToonTV_Flower
    dw   $592d, data_02_79f6
    dw   $592d, data_02_79fc
    dw   $592d, data_02_7a02
data_02_4eef:                        ;; Object_ToonTV_Hunter
    dw   $5993, data_02_774c
    dw   $59c8, data_02_7759
    dw   $59d2, data_02_7768
    dw   $59db, data_02_777c
    dw   $59e4, data_02_7784
    dw   $59ed, data_02_778a
data_02_4f07:                        ;; Object_ToonTV_Mushroom
    dw   $5a28, data_02_7a1b
data_02_4f0b:                        ;; Object_unk_28
    dw   $5a73, data_02_7a21
data_02_4f0f:                        ;; Object_ToonTV_Lizard
    dw   $5a7d, data_02_7a3a
data_02_4f13:                        ;; Object_ToonTV_HappyFace
    dw   $5a8c, data_02_773a
    dw   $5a9a, data_02_7744
data_02_4f1b:                        ;; Object_ToonTV_VanishingBlock
    dw   $5aab, data_02_7a45
    dw   $5aea, data_02_7a45
    dw   $5b39, data_02_7a4b
data_02_4f27:                        ;; Object_ToonTV_MovingBlock
    dw   $5b47, data_02_7a51
    dw   $5b9d, data_02_7a51
data_02_4f2f:                        ;; Object_ToonTV_MovingLogPlatform
    dw   $5bb6, data_02_7a2e
data_02_4f33:                        ;; Object_ToonTV_StationaryLogPlatform
    dw   $5be1, data_02_7a34
data_02_4f37:                        ;; Object_ToonTV_FlowerHammerAttack
    dw   $596c, data_02_7a08
    dw   $597a, data_02_7a0e
    dw   $598c, data_02_7a15
data_02_4f43:                        ;; Object_ToonTV_HunterBullet
    dw   $5a10, data_02_79d0
    dw   $5a1f, data_02_79d0
data_02_4f4b:                        ;; Object_ToonTV_Rocket
    dw   $5be2, data_02_7c7b
    dw   $5bf7, data_02_7c81
    dw   $5c00, data_02_7c9a
data_02_4f57:                        ;; Object_PreHistory_FastDinosaur
    dw   $5c08, data_02_7790
data_02_4f5b:                        ;; Object_PreHistory_Dragonfly
    dw   $5c10, data_02_77a7
data_02_4f5f:                        ;; Object_PreHistory_Egg
    dw   $5c18, data_02_77d5
    dw   $5c47, data_02_77e2
    dw   $5c5b, data_02_77ea
data_02_4f6b:                        ;; Object_unk_35
    dw   $5c69, data_02_7a62
    dw   $5c73, data_02_7a68
data_02_4f73:                        ;; Object_unk_36
    dw   $5c7c, data_02_7a57
data_02_4f77:                        ;; Object_PreHistory_FallingLava
    dw   $5c7d, data_02_7a73
    dw   $5c9c, data_02_7a79
data_02_4f7f:                        ;; Object_PreHistory_LavaRaft
    dw   $5ca8, data_02_7a84
    dw   $5cba, data_02_7a8a
data_02_4f87:                        ;; Object_PreHistory_MovingPlatform
    dw   $5cbb, data_02_7a90
data_02_4f8b:                        ;; Object_unk_3A
    dw   $5ccd, data_02_7a96
data_02_4f8f:                        ;; Object_unk_3B
    dw   $5cce, data_02_7a9c
data_02_4f93:                        ;; Object_PreHistory_Pterosaur
    dw   $5ccf, data_02_77b2
data_02_4f97:                        ;; Object_unk_3D
    dw   $5d0b, data_02_7aa8
data_02_4f9b:                        ;; Object_PreHistory_FallingBoulder
    dw   $5d0c, data_02_7aae
    dw   $5d37, data_02_7ab4
    dw   $5d48, data_02_7aba
    dw   $5d5b, data_02_7cda
data_02_4fab:                        ;; Object_unk_3F
    dw   $5d6f, data_02_7790
data_02_4faf:                        ;; Object_PreHistory_BeetleHorizontal
    dw   $5d81, data_02_7ac1
data_02_4fb3:                        ;; Object_PreHistory_BeetleVertical
    dw   $5d70, data_02_7ac8
data_02_4fb7:                        ;; Object_PreHistory_Ant
    dw   $5d81, data_02_7acf
data_02_4fbb:                        ;; Object_PreHistory_FirePlant
    dw   $5d92, data_02_7aef
    dw   $5db2, data_02_7af8
    dw   $5dd3, data_02_7b01
data_02_4fc7:                        ;; Object_PreHistory_FirePlantProjectiles
    dw   $5ddc, data_02_7b08
    dw   $5de6, data_02_7ce0
data_02_4fcf:                        ;; Object_PreHistory_Geyser
    dw   $5df8, data_02_7ad8
    dw   $5e02, data_02_7ade
data_02_4fd7:                        ;; Object_unk_46
    dw   $5e0b, data_02_7aa2
data_02_4fdb:                        ;; Object_PreHistory_Dinosaur
    dw   $5e0c, data_02_77bd
data_02_4fdf:                        ;; Object_PreHistory_Triceratops
    dw   $5e26, data_02_77ca
data_02_4fe3:                        ;; Object_PreHistory_TriceratopsHorn
    dw   $5e90, data_02_7ae9
data_02_4fe7:                        ;; Object_unk_4A
    dw   $5e91, data_02_7790
data_02_4feb:                        ;; Object_KungFuTheater_HangingBlade
    dw   $5e92, data_02_7b15
data_02_4fef:                        ;; Object_KungFuTheater_Cannon
    dw   $5ebd, data_02_7b1b
data_02_4ff3:                        ;; Object_KungFuTheater_CannonProjectile
    dw   $5ef0, data_02_7b21
    dw   $5efa, data_02_7b21
data_02_4ffb:                        ;; Object_KungFuTheater_Dragonfly
    dw   $5f48, data_02_77f2
data_02_4fff:                        ;; Object_KungFuTheater_DragonBodySegment
    dw   $5f50, data_02_7b27
data_02_5003:                        ;; Object_KungFuTheater_DragonHead
    dw   $5f67, data_02_7824
data_02_5007:                        ;; Object_unk_51
    dw   $616d, data_02_7b2d
data_02_500b:                        ;; Object_KungFuTheater_DragonProjectile
    dw   $6152, data_02_7b39
    dw   $615f, data_02_7b39
data_02_5013:                        ;; Object_KungFuTheater_WalkingNinja
    dw   $616e, data_02_77fd
    dw   $6213, data_02_7806
    dw   $621c, data_02_7815
data_02_501f:                        ;; Object_KungFuTheater_JumpingNinja
    dw   $616e, data_02_77fd
    dw   $6213, data_02_7806
    dw   $621c, data_02_7815
    dw   $6235, data_02_781e
data_02_502f:                        ;; Object_KungFuTheater_SamuraiBody
    dw   $624c, data_02_782a
    dw   $62c3, data_02_7837
data_02_5037:                        ;; Object_KungFuTheater_SamuraiHead
    dw   $62db, data_02_7b6c
    dw   $62fc, data_02_7b6c
    dw   $6327, data_02_7b72
data_02_5043:                        ;; Object_KungFuTheater_Lizard
    dw   $6335, data_02_7b7a
data_02_5047:                        ;; Object_KungFuTheater_NinjaProjectile
    dw   $633d, data_02_7b85
    dw   $6347, data_02_7b85
data_02_504f:                        ;; Object_KungFuTheater_SpikyLog
    dw   $6355, data_02_7b8c
data_02_5053:                        ;; Object_KungFuTheater_TallJar
    dw   $635d, data_02_7b92
    dw   $6375, data_02_7cec
data_02_505b:                        ;; Object_KungFuTheater_Jar
    dw   $635d, data_02_7b92
    dw   $6375, data_02_7cec
data_02_5063:                        ;; Object_unk_5C
    dw   $6387, data_02_7b98
data_02_5067:                        ;; Object_unk_5D
    dw   $6388, data_02_7b98
data_02_506b:                        ;; Object_KungFuTheater_VanishingPlatform
    dw   $6388, data_02_7b42
    dw   $63ac, data_02_7b42
    dw   $63fb, data_02_7b48
data_02_5077:                        ;; Object_KungFuTheater_MovingPlatform
    dw   $6409, data_02_7b4e
data_02_507b:                        ;; Object_unk_60
    dw   $6434, data_02_7b54
data_02_507f:                        ;; Object_KungFuTheater_MovingRaft
    dw   $6435, data_02_7b5a
data_02_5083:                        ;; Object_KungFuTheater_StationaryRaft
    dw   $6447, data_02_7b60
data_02_5087:                        ;; Object_unk_63
    dw   $6448, data_02_7b66
data_02_508b:                        ;; Object_unk_64
    dw   $6449, data_02_7b98
data_02_508f:                        ;; Object_Rezopolis_SpecialMovingPlatform
    dw   $644a, data_02_7b98
data_02_5093:                        ;; Object_Rezopolis_MovingPlatform
    dw   $649c, data_02_7b9e
data_02_5097:                        ;; Object_Rezopolis_RedPlatform
    dw   $64ae, data_02_7ba4
data_02_509b:                        ;; Object_Rezopolis_ActivatedRedPlatform
    dw   $650f, data_02_7ba4
data_02_509f:                        ;; Object_Rezopolis_TailspinPlatform
    dw   $655d, data_02_7baa
data_02_50a3:                        ;; Object_Rezopolis_TailspinGear
    dw   $65b7, data_02_7bbd
    dw   $65c0, data_02_7bc3
    dw   $65c9, data_02_7bcc
    dw   $65d2, data_02_7bd5
    dw   $65db, data_02_7bde
data_02_50b7:                        ;; Object_unk_6B
    dw   $6626, data_02_7790
data_02_50bb:                        ;; Object_unk_6C
    dw   $6627, data_02_7bb0
data_02_50bf:                        ;; Object_unk_6D
    dw   $6628, data_02_7bb0
data_02_50c3:                        ;; Object_Rezopolis_GreenMonster
    dw   $6629, data_02_7865
    dw   $6632, data_02_7872
    dw   $6633, data_02_7879
data_02_50cf:                        ;; Object_unk_6F
    dw   $6634, data_02_7bf0
data_02_50d3:                        ;; Object_unk_70
    dw   $6635, data_02_7bf0
data_02_50d7:                        ;; Object_Rezopolis_Pincer
    dw   $6636, data_02_7880
data_02_50db:                        ;; Object_Rezopolis_Flamethrower
    dw   $664b, data_02_7bb0
    dw   $664c, data_02_7bb0
data_02_50e3:                        ;; Object_Rezopolis_UFO
    dw   $664d, data_02_784d
    dw   $666b, data_02_785c
data_02_50eb:                        ;; Object_Rezopolis_Ant
    dw   $66bb, data_02_7be7
data_02_50ef:                        ;; Object_Rezopolis_AntSpawner
    dw   $666c, data_02_7c6f
data_02_50f3:                        ;; Object_CircuitCentral_Ant
    dw   $66db, data_02_7bf0
data_02_50f7:                        ;; Object_CircuitCentral_Capacitor
    dw   $66e3, data_02_7bf9
    dw   $66f1, data_02_7c01
data_02_50ff:                        ;; Object_CircuitCentral_PowerUp
    dw   $66fd, data_02_7c07
    dw   $6710, data_02_7c07
data_02_5107:                        ;; Object_unk_79
    dw   $6723, data_02_7790
data_02_510b:                        ;; Object_CircuitCentral_LittleRobot
    dw   $6724, data_02_7c10
    dw   $676c, data_02_7c16
data_02_5113:                        ;; Object_CircuitCentral_LittleRobotGear
    dw   $6775, data_02_7c1d
data_02_5117:                        ;; Object_CircuitCentral_ElectricBall
    dw   $6786, data_02_7c25
    dw   $679e, data_02_7c2b
data_02_511f:                        ;; Object_CircuitCentral_MovingPlatform
    dw   $68c0, data_02_7c42
data_02_5123:                        ;; Object_CircuitCentral_PoweredPlaform
    dw   $696f, data_02_7c34
    dw   $6993, data_02_7c3a
    dw   $69c4, data_02_7c48
data_02_512f:                        ;; Object_CircuitCentral_LoweringPlatform
    dw   $69d7, data_02_7c50
data_02_5133:                        ;; Object_CircuitCentral_WalkerRobot
    dw   $6a33, data_02_7889
data_02_5137:                        ;; Object_CircuitCentral_PoweredWalkway
    dw   $6a3b, data_02_7c56
data_02_513b:                        ;; Object_CircuitCentral_WalkwayActivator
    dw   $6a3c, data_02_7c5c
data_02_513f:                        ;; Object_ChannelZ_ArcedGunProjectile
    dw   $6a8b, data_02_7c62
    dw   $6aac, data_02_7c68
data_02_5147:                        ;; Object_ChannelZ_ArcedGunProjectile2
    dw   $6ad3, data_02_7c62
    dw   $6af9, data_02_7c68
    dw   $6b30, data_02_7c68
    dw   $6b43, data_02_7c68
data_02_5157:                        ;; Object_ChannelZ_GunProjectile
    dw   $6b6a, data_02_7c62
    dw   $6b81, data_02_7c68
data_02_515f:                        ;; Object_ChannelZ_Rez
    dw   $6c18, data_02_78a8
    dw   $6c41, data_02_78b5
    dw   $6c4a, data_02_78d7
    dw   $6c42, data_02_78e4
    dw   $6c82, data_02_78c2
    dw   $6c99, data_02_78f1
    dw   $6c99, data_02_78f1
    dw   $6c99, data_02_78f1
    dw   $6c99, data_02_78f1
    dw   $6c9d, data_02_78fc
    dw   $6ca6, data_02_790b
data_02_518b:                        ;; Object_unk_87
    dw   $6d11, data_02_7c75
data_02_518f:                        ;; Object_unk_88
    dw   $6d23, data_02_7c75
data_02_5193:                        ;; Object_ChannelZ_RezFollowingFire
    dw   $6cca, data_02_7ca1
data_02_5197:                        ;; Object_ChannelZ_GunProjectileExplosion
    dw   $6d24, data_02_7caa
data_02_519b:                        ;; Object_unk_8B
    dw   $6d5d, data_02_7cb6
    dw   $6d7f, data_02_7cb6
data_02_51a3:                        ;; Object_ChannelZ_FinalBattleButton
    dw   $6d80, data_02_7cbc
    dw   $6db8, data_02_7cc2
data_02_51ab:                        ;; Object_unk_8D
    dw   $6de3, data_02_7894
data_02_51af:                        ;; Object_unk_8E
    dw   $6df0, data_02_791a
data_02_51b3:                        ;; Object_MediaDimension_MovingPlatform
    dw   call_02_6df1, data_02_7cc8

call_02_51b7:
    call call_00_3b8d                                  ;; 02:51b7 $cd $8d $3b
    push AF                                            ;; 02:51ba $f5
    ld   [wD59D_ReturnBank], A                                    ;; 02:51bb $ea $9d $d5
    ld   A, Bank03                                        ;; 02:51be $3e $03
    ld   HL, entry_03_6584                              ;; 02:51c0 $21 $84 $65
    call call_00_1078_CallAltBankFunc                                  ;; 02:51c3 $cd $78 $10
    jr   NZ, .jr_02_51cc                               ;; 02:51c6 $20 $04
    pop  AF                                            ;; 02:51c8 $f1
    jp   call_00_3931                                    ;; 02:51c9 $c3 $31 $39
.jr_02_51cc:
    pop  AF                                            ;; 02:51cc $f1
    ret  NZ                                            ;; 02:51cd $c0
    ld   H, $d2                                        ;; 02:51ce $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:51d0 $fa $00 $d3
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

call_02_51ea:
    call call_00_3878                                  ;; 02:51ea $cd $78 $38
    ld   E, A                                          ;; 02:51ed $5f
    ld   H, $d2                                        ;; 02:51ee $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:51f0 $fa $00 $d3
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
    call call_02_7102_SetObjectAction                                  ;; 02:5229 $cd $02 $71
    ld   A, [wD624_CurrentLevelId]                                    ;; 02:522c $fa $24 $d6
    and  A, A                                          ;; 02:522f $a7
    jr   NZ, .jr_02_524d                               ;; 02:5230 $20 $1b
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5232 $fa $00 $d3
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
call_02_5252:
    ret                                                ;; 02:5252 $c9

call_02_5253:
    call call_00_34ea                                  ;; 02:5253 $cd $ea $34
    call NZ, call_00_3bf4                              ;; 02:5256 $c4 $f4 $3b
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:5259 $21 $0f $d6
    bit  4, [HL]                                       ;; 02:525c $cb $66
    call Z, call_00_0634                               ;; 02:525e $cc $34 $06
    ld   A, [wD59E]                                    ;; 02:5261 $fa $9e $d5
    and  A, A                                          ;; 02:5264 $a7
    ld   A, $01                                        ;; 02:5265 $3e $01
    call NZ, call_02_7102_SetObjectAction                              ;; 02:5267 $c4 $02 $71
call_02_526a:
    call call_00_38c1                                  ;; 02:526a $cd $c1 $38
    ld   E, A                                          ;; 02:526d $5f
    ld   H, $d2                                        ;; 02:526e $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5270 $fa $00 $d3
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
    db   $fa, $9e, $d5, $a7, $3e, $01, $c4, $02        ;; 02:5284 ????????
    db   $71, $c9, $fa, $9e, $d5, $a7, $3e, $01        ;; 02:528c ????????
    db   $c4, $02, $71, $fa, $49, $d6, $a7, $c2        ;; 02:5294 ????????
    db   $31, $39, $fa, $3b, $d7, $e6, $1f, $c0        ;; 02:529c ????????
    db   $0e, $04, $cd, $2f, $11, $c9, $c9             ;; 02:52a4 ???????

call_02_52ab:
    call call_00_3b8d                                  ;; 02:52ab $cd $8d $3b
    jr   Z, .jr_02_52bc                                ;; 02:52ae $28 $0c
    ld   [wD59D_ReturnBank], A                                    ;; 02:52b0 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:52b3 $3e $03
    ld   HL, entry_03_65f9                              ;; 02:52b5 $21 $f9 $65
    call call_00_1078_CallAltBankFunc                                  ;; 02:52b8 $cd $78 $10
    ret  NZ                                            ;; 02:52bb $c0
.jr_02_52bc:
    ld   C, $01                                        ;; 02:52bc $0e $01
    call call_00_37e7                                  ;; 02:52be $cd $e7 $37
    ld   H, $d2                                        ;; 02:52c1 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:52c3 $fa $00 $d3
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
    jp   call_02_7102_SetObjectAction                                  ;; 02:52e4 $c3 $02 $71
    db   $c9, $cd, $f5, $34, $cb, $46, $20, $10        ;; 02:52e7 ????????
    db   $cb, $4e, $20, $30, $cb, $40, $c8, $cb        ;; 02:52ef ????????
    db   $c6, $2c, $3e, $64, $22, $2a, $77, $c9        ;; 02:52f7 ????????
    db   $2c, $7e, $a7, $28, $08, $35, $c0, $0e        ;; 02:52ff ????????
    db   $27, $cd, $2f, $11, $c9, $2c, $2c, $7e        ;; 02:5307 ????????
    db   $a7, $20, $0a, $2d, $2d, $36, $fa, $2d        ;; 02:530f ????????
    db   $cb, $86, $cb, $ce, $c9, $35, $01, $02        ;; 02:5317 ????????
    db   $00, $c3, $d8, $37, $cb, $40, $28, $08        ;; 02:531f ????????
    db   $cb, $8e, $cb, $c6, $2c, $36, $00, $c9        ;; 02:5327 ????????
    db   $2c, $7e, $a7, $28, $02, $35, $c9, $2c        ;; 02:532f ????????
    db   $2a, $be, $20, $06, $2d, $2d, $2d, $36        ;; 02:5337 ????????
    db   $00, $c9, $34, $01, $fe, $ff, $c3, $d8        ;; 02:533f ????????
    db   $37                                           ;; 02:5347 ?
call_02_5348:
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
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5356 $fa $00 $d3
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
    db   $26, $d2, $fa, $00, $d3, $f6, $0e, $6f        ;; 02:5373 ????????
    db   $2a, $d6, $a0, $7e, $de, $02, $d0, $21        ;; 02:537b ????????
    db   $8b, $d7, $7e, $a7, $c0, $36, $02, $c9        ;; 02:5383 ????????
call_02_538b:
    call call_00_3843                                  ;; 02:538b $cd $43 $38
    ret  Z                                             ;; 02:538e $c8
    ld   C, $28                                        ;; 02:538f $0e $28
    call call_00_335a                                  ;; 02:5391 $cd $5a $33
    ld   A, $01                                        ;; 02:5394 $3e $01
    jp   call_02_7102_SetObjectAction                                  ;; 02:5396 $c3 $02 $71
call_02_5399:
    call call_00_30af                                  ;; 02:5399 $cd $af $30
    call call_00_3154                                  ;; 02:539c $cd $54 $31
    ret  C                                             ;; 02:539f $d8
    ld   C, $24                                        ;; 02:53a0 $0e $24
    call call_00_112f                                  ;; 02:53a2 $cd $2f $11
    ld   A, $00                                        ;; 02:53a5 $3e $00
    jp   call_02_7102_SetObjectAction                                  ;; 02:53a7 $c3 $02 $71
    db   $c3, $64, $33, $cd, $ea, $34, $28, $11        ;; 02:53aa ????????
    db   $7d, $ee, $10, $6f, $0e, $00, $cb, $46        ;; 02:53b2 ????????
    db   $28, $02, $0e, $20, $7d, $ee, $14, $6f        ;; 02:53ba ????????
    db   $71, $cd, $43, $38, $c8, $0e, $00, $ea        ;; 02:53c2 ????????
    db   $9d, $d5, $3e, $0a, $21, $9a, $7b, $cd        ;; 02:53ca ????????
    db   $78, $10, $3e, $01, $c3, $02, $71, $cd        ;; 02:53d2 ????????
    db   $43, $38, $3e, $00, $c4, $02, $71, $c9        ;; 02:53da ????????
    db   $0e, $01, $cd, $50, $33, $cd, $42, $34        ;; 02:53e2 ????????
    db   $cd, $af, $30, $26, $d2, $fa, $00, $d3        ;; 02:53ea ????????
    db   $f6, $18, $6f, $5e, $2c, $56, $2c, $2a        ;; 02:53f2 ????????
    db   $c6, $10, $4f, $7e, $ce, $00, $47, $7d        ;; 02:53fa ????????
    db   $ee, $16, $6f, $cb, $6e, $28, $0e, $7d        ;; 02:5402 ????????
    db   $ee, $03, $6f, $7b, $96, $5f, $23, $7a        ;; 02:540a ????????
    db   $9e, $57, $23, $18, $0a, $7d, $ee, $03        ;; 02:5412 ????????
    db   $6f, $2a, $93, $5f, $2a, $9a, $57, $79        ;; 02:541a ????????
    db   $83, $4f, $78, $8a, $47, $2a, $91, $7e        ;; 02:5422 ????????
    db   $98, $d8, $70, $2d, $71, $0e, $28, $c3        ;; 02:542a ????????
    db   $5a, $33, $cd, $43, $38, $c8, $cd, $bd        ;; 02:5432 ????????
    db   $36, $3e, $01, $c3, $02, $71, $cd, $43        ;; 02:543a ????????
    db   $38, $c8, $0e, $34, $cd, $2f, $11, $0e        ;; 02:5442 ????????
    db   $01, $ea, $9d, $d5, $3e, $0a, $21, $9a        ;; 02:544a ????????
    db   $7b, $cd, $78, $10, $3e, $02, $c3, $02        ;; 02:5452 ????????
    db   $71, $cd, $43, $38, $3e, $00, $c2, $02        ;; 02:545a ????????
    db   $71, $c9, $0e, $06, $cd, $23, $3a, $3e        ;; 02:5462 ????????
    db   $01, $c3, $02, $71, $cd, $8d, $3b, $ca        ;; 02:546a ????????
    db   $31, $39, $ea, $9d, $d5, $3e, $03, $21        ;; 02:5472 ????????
    db   $49, $65, $cd, $78, $10, $c9, $26, $d2        ;; 02:547a ????????
    db   $fa, $00, $d3, $f6, $1a, $6f, $36, $02        ;; 02:5482 ????????
    db   $2c, $2c, $36, $01, $7d, $ee, $0b, $6f        ;; 02:548a ????????
    db   $cb, $46, $ca, $64, $33, $7d, $ee, $16        ;; 02:5492 ????????
    db   $6f, $7e, $e6, $1f, $fe, $00, $20, $0d        ;; 02:549a ????????
    db   $0e, $02, $ea, $9d, $d5, $3e, $0a, $21        ;; 02:54a2 ????????
    db   $9a, $7b, $cd, $78, $10, $3e, $02, $c3        ;; 02:54aa ????????
    db   $02, $71, $26, $d2, $fa, $00, $d3, $f6        ;; 02:54b2 ????????
    db   $18, $6f, $35, $c0, $2d, $cb, $86, $3e        ;; 02:54ba ????????
    db   $01, $c3, $02, $71, $0e, $28, $cd, $5a        ;; 02:54c2 ????????
    db   $33, $0e, $03, $cd, $02, $38, $26, $d2        ;; 02:54ca ????????
    db   $fa, $00, $d3, $f6, $0d, $6f, $36, $00        ;; 02:54d2 ????????
    db   $3e, $01, $c3, $02, $71, $cd, $af, $30        ;; 02:54da ????????
    db   $cd, $37, $31, $d8, $cd, $17, $38, $3e        ;; 02:54e2 ????????
    db   $02, $ca, $02, $71, $6e, $26, $00, $11        ;; 02:54ea ????????
    db   $f9, $54, $19, $4e, $c3, $5a, $33, $00        ;; 02:54f2 ????????
    db   $0a, $14, $c3, $bd, $36, $26, $d2, $fa        ;; 02:54fa ????????
    db   $00, $d3, $f6, $19, $6f, $fa, $3b, $d7        ;; 02:5502 ????????
    db   $e6, $7f, $be, $3e, $01, $ca, $02, $71        ;; 02:550a ????????
    db   $c9, $01, $02, $00, $cd, $d8, $37, $26        ;; 02:5512 ????????
    db   $d2, $fa, $00, $d3, $f6, $18, $6f, $34        ;; 02:551a ????????
    db   $34, $7e, $fe, $24, $c0, $3e, $02, $c3        ;; 02:5522 ????????
    db   $02, $71, $cd, $43, $38, $3e, $03, $c2        ;; 02:552a ????????
    db   $02, $71, $c9, $01, $ff, $ff, $cd, $d8        ;; 02:5532 ????????
    db   $37, $cd, $17, $38, $3e, $00, $ca, $02        ;; 02:553a ????????
    db   $71, $c9, $cd, $5e, $55, $fa, $57, $d7        ;; 02:5542 ????????
    db   $a7, $c0, $3e, $01, $c3, $02, $71, $cd        ;; 02:554a ????????
    db   $5e, $55, $fa, $57, $d7, $a7, $c8, $3e        ;; 02:5552 ????????
    db   $00, $c3, $02, $71, $26, $d2, $fa, $00        ;; 02:555a ????????
    db   $d3, $f6, $18, $6f, $34, $7e, $e6, $01        ;; 02:5562 ????????
    db   $c0, $cb, $56, $c8, $01, $01, $00, $cb        ;; 02:556a ????????
    db   $5e, $ca, $d8, $37, $01, $ff, $ff, $c3        ;; 02:5572 ????????
    db   $d8, $37, $26, $d2, $fa, $00, $d3, $f6        ;; 02:557a ????????
    db   $1c, $6f, $36, $01, $c3, $64, $33, $cd        ;; 02:5582 ????????
    db   $ea, $34, $28, $07, $7d, $ee, $10, $6f        ;; 02:558a ????????
    db   $3a, $2d, $77, $cd, $59, $35, $c3, $8d        ;; 02:5592 ????????
    db   $31, $c9, $cd, $43, $38, $c4, $31, $39        ;; 02:559a ????????
    db   $c9, $cd, $43, $38, $c8, $26, $d2, $3e        ;; 02:55a2 ????????
    db   $20, $6f, $7e, $fe, $15, $28, $08, $7d        ;; 02:55aa ????????
    db   $c6, $20, $20, $f5, $c3, $10, $39, $7d        ;; 02:55b2 ????????
    db   $f6, $0e, $6f, $54, $fa, $00, $d3, $f6        ;; 02:55ba ????????
    db   $0e, $5f, $01, $30, $00, $fa, $0d, $d2        ;; 02:55c2 ????????
    db   $cb, $6f, $28, $03, $01, $d0, $ff, $2a        ;; 02:55ca ????????
    db   $81, $12, $1c, $2a, $88, $12, $1c, $2a        ;; 02:55d2 ????????
    db   $c6, $38, $12, $1c, $2a, $ce, $00, $12        ;; 02:55da ????????
    db   $1c, $3e, $01, $c3, $02, $71, $cd, $43        ;; 02:55e2 ????????
    db   $38, $c8, $3e, $02, $c3, $02, $71, $fa        ;; 02:55ea ????????
    db   $57, $d7, $a7, $20, $11, $26, $d2, $fa        ;; 02:55f2 ????????
    db   $00, $d3, $b5, $6f, $cb, $46, $c8, $cb        ;; 02:55fa ????????
    db   $86, $3e, $00, $c3, $02, $71, $0e, $00        ;; 02:5602 ????????
    db   $cd, $50, $33, $3e, $03, $c3, $02, $71        ;; 02:560a ????????
    db   $fa, $57, $d7, $a7, $28, $0b, $cd, $31        ;; 02:5612 ????????
    db   $35, $38, $06, $cd, $bd, $36, $c3, $51        ;; 02:561a ????????
    db   $32, $3e, $00, $c3, $02, $71, $cd, $ea        ;; 02:5622 ????????
    db   $34, $28, $07, $7d, $ee, $10, $6f, $3a        ;; 02:562a ????????
    db   $2d, $77, $cd, $59, $35, $c3, $8d, $31        ;; 02:5632 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $1b, $6f        ;; 02:563a ????????
    db   $fa, $3b, $d7, $be, $c0, $7d, $ee, $03        ;; 02:5642 ????????
    db   $6f, $36, $40, $3e, $01, $c3, $02, $71        ;; 02:564a ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $18, $6f        ;; 02:5652 ????????
    db   $35, $4e, $7d, $ee, $12, $6f, $cb, $9e        ;; 02:565a ????????
    db   $79, $a7, $28, $21, $fe, $40, $d0, $e5        ;; 02:5662 ????????
    db   $cb, $3f, $cb, $3f, $cb, $3f, $5f, $16        ;; 02:566a ????????
    db   $00, $21, $91, $56, $19, $46, $79, $e6        ;; 02:5672 ????????
    db   $07, $5f, $21, $99, $56, $19, $7e, $e1        ;; 02:567a ????????
    db   $a0, $c0, $cb, $de, $c9, $0e, $00, $cd        ;; 02:5682 ????????
    db   $2f, $38, $3e, $02, $c3, $02, $71, $00        ;; 02:568a ????????
    db   $01, $11, $11, $55, $55, $55, $ff, $01        ;; 02:5692 ????????
    db   $02, $04, $08, $10, $20, $40, $80, $cd        ;; 02:569a ????????
    db   $43, $38, $c8, $0e, $10, $cd, $2f, $38        ;; 02:56a2 ????????
    db   $3e, $00, $c3, $02, $71, $cd, $ea, $34        ;; 02:56aa ????????
    db   $28, $07, $7d, $ee, $10, $6f, $3a, $2d        ;; 02:56b2 ????????
    db   $77, $fa, $8b, $d7, $a7, $c8, $cd, $59        ;; 02:56ba ????????
    db   $35, $cd, $f5, $34, $cb, $46, $20, $0f        ;; 02:56c2 ????????
    db   $cb, $40, $c8, $cb, $c6, $7e, $e6, $3f        ;; 02:56ca ????????
    db   $4f, $07, $07, $e6, $c0, $b1, $77, $c3        ;; 02:56d2 ????????
    db   $8d, $31                                      ;; 02:56da ??
call_02_56dc:
    ld   H, $d2                                        ;; 02:56dc $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:56de $fa $00 $d3
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
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:570f $fa $00 $d3
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
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5730 $fa $00 $d3
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
    call call_02_7102_SetObjectAction                                  ;; 02:5755 $cd $02 $71
    ld   C, $19                                        ;; 02:5758 $0e $19
    call call_00_112f                                  ;; 02:575a $cd $2f $11
    ret                                                ;; 02:575d $c9
.data_02_575e:
    db   $00, $00, $00, $00, $24, $00, $dc, $ff        ;; 02:575e ????????
    db   $48, $00, $b8, $ff                            ;; 02:5766 ????
.data_02_576a:
    db   $01, $02, $01, $02                            ;; 02:576a .??.
call_02_576e:
    ld   H, $d2                                        ;; 02:576e $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5770 $fa $00 $d3
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
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5788 $fa $00 $d3
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
    jp   call_02_7102_SetObjectAction                                  ;; 02:57e0 $c3 $02 $71
.data_02_57e3:
    db   $00, $01, $11, $11, $55, $55, $55, $ff        ;; 02:57e3 ........
.data_02_57eb:
    db   $01, $02, $04, $08, $10, $20, $40, $80        ;; 02:57eb ........
    db   $cd, $17, $38, $c0, $36, $ff, $0e, $24        ;; 02:57f3 ????????
    db   $cd, $5a, $33, $3e, $01, $c3, $02, $71        ;; 02:57fb ????????
    db   $cd, $af, $30, $01, $08, $00, $cd, $6e        ;; 02:5803 ????????
    db   $31, $3e, $00, $d2, $02, $71, $c9, $cd        ;; 02:580b ????????
    db   $ea, $34, $28, $05, $0e, $10, $cd, $50        ;; 02:5813 ????????
    db   $33, $cd, $af, $30, $cd, $54, $31, $cd        ;; 02:581b ????????
    db   $43, $38, $c8, $0e, $24, $cd, $5a, $33        ;; 02:5823 ????????
    db   $3e, $01, $c3, $02, $71, $cd, $af, $30        ;; 02:582b ????????
    db   $cd, $54, $31, $da, $f7, $36, $0e, $09        ;; 02:5833 ????????
    db   $cd, $5a, $33, $3e, $00, $c3, $02, $71        ;; 02:583b ????????
call_02_5843:
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
    jp   call_02_7102_SetObjectAction                                  ;; 02:585b $c3 $02 $71
    db   $0e, $20, $cd, $e1, $32, $cd, $f7, $36        ;; 02:585e ????????
    db   $0e, $40, $cd, $59, $38, $d8, $3e, $00        ;; 02:5866 ????????
    db   $c3, $02, $71, $cd, $af, $30, $26, $d2        ;; 02:586e ????????
    db   $fa, $00, $d3, $f6, $18, $6f, $e5, $cb        ;; 02:5876 ????????
    db   $7e, $c4, $f7, $36, $e1, $6e, $cb, $bd        ;; 02:587e ????????
    db   $26, $00, $29, $11, $c1, $58, $19, $4e        ;; 02:5886 ????????
    db   $23, $46, $cd, $6e, $31, $d8, $0e, $1a        ;; 02:588e ????????
    db   $cd, $2f, $11, $26, $d2, $fa, $00, $d3        ;; 02:5896 ????????
    db   $f6, $18, $6f, $35, $7e, $e6, $7f, $fe        ;; 02:589e ????????
    db   $7f, $0e, $24, $c2, $5a, $33, $34, $4e        ;; 02:58a6 ????????
    db   $7d, $ee, $08, $6f, $11, $40, $0a, $73        ;; 02:58ae ????????
    db   $2c, $72, $79, $e6, $80, $c6, $08, $4f        ;; 02:58b6 ????????
    db   $c3, $02, $38, $80, $00, $00, $00, $c0        ;; 02:58be ????????
    db   $ff, $80, $ff, $40, $ff, $00, $ff, $c0        ;; 02:58c6 ????????
    db   $fe, $80, $fe, $40, $fe                       ;; 02:58ce ?????
call_02_58d3:
    ld   C, $40                                        ;; 02:58d3 $0e $40
    call call_00_3859                                  ;; 02:58d5 $cd $59 $38
    ret  NC                                            ;; 02:58d8 $d0
    ld   A, [wD73C]                                    ;; 02:58d9 $fa $3c $d7
    and  A, $03                                        ;; 02:58dc $e6 $03
    inc  A                                             ;; 02:58de $3c
    ld   C, A                                          ;; 02:58df $4f
    call call_00_3802                                  ;; 02:58e0 $cd $02 $38
    ld   A, $01                                        ;; 02:58e3 $3e $01
    jp   call_02_7102_SetObjectAction                                  ;; 02:58e5 $c3 $02 $71
call_02_58e8:
    call call_00_3843                                  ;; 02:58e8 $cd $43 $38
    ret  Z                                             ;; 02:58eb $c8
    call call_00_3817                                  ;; 02:58ec $cd $17 $38
    ret  NZ                                            ;; 02:58ef $c0
    ld   C, $34                                        ;; 02:58f0 $0e $34
    call call_00_335a                                  ;; 02:58f2 $cd $5a $33
    ld   A, $02                                        ;; 02:58f5 $3e $02
    jp   call_02_7102_SetObjectAction                                  ;; 02:58f7 $c3 $02 $71
call_02_58fa:
    call call_00_30af                                  ;; 02:58fa $cd $af $30
    call call_00_3154                                  ;; 02:58fd $cd $54 $31
    ret  C                                             ;; 02:5900 $d8
    ld   C, $24                                        ;; 02:5901 $0e $24
    call call_00_112f                                  ;; 02:5903 $cd $2f $11
    ld   A, $00                                        ;; 02:5906 $3e $00
    jp   call_02_7102_SetObjectAction                                  ;; 02:5908 $c3 $02 $71
    db   $cd, $af, $30, $cd, $54, $31, $d8, $0e        ;; 02:590b ????????
    db   $1a, $cd, $2f, $11, $0e, $40, $c3, $5a        ;; 02:5913 ????????
    db   $33                                           ;; 02:591b ?
call_02_591c:
    ld   C, $30                                        ;; 02:591c $0e $30
    call call_00_3859                                  ;; 02:591e $cd $59 $38
    ld   C, $20                                        ;; 02:5921 $0e $20
    jr   C, .jr_02_5927                                ;; 02:5923 $38 $02
    ld   C, $08                                        ;; 02:5925 $0e $08
.jr_02_5927:
    call call_00_32e1                                  ;; 02:5927 $cd $e1 $32
    jp   call_00_36f7                                  ;; 02:592a $c3 $f7 $36
call_02_592d:
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
    call call_02_7102_SetObjectAction                                  ;; 02:5945 $cd $02 $71
    ld   H, $d2                                        ;; 02:5948 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:594a $fa $00 $d3
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
    ld   [wD59D_ReturnBank], A                                    ;; 02:5960 $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:5963 $3e $0a
    ld   HL, entry_0a_7b9a                              ;; 02:5965 $21 $9a $7b
    call call_00_1078_CallAltBankFunc                                  ;; 02:5968 $cd $78 $10
    ret                                                ;; 02:596b $c9
call_02_596c:
    call call_00_3843                                  ;; 02:596c $cd $43 $38
    ret  Z                                             ;; 02:596f $c8
    ld   C, $1c                                        ;; 02:5970 $0e $1c
    call call_00_112f                                  ;; 02:5972 $cd $2f $11
    ld   A, $01                                        ;; 02:5975 $3e $01
    jp   call_02_7102_SetObjectAction                                  ;; 02:5977 $c3 $02 $71
call_02_597a:
    call call_00_30af                                  ;; 02:597a $cd $af $30
    call call_00_30af                                  ;; 02:597d $cd $af $30
    ld   BC, $0c                                       ;; 02:5980 $01 $0c $00
    call call_00_316e                                  ;; 02:5983 $cd $6e $31
    ld   A, $02                                        ;; 02:5986 $3e $02
    jp   NC, call_02_7102_SetObjectAction                              ;; 02:5988 $d2 $02 $71
    ret                                                ;; 02:598b $c9
call_02_598c:
    call call_00_3843                                  ;; 02:598c $cd $43 $38
    jp   NZ, call_00_3910                              ;; 02:598f $c2 $10 $39
    ret                                                ;; 02:5992 $c9
    db   $cd, $ea, $34, $28, $05, $0e, $03, $cd        ;; 02:5993 ????????
    db   $02, $38, $fa, $3b, $d7, $e6, $7f, $20        ;; 02:599b ????????
    db   $1a, $cd, $bd, $36, $0e, $20, $cd, $2f        ;; 02:59a3 ????????
    db   $11, $0e, $0b, $ea, $9d, $d5, $3e, $0a        ;; 02:59ab ????????
    db   $21, $9a, $7b, $cd, $78, $10, $3e, $01        ;; 02:59b3 ????????
    db   $c3, $02, $71, $0e, $08, $cd, $e1, $32        ;; 02:59bb ????????
    db   $cd, $f7, $36, $18, $38, $cd, $43, $38        ;; 02:59c3 ????????
    db   $28, $33, $3e, $00, $c3, $02, $71, $cd        ;; 02:59cb ????????
    db   $43, $38, $3e, $03, $c2, $02, $71, $c9        ;; 02:59d3 ????????
    db   $cd, $43, $38, $3e, $04, $c2, $02, $71        ;; 02:59db ????????
    db   $c9, $cd, $43, $38, $3e, $05, $c2, $02        ;; 02:59e3 ????????
    db   $71, $c9, $cd, $43, $38, $c8, $26, $d2        ;; 02:59eb ????????
    db   $fa, $00, $d3, $f6, $17, $6f, $cb, $86        ;; 02:59f3 ????????
    db   $3e, $00, $c3, $02, $71, $26, $d2, $fa        ;; 02:59fb ????????
    db   $00, $d3, $f6, $17, $6f, $cb, $46, $c8        ;; 02:5a03 ????????
    db   $3e, $02, $c3, $02, $71, $0e, $01, $cd        ;; 02:5a0b ????????
    db   $50, $33, $0e, $5a, $cd, $02, $38, $3e        ;; 02:5a13 ????????
    db   $01, $c3, $02, $71, $cd, $17, $38, $ca        ;; 02:5a1b ????????
    db   $10, $39, $c3, $42, $34                       ;; 02:5a23 ?????
call_02_5a28:
    ld   H, $d2                                        ;; 02:5a28 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5a2a $fa $00 $d3
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
    ld   [wD59D_ReturnBank], A                                    ;; 02:5a43 $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:5a46 $3e $0a
    ld   HL, entry_0a_7b9a                              ;; 02:5a48 $21 $9a $7b
    call call_00_1078_CallAltBankFunc                                  ;; 02:5a4b $cd $78 $10
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
call_02_5a73:
    call call_00_30af                                  ;; 02:5a73 $cd $af $30
    call call_00_3154                                  ;; 02:5a76 $cd $54 $31
    jp   NC, call_00_3910                              ;; 02:5a79 $d2 $10 $39
    ret                                                ;; 02:5a7c $c9
    db   $fa, $3b, $d7, $e6, $3f, $20, $00, $0e        ;; 02:5a7d ????????
    db   $14, $cd, $e1, $32, $c3, $f7, $36             ;; 02:5a85 ???????
call_02_5a8c:
    call call_00_3843                                  ;; 02:5a8c $cd $43 $38
    ret  Z                                             ;; 02:5a8f $c8
    ld   C, $28                                        ;; 02:5a90 $0e $28
    call call_00_335a                                  ;; 02:5a92 $cd $5a $33
    ld   A, $01                                        ;; 02:5a95 $3e $01
    jp   call_02_7102_SetObjectAction                                  ;; 02:5a97 $c3 $02 $71
call_02_5a9a:
    call call_00_30af                                  ;; 02:5a9a $cd $af $30
    call call_00_3154                                  ;; 02:5a9d $cd $54 $31
    ret  C                                             ;; 02:5aa0 $d8
    ld   C, $24                                        ;; 02:5aa1 $0e $24
    call call_00_112f                                  ;; 02:5aa3 $cd $2f $11
    ld   A, $00                                        ;; 02:5aa6 $3e $00
    jp   call_02_7102_SetObjectAction                                  ;; 02:5aa8 $c3 $02 $71
    db   $cd, $ea, $34, $28, $07, $7d, $ee, $10        ;; 02:5aab ????????
    db   $6f, $3a, $2d, $77, $26, $d2, $fa, $00        ;; 02:5ab3 ????????
    db   $d3, $f6, $17, $6f, $cb, $46, $28, $0f        ;; 02:5abb ????????
    db   $2c, $2c, $2c, $6e, $26, $00, $11, $8b        ;; 02:5ac3 ????????
    db   $d7, $19, $7e, $a7, $ca, $10, $39, $26        ;; 02:5acb ????????
    db   $d2, $fa, $00, $d3, $f6, $1b, $6f, $fa        ;; 02:5ad3 ????????
    db   $3b, $d7, $be, $c0, $7d, $ee, $03, $6f        ;; 02:5adb ????????
    db   $36, $40, $3e, $01, $c3, $02, $71, $26        ;; 02:5ae3 ????????
    db   $d2, $fa, $00, $d3, $f6, $18, $6f, $35        ;; 02:5aeb ????????
    db   $4e, $7d, $ee, $12, $6f, $cb, $9e, $79        ;; 02:5af3 ????????
    db   $a7, $28, $21, $fe, $40, $d0, $e5, $cb        ;; 02:5afb ????????
    db   $3f, $cb, $3f, $cb, $3f, $5f, $16, $00        ;; 02:5b03 ????????
    db   $21, $29, $5b, $19, $46, $79, $e6, $07        ;; 02:5b0b ????????
    db   $5f, $21, $31, $5b, $19, $7e, $e1, $a0        ;; 02:5b13 ????????
    db   $c0, $cb, $de, $c9, $0e, $00, $cd, $2f        ;; 02:5b1b ????????
    db   $38, $3e, $02, $c3, $02, $71, $00, $01        ;; 02:5b23 ????????
    db   $11, $11, $55, $55, $55, $ff, $01, $02        ;; 02:5b2b ????????
    db   $04, $08, $10, $20, $40, $80, $cd, $43        ;; 02:5b33 ????????
    db   $38, $c8, $0e, $08, $cd, $2f, $38, $3e        ;; 02:5b3b ????????
    db   $00, $c3, $02, $71, $cd, $ea, $34, $28        ;; 02:5b43 ????????
    db   $07, $7d, $ee, $10, $6f, $3a, $2d, $77        ;; 02:5b4b ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $1a, $6f        ;; 02:5b53 ????????
    db   $3a, $fe, $ff, $28, $37, $e6, $0f, $c6        ;; 02:5b5b ????????
    db   $8b, $5f, $3e, $00, $ce, $d7, $57, $2d        ;; 02:5b63 ????????
    db   $2d, $cb, $56, $28, $20, $cb, $5e, $28        ;; 02:5b6b ????????
    db   $23, $cb, $46, $20, $1f, $7e, $e6, $c0        ;; 02:5b73 ????????
    db   $4f, $7e, $07, $07, $e6, $c0, $91, $20        ;; 02:5b7b ????????
    db   $04, $12, $cb, $96, $c9, $2c, $36, $46        ;; 02:5b83 ????????
    db   $3e, $01, $c3, $02, $71, $1a, $a7, $c8        ;; 02:5b8b ????????
    db   $cb, $d6, $cb, $c6, $cd, $59, $35, $c3        ;; 02:5b93 ????????
    db   $8d, $31, $fa, $3b, $d7, $e6, $07, $c0        ;; 02:5b9b ????????
    db   $cd, $17, $38, $c0, $26, $d2, $fa, $00        ;; 02:5ba3 ????????
    db   $d3, $f6, $17, $6f, $cb, $c6, $3e, $00        ;; 02:5bab ????????
    db   $c3, $02, $71                                 ;; 02:5bb3 ???
call_02_5bb6:
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
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:5bc4 $fa $00 $d3
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
call_02_5be1:
    ret                                                ;; 02:5be1 $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $17, $6f        ;; 02:5be2 ????????
    db   $cb, $7e, $c8, $0e, $1e, $cd, $2f, $11        ;; 02:5bea ????????
    db   $3e, $01, $c3, $02, $71, $cd, $43, $38        ;; 02:5bf2 ????????
    db   $3e, $02, $c2, $02, $71, $c9, $0e, $c0        ;; 02:5bfa ????????
    db   $cd, $16, $33, $c3, $97, $35, $0e, $22        ;; 02:5c02 ????????
    db   $cd, $e1, $32, $c3, $f7, $36, $0e, $0c        ;; 02:5c0a ????????
    db   $cd, $e1, $32, $c3, $f7, $36, $0e, $30        ;; 02:5c12 ????????
    db   $cd, $59, $38, $38, $08, $0e, $04, $cd        ;; 02:5c1a ????????
    db   $e1, $32, $c3, $f7, $36, $cd, $da, $36        ;; 02:5c22 ????????
    db   $0e, $1e, $cd, $e1, $32, $cd, $f7, $36        ;; 02:5c2a ????????
    db   $20, $09, $0e, $18, $cd, $59, $38, $d0        ;; 02:5c32 ????????
    db   $cd, $bd, $36, $0e, $30, $cd, $5a, $33        ;; 02:5c3a ????????
    db   $3e, $01, $c3, $02, $71, $0e, $10, $cd        ;; 02:5c42 ????????
    db   $e1, $32, $cd, $f7, $36, $cd, $af, $30        ;; 02:5c4a ????????
    db   $cd, $54, $31, $3e, $02, $d2, $02, $71        ;; 02:5c52 ????????
    db   $c9, $0e, $00, $cd, $50, $33, $cd, $43        ;; 02:5c5a ????????
    db   $38, $3e, $00, $c2, $02, $71, $c9, $fa        ;; 02:5c62 ????????
    db   $3b, $d7, $a7, $3e, $01, $ca, $02, $71        ;; 02:5c6a ????????
    db   $c9, $cd, $43, $38, $3e, $00, $c2, $02        ;; 02:5c72 ????????
    db   $71, $c9, $c9, $cd, $9c, $34, $26, $d2        ;; 02:5c7a ????????
    db   $fa, $00, $d3, $f6, $10, $6f, $73, $2c        ;; 02:5c82 ????????
    db   $72, $cd, $17, $38, $c0, $fa, $3c, $d7        ;; 02:5c8a ????????
    db   $e6, $3f, $f6, $40, $77, $3e, $01, $c3        ;; 02:5c92 ????????
    db   $02, $71, $cd, $af, $30, $cd, $54, $31        ;; 02:5c9a ????????
    db   $3e, $00, $d2, $02, $71, $c9                  ;; 02:5ca2 ??????

data_02_5ca8:
    db   $cd, $ea, $34, $28, $07, $7d, $ee, $10        ;; 02:5ca8 ????????
    db   $6f, $3a, $2d, $77, $cd, $59, $35, $c3        ;; 02:5cb0 ????????
    db   $8d, $31, $c9, $cd, $ea, $34, $28, $07        ;; 02:5cb8 ????????
    db   $7d, $ee, $10, $6f, $3a, $2d, $77, $cd        ;; 02:5cc0 ????????
    db   $59, $35, $c3, $8d, $31, $c9, $c9, $cd        ;; 02:5cc8 ????????
    db   $da, $30, $30, $0b, $cd, $45, $33, $0e        ;; 02:5cd0 ????????
    db   $20, $cb, $7f, $28, $24, $18, $20, $cd        ;; 02:5cd8 ????????
    db   $0c, $38, $20, $1b, $0e, $30, $cd, $59        ;; 02:5ce0 ????????
    db   $38, $30, $14, $fa, $0e, $d2, $e6, $03        ;; 02:5ce8 ????????
    db   $3c, $4f, $cd, $02, $38, $0e, $38, $cd        ;; 02:5cf0 ????????
    db   $5a, $33, $0e, $33, $cd, $2f, $11, $0e        ;; 02:5cf8 ????????
    db   $0c, $cd, $e1, $32, $cd, $f7, $36, $c4        ;; 02:5d00 ????????
    db   $17, $38, $c9, $c9, $21, $ef, $d6, $2a        ;; 02:5d08 ????????
    db   $66, $6f, $11, $c0, $ff, $19, $5d, $54        ;; 02:5d10 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $10, $6f        ;; 02:5d18 ????????
    db   $73, $2c, $72, $ee, $09, $6f, $fa, $3b        ;; 02:5d20 ????????
    db   $d7, $e6, $3f, $be, $c0, $0e, $0f, $cd        ;; 02:5d28 ????????
    db   $25, $38, $3e, $01, $c3, $02, $71, $cd        ;; 02:5d30 ????????
    db   $af, $30, $cd, $54, $31, $d8, $0e, $31        ;; 02:5d38 ????????
    db   $cd, $2f, $11, $3e, $02, $c3, $02, $71        ;; 02:5d40 ????????
    db   $cd, $43, $38, $c8, $0e, $13, $cd, $25        ;; 02:5d48 ????????
    db   $38, $3e, $03, $cd, $02, $71, $0e, $04        ;; 02:5d50 ????????
    db   $c3, $23, $3a, $cd, $8d, $3b, $3e, $00        ;; 02:5d58 ????????
    db   $ca, $02, $71, $ea, $9d, $d5, $3e, $03        ;; 02:5d60 ????????
    db   $21, $b8, $65, $cd, $78, $10, $c9, $c9        ;; 02:5d68 ????????
    db   $0e, $18, $cd, $59, $38, $0e, $20, $38        ;; 02:5d70 ????????
    db   $02, $0e, $10, $cd, $e1, $32, $c3, $60        ;; 02:5d78 ????????
    db   $37, $0e, $18, $cd, $59, $38, $0e, $20        ;; 02:5d80 ????????
    db   $38, $02, $0e, $10, $cd, $e1, $32, $c3        ;; 02:5d88 ????????
    db   $f7, $36, $cd, $43, $38, $c8, $cd, $17        ;; 02:5d90 ????????
    db   $38, $c0, $26, $d2, $fa, $00, $d3, $f6        ;; 02:5d98 ????????
    db   $19, $6f, $35, $7e, $2d, $e6, $03, $77        ;; 02:5da0 ????????
    db   $0e, $40, $cd, $5a, $33, $3e, $01, $c3        ;; 02:5da8 ????????
    db   $02, $71, $cd, $af, $30, $01, $08, $00        ;; 02:5db0 ????????
    db   $cd, $6e, $31, $d8, $0e, $34, $cd, $2f        ;; 02:5db8 ????????
    db   $11, $0e, $06, $ea, $9d, $d5, $3e, $0a        ;; 02:5dc0 ????????
    db   $21, $9a, $7b, $cd, $78, $10, $3e, $02        ;; 02:5dc8 ????????
    db   $c3, $02, $71, $cd, $43, $38, $3e, $00        ;; 02:5dd0 ????????
    db   $c2, $02, $71, $c9, $0e, $06, $cd, $23        ;; 02:5dd8 ????????
    db   $3a, $3e, $01, $c3, $02, $71, $cd, $8d        ;; 02:5de0 ????????
    db   $3b, $ca, $31, $39, $ea, $9d, $d5, $3e        ;; 02:5de8 ????????
    db   $03, $21, $3a, $66, $cd, $78, $10, $c9        ;; 02:5df0 ????????
    db   $fa, $3b, $d7, $a7, $3e, $01, $ca, $02        ;; 02:5df8 ????????
    db   $71, $c9, $cd, $43, $38, $3e, $00, $c2        ;; 02:5e00 ????????
    db   $02, $71, $c9, $c9, $0e, $10, $cd, $e1        ;; 02:5e08 ????????
    db   $32, $cd, $f7, $36, $cd, $af, $30, $cd        ;; 02:5e10 ????????
    db   $54, $31, $d8, $0e, $34, $cd, $59, $38        ;; 02:5e18 ????????
    db   $0e, $28, $dc, $5a, $33, $c9, $cd, $ea        ;; 02:5e20 ????????
    db   $34, $28, $0d, $0e, $07, $ea, $9d, $d5        ;; 02:5e28 ????????
    db   $3e, $0a, $21, $9a, $7b, $cd, $78, $10        ;; 02:5e30 ????????
    db   $0e, $08, $cd, $e1, $32, $cd, $f7, $36        ;; 02:5e38 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $01, $f6        ;; 02:5e40 ????????
    db   $0d, $6f, $7e, $f5, $7d, $ee, $03, $6f        ;; 02:5e48 ????????
    db   $5e, $2c, $56, $2c, $4e, $2c, $46, $26        ;; 02:5e50 ????????
    db   $d2, $3e, $20, $6f, $7e, $fe, $49, $28        ;; 02:5e58 ????????
    db   $07, $7d, $c6, $20, $20, $f5, $f1, $c9        ;; 02:5e60 ????????
    db   $7d, $f6, $0d, $6f, $f1, $77, $cb, $6f        ;; 02:5e68 ????????
    db   $28, $0e, $7d, $ee, $03, $6f, $7b, $d6        ;; 02:5e70 ????????
    db   $14, $22, $7a, $de, $00, $22, $18, $0c        ;; 02:5e78 ????????
    db   $7d, $ee, $03, $6f, $7b, $c6, $14, $22        ;; 02:5e80 ????????
    db   $7a, $ce, $00, $22, $71, $2c, $70, $c9        ;; 02:5e88 ????????
    db   $c9, $c9, $26, $d2, $fa, $00, $d3, $f6        ;; 02:5e90 ????????
    db   $17, $6f, $cb, $46, $20, $11, $cd, $af        ;; 02:5e98 ????????
    db   $30, $cd, $54, $31, $d8, $0e, $3c, $cd        ;; 02:5ea0 ????????
    db   $02, $38, $0e, $01, $c3, $f8, $37, $cd        ;; 02:5ea8 ????????
    db   $17, $38, $c0, $0e, $00, $cd, $f8, $37        ;; 02:5eb0 ????????
    db   $0e, $40, $c3, $5a, $33, $26, $d2             ;; 02:5eb8 ???????

data_02_5ebf:
    db   $fa, $00, $d3, $f6, $17, $6f, $cb, $7e        ;; 02:5ebf ????????
    db   $c8, $cb, $be, $3e, $20, $6f, $7e, $fe        ;; 02:5ec7 ????????
    db   $4d, $c8, $7d, $c6, $20, $20, $f6, $21        ;; 02:5ecf ????????
    db   $15, $d6, $4e, $cd, $90, $32, $0e, $0d        ;; 02:5ed7 ????????
    db   $ea, $9d, $d5, $3e, $0a, $21, $9a, $7b        ;; 02:5edf ????????
    db   $cd, $78, $10, $0e, $30, $cd, $2f, $11        ;; 02:5ee7 ????????
    db   $c9, $0e, $80, $cd, $02, $38, $3e, $01        ;; 02:5eef ????????
    db   $c3, $02, $71, $cd, $17, $38, $ca, $10        ;; 02:5ef7 ????????
    db   $39, $0e, $02, $cd, $50, $33, $cd, $42        ;; 02:5eff ????????
    db   $34, $26, $d2, $fa, $00, $d3, $f6, $0a        ;; 02:5f07 ????????
    db   $6f, $cb, $6e, $c8, $3e, $20, $6f, $7e        ;; 02:5f0f ????????
    db   $fe, $50, $28, $06                            ;; 02:5f17 ????

data_02_5f1b:
    db   $7d, $c6, $20, $20, $f5, $c9, $7d, $f6        ;; 02:5f1b ????????
    db   $12, $6f, $5e, $2c, $56, $fa, $00, $d3        ;; 02:5f23 ????????
    db   $f6, $12, $6f, $2a, $93, $c6, $08, $fe        ;; 02:5f2b ????????
    db   $10, $d0, $7e, $92, $c6, $08, $fe, $10        ;; 02:5f33 ????????
    db   $d0, $21, $13, $d6, $35, $21, $14, $d6        ;; 02:5f3b ????????
    db   $36, $80, $c3, $10, $39, $0e, $0c, $cd        ;; 02:5f43 ????????
    db   $e1, $32, $c3, $f7, $36, $fa, $14, $d6        ;; 02:5f4b ????????
    db   $a7, $28, $04, $3d                            ;; 02:5f53 ????

data_02_5f57:
    db   $ea, $14, $d6, $cd, $3f, $61, $fa, $13        ;; 02:5f57 ????????
    db   $d6, $a7, $ca, $85, $39, $c3, $29, $60        ;; 02:5f5f ????????
    db   $cd, $3f, $61, $fa, $13, $d6, $a7, $c2        ;; 02:5f67 ????????
    db   $79, $5f, $3e, $02, $ea, $8f, $d7, $c3        ;; 02:5f6f ????????
    db   $85, $39, $26, $d2, $fa, $00, $d3, $f6        ;; 02:5f77 ????????
    db   $1a, $6f, $3a, $fe, $01, $28, $04, $fe        ;; 02:5f7f ????????
    db   $03, $20, $16, $7e, $a7, $20, $12, $0e        ;; 02:5f87 ????????
    db   $0c, $ea, $9d, $d5, $3e, $0a, $21, $9a        ;; 02:5f8f ????????
    db   $7b, $cd, $78, $10, $0e, $2f, $cd, $2f        ;; 02:5f97 ????????
    db   $11, $cd, $29, $60, $26, $d2, $fa, $00        ;; 02:5f9f ????????
    db   $d3, $f6, $1a, $6f, $3a, $87, $87, $87        ;; 02:5fa7 ????????
    db   $4f, $0d, $7e, $21, $df, $5f, $0c, $23        ;; 02:5faf ????????
    db   $be, $30, $fb, $79, $e6, $1f, $6f, $26        ;; 02:5fb7 ????????
    db   $00, $29, $11, $e9, $5f, $19, $4e, $23        ;; 02:5fbf ????????
    db   $46, $21, $88, $d5, $79, $c6, $73, $be        ;; 02:5fc7 ????????
    db   $c8, $77, $26, $d2, $fa, $00, $d3, $f6        ;; 02:5fcf ????????
    db   $0d, $6f, $70, $21, $0f, $d6, $cb, $ce        ;; 02:5fd7 ????????
    db   $c9, $05, $0e, $17, $20, $32, $3b, $44        ;; 02:5fdf ????????
    db   $4d, $56, $00, $00, $01, $00, $02, $00        ;; 02:5fe7 ????????
    db   $03, $00, $04, $00, $05, $00, $06, $00        ;; 02:5fef ????????
    db   $07, $00, $08, $00, $07, $20, $06, $20        ;; 02:5ff7 ????????
    db   $05, $20, $04, $20, $03, $20, $02, $20        ;; 02:5fff ????????
    db   $01, $20, $00, $20, $01, $60, $02, $60        ;; 02:6007 ????????
    db   $03, $60, $04, $60, $05, $60, $06, $60        ;; 02:600f ????????
    db   $07, $60, $08, $60, $07, $40, $06, $40        ;; 02:6017 ????????
    db   $05, $40, $04, $40, $03, $40, $02, $40        ;; 02:601f ????????
    db   $01, $40, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6027 ????????
    db   $19, $6f, $34, $7e, $d6, $52, $20, $06        ;; 02:602f ????????
    db   $77, $2c, $34, $cb, $96, $2d, $2c, $3a        ;; 02:6037 ????????
    db   $6e, $26, $00, $29, $11, $9b, $60, $19        ;; 02:603f ????????
    db   $fe, $00, $28, $21, $fe, $01, $28, $15        ;; 02:6047 ????????
    db   $fe, $02, $28, $07, $2a, $2f, $3c, $4f        ;; 02:604f ????????
    db   $5e, $18, $15, $2a, $2f, $3c, $5f, $7e        ;; 02:6057 ????????
    db   $2f, $3c, $4f, $18, $0b, $4e, $23, $7e        ;; 02:605f ????????
    db   $2f, $3c, $5f, $18, $03, $5e, $23, $4e        ;; 02:6067 ????????
    db   $7b, $fe, $80, $3e, $ff, $ce, $00, $57        ;; 02:606f ????????
    db   $21, $30, $02, $19, $5d, $54, $79, $fe        ;; 02:6077 ????????
    db   $80, $3e, $ff, $ce, $00, $47, $21, $f0        ;; 02:607f ????????
    db   $04, $09, $4d, $44, $26, $d2, $fa, $00        ;; 02:6087 ????????
    db   $d3, $f6, $0e, $6f, $73, $2c, $72, $2c        ;; 02:608f ????????
    db   $71, $2c, $70, $c9, $00, $c6, $01, $c6        ;; 02:6097 ????????
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
    db   $26, $d2, $fa, $00, $d3, $f6, $0a, $6f        ;; 02:613f ????????
    db   $cb, $9e, $fa, $14, $d6, $e6, $02, $c8        ;; 02:6147 ????????
    db   $cb, $de, $c9, $0e, $80, $cd, $02, $38        ;; 02:614f ????????
    db   $cd, $bd, $36, $3e, $01, $c3, $02, $71        ;; 02:6157 ????????
    db   $cd, $17, $38, $ca, $10, $39, $0e, $02        ;; 02:615f ????????
    db   $cd, $50, $33, $c3, $42, $34, $c9, $26        ;; 02:6167 ????????
    db   $d2, $fa, $00, $d3, $f6, $17, $6f, $cb        ;; 02:616f ????????
    db   $46, $20, $42, $cb, $4e, $20, $63, $cb        ;; 02:6177 ????????
    db   $56, $20, $79, $0e, $14, $cd, $59, $38        ;; 02:617f ????????
    db   $38, $23, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6187 ????????
    db   $00, $6f, $7e, $fe, $54, $20, $0e, $0e        ;; 02:618f ????????
    db   $40, $cd, $59, $38, $30, $31, $0e, $20        ;; 02:6197 ????????
    db   $cd, $59, $38, $38, $52, $0e, $10, $cd        ;; 02:619f ????????
    db   $e1, $32, $c3, $f7, $36, $0e, $01, $cd        ;; 02:61a7 ????????
    db   $f8, $37, $fa, $0e, $d2, $e6, $01, $c6        ;; 02:61af ????????
    db   $02, $4f, $cd, $02, $38, $cd, $bd, $36        ;; 02:61b7 ????????
    db   $cd, $17, $38, $3e, $01, $c2, $02, $71        ;; 02:61bf ????????
    db   $0e, $00, $cd, $f8, $37, $18, $b4, $0e        ;; 02:61c7 ????????
    db   $02, $cd, $f8, $37, $fa, $0e, $d2, $0f        ;; 02:61cf ????????
    db   $0f, $0f, $e6, $60, $f6, $1f, $4f, $cd        ;; 02:61d7 ????????
    db   $02, $38, $cd, $17, $38, $28, $10, $e6        ;; 02:61df ????????
    db   $1f, $3e, $02, $ca, $02, $71, $0e, $02        ;; 02:61e7 ????????
    db   $cd, $e1, $32, $cd, $f7, $36, $c8, $0e        ;; 02:61ef ????????
    db   $04, $cd, $f8, $37, $0e, $18, $cd, $e1        ;; 02:61f7 ????????
    db   $32, $cd, $f7, $36, $0e, $20, $cd, $59        ;; 02:61ff ????????
    db   $38, $d0, $0e, $28, $cd, $5a, $33, $3e        ;; 02:6207 ????????
    db   $03, $c3, $02, $71, $cd, $43, $38, $3e        ;; 02:620f ????????
    db   $00, $c2, $02, $71, $c9, $cd, $bd, $36        ;; 02:6217 ????????
    db   $cd, $43, $38, $c8, $0e, $04, $ea, $9d        ;; 02:621f ????????
    db   $d5, $3e, $0a, $21, $9a, $7b, $cd, $78        ;; 02:6227 ????????
    db   $10, $3e, $00, $c3, $02, $71, $cd, $f7        ;; 02:622f ????????
    db   $36, $cd, $af, $30, $cd, $54, $31, $d8        ;; 02:6237 ????????
    db   $0e, $00, $cd, $f8, $37, $cd, $bd, $36        ;; 02:623f ????????
    db   $3e, $00, $c3, $02, $71, $cd, $ea, $34        ;; 02:6247 ????????
    db   $28, $0d, $0e, $05, $ea, $9d, $d5, $3e        ;; 02:624f ????????
    db   $0a, $21, $9a, $7b, $cd, $78, $10, $0e        ;; 02:6257 ????????
    db   $10, $cd, $e1, $32, $cd, $f7, $36, $0e        ;; 02:625f ????????
    db   $12, $cd, $59, $38, $30, $08, $3e, $01        ;; 02:6267 ????????
    db   $cd, $02, $71, $cd, $bd, $36, $26, $d2        ;; 02:626f ????????
    db   $fa, $00, $d3, $f6, $01, $f6, $0d, $6f        ;; 02:6277 ????????
    db   $7e, $f5, $7d, $ee, $03, $6f, $5e, $2c        ;; 02:627f ????????
    db   $56, $2c, $4e, $2c, $46, $26, $d2, $3e        ;; 02:6287 ????????
    db   $20, $6f, $7e, $fe, $56, $28, $09, $7d        ;; 02:628f ????????
    db   $c6, $20, $20, $f5, $f1, $c3, $85, $39        ;; 02:6297 ????????
    db   $7d, $f6, $01, $6f, $7e, $e6, $1f, $fe        ;; 02:629f ????????
    db   $01, $20, $02, $f1, $c9, $7d, $ee, $0c        ;; 02:62a7 ????????
    db   $6f, $f1, $77, $7d, $ee, $03, $6f, $73        ;; 02:62af ????????
    db   $2c, $72, $2c, $79, $d6, $09, $22, $78        ;; 02:62b7 ????????
    db   $de, $00, $22, $c9, $cd, $43, $38, $c8        ;; 02:62bf ????????
    db   $0e, $12, $cd, $59, $38, $3e, $00, $30        ;; 02:62c7 ????????
    db   $05, $cd, $bd, $36, $3e, $01, $cd, $02        ;; 02:62cf ????????
    db   $71, $c3, $75, $62, $26, $d2, $3e, $20        ;; 02:62d7 ????????
    db   $6f, $7e, $fe, $55, $28, $06, $7d, $c6        ;; 02:62df ????????
    db   $20, $20, $f5, $c9, $7d, $f6, $17, $6f        ;; 02:62e7 ????????
    db   $cb, $46, $c8, $0e, $34, $cd, $5a, $33        ;; 02:62ef ????????
    db   $3e, $01, $c3, $02, $71, $cd, $af, $30        ;; 02:62f7 ????????
    db   $cd, $54, $31, $d8, $fa, $9e, $d5, $a7        ;; 02:62ff ????????
    db   $28, $0c, $21, $1f, $63, $11, $3b, $da        ;; 02:6307 ????????
    db   $01, $08, $00, $cd, $b0, $07, $0e, $19        ;; 02:630f ????????
    db   $cd, $25, $38, $3e, $02, $c3, $02, $71        ;; 02:6317 ????????
    db   $00, $00, $00, $00, $96, $6e, $78, $77        ;; 02:631f ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $17, $6f        ;; 02:6327 ????????
    db   $cb, $46, $c2, $85, $39, $c9, $0e, $14        ;; 02:632f ????????
    db   $cd, $e1, $32, $c3, $f7, $36, $0e, $ff        ;; 02:6337 ????????
    db   $cd, $02, $38, $3e, $01, $c3, $02, $71        ;; 02:633f ????????
    db   $cd, $17, $38, $ca, $10, $39, $0e, $02        ;; 02:6347 ????????
    db   $cd, $50, $33, $c3, $42, $34, $0e, $10        ;; 02:634f ????????
    db   $cd, $e1, $32, $c3, $60, $37, $cd, $0c        ;; 02:6357 ????????
    db   $38, $c8, $0e, $2d, $cd, $2f, $11, $0e        ;; 02:635f ????????
    db   $00, $cd, $25, $38, $3e, $01, $cd, $02        ;; 02:6367 ????????
    db   $71, $0e, $05, $c3, $23, $3a, $cd, $8d        ;; 02:636f ????????
    db   $3b, $ca, $85, $39, $ea, $9d, $d5, $3e        ;; 02:6377 ????????
    db   $03, $21, $75, $66, $cd, $78, $10, $c9        ;; 02:637f ????????
    db   $c9, $cd, $ea, $34, $28, $07, $7d, $ee        ;; 02:6387 ????????
    db   $10, $6f, $3a, $2d, $77, $26, $d2, $fa        ;; 02:638f ????????
    db   $00, $d3, $f6, $1b, $6f, $fa, $3b, $d7        ;; 02:6397 ????????
    db   $be, $c0, $7d, $ee, $03, $6f, $36, $40        ;; 02:639f ????????
    db   $3e, $01, $c3, $02, $71, $26, $d2, $fa        ;; 02:63a7 ????????
    db   $00, $d3, $f6, $18, $6f, $35, $4e, $7d        ;; 02:63af ????????
    db   $ee, $12, $6f, $cb, $9e, $79, $a7, $28        ;; 02:63b7 ????????
    db   $21, $fe, $40, $d0, $e5, $cb, $3f, $cb        ;; 02:63bf ????????
    db   $3f, $cb, $3f, $5f, $16, $00, $21, $eb        ;; 02:63c7 ????????
    db   $63, $19, $46, $79, $e6, $07, $5f, $21        ;; 02:63cf ????????
    db   $f3, $63, $19, $7e, $e1, $a0, $c0, $cb        ;; 02:63d7 ????????
    db   $de, $c9, $0e, $00, $cd, $2f, $38, $3e        ;; 02:63df ????????
    db   $02, $c3, $02, $71, $00, $01, $11, $11        ;; 02:63e7 ????????
    db   $55, $55, $55, $ff, $01, $02, $04, $08        ;; 02:63ef ????????
    db   $10, $20, $40, $80, $cd, $43, $38, $c8        ;; 02:63f7 ????????
    db   $0e, $10, $cd, $2f, $38, $3e, $00, $c3        ;; 02:63ff ????????
    db   $02, $71, $cd, $ea, $34, $28, $07, $7d        ;; 02:6407 ????????
    db   $ee, $10, $6f, $3a, $2d, $77, $26, $d2        ;; 02:640f ????????
    db   $fa, $00, $d3, $f6, $1a, $6f, $7e, $fe        ;; 02:6417 ????????
    db   $ff, $28, $0c, $e6, $0f, $6f, $26, $00        ;; 02:641f ????????
    db   $11, $8b, $d7, $19, $7e, $a7, $c8, $cd        ;; 02:6427 ????????
    db   $59, $35, $c3, $8d, $31, $c9, $cd, $ea        ;; 02:642f ????????
    db   $34, $28, $07, $7d, $ee, $10, $6f, $3a        ;; 02:6437 ????????
    db   $2d, $77, $cd, $59, $35, $c3, $8d, $31        ;; 02:643f ????????
    db   $c9, $c9, $c9, $cd, $ea, $34, $28, $07        ;; 02:6447 ????????
    db   $7d, $ee, $10, $6f, $3a, $2d, $77, $21        ;; 02:644f ????????
    db   $10, $d2, $2a, $66, $6f, $29, $29, $29        ;; 02:6457 ????????
    db   $7c, $fe, $0a, $28, $20, $cd, $f5, $34        ;; 02:645f ????????
    db   $cb, $40, $20, $1f, $26, $d2, $fa, $00        ;; 02:6467 ????????
    db   $d3, $f6, $18, $6f, $7e, $fe, $10, $28        ;; 02:646f ????????
    db   $07, $34, $01, $01, $00, $cd, $d8, $37        ;; 02:6477 ????????
    db   $fa, $4d, $d7, $a7, $c8, $cd, $59, $35        ;; 02:647f ????????
    db   $c3, $8d, $31, $26, $d2, $fa, $00, $d3        ;; 02:6487 ????????
    db   $f6, $18, $6f, $7e, $a7, $c8, $35, $01        ;; 02:648f ????????
    db   $ff, $ff, $c3, $d8, $37, $cd, $ea, $34        ;; 02:6497 ????????
    db   $28, $07, $7d, $ee, $10, $6f, $3a, $2d        ;; 02:649f ????????
    db   $77, $cd, $59, $35, $c3, $8d, $31, $0e        ;; 02:64a7 ????????
    db   $80, $cd, $90, $32, $cd, $f5, $34, $cb        ;; 02:64af ????????
    db   $4e, $20, $20, $cb, $46, $28, $29, $2c        ;; 02:64b7 ????????
    db   $35, $c0, $36, $04, $2c, $7e, $fe, $0d        ;; 02:64bf ????????
    db   $28, $07, $34, $01, $01, $00, $c3, $d8        ;; 02:64c7 ????????
    db   $37, $cb, $40, $c0, $2d, $36, $f0, $2d        ;; 02:64cf ????????
    db   $cb, $ce, $c9, $2c, $35, $c0, $36, $04        ;; 02:64d7 ????????
    db   $2d, $7e, $e6, $01, $ee, $01, $77, $c9        ;; 02:64df ????????
    db   $cb, $40, $28, $14, $2c, $2c, $7e, $a7        ;; 02:64e7 ????????
    db   $20, $07, $2d, $36, $3c, $2d, $cb, $ce        ;; 02:64ef ????????
    db   $c9, $2d, $36, $01, $2d, $36, $01, $c9        ;; 02:64f7 ????????
    db   $2c, $35, $c0, $36, $04, $2c, $7e, $a7        ;; 02:64ff ????????
    db   $c8, $35, $01, $ff, $ff, $c3, $d8, $37        ;; 02:6507 ????????
    db   $0e, $80, $cd, $90, $32, $26, $d2, $fa        ;; 02:650f ????????
    db   $00, $d3, $f6, $17, $6f, $cb, $46, $28        ;; 02:6517 ????????
    db   $2f, $cb, $4e, $20, $20, $cb, $56, $20        ;; 02:651f ????????
    db   $0d, $2c, $35, $20, $03, $2d, $36, $00        ;; 02:6527 ????????
    db   $01, $01, $00, $c3, $d8, $37, $2c, $35        ;; 02:652f ????????
    db   $20, $05, $36, $f0, $2d, $cb, $ce, $01        ;; 02:6537 ????????
    db   $ff                                           ;; 02:653f ?

data_02_6540:
    db   $ff, $c3, $d8, $37, $2c, $35, $c0, $36        ;; 02:6540 ????????
    db   $0d, $2d, $cb, $8e, $cb, $96, $c9, $fa        ;; 02:6548 ????????
    db   $17, $d6, $fe, $40, $d8, $cb, $c6, $cb        ;; 02:6550 ????????
    db   $d6, $2c, $36, $0d, $c9, $cd, $f5, $34        ;; 02:6558 ????????
    db   $cb, $40, $28, $3e, $fa, $01, $d2, $e6        ;; 02:6560 ????????
    db   $1f, $fe, $0d, $20, $35, $26, $d2, $fa        ;; 02:6568 ????????
    db   $00, $d3, $f6, $10, $6f, $2a, $66, $6f        ;; 02:6570 ????????
    db   $29, $29, $29, $4c, $fa, $00, $d3, $0f        ;; 02:6578 ????????
    db   $0f, $0f, $6f, $26                            ;; 02:6580 ????

data_02_6584:
    db   $00, $11, $0c, $d3, $19, $7e, $b9, $d0        ;; 02:6584 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $19, $6f        ;; 02:658c ????????
    db   $7e, $c6, $01, $22, $7e, $ce, $00, $77        ;; 02:6594 ????????
    db   $01, $ff, $ff, $c3, $d8, $37, $7d, $ee        ;; 02:659c ????????
    db   $0d, $6f, $3a, $b6, $c8, $7e, $d6, $01        ;; 02:65a4 ????????
    db   $22, $7e, $de, $00, $77, $01, $01, $00        ;; 02:65ac ????????
    db   $c3, $d8, $37, $cd, $11, $66, $0e, $00        ;; 02:65b4 ????????
    db   $06, $01, $18, $22, $cd, $11, $66, $0e        ;; 02:65bc ????????
    db   $00, $06, $02, $18, $19, $cd, $11, $66        ;; 02:65c4 ????????
    db   $0e, $01, $06, $03, $18, $10, $cd, $11        ;; 02:65cc ????????
    db   $66, $0e, $02, $06, $04, $18, $07, $cd        ;; 02:65d4 ????????
    db   $1b, $66, $0e, $03, $06, $04, $26, $d2        ;; 02:65dc ????????
    db   $fa, $00, $d3, $f6, $17, $6f, $cb, $46        ;; 02:65e4 ????????
    db   $28, $06, $48, $78, $fe, $01, $28, $06        ;; 02:65ec ????????
    db   $c5, $cd, $43, $38, $c1                       ;; 02:65f4 ?????

data_02_65f9:
    db   $c8, $26, $d2, $fa, $00, $d3, $f6, $01        ;; 02:65f9 ????????
    db   $6f, $7e, $e6, $1f, $b9, $79, $c8, $cd        ;; 02:6601 ????????
    db   $02, $71, $0e, $35, $cd, $2f, $11, $c9        ;; 02:6609 ????????
    db   $fa, $17, $d6, $a7, $c8, $3d, $ea, $17        ;; 02:6611 ????????
    db   $d6, $c9, $fa, $17, $d6, $fe, $40, $d0        ;; 02:6619 ????????
    db   $3c, $ea, $17, $d6, $c9, $c9, $c9, $c9        ;; 02:6621 ????????
    db   $0e, $18, $cd, $e1, $32, $cd, $f7, $36        ;; 02:6629 ????????
    db   $c9, $c9, $c9, $c9, $c9, $26, $d2, $fa        ;; 02:6631 ????????
    db   $00, $d3, $f6, $19, $6f, $0e, $00, $cb        ;; 02:6639 ????????
    db   $46, $28, $02, $0e, $40, $ee, $14, $6f        ;; 02:6641 ????????
    db   $71, $c9, $c9, $c9, $26, $d2, $fa, $00        ;; 02:6649 ????????
    db   $d3, $f6, $19, $6f, $cb, $46, $20, $09        ;; 02:6651 ????????
    db   $0e, $08, $cd, $e1, $32, $cd, $60, $37        ;; 02:6659 ????????
    db   $c9, $0e, $08, $cd, $e1, $32, $cd, $f7        ;; 02:6661 ????????
    db   $36, $c9, $c9, $26, $d2, $fa, $00, $d3        ;; 02:6669 ????????
    db   $f6, $0d, $6f, $36, $20, $ee, $1a, $6f        ;; 02:6671 ????????
    db   $cb, $46, $20, $37, $fa, $49, $d6, $a7        ;; 02:6679 ????????
    db   $c8, $fa, $17, $d6, $fe, $40, $d8, $cb        ;; 02:6681 ????????
    db   $c6, $2c, $36, $78, $0e, $00, $3e, $20        ;; 02:6689 ????????
    db   $6f, $7e, $fe, $74, $20, $01, $0c, $7d        ;; 02:6691 ????????
    db   $c6, $20, $20, $f4, $79, $fe, $02, $d0        ;; 02:6699 ????????
    db   $0e, $0e, $ea, $9d, $d5, $3e, $0a, $21        ;; 02:66a1 ????????
    db   $9a, $7b, $cd, $78, $10, $0e, $06, $cd        ;; 02:66a9 ????????
    db   $2f, $11, $c9, $2c, $35, $c0, $2d, $cb        ;; 02:66b1 ????????
    db   $86, $c9, $26, $d2, $fa, $00, $d3, $f6        ;; 02:66b9 ????????
    db   $0e, $6f, $2a, $66, $6f, $29, $29, $29        ;; 02:66c1 ????????
    db   $7c, $fe, $19, $38, $05, $fe, $21, $da        ;; 02:66c9 ????????
    db   $31, $39, $0e, $0c, $cd, $e1, $32, $c3        ;; 02:66d1 ????????
    db   $f7, $36, $0e, $0c, $cd, $e1, $32, $c3        ;; 02:66d9 ????????
    db   $f7, $36, $cd, $43, $38, $c8, $0e, $30        ;; 02:66e1 ????????
    db   $cd, $5a, $33, $3e, $01, $c3, $02, $71        ;; 02:66e9 ????????
    db   $cd, $af, $30, $cd, $54, $31, $3e, $00        ;; 02:66f1 ????????
    db   $d4, $02, $71, $c9, $cd, $43, $38, $c8        ;; 02:66f9 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $0d, $6f        ;; 02:6701 ????????
    db   $36, $60, $3e, $01, $c3, $02, $71, $cd        ;; 02:6709 ????????
    db   $43, $38, $c8, $26, $d2, $fa, $00, $d3        ;; 02:6711 ????????
    db   $f6, $0d, $6f, $36, $00, $3e, $00, $c3        ;; 02:6719 ????????
    db   $02, $71, $c9, $cd, $ea, $34, $28, $0d        ;; 02:6721 ????????
    db   $0e, $09, $ea, $9d, $d5, $3e, $0a, $21        ;; 02:6729 ????????
    db   $9a, $7b, $cd, $78, $10, $0e, $08, $cd        ;; 02:6731 ????????
    db   $e1, $32, $cd, $f7, $36, $3e, $01, $c4        ;; 02:6739 ????????
    db   $02, $71, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6741 ????????
    db   $0e, $6f, $5e, $2c, $56, $ee, $03, $6f        ;; 02:6749 ????????
    db   $4e, $3e, $20, $6f, $7e, $fe, $7b, $28        ;; 02:6751 ????????
    db   $06, $7d, $c6, $20, $20, $f5, $c9, $7d        ;; 02:6759 ????????
    db   $f6, $0e, $6f, $73, $2c, $72, $ee, $03        ;; 02:6761 ????????
    db   $6f, $71, $c9, $cd, $43, $38, $3e, $00        ;; 02:6769 ????????
    db   $c2, $02, $71, $c9, $26, $d2, $3e, $20        ;; 02:6771 ????????
    db   $6f, $7e, $fe, $7a, $c8, $7d, $c6, $20        ;; 02:6779 ????????
    db   $20, $f6, $c3, $10, $39, $26, $d2, $fa        ;; 02:6781 ????????
    db   $00, $d3, $f6, $1b, $6f, $fa, $3b, $d7        ;; 02:6789 ????????
    db   $be, $c0, $2d, $36, $00, $cd, $0e, $68        ;; 02:6791 ????????
    db   $3e, $01, $c3, $02, $71, $26, $d2, $fa        ;; 02:6799 ????????
    db   $00, $d3, $f6, $17, $6f, $7e, $0f, $0f        ;; 02:67a1 ????????
    db   $e6, $3c, $5f, $16, $00, $21, $ce, $67        ;; 02:67a9 ????????
    db   $19, $4e, $23, $46, $23, $c5, $4e, $23        ;; 02:67b1 ????????
    db   $46, $cd, $d8, $37, $c1, $cd, $c9, $37        ;; 02:67b9 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $18, $6f        ;; 02:67c1 ????????
    db   $35, $cc, $0e, $68, $c9, $00, $00, $00        ;; 02:67c9 ????????
    db   $00, $02, $00, $00, $00, $fe, $ff, $00        ;; 02:67d1 ????????
    db   $00, $02, $00, $00, $00, $00, $00, $fe        ;; 02:67d9 ????????
    db   $ff, $02, $00, $fe, $ff, $fe, $ff, $fe        ;; 02:67e1 ????????
    db   $ff, $02, $00, $fe, $ff, $00, $00, $02        ;; 02:67e9 ????????
    db   $00, $02, $00, $02, $00, $fe, $ff, $02        ;; 02:67f1 ????????
    db   $00, $02, $00, $02, $00, $00, $00, $02        ;; 02:67f9 ????????
    db   $00, $02, $00, $02, $00, $fe, $ff, $02        ;; 02:6801 ????????
    db   $00, $02, $00, $02, $00, $26, $d2, $fa        ;; 02:6809 ????????
    db   $00, $d3, $f6, $1a, $6f, $4e, $34, $2d        ;; 02:6811 ????????
    db   $6e, $26, $00, $29, $11, $3c, $68, $19        ;; 02:6819 ????????
    db   $5e, $23, $56, $69, $26, $00, $29, $19        ;; 02:6821 ????????
    db   $16, $d2, $fa, $00, $d3, $f6, $17, $5f        ;; 02:6829 ????????
    db   $2a, $fe, $ff, $ca, $10, $39, $12, $1c        ;; 02:6831 ????????
    db   $7e, $12, $c9, $50, $68, $57, $68, $5e        ;; 02:6839 ????????
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
    db   $10, $40, $90, $10, $10, $5c, $ff, $cd        ;; 02:68b9 ????????
    db   $ea, $34, $c4, $d6, $68, $cd, $59, $35        ;; 02:68c1 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $1b, $6f        ;; 02:68c9 ????????
    db   $35, $cc, $d6, $68, $c9, $26, $d2, $fa        ;; 02:68d1 ????????
    db   $00, $d3, $f6, $1a, $6f, $4e, $34, $2d        ;; 02:68d9 ????????
    db   $6e, $26, $00, $29, $11, $15, $69, $19        ;; 02:68e1 ????????
    db   $5e, $23, $56, $06, $00, $69, $60, $29        ;; 02:68e9 ????????
    db   $09, $19, $16, $d2, $fa, $00, $d3, $f6        ;; 02:68f1 ????????
    db   $1b, $5f, $2a, $fe, $ff, $28, $09, $12        ;; 02:68f9 ????????
    db   $1c, $2a, $12, $1c, $1c, $7e, $12, $c9        ;; 02:6901 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $1a, $6f        ;; 02:6909 ????????
    db   $36, $00, $18, $c1, $1d, $69, $2a, $69        ;; 02:6911 ????????
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
    db   $f0, $10, $e0, $10, $10, $ff, $cd, $ea        ;; 02:6969 ????????
    db   $34, $28, $07, $7d, $ee, $10, $6f, $3a        ;; 02:6971 ????????
    db   $2d, $77, $cd, $f5, $34, $cb, $40, $c8        ;; 02:6979 ????????
    db   $fa, $51, $d7, $5f, $fa, $52, $d7, $b3        ;; 02:6981 ????????
    db   $c8, $cb, $d6, $cb, $c6, $3e, $01, $c3        ;; 02:6989 ????????
    db   $02, $71, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6991 ????????
    db   $17, $6f, $cb, $5e, $28, $1f, $cb, $46        ;; 02:6999 ????????
    db   $20, $1b, $7e, $e6, $c0, $4f, $7e, $07        ;; 02:69a1 ????????
    db   $07, $e6, $c0, $91, $20, $07, $cb, $96        ;; 02:69a9 ????????
    db   $3e, $00, $c3, $02, $71, $2c, $36, $b4        ;; 02:69b1 ????????
    db   $3e, $02, $c3, $02, $71, $cd, $59, $35        ;; 02:69b9 ????????
    db   $c3, $8d, $31, $cd, $17, $38, $c0, $26        ;; 02:69c1 ????????
    db   $d2, $fa, $00, $d3, $f6, $17, $6f, $cb        ;; 02:69c9 ????????
    db   $c6, $3e, $01, $c3, $02, $71, $cd, $f5        ;; 02:69d1 ????????
    db   $34, $cb, $4e, $20, $20, $cb, $46, $28        ;; 02:69d9 ????????
    db   $29, $2c, $35, $c0, $36, $04, $2c, $7e        ;; 02:69e1 ????????
    db   $fe, $20, $28, $07, $34, $01, $01, $00        ;; 02:69e9 ????????
    db   $c3, $d8, $37, $cb, $40, $c0, $2d, $36        ;; 02:69f1 ????????
    db   $f0, $2d, $cb, $ce, $c9, $2c, $35, $c0        ;; 02:69f9 ????????
    db   $36, $04, $2d, $7e, $e6, $01, $ee, $01        ;; 02:6a01 ????????
    db   $77, $c9, $cb, $40, $28, $14, $2c, $2c        ;; 02:6a09 ????????
    db   $7e, $a7, $20, $07, $2d, $36, $3c, $2d        ;; 02:6a11 ????????
    db   $cb, $ce, $c9, $2d, $36, $01, $2d, $36        ;; 02:6a19 ????????
    db   $01, $c9, $2c, $35, $c0, $36, $04, $2c        ;; 02:6a21 ????????
    db   $7e, $a7, $c8, $35, $01, $ff, $ff, $c3        ;; 02:6a29 ????????
    db   $d8, $37, $0e, $18, $cd, $e1, $32, $c3        ;; 02:6a31 ????????
    db   $f7, $36, $c9, $26, $d2, $fa, $00, $d3        ;; 02:6a39 ????????
    db   $f6, $19, $6f, $6e, $2d, $26, $00, $11        ;; 02:6a41 ????????
    db   $a3, $d5, $19, $0e, $00, $7e, $a7, $28        ;; 02:6a49 ????????
    db   $02, $0e, $10, $26, $d2, $fa, $00, $d3        ;; 02:6a51 ????????
    db   $f6, $14, $6f, $71, $21, $0e, $d2, $2a        ;; 02:6a59 ????????
    db   $66, $6f, $29, $29, $29, $4c, $fa, $00        ;; 02:6a61 ????????
    db   $d3, $0f, $0f, $0f, $6f, $26, $00, $11        ;; 02:6a69 ????????
    db   $09, $d3, $19, $2a, $b9, $d8, $79, $be        ;; 02:6a71 ????????
    db   $d8, $26, $d2, $fa, $00, $d3, $f6, $0e        ;; 02:6a79 ????????
    db   $6f, $fa, $0e, $d2, $22, $fa, $0f, $d2        ;; 02:6a81 ????????
    db   $77, $c9, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6a89 ????????
    db   $19, $6f, $fa, $3b, $d7, $e6, $3f, $be        ;; 02:6a91 ????????
    db   $c0, $cd, $cd, $6b, $0e, $02, $cd, $50        ;; 02:6a99 ????????
    db   $33, $0e, $30, $cd, $5a, $33, $3e, $01        ;; 02:6aa1 ????????
    db   $c3, $02, $71, $cd, $42, $34, $26, $d2        ;; 02:6aa9 ????????
    db   $fa, $00, $d3, $f6, $1a, $6f, $cb, $46        ;; 02:6ab1 ????????
    db   $20, $09, $cd, $da, $30, $d2, $03, $6c        ;; 02:6ab9 ????????
    db   $c3, $f8, $6b, $cd, $af, $30, $01, $f1        ;; 02:6ac1 ????????
    db   $ff, $cd, $6e, $31, $d2, $03, $6c, $c3        ;; 02:6ac9 ????????
    db   $f8, $6b, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6ad1 ????????
    db   $19, $6f, $fa, $3b, $d7, $e6, $3f, $be        ;; 02:6ad9 ????????
    db   $c0, $cd, $cd, $6b, $0e, $02, $cd, $50        ;; 02:6ae1 ????????
    db   $33, $0e, $30, $cd, $5a, $33, $0e, $f0        ;; 02:6ae9 ????????
    db   $cd, $02, $38, $3e, $01, $c3, $02, $71        ;; 02:6af1 ????????
    db   $cd, $42, $34, $cd, $17, $38, $ca, $03        ;; 02:6af9 ????????
    db   $6c, $26, $d2, $fa, $00, $d3, $f6, $1a        ;; 02:6b01 ????????
    db   $6f, $cb, $46, $20, $09, $cd, $da, $30        ;; 02:6b09 ????????
    db   $d2, $03, $6c, $c3, $f8, $6b, $cd, $af        ;; 02:6b11 ????????
    db   $30, $cd, $45, $33, $cb, $7f, $3e, $02        ;; 02:6b19 ????????
    db   $c2, $02, $71, $01, $f1, $ff, $cd, $6e        ;; 02:6b21 ????????
    db   $31, $d2, $03, $6c, $c3, $f8, $6b, $cd        ;; 02:6b29 ????????
    db   $42, $34, $cd, $17, $38, $28, $06, $0e        ;; 02:6b31 ????????
    db   $08, $cd, $59, $38, $d0, $3e, $03, $c3        ;; 02:6b39 ????????
    db   $02, $71, $cd, $42, $34, $26, $d2, $fa        ;; 02:6b41 ????????
    db   $00, $d3, $f6, $1a, $6f, $cb, $46, $20        ;; 02:6b49 ????????
    db   $09, $cd, $da, $30, $d2, $03, $6c, $c3        ;; 02:6b51 ????????
    db   $f8, $6b, $cd, $af, $30, $01, $f1, $ff        ;; 02:6b59 ????????
    db   $cd, $6e, $31, $d2, $03, $6c, $c3, $f8        ;; 02:6b61 ????????
    db   $6b, $26, $d2, $fa, $00, $d3, $f6, $19        ;; 02:6b69 ????????
    db   $6f, $fa, $3b, $d7, $e6, $3f, $be, $c0        ;; 02:6b71 ????????
    db   $cd, $cd, $6b, $3e, $01, $c3, $02, $71        ;; 02:6b79 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $1a, $6f        ;; 02:6b81 ????????
    db   $4e, $ee, $0a, $6f, $2a, $66, $6f, $29        ;; 02:6b89 ????????
    db   $29, $29, $44, $cb, $41, $28, $17, $fa        ;; 02:6b91 ????????
    db   $00, $d3, $0f, $0f, $0f, $e6, $1c, $6f        ;; 02:6b99 ????????
    db   $26, $00, $11, $0c, $d3, $19, $7e, $b8        ;; 02:6ba1 ????????
    db   $28, $58, $0e, $d0, $18, $15, $fa, $00        ;; 02:6ba9 ????????
    db   $d3, $0f, $0f, $0f, $e6, $1c, $6f, $26        ;; 02:6bb1 ????????
    db   $00, $11, $0b, $d3, $19, $7e, $b8, $28        ;; 02:6bb9 ????????
    db   $41, $0e, $30, $cd, $16, $33, $cd, $97        ;; 02:6bc1 ????????
    db   $35, $c3, $f8, $6b, $0e, $36, $cd, $2f        ;; 02:6bc9 ????????
    db   $11, $0e, $1e, $cd, $25, $38, $26, $d2        ;; 02:6bd1 ????????
    db   $fa, $00, $d3, $f6, $1c, $6f, $af, $22        ;; 02:6bd9 ????????
    db   $22, $22, $77, $7d, $ee, $05, $6f, $cb        ;; 02:6be1 ????????
    db   $46, $20, $06, $01, $10, $00, $c3, $d8        ;; 02:6be9 ????????
    db   $37, $01, $f0, $ff, $c3, $d8, $37, $26        ;; 02:6bf1 ????????
    db   $d2, $fa, $00, $d3, $f6, $17, $6f, $cb        ;; 02:6bf9 ????????
    db   $7e, $c8, $0e, $37, $cd, $2f, $11, $0e        ;; 02:6c01 ????????
    db   $0a, $ea, $9d, $d5, $3e, $0a, $21, $9a        ;; 02:6c09 ????????
    db   $7b, $cd, $78, $10, $c3, $10, $39, $cd        ;; 02:6c11 ????????
    db   $ea, $34, $28, $1b, $3e, $0a, $ea, $16        ;; 02:6c19 ????????
    db   $d6, $26, $d2, $fa, $00, $d3, $f6, $0e        ;; 02:6c21 ????????
    db   $6f, $2a, $66, $6f, $29, $29, $29, $7c        ;; 02:6c29 ????????
    db   $fe, $73, $3e, $08, $d2, $02, $71, $cd        ;; 02:6c31 ????????
    db   $43, $38, $3e, $02, $c2, $02, $71, $c9        ;; 02:6c39 ????????
    db   $c9, $cd, $43, $38, $3e, $02, $c4, $02        ;; 02:6c41 ????????
    db   $71, $fa, $3b, $d7, $e6, $03, $20, $2b        ;; 02:6c49 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $10, $6f        ;; 02:6c51 ????????
    db   $5e, $2c, $56, $fa, $10, $d2, $d6, $08        ;; 02:6c59 ????????
    db   $6f, $fa, $11, $d2, $de, $00, $67, $01        ;; 02:6c61 ????????
    db   $01, $00, $7b, $95, $5f, $7a, $9c, $57        ;; 02:6c69 ????????
    db   $38, $06, $b3, $28, $06, $01, $ff, $ff        ;; 02:6c71 ????????
    db   $cd, $d8, $37, $cd, $bd, $36, $c3, $51        ;; 02:6c79 ????????
    db   $32, $cd, $43, $38, $c8, $3e, $03, $cd        ;; 02:6c81 ????????
    db   $02, $71, $26, $d2, $fa, $00, $d3, $f6        ;; 02:6c89 ????????
    db   $1b, $6f, $7e, $fe, $19, $d8, $35, $c9        ;; 02:6c91 ????????
    db   $cd, $a7, $6c, $c9, $cd, $43, $38, $3e        ;; 02:6c99 ????????
    db   $08, $c2, $02, $71, $c9, $c9, $21, $16        ;; 02:6ca1 ????????
    db   $d6, $cb, $7e, $c8, $cb, $be, $35, $3e        ;; 02:6ca9 ????????
    db   $09, $c2, $02, $71, $0e, $11, $ea, $9d        ;; 02:6cb1 ????????
    db   $d5, $3e, $0a, $21, $9a, $7b, $cd, $78        ;; 02:6cb9 ????????
    db   $10, $0e, $37, $cd, $2f, $11, $c3, $85        ;; 02:6cc1 ????????
    db   $39, $26, $d2, $3e, $20, $6f, $7e, $fe        ;; 02:6cc9 ????????
    db   $86, $28, $06, $7d, $c6, $20, $20, $f5        ;; 02:6cd1 ????????
    db   $c9, $7d, $f6, $0d, $6f, $7e, $f5, $7d        ;; 02:6cd9 ????????
    db   $ee, $03, $6f, $f1, $cb, $6f, $20, $0a        ;; 02:6ce1 ????????
    db   $2a, $d6, $09, $4f, $2a, $de, $00, $47        ;; 02:6ce9 ????????
    db   $18, $08, $2a, $c6, $09, $4f, $2a, $ce        ;; 02:6cf1 ????????
    db   $00, $47, $2a, $c6, $18, $5f, $7e, $ce        ;; 02:6cf9 ????????
    db   $00, $57, $fa, $00, $d3, $f6, $0e, $6f        ;; 02:6d01 ????????
    db   $71, $2c, $70, $2c, $73, $2c, $72, $c9        ;; 02:6d09 ????????
    db   $cd, $ea, $34, $28, $07, $7d, $ee, $10        ;; 02:6d11 ????????
    db   $6f, $3a, $2d, $77, $cd, $59, $35, $c3        ;; 02:6d19 ????????
    db   $8d, $31, $c9, $cd, $43, $38, $c2, $10        ;; 02:6d21 ????????
    db   $39, $26, $d2, $fa, $00, $d3, $f6, $07        ;; 02:6d29 ????????
    db   $6f, $6e, $26, $00, $29, $11, $4f, $6d        ;; 02:6d31 ????????
    db   $19, $5e, $23, $56, $26, $d2, $fa, $00        ;; 02:6d39 ????????
    db   $d3, $f6, $0d, $6f, $73, $ee, $07, $6f        ;; 02:6d41 ????????
    db   $7e, $cb, $9f, $b2, $77, $c9, $00, $00        ;; 02:6d49 ????????
    db   $20, $00, $00, $00, $00, $08, $20, $00        ;; 02:6d51 ????????
    db   $00, $08, $00, $00, $cd, $af, $30, $26        ;; 02:6d59 ????????
    db   $d2, $fa, $00, $d3, $f6, $10, $6f, $2a        ;; 02:6d61 ????????
    db   $66, $6f, $29, $29, $29, $7c, $fe, $7d        ;; 02:6d69 ????????
    db   $d8, $21, $16, $d6, $cb, $fe, $0e, $38        ;; 02:6d71 ????????
    db   $cd, $2f, $11, $c3, $31, $39, $c9, $cd        ;; 02:6d79 ????????
    db   $f5, $34, $cb, $40, $c8, $fa, $16, $d6        ;; 02:6d81 ????????
    db   $e6, $7f, $c8, $26, $d2, $fa, $00, $d3        ;; 02:6d89 ????????
    db   $f6, $19, $6f, $7e, $fe, $01, $0e, $0f        ;; 02:6d91 ????????
    db   $28, $02, $0e, $10, $ea, $9d, $d5, $3e        ;; 02:6d99 ????????
    db   $0a, $21, $9a, $7b, $cd, $78, $10, $01        ;; 02:6da1 ????????
    db   $05, $00, $cd, $d8, $37, $0e, $39, $cd        ;; 02:6da9 ????????
    db   $2f, $11, $3e, $01, $c3, $02, $71, $26        ;; 02:6db1 ????????
    db   $d2, $3e, $20, $6f, $7e, $fe, $8c, $20        ;; 02:6db9 ????????
    db   $06, $fa, $00, $d3, $bd, $20, $06, $7d        ;; 02:6dc1 ????????
    db   $c6, $20, $20, $ef, $c9, $7d, $f6, $01        ;; 02:6dc9 ????????
    db   $6f, $7e, $e6, $1f, $fe, $01, $c0, $01        ;; 02:6dd1 ????????
    db   $fb, $ff, $cd, $d8, $37, $3e, $00, $c3        ;; 02:6dd9 ????????
    db   $02, $71, $cd, $43, $38, $c8, $af, $ea        ;; 02:6de1 ????????
    db   $47, $d6, $3e, $13, $c3, $cd, $4c, $c9        ;; 02:6de9 ????????

call_02_6df1:
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
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:6dff $fa $00 $d3
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
    