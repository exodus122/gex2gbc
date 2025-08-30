;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "wram0", WRAM0[$c000]

wC000_BgMapTileIds:
; tiles currently loaded (for current 32x32 tile bg map)
    ds 1024                                               ;; c000

wC400_CollectibleCoordinates:
; C400 to C500 stores the x position of each collectible in the current level
; C500 to C600 stores the y position of each collectible in the current level
; C500 to C600 also gets set to FF when you get the collectible
    ds 512                                             ;; c400

wC600_CollectibleRelated:
    ds 512                                            ;; c600

wC800_CurrentCollisionData:
;C800 to CC00 is the collision data currently loaded (for current 32x32 tile bg map)
    ds 1024

wCC00:
    ds 1                                               ;; cc00

wCC01:
    ds 95                                              ;; cc01

wCC60:
    ds 32                                              ;; cc60

wCC80:
    ds 32                                              ;; cc80

wCCA0:
    ds 4                                               ;; cca0

wCCA4:
    ds 1                                               ;; cca4

wCCA5:
    ds 2                                               ;; cca5

wCCA7:
    ds 86                                              ;; cca7

wCCFD:
    ds 1                                               ;; ccfd

wCCFE:
    ds 1                                               ;; ccfe

wCCFF:
    ds 1                                             ;; ccff

wCD00_BgTileFlags:
; updated when hit a checkpoint in a level, or a blood cooler
; or hidden smellraiser switch, etc.
    ds 256

wCE00_BgTileFlags:
; updated when hit a checkpoint in a level, or a blood cooler
; or hidden smellraiser switch, etc.
    ds 256

wCF00_SpecialTilePaletteIds:
    ds 256                                             ;; cf00

wD000_ObjectFlags:
;; FF = killed enemy
;; 01 = active
    ds 256                                             ;; d000

wD100_TilesToLoadBuffer:
    ds 256                                             ;; d100


; From D200 to D300 is the loaded objects space
; Each object takes up 0x20 of space, and there can be up to 8 objects. 
; Gex occupies the first slot. The first byte of each object is the id

; Object Instance Struct
; 0x00 object id
; 0x01 current action id (index into action jump table)
; 0x02-0x03 pointer to current action function
; 0x04-0x05 ? pointer to some data in bank 2, whose value is set to 0x0C
; 0x06 ? animation timer, how many frames to be in this animation?
; 0x07 ? animation timer/index?, which frame of animation?
; 0x08 sprite index (for example gex's 4 standing sprites are 0x14-0x17, and that's the index to those sprites in bank 4
; 0x09 ? bitfield
; 0x0A ? bitfield
; 0x0B ? gets its value from table pointed to by 0x04-0x05
; 0x0C ? unknown byte whose value comes from pointer in 0x04-0x05
; 0x0D facing angle. right: 0x00, left: 0x20 
; 0x0E-0x0F x position on map
; 0x10-0x11 y position on map
; 0x12 x position on screen
; 0x13 y position on screen
; 0x14-0x15 is ? 
; 0x16 is index into bank 3 graphics jump table
; 
; 

wD200_PlayerObject_Id:
    ds 1                                               ;; d200

wD201_PlayerObject_ActionId:
    ds 1                                               ;; d201

wD202_PlayerObject_ActionFunc:
    ds 2                                               ;; d202

    ds 3

wD207:
    ds 1                                               ;; d207

wD208_PlayerSpriteIndex:
    ds 1                                               ;; d208

wD209:
    ds 1                                               ;; d209

wD20A:
    ds 3                                               ;; d20a

wD20D_PlayerFacingAngle:
    ds 1                                               ;; d20d

; wD20E_PlayerXPosition and wD20F_PlayerXPosition_PlayerXPosition control gex's x coordinate position (can freeze wD20F_PlayerXPosition_PlayerXPosition to sometimes fall through floors)
wD20E_PlayerXPosition:
    ds 1                                               ;; d20e

wD20F_PlayerXPosition:
    ds 1                                               ;; d20f

; wD210_PlayerYPosition and wD211_PlayerYPosition control gex's y coordinate position (can freeze both to hover at fixed height)
; can also set to 0000 to warp to top of map for example
wD210_PlayerYPosition:
    ds 1                                               ;; d210

wD211_PlayerYPosition:
    ds 1                                               ;; d211

wD212_PlayerScreenXPosition:
    ds 1                                               ;; d212

wD213_PlayerScreenYPosition:
    ds 1

    ds 12                                              ;; d213

wD220_OtherLoadedObjects:
    ds 224                                             ;; d220

wD300_CurrentObjectAddr:
; addr of object currently being updated (normally set to first available slot)
    ds 1                                               ;; d300

wD301:
    ds 8                                               ;; d301

wD309:
    ds 1                                               ;; d309

wD30A:
    ds 1                                               ;; d30a

wD30B:
    ds 1                                               ;; d30b

wD30C:
    ds 29                                              ;; d30c

wD329:
    ds 1                                               ;; d329

wD32A:
    ds 1                                               ;; d32a

wD32B:
    ds 1                                               ;; d32b

wD32C:
    ds 1                                               ;; d32c

wD32D:
    ds 8                                               ;; d32d

wD335:
    ds 1                                               ;; d335

wD336_CurrentObjectToLoadPtr:
    ds 1                                               ;; d336

wD337_CurrentObjectToLoadPtr:
    ds 1                                               ;; d337

wD338:
    ds 1                                               ;; d338

wD339:
    ds 1                                               ;; d339

wD33A:
    ds 1                                               ;; d33a

wD33B:
    ds 1                                             ;; d33b

wD33C:
    ds 33

wD35D:
    ds 33

wD37E:
    ds 33

wD39F:
    ds 33

wD3C0:
    ds 33

wD3E1:
    ds 33

wD402:
    ds 33

wD423:
    ds 33

wD444:
    ds 40

wD46C:
    ds 40

wD494:
    ds 40

wD4BC:
    ds 40

wD4E4:
    ds 40

wD50C:
    ds 40

wD534:
    ds 40

wD55C:
    ds 40

wD584_CollisionFlagsPrev:
; copy of the value that wD585_CollisionFlags had at the start of the frame
    ds 1                                               ;; d584

wD585_CollisionFlags:
    ds 1                                               ;; d585

wD586:
    ds 1                                               ;; d586

wD587:
    ds 1                                               ;; d587

wD588:
    ds 1                                               ;; d588

wD589:
    ds 1                                               ;; d589

wD58A:
    ds 16                                              ;; d58a

wD59A:
; used to switch back to previous bank after loaded asset from a new bank (or ran code?)
    ds 2                                               ;; d59a

wD59C_CurrentROMBank:
    ds 1                                               ;; d59c

wD59D_ReturnBank:
; bank to return to after the upcoming bank switch
    ds 1                                               ;; d59d

wD59E:
    ds 1                                               ;; d59e

wD59F_CurrentInputs: ; A = 01, B = 02, Select = 04, Start = 08, Right = 0x10, Left = 0x20, Up = 0x40, Down = 0x80
    ds 1                                               ;; d59f

wD5A0:
    ds 1                                               ;; d5a0

wD5A1: ; related to gex's x position
    ds 1                                               ;; d5a1

wD5A2: ; related to gex's y position
    ds 1                                               ;; d5a2

wD5A3:
    ds 1                                               ;; d5a3

wD5A4:
    ds 1                                               ;; d5a4

wD5A5:
    ds 1                                               ;; d5a5

wD5A6_TextBuffer: ; goes until at least D5CC
    ds 1                                               ;; d5a6

wD5A7:
    ds 1                                               ;; d5a7

wD5A8:
    ds 1                                               ;; d5a8

wD5A9:
    ds 1                                               ;; d5a9

wD5AA:
    ds 100                                             ;; d5aa

wD60E:
    ds 1                                               ;; d60e

wD60F_BitmapOfThingsToLoad:
    ds 1                                               ;; d60f

wD610:
    ds 1                                               ;; d610

wD611_MovingTilesId:
    ds 1                                               ;; d611

wD612_MovingTilesId:
    ds 1                                               ;; d612

wD613:
    ds 1                                               ;; d613

wD614:
    ds 2                                               ;; d614

wD616:
    ds 1                                               ;; d616

wD617:
    ds 1                                               ;; d617

wD618_CheckpointSpawnId:
    ds 1                                               ;; d618

wD619_TitleScreenCounter:
; frame count used for starting demo
    ds 1                                               ;; d619

wD61A_TitleScreenCounter:
; frame count used for starting demo
    ds 1                                               ;; d61a

wD61B_DemoInputsPointer:
; pointer to current demo mode inputs
    ds 1                                               ;; d61b

wD61C_DemoInputsPointer:
; pointer to current demo mode inputs
    ds 1                                               ;; d61c

wD61D:
    ds 1                                               ;; d61d

wD61E_DemoModeEnabled:
    ds 1                                               ;; d61e

wD61F_DemoRelatedCounter:
; counter of how many frames to input the demo inputs?
    ds 1                                               ;; d61f

wD620_DemoInputs:
; demo inputs that are being played currently
    ds 1                                               ;; d620

wD621:
    ds 1                                               ;; d621

wD622:
    ds 1                                               ;; d622

wD623:
    ds 1                                               ;; d623

wD624_CurrentLevelId:
    ds 1                                               ;; d624

wD625_TotalsMenuPage:
; which page you are on in the totals menu
    ds 1                                               ;; d625

wD626: ; unknown but related to the level you enter. 1 for smellraiser, 3 for out of toon, 2 for kung fu?, 3 for franken, 1 for thursday
    ds 1                                               ;; d626

wD627_CurrentMission:
; which mission you selected when entered a level
    ds 1                                               ;; d627

wD628_MediaDimensionRespawnPoint:
; which tv you respawn at if you die in media dimension
; also where you go if you quit current level
    ds 1                                               ;; d628

wD629_RemoteProgressFlags: 
    ds 30                                              ;; d629
; D62A : out of toon obtained remotes bitfield (1F = all)
; D62B : smellraiser obtained remotes bitfield (1F = all)
; D62C : frankensteinfeld obtained remotes bitfield (1F = all)
; D62D : www.dotcom.com obtained remotes bitfield (1B = all)
; D62E : moa tse tongue obtained remotes bitfield (1B = all)
; D62F : ? obtained remotes bitfield (unused byte, deleted world?)
; D630 : pangaea 90210 obtained remotes bitfield (1B = all)
; D631 : fine tooning obtained remotes bitfield (1B = all)
; D632 : this old cave obtained remotes bitfield (1F = all)
; D633 : honey I shrunk the gecko obtained remotes bitfield (1F = all)
; D634 : poltergex obtained remotes bitfield (1F = all)
; D635 : ? obtained remotes bitfield (unused byte, deleted world?)
; D636 : samurai night fever obtained remotes bitfield (1F = all)
; D637 : no weddings and a funeral obtained remotes bitfield (19 = all)
; D638 : ? obtained remotes bitfield (unused byte, deleted world?)
; D639 : thursday the 12th obtained remotes bitfield (20 = all)


; D63E : lizard in a china shop obtained remotes bitfield (20 = all)
; D63F : bugged out obtained remotes bitfield (20 = all)
; D640 : chips and dips obtained remotes bitfield (20 = all)
; D641 : lava daba doo obtained remotes bitfield (01 = all)
; D642 : texas chainsaw manicure obtained remotes bitfield (01 = all)
; D643 : mazed and confused obtained remotes bitfield (03 = all)

wD647:
    ds 1                                               ;; d647

wD648:
    ds 1                                               ;; d648

wD649_CollectibleAmount:
    ds 1                                               ;; d649

wD64A:
    ds 1                                               ;; d64a

wD64B:
    ds 1                                               ;; d64b

wD64C:
    ds 1                                               ;; d64c

wD64D:
    ds 1                                               ;; d64d

wD64E:
    ds 1                                               ;; d64e

wD64F:
    ds 1                                               ;; d64f

wD650:
    ds 1                                               ;; d650

wD651:
    ds 1                                               ;; d651

wD652:
    ds 8                                               ;; d652

wD65A:
    ds 1                                               ;; d65a

wD65B:
    ds 1                                               ;; d65b

wD65C:
    ds 8                                               ;; d65c

wD664:
    ds 1                                               ;; d664

wD665:
    ds 2                                               ;; d665

wD667_PasswordExitButton: ; Password exit button (value 49)
    ds 1                                               ;; d667

wD668_PasswordValues: ; password on entry screen and in game
; 20 is blank
; solid color arrows: 45 right, 46 left, 47 up, 48 down
; outlined arrows:  41 right, 42 left, 43 up, 44 down
; bug: the first time you enter a value after going into the "enter password" screen, 
; it updates the value, but not visually
    ds 28                                              ;; d668

wD684_PasswordGoButton: ; Password go button (value 4a)
    ds 1                                               ;; d684

wD685:
    ds 1                                               ;; d685

wD686:
    ds 1                                               ;; d686

wD687:
    ds 1                                               ;; d687

wD688:
    ds 1                                               ;; d688

wD689:
    ds 1                                               ;; d689

; start data related to current menu (8 bytes from data_01_5574 for a particular menu type)
wD68A_MenuTypeDataPointer:
    ds 2                                               ;; d68a

wD68C:
    ds 1                                               ;; d68c

wD68D:
    ds 1                                               ;; d68d

wD68E:
    ds 1                                               ;; d68e

wD68F:
    ds 1                                               ;; d68f

wD690:
    ds 1                                               ;; d690

wD691:
    ds 1                                               ;; d691

; end data related to current menu

wD692:
    ds 1                                               ;; d692

wD693:
    ds 1                                               ;; d693

wD694:
    ds 1                                               ;; d694

wD695:
    ds 1                                               ;; d695

wD696:
    ds 1                                               ;; d696

wD697:
    ds 1                                               ;; d697

wD698:
    ds 1                                               ;; d698

wD699:
    ds 1                                               ;; d699

wD69A:
    ds 1                                               ;; d69a

wD69B:
    ds 1                                               ;; d69b

wD69C:
    ds 1                                               ;; d69c

wD69D:
    ds 1                                               ;; d69d

wD69E:
    ds 1                                               ;; d69e

wD69F:
    ds 2                                               ;; d69f

wD6A1:
    ds 2                                               ;; d6a1

wD6A3:
    ds 1                                               ;; d6a3

wD6A4:
    ds 1                                              ;; d6a4

wD6A5_PasswordTilesBank:
    ds 1

wD6A6:
    ds 1
    
wD6A7:
    ds 1
    
wD6A8:
    ds 1
    
wD6A9:
    ds 2
    
wD6AB:
    ds 2
    
wD6AD:
    ds 2
    
wD6AF:
    ds 1

wD6B0:
    ds 1                                               ;; d6b0

wD6B1:
    ds 2                                               ;; d6b1

wD6B3:
    ds 1                                               ;; d6b3

wD6B4:
    ds 1                                               ;; d6b4

wD6B5:
    ds 1                                               ;; d6b5

wD6B6:
    ds 1                                               ;; d6b6

wD6B7:
    ds 1                                               ;; d6b7

wD6B8:
    ds 1                                               ;; d6b8

wD6B9:
    ds 1                                               ;; d6b9

wD6BA:
    ds 1                                               ;; d6ba

wD6BB:
    ds 1                                               ;; d6bb

wD6BC:
    ds 1                                               ;; d6bc

wD6BD:
    ds 1                                               ;; d6bd

wD6BE:
    ds 1                                               ;; d6be

wD6BF:
    ds 1                                               ;; d6bf

wD6C0:
    ds 1                                               ;; d6c0

wD6C1:
    ds 1                                               ;; d6c1

wD6C2:
    ds 1                                               ;; d6c2

wD6C3:
    ds 1                                               ;; d6c3

wD6C4:
    ds 1                                               ;; d6c4

wD6C5:
    ds 16                                              ;; d6c5

wD6D5:
    ds 1                                               ;; d6d5

wD6D6:
    ds 1                                               ;; d6d6

wD6D7:
    ds 1                                               ;; d6d7

wD6D8:
    ds 1                                               ;; d6d8

wD6D9:
    ds 1                                               ;; d6d9

wD6DA:
    ds 1                                               ;; d6da

wD6DB:
    ds 1                                               ;; d6db

wD6DC: ; menu related
    ds 1                                               ;; d6dc

wD6DD: ; menu related
    ds 1                                               ;; d6dd

wD6DE_MenuType: 
; 0 = pause in media dimension, 1 = exit game, 2 = pause in world, 3 = exit to map
; 5 = view totals, 6 = current password, B = mission select, F = enter password
    ds 1                                               ;; d6de

wD6DF_MenuSelectedColumn: ; used for password entry, but not totals screen
    ds 1                                               ;; d6df

wD6E0_MenuSelectedRow: ; used for password entry, title screen, mission select, and leaving maps
    ds 1                                               ;; d6e0

wD6E1:
    ds 1                                               ;; d6e1

wD6E2:
    ds 1                                               ;; d6e2

wD6E3:
    ds 1                                               ;; d6e3

wD6E4:
    ds 1                                               ;; d6e4

wD6E5_PasswordArrowSprites:
    ds 1                                               ;; d6e5

wD6E6_PasswordArrowSprites:
    ds 1                                               ;; d6e6

wD6E7_PasswordArrowSprites:
    ds 1                                               ;; d6e7

wD6E8_PasswordArrowSprites:
    ds 1                                               ;; d6e8

wD6E9:
    ds 1                                               ;; d6e9

wD6EA:
    ds 1                                               ;; d6ea

wD6EB:
    ds 1                                               ;; d6eb

wD6EC:
    ds 1                                               ;; d6ec

wD6ED_XPositionInMap: ; current x position in map of screen/player?
    ds 2                                               ;; d6ed

wD6EF_YPositionInMap: ; current y position in map of screen/player?
    ds 1                                               ;; d6ef

wD6F0:
    ds 1                                               ;; d6f0

wD6F1:
    ds 2                                               ;; d6f1

wD6F3:
    ds 2                                               ;; d6f3

wD6F5_CurrentMapBank:
    ds 1                                               ;; d6f5

wD6F6_CurrentMapSpecialTileBank:
    ds 1                                               ;; d6f6

wD6F7_CurrentBlocksetAndCollisionBank:
    ds 2                                               ;; d6f7

wD6F9:
    ds 1                                               ;; d6f9

wD6FA:
    ds 1                                               ;; d6fa

wD6FB:
    ds 1                                               ;; d6fb

wD6FC:
    ds 1                                               ;; d6fc

wD6FD:
    ds 1                                               ;; d6fd

wD6FE_LevelTileOverrideBit:
    ds 1                                               ;; d6fe

wD6FF_CurrentBgTilesetBank:
    ds 1                                               ;; d6ff

wD700:
    ds 2                                               ;; d700

wD702:
    ds 1                                               ;; d702

wD703:
    ds 11                                              ;; d703

wD70E:
    ds 1                                               ;; d70e

wD70F:
    ds 11                                              ;; d70f

wD71A:
    ds 4                                               ;; d71a

wD71E:
    ds 1                                               ;; d71e

wD71F:
    ds 1                                               ;; d71f

wD720:
    ds 1                                               ;; d720

wD721:
    ds 1                                               ;; d721

wD722:
    ds 1                                               ;; d722

wD723:
    ds 1                                               ;; d723

wD724:
    ds 1                                               ;; d724

wD725:
    ds 1                                               ;; d725

wD726_SpecialTilesetBank:
    ds 1                                               ;; d726

wD727:
    ds 1                                               ;; d727

wD728_CurrentSpecialTilesetAddr: ; this determines which special tilset to load (and is loading)
    ds 1                                               ;; d728

wD729:
    ds 1                                               ;; d729

wD72A:
    ds 1                                               ;; d72a

wD72B:
    ds 1                                               ;; d72b

wD72C:
    ds 1                                               ;; d72c

wD72D_CurrentSpecialTilesetIndex:
    ds 1                                               ;; d72d

wD72E:
    ds 1                                               ;; d72e

wD72F:
    ds 1                                               ;; d72f

wD730:
    ds 1                                               ;; d730

wD731:
    ds 1                                               ;; d731

wD732:
    ds 1                                               ;; d732

wD733:
    ds 1                                               ;; d733

wD734:
    ds 1                                               ;; d734

wD735:
    ds 1                                               ;; d735

wD736:
    ds 1                                               ;; d736

wD737:
    ds 1                                               ;; d737

wD738:
    ds 1                                               ;; d738

wD739:
    ds 1                                               ;; d739

wD73A:
    ds 1                                               ;; d73a

wD73B:
    ds 1                                               ;; d73b

wD73C:
    ds 1                                               ;; d73c

wD73D_LivesRemaining:
    ds 1                                               ;; d73d

wD73E_PlayerLivesHundreds: ; the hundreds unit of your lives
    ds 1                                               ;; d73e

wD73F_PlayerLivesTens: ; the tens unit of your lives
    ds 1                                               ;; d73f

wD740_PlayerLivesOnes: ; the ones unit of your lives
    ds 1                                               ;; d740

wD741_PlayerHealth:
    ds 1                                               ;; d741

wD742_PlayerCurrentFly:
    ds 1                                               ;; d742

wD743:
    ds 1                                               ;; d743

wD744:
    ds 1                                               ;; d744

wD745:
    ds 1                                               ;; d745

wD746_PlayerClimbingState:
; 0 = climbing background
; 1 = climbing background and tail spinning
; 2 = climbing wall
; 3 = climbing wall and tail spinning
; 6 = climbing background - dropping down to floor
; 7 = ?
; 8 = ?
; 9 = ?
; FF = default (run normal collision func)
    ds 1                                               ;; d746

wD747:
    ds 1                                               ;; d747

wD748:
    ds 1                                               ;; d748

wD749:
    ds 1                                               ;; d749

wD74A:
    ds 1                                               ;; d74a

wD74B:
    ds 1                                               ;; d74b

wD74C:
    ds 1                                               ;; d74c

wD74D:
    ds 1                                               ;; d74d

wD74E:
    ds 1                                               ;; d74e

wD74F:
    ds 1                                               ;; d74f

wD750:
    ds 1                                               ;; d750

wD751:
    ds 1                                               ;; d751

wD752:
    ds 1                                               ;; d752

wD753:
    ds 1                                               ;; d753

wD754:
    ds 1                                               ;; d754

wD755:
    ds 1                                               ;; d755

wD756:
    ds 1                                               ;; d756

wD757:
    ds 1                                               ;; d757

wD758:
    ds 1                                               ;; d758

wD759:
    ds 1                                               ;; d759

wD75A_CurrentInputs:
; button bits are only set for 1 frame. d-pad stays set while held
; A = 01, B = 02, Select = 04, Start = 08, Right = 0x10, Left = 0x20, Up = 0x40, Down = 0x80
    ds 1                                               ;; d75a

wD75B_IdleTimer:
; counter used to determine if gex has been idle long enough to do the tongue flick
    ds 1                                               ;; d75b

wD75C:
    ds 1                                               ;; d75c

wD75D_PlayerXSpeedPrev:
; (1 = walk, 2 = run)
    ds 1                                               ;; d75d

wD75E_PlayerXSpeed:
; how fast gex runs (1 = walk, 2 = run)
; can freeze to change how fast you run, but doesn't make you move by itself
    ds 1                                               ;; d75e

wD75F_PlayerYVelocityRelated:
    ds 1                                               ;; d75f

wD760_PlayerYVelocity:
; signed byte (positive = up, negative = down)
; can freeze this to levitate
    ds 1                                               ;; d760

wD761_PlayerFallingFlag:
; set to c0 when gex is falling, 0 otherwise?
    ds 1                                               ;; d761

wD762_PlayerInitialYVelocity:
; y velocity when first entered the air (2a = jump, 36 = double jump). also set to 1 if fall off ledge
    ds 1                                               ;; d762

wD763_PlayerMovementFlags:
    ds 1                                               ;; d763

wD764_TileTypeBehindGexsBody:
    ds 1                                               ;; d764

wD765_TileTypeBehindGexsBody:
    ds 1                                               ;; d765

wD766_TileTypeBehindGexsFace: ; also set to 22 in front of doors?
    ds 1                                               ;; d766

wD767_FloorTileType:
    ds 1                                               ;; d767

    ds 1

wD769:
    ds 1                                               ;; d769

wD76A_PlayerXPositionBlock:
    ds 1                                               ;; d76a

wD76B_TailSpinningFlagMaybe:
    ds 1                                               ;; d76b

wD76C:
    ds 1                                               ;; d76c

wD76D:
    ds 1                                               ;; d76d

wD76E:
    ds 1                                               ;; d76e

wD76F:
    ds 1                                               ;; d76f

wD770:
    ds 1                                               ;; d770

wD771:
    ds 1                                               ;; d771

wD772:
    ds 1                                               ;; d772

wD773:
    ds 1                                               ;; d773

wD774:
    ds 1                                               ;; d774

wD775:
    ds 3                                               ;; d775

wD778:
    ds 1                                               ;; d778

wD779_RelatedToXPosition:
    ds 1                                               ;; d779

wD77A_PlayerYPositionBlock:
    ds 1                                               ;; d77a

wD77B:
    ds 1                                               ;; d77b

wD77C:
    ds 1                                               ;; d77c

wD77D:
    ds 1                                               ;; d77d

wD77E:
    ds 1                                               ;; d77e

wD77F:
    ds 1                                               ;; d77f

wD780:
    ds 1                                               ;; d780

wD781:
    ds 1                                               ;; d781

wD782:
    ds 1                                               ;; d782

wD783:
    ds 1                                               ;; d783

wD784:
    ds 1                                               ;; d784

wD785:
    ds 1                                               ;; d785

wD786:
    ds 1                                               ;; d786

wD787:
    ds 1                                               ;; d787

wD788_CurrentAudioBank:
    ds 1                                               ;; d788

wD789: ; audio related
    ds 1                                               ;; d789

wD78A_MusicId: ; multiplied by 4 and used as index into .data_00_1244_MusicList
    ds 1                                               ;; d78a

wD78B:
    ds 4                                              ;; d78b

wD78F:
    ds 9

wD798:
    ds 2                                               ;; d798

wD79A:
    ds 1                                               ;; d79a

wD79B:
    ds 1                                               ;; d79b

wD79C:
    ds 1                                               ;; d79c

wD79D:
    ds 1                                               ;; d79d

wD79E:
    ds 1                                               ;; d79e

wD79F:
    ds 256                                             ;; d79f

wD89F:
    ds 256                                             ;; d89f

wD99F:
    ds 8                                               ;; d99f

wD9A7:
    ds 32                                              ;; d9a7

wD9C7:
    ds 1                                               ;; d9c7

wD9C8:
    ds 1                                               ;; d9c8

wD9C9:
    ds 1                                               ;; d9c9

wD9CA:
    ds 1                                               ;; d9ca

wD9CB_Bg_Palettes:
    ds 48                                              ;; d9cb

wD9FB:
    ds 16                                              ;; d9fb

wDA0B_Obj_Palettes:
    ds 8                                               ;; da0b

wDA13:
    ds 8                                               ;; da13

wDA1B:
    ds 48                                              ;; da1b

wDA4B:
    ds 48                                              ;; da4b

wDA7B:
    ds 48                                              ;; da7b

wDAAB:
    ds 32                                              ;; daab

wDACB:
    ds 1                                               ;; dacb

wDACC:
    ds 1                                               ;; dacc

wDACD:
    ds 1                                               ;; dacd

wDACE:
    ds 1                                               ;; dace

wDACF:
    ds 1                                               ;; dacf

wDAD0:
    ds 1                                               ;; dad0

wDAD1:
    ds 1                                               ;; dad1

wDAD2:
    ds 1                                               ;; dad2

wDAD3:
    ds 1                                               ;; dad3

wDAD4:
    ds 1                                               ;; dad4

wDAD5:
    ds 1                                               ;; dad5

wDAD6:
    ds 1                                               ;; dad6

wDAD7:
    ds 1                                               ;; dad7

wDAD8:
    ds 1                                               ;; dad8

wDAD9:
    ds 1                                               ;; dad9

wDADA:
    ds 1                                               ;; dada

wDADB:
    ds 2                                               ;; dadb
    
; DADD through DFAD might be be unused memory?
    ds 1233

; The rest of wram is used for audio-related purposes

wDFAE_AudioBankDataPointer: ; always 60 (as in 0x4460, which is where the audio data begins in all 4 audio banks)
    ds 1                                               ;; dfae

wDFAF_AudioBankDataPointer: ; always 44 (as in 0x4460, which is where the audio data begins in all 4 audio banks)
    ds 1                                               ;; dfaf

wDFB0:
    ds 8                                               ;; dfb0

wDFB8:
    ds 1                                               ;; dfb8

wDFB9:
    ds 1                                               ;; dfb9

wDFBA:
    ds 1                                               ;; dfba

wDFBB:
    ds 1                                               ;; dfbb

wDFBC:
    ds 1                                               ;; dfbc

wDFBD:
    ds 1                                               ;; dfbd

wDFBE:
    ds 1                                               ;; dfbe

wDFBF:
    ds 1                                               ;; dfbf

wDFC0:
    ds 1                                               ;; dfc0

wDFC1:
    ds 1                                               ;; dfc1

wDFC2:
    ds 1                                               ;; dfc2

wDFC3:
    ds 8                                               ;; dfc3

wDFCB:
    ds 1                                               ;; dfcb

wDFCC:
    ds 1                                               ;; dfcc

wDFCD:
    ds 1                                               ;; dfcd

wDFCE:
    ds 1                                               ;; dfce

wDFCF:
    ds 1                                               ;; dfcf

wDFD0:
    ds 1                                               ;; dfd0

wDFD1:
    ds 1                                               ;; dfd1

wDFD2:
    ds 20                                              ;; dfd2

wDFE6:
    ds 16                                              ;; dfe6

wDFF6:
    ds 8                                               ;; dff6

wDFFE:
    ds 2                                               ;; dffe

SECTION "hram", HRAM[$ff80]

hFF80:
    ds 112                                             ;; ff80

hFFF0:
    ds 1                                               ;; fff0

hFFF1:
    ds 14                                              ;; fff1

SECTION "vram", VRAM[$8000]
    ds 8192                                            ;; 8000

SECTION "sram", SRAM[$a000]
    ds 8192                                            ;; a000
