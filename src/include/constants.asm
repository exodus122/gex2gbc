; MBC1
DEF MBC1SRamEnable      EQU $0001
DEF MBC1RomBank         EQU $2001
DEF MBC1SRamBank        EQU $4001
DEF MBC1SRamBankingMode EQU $6001

; ROM Banks
DEF Bank00      EQU $00
DEF Bank01      EQU $01
DEF Bank02      EQU $02
DEF Bank03      EQU $03
DEF Bank04      EQU $04
DEF Bank05      EQU $05
DEF Bank06      EQU $06
DEF Bank07      EQU $07
DEF Bank08      EQU $08
DEF Bank09      EQU $09
DEF Bank0a      EQU $0a
DEF Bank0b      EQU $0b
DEF Bank0c      EQU $0c
DEF Bank0d      EQU $0d
DEF Bank0e      EQU $0e
DEF Bank0f      EQU $0f
DEF Bank10      EQU $10
DEF Bank11      EQU $11
DEF Bank12      EQU $12
DEF Bank13      EQU $13
DEF Bank14      EQU $14
DEF Bank15      EQU $15
DEF Bank16      EQU $16
DEF Bank17      EQU $17
DEF Bank18      EQU $18
DEF Bank19      EQU $19
DEF Bank1a      EQU $1a
DEF Bank1b      EQU $1b
DEF Bank1c      EQU $1c
DEF Bank1d      EQU $1d
DEF Bank1e      EQU $1e
DEF Bank1f      EQU $1f
DEF Bank20      EQU $20
DEF Bank21      EQU $21
DEF Bank22      EQU $22
DEF Bank23      EQU $23
DEF Bank24      EQU $24
DEF Bank25      EQU $25
DEF Bank26      EQU $26
DEF Bank27      EQU $27
DEF Bank28      EQU $28
DEF Bank29      EQU $29
DEF Bank2a      EQU $2a
DEF Bank2b      EQU $2b
DEF Bank2c      EQU $2c
DEF Bank2d      EQU $2d
DEF Bank2e      EQU $2e
DEF Bank2f      EQU $2f
DEF Bank30      EQU $30
DEF Bank31      EQU $31
DEF Bank32      EQU $32
DEF Bank33      EQU $33
DEF Bank34      EQU $34
DEF Bank35      EQU $35
DEF Bank36      EQU $36
DEF Bank37      EQU $37
DEF Bank38      EQU $38
DEF Bank39      EQU $39
DEF Bank3a      EQU $3a
DEF Bank3b      EQU $3b
DEF Bank3c      EQU $3c
DEF Bank3d      EQU $3d
DEF Bank3e      EQU $3e
DEF Bank3f      EQU $3f

; Inputs
DEF Input_A        EQU $01
DEF Input_B        EQU $02
DEF Input_Select   EQU $04
DEF Input_Start    EQU $08
DEF Input_Right    EQU $10
DEF Input_Left     EQU $20
DEF Input_Up       EQU $40
DEF Input_Down     EQU $80

; Menu Types
DEF MenuType_PausedInMediaDimension   EQU $00
DEF MenuType_ExitGame                 EQU $01
DEF MenuType_PausedInLevel            EQU $02
DEF MenuType_ExitToMap                EQU $03
DEF MenuType_GameOverTotals           EQU $04
DEF MenuType_ViewTotals               EQU $05
DEF MenuType_ViewPassword             EQU $06
DEF MenuType_TitleOptions             EQU $07
DEF MenuType_EnteringLevelName        EQU $08
DEF MenuType_MissionSelect1Option     EQU $09
DEF MenuType_MissionSelect2Options    EQU $0A
DEF MenuType_MissionSelect3Options    EQU $0B
DEF MenuType_GameOver                 EQU $0C
DEF MenuType_BlackScreen              EQU $0D
DEF MenuType_Congratulations          EQU $0E
DEF MenuType_EnterPassword            EQU $0F
DEF MenuType_TitleScreen              EQU $10
DEF MenuType_AudioOptionsUnused       EQU $11
DEF MenuType_CreditsGreatJob          EQU $12
DEF MenuType_TitleCrave               EQU $13
DEF MenuType_TitleSplash              EQU $14
DEF MenuType_EnteredInvalidPassword   EQU $15
DEF MenuType_TitleDavid               EQU $16
DEF MenuType_Credits1                 EQU $17
DEF MenuType_Credits2                 EQU $18
DEF MenuType_Credits3                 EQU $19
DEF MenuType_Credits4                 EQU $1A
DEF MenuType_TimeUp                   EQU $1B

; Music
DEF Music_KungFuTheater               EQU $00
DEF Music_CircuitCentral              EQU $01
DEF Music_PrehistoryChannel           EQU $02
DEF Music_Rezopolis                   EQU $03
DEF Music_unk_04                      EQU $04
DEF Music_ScreamTV                    EQU $05
DEF Music_ToonTV                      EQU $06
DEF Music_MediaDimension              EQU $07

; Levels
DEF Level_MediaDimension                         EQU $00
DEF Level_ToonTV_OutOfToon                       EQU $01
DEF Level_ScreamTV_Smellraiser                   EQU $02
DEF Level_ScreamTV_Frankensteinfeld              EQU $03
DEF Level_CircuitCentral_wwwdotcomcom            EQU $04
DEF Level_KungFuTheater_MaoTseTongue             EQU $05
DEF Level_unused_04                              EQU $06
DEF Level_PreHistoryChannel_Pangaea90210         EQU $07
DEF Level_ToonTV_FineTooning                     EQU $08
DEF Level_PreHistoryChannel_ThisOldCave          EQU $09
DEF Level_CircuitCentral_HoneyIShrunkTheGecko    EQU $0A
DEF Level_ScreamTV_Poltergex                     EQU $0B
DEF Level_unused_0C                              EQU $0C
DEF Level_KungFuTheater_SamuraiNightFever        EQU $0D
DEF Level_Rezopolis_NoWeddingsAndAFuneral        EQU $0E
DEF Level_unused_0F                              EQU $0F
DEF Level_ScreamTV_ThursdayThe12th               EQU $10
DEF Level_unused_11                              EQU $11
DEF Level_unused_12                              EQU $12
DEF Level_unused_13                              EQU $13
DEF Level_unused_14                              EQU $14
DEF Level_KungFuTheater_LizardInAChinaShop       EQU $15
DEF Level_Rezopolis_BuggedOut                    EQU $16
DEF Level_CircuitCentral_ChipsAndDips            EQU $17
DEF Level_PreHistoryChannel_LavaDabbaDoo         EQU $18
DEF Level_ScreamTV_TexasChainsawManicure         EQU $19
DEF Level_Rezopolis_MazedAndConfused             EQU $1A
DEF Level_unused_1B                              EQU $1B
DEF Level_unused_1C                              EQU $1C
DEF Level_unused_1D                              EQU $1D
DEF Level_BossTV_ChannelZ                        EQU $1E

; Objects
DEF Object_Gex                              EQU $00
DEF Object_CollectibleSpawn                 EQU $01
DEF Object_unk_02                           EQU $02 ; not in level object lists. may be unused
DEF Object_TVButton                         EQU $03
DEF Object_RedRemote                        EQU $04
DEF Object_SilverRemote                     EQU $05 ; hidden remote
DEF Object_GoldRemote                       EQU $06
DEF Object_EnemyDefeated                    EQU $07
DEF Object_unk_08                           EQU $08 ; not in level object lists. may be unused
DEF Object_ScreamTV_FallingPlatform         EQU $09
DEF Object_ScreamTV_MovingPlatform          EQU $0A
DEF Object_ScreamTV_PushBlock               EQU $0B ; in poltergex, push the block to cause platform to appear
DEF Object_ScreamTV_Pumpkin                 EQU $0C
DEF Object_ScreamTV_Frankie                 EQU $0D
DEF Object_ScreamTV_HeadGhost               EQU $0E
DEF Object_ScreamTV_HeadGhostHead           EQU $0F
DEF Object_ScreamTV_FloatingSkull           EQU $10
DEF Object_ScreamTV_FloatingSkullProjectile EQU $11
DEF Object_ScreamTV_Zombie                  EQU $12
DEF Object_ScreamTV_ZombieHead              EQU $13
DEF Object_ScreamTV_FallingAxe              EQU $14
DEF Object_ScreamTV_Lantern                 EQU $15
DEF Object_ScreamTV_Bat                     EQU $16
DEF Object_ScreamTV_OrangeMovingPlatform    EQU $17
DEF Object_ScreamTV_DoorOpening             EQU $18
DEF Object_ScreamTV_Ghost                   EQU $19
DEF Object_ScreamTV_ClimbWallSunEnemy       EQU $1A
DEF Object_ScreamTV_VanishingPlatform       EQU $1B
DEF Object_ScreamTV_MonaLisaElevator        EQU $1C
DEF Object_ToonTV_HardHeadAreaObject        EQU $1D
DEF Object_ToonTV_StationaryBearTrap        EQU $1E
DEF Object_ToonTV_MovingBearTrap            EQU $1F
DEF Object_ToonTV_Bumblebee                 EQU $20
DEF Object_ToonTV_FallingBowlingBall        EQU $21
DEF Object_ToonTV_Cactus                    EQU $22
DEF Object_ToonTV_Domino                    EQU $23
DEF Object_ToonTV_Shark                     EQU $24
DEF Object_ToonTV_Flower                    EQU $25
DEF Object_ToonTV_Hunter                    EQU $26
DEF Object_ToonTV_Mushroom                  EQU $27
DEF Object_unk_28                           EQU $28 ; not in level object lists. may be unused
DEF Object_ToonTV_Lizard                    EQU $29
DEF Object_ToonTV_HappyFace                 EQU $2A
DEF Object_ToonTV_VanishingBlock            EQU $2B
DEF Object_ToonTV_MovingBlock               EQU $2C
DEF Object_ToonTV_MovingLogPlatform         EQU $2D
DEF Object_ToonTV_StationaryLogPlatform     EQU $2E
DEF Object_ToonTV_FlowerHammerAttack        EQU $2F
DEF Object_ToonTV_HunterBullet              EQU $30
DEF Object_ToonTV_Rocket                    EQU $31
DEF Object_PreHistory_FastDinosaur          EQU $32 ; in pangaea 90210 above the happy face on map
DEF Object_PreHistory_Dragonfly             EQU $33
DEF Object_PreHistory_Egg                   EQU $34
DEF Object_unk_35                           EQU $35 ; not in level object lists. may be unused
DEF Object_unk_36                           EQU $36 ; not in level object lists. may be unused
DEF Object_PreHistory_FallingLava           EQU $37
DEF Object_PreHistory_LavaRaft              EQU $38
DEF Object_PreHistory_MovingPlatform        EQU $39
DEF Object_unk_3A                           EQU $3A ; not in level object lists. may be unused
DEF Object_unk_3B                           EQU $3B ; not in level object lists. may be unused
DEF Object_PreHistory_Pterosaur             EQU $3C
DEF Object_unk_3D                           EQU $3D ; not in level object lists. may be unused
DEF Object_PreHistory_FallingBoulder        EQU $3E
DEF Object_PreHistory_BeetleHorizontal      EQU $40 ; lava dabba doo on the climbable background
DEF Object_PreHistory_BeetleVertical        EQU $41
DEF Object_PreHistory_Ant                   EQU $42 ; lava dabba doo at the beginning
DEF Object_PreHistory_FirePlant             EQU $43
DEF Object_PreHistory_FirePlantProjectiles  EQU $44
DEF Object_PreHistory_Geyser                EQU $45
DEF Object_unk_46                           EQU $46 ; not in level object lists. may be unused
DEF Object_PreHistory_Dinosaur              EQU $47
DEF Object_PreHistory_Triceratops           EQU $48
DEF Object_PreHistory_TriceratopsHorn       EQU $49
DEF Object_unk_4A                           EQU $4A ; not in level object lists. may be unused
DEF Object_KungFuTheater_HangingBlade       EQU $4B
DEF Object_KungFuTheater_Cannon             EQU $4C
DEF Object_KungFuTheater_CannonProjectile   EQU $4D
DEF Object_KungFuTheater_Dragonfly          EQU $4E
DEF Object_KungFuTheater_DragonBodySegment  EQU $4F
DEF Object_KungFuTheater_DragonHead         EQU $50
DEF Object_unk_51                           EQU $51 ; not in level object lists. may be unused
DEF Object_KungFuTheater_DragonProjectile   EQU $52
DEF Object_KungFuTheater_WalkingNinja       EQU $53
DEF Object_KungFuTheater_JumpingNinja       EQU $54
DEF Object_KungFuTheater_SamuraiBody        EQU $55
DEF Object_KungFuTheater_SamuraiHead        EQU $56
DEF Object_KungFuTheater_Lizard             EQU $57
DEF Object_KungFuTheater_NinjaProjectile    EQU $58 ; jumping ninja throws projectiles, but not walking ninja
DEF Object_KungFuTheater_SpikyLog           EQU $59
DEF Object_KungFuTheater_TallJar            EQU $5A
DEF Object_KungFuTheater_Jar                EQU $5B
DEF Object_unk_5C                           EQU $5C ; not in level object lists. may be unused
DEF Object_unk_5D                           EQU $5D ; not in level object lists. may be unused
DEF Object_KungFuTheater_VanishingPlatform  EQU $5E
DEF Object_KungFuTheater_MovingPlatform     EQU $5F
DEF Object_unk_60                           EQU $60 ; not in level object lists. may be unused
DEF Object_KungFuTheater_MovingRaft         EQU $61
DEF Object_KungFuTheater_StationaryRaft     EQU $62
DEF Object_unk_63                           EQU $63 ; not in level object lists. may be unused
DEF Object_unk_64                           EQU $64 ; not in level object lists. may be unused
DEF Object_Rezopolis_SpecialMovingPlatform  EQU $65 ; at the start of no weddings
DEF Object_Rezopolis_MovingPlatform         EQU $66 ; small, yellow, and black
DEF Object_Rezopolis_RedPlatform            EQU $67 ; no weddings
DEF Object_Rezopolis_ActivatedRedPlatform   EQU $68 ; no weddings
DEF Object_Rezopolis_TailspinPlatform       EQU $69
DEF Object_Rezopolis_TailspinGear           EQU $6A
DEF Object_unk_6B                           EQU $6B ; not in level object lists. may be unused
DEF Object_unk_6C                           EQU $6C ; not in level object lists. may be unused
DEF Object_unk_6D                           EQU $6D ; not in level object lists. may be unused
DEF Object_Rezopolis_GreenMonster           EQU $6E
DEF Object_unk_6F                           EQU $6F ; not in level object lists. may be unused
DEF Object_unk_70                           EQU $70 ; not in level object lists. may be unused
DEF Object_Rezopolis_Pincer                 EQU $71
DEF Object_Rezopolis_Flamethrower           EQU $72
DEF Object_Rezopolis_UFO                    EQU $73
DEF Object_Rezopolis_Ant                    EQU $74 ; bugged out, spawned by hitting the gear
DEF Object_Rezopolis_AntSpawner             EQU $75 ; bugged out
DEF Object_CircuitCentral_Ant               EQU $76
DEF Object_CircuitCentral_Capacitor         EQU $77
DEF Object_CircuitCentral_PowerUp           EQU $78
DEF Object_unk_79                           EQU $79 ; not in level object lists. may be unused
DEF Object_CircuitCentral_LittleRobot       EQU $7A
DEF Object_CircuitCentral_LittleRobotGear   EQU $7B
DEF Object_CircuitCentral_ElectricBall      EQU $7C
DEF Object_CircuitCentral_MovingPlatform    EQU $7D
DEF Object_CircuitCentral_PoweredPlaform    EQU $7E
DEF Object_CircuitCentral_LoweringPlatform  EQU $7F
DEF Object_CircuitCentral_WalkerRobot       EQU $80
DEF Object_CircuitCentral_PoweredWalkway    EQU $81
DEF Object_CircuitCentral_WalkwayActivator  EQU $82
DEF Object_ChannelZ_ArcedGunProjectile      EQU $83
DEF Object_ChannelZ_ArcedGunProjectile2     EQU $84
DEF Object_ChannelZ_GunProjectile           EQU $85
DEF Object_ChannelZ_Rez                     EQU $86
DEF Object_unk_87                           EQU $87 ; not in level object lists. may be unused
DEF Object_unk_88                           EQU $88 ; not in level object lists. may be unused
DEF Object_ChannelZ_RezFollowingFire        EQU $89
DEF Object_ChannelZ_GunProjectileExplosion  EQU $8A
DEF Object_unk_8B                           EQU $8B ; not in level object lists. may be unused
DEF Object_ChannelZ_FinalBattleButton       EQU $8C
DEF Object_unk_8D                           EQU $8D ; not in level object lists. may be unused
DEF Object_unk_8E                           EQU $8E ; not in level object lists. may be unused
DEF Object_MediaDimension_MovingPlatform    EQU $8F
DEF ObjectListTerminator                    EQU $FF

; Text
DEF _Space            EQU $20
DEF _ExclamationPoint EQU $21
DEF _Apostrophe       EQU $27
DEF _Dash             EQU $2d
DEF _Period           EQU $2e
DEF _0                EQU $30
DEF _1                EQU $31
DEF _2                EQU $32
DEF _3                EQU $33
DEF _4                EQU $34
DEF _5                EQU $35
DEF _6                EQU $36
DEF _7                EQU $37
DEF _8                EQU $38
DEF _9                EQU $39
DEF _A                EQU $41
DEF _B                EQU $42
DEF _C                EQU $43
DEF _D                EQU $44
DEF _E                EQU $45
DEF _F                EQU $46
DEF _G                EQU $47
DEF _H                EQU $48
DEF _I                EQU $49
DEF _J                EQU $4A
DEF _K                EQU $4B
DEF _L                EQU $4C
DEF _M                EQU $4D
DEF _N                EQU $4E
DEF _O                EQU $4F
DEF _P                EQU $50
DEF _Q                EQU $51
DEF _R                EQU $52
DEF _S                EQU $53
DEF _T                EQU $54
DEF _U                EQU $55
DEF _V                EQU $56
DEF _W                EQU $57
DEF _X                EQU $58
DEF _Y                EQU $59
DEF _Z                EQU $5A
DEF TextTerminator    EQU $80
