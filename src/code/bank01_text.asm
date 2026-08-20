; ==================================================================
; MENU AND MAP TEXT - included into bank $01 by bank01_menus.asm
;
; Strings for the menu text renderer (call_01_4a8f_Text_Render). A string is a run
; of plain ASCII codes in which bit 7 marks the LAST byte of a line - that is what
; END_TEXT or's on - and a $00 byte after a line end finishes the string. There is
; no separate line terminator and no length byte, so a one-line string is just its
; characters with END_TEXT folded into the last one.
;
; Two groups live here. The fixed menu strings come first, then the per-map text
; blocks: four pointers each, being the level's name followed by its three mission
; descriptions, reached through MAPDATA_TEXT_BLOCK_PTR. A block whose entries point
; at bare END_TEXT bytes belongs to an unused map slot - the pointers exist so the
; table stays regular, but there is nothing to draw.
; ==================================================================

data_01_5ccf_Text_Start:
    db   "START", END_TEXT
data_01_5cd5_Text_Sound:
    db   "SOUND", END_TEXT
data_01_5cdb_Text_Password:
    db   "PASSWORD", END_TEXT
data_01_5ce4_Text_Paused:
    db   "PAUSED", END_TEXT
data_01_5ceb_Text_Resume:
    db   "RESUME", END_TEXT
data_01_5cf2_Text_Quit:
    db   "QUIT", END_TEXT
data_01_5cf7_Text_Exit:
    db   "EXIT", END_TEXT
data_01_5cfc_Text_QuitGame:
    db   "QUIT GAME", END_TEXT
data_01_5d06_Text_ExitToMap:
    db   "EXIT TO MAP", END_TEXT
data_01_5d12_Text_NoWay:
    db   "NO WAY!", END_TEXT
data_01_5d1a_Text_Okay:
    db   "OKAY", END_TEXT
data_01_5d1f_Text_TimeUp:
    db   "TIME UP!", END_TEXT
data_01_5d28_Text_GameOver:
    db   "GAME OVER", END_TEXT
data_01_5d32_Text_ResumePlay:
    db   "RESUME PLAY", END_TEXT
data_01_5d3e_Text_SeePassword:
    db   "SEE PASSWORD", END_TEXT

data_01_5d4b_Text_GameStats:
    db   "GAME STATS", END_TEXT
data_01_5d56_Text_Entering:
    db   "ENTERING...", END_TEXT
data_01_5d62_Text_LivesX:
    db   "X", END_TEXT
data_01_5d64_Text_Congratulations:
    db   "CONGRATULATIONS!", END_TEXT
data_01_5d75_Text_Reward:
    db   "REWARD", END_TEXT
data_01_5d7c_Text_Hidden:
    db   "HIDDEN", END_TEXT
data_01_5d83_Text_PressBToContinue:
    db   "PRESS B TO CONTINUE", END_TEXT
data_01_5d97_Text_0Of3RedRemotes:
    db   "0 OF 3 RED REMOTES FOUND", END_TEXT
data_01_5db0_Text_1Of3RedRemotes:
    db   "1 OF 3 RED REMOTES FOUND", END_TEXT
data_01_5dc9_Text_2Of3RedRemotes:
    db   "2 OF 3 RED REMOTES FOUND", END_TEXT
data_01_5de2_Text_3Of3RedRemotes:
    db   "3 OF 3 RED REMOTES FOUND", END_TEXT
data_01_5dfb_Text_0Of2RedRemotes:
    db   "0 OF 2 RED REMOTES FOUND", END_TEXT
data_01_5e14_Text_1Of2RedRemotes:
    db   "1 OF 2 RED REMOTES FOUND", END_TEXT
data_01_5e2d_Text_2Of2RedRemotes:
    db   "2 OF 2 RED REMOTES FOUND", END_TEXT
data_01_5e46_Text_0Of1RedRemotes:
    db   "0 OF 1 RED REMOTES FOUND", END_TEXT
data_01_5e5f_Text_1Of1RedRemotes:
    db   "1 OF 1 RED REMOTES FOUND", END_TEXT
data_01_5e78_Text_0Of1GoldRemotes:
    db   "0 OF 1 GOLD REMOTES FOUND", END_TEXT
data_01_5e92_Text_1Of1GoldRemotes:
    db   "1 OF 1 GOLD REMOTES FOUND", END_TEXT
data_01_5eac_Text_ChooseAHint:
    db   "CHOOSE A HINT THEN PRESS B TO CONTINUE", END_TEXT
data_01_5ed3_Text_PressBToContinueShort:
    db   "PRESS B TO CONTINUE", END_TEXT

data_01_5ee7_TVNameTable:
; The channel names shown above the mission list, indexed by the map's
; MAPDATA_TV_PALETTE_ID - the same index that picks the TV picture in
; data_01_5cb9_TVScreenImageTable, so the name and the artwork cannot disagree
    dw   data_01_5efd_Text_TVGameStats
    dw   data_01_5f08_Text_TVCircuitCentral
    dw   data_01_5f18_Text_TVKungFuTheatre
    dw   data_01_5f28_Text_TVPrehistChannel
    dw   data_01_5f38_Text_TVRezopolis
    dw   data_01_5f42_Text_TVRocketChannel
    dw   data_01_5f51_Text_TVScreamTV
    dw   data_01_5f5b_Text_TVToonTV
    dw   data_01_5f63_Text_TVBonusBonanza
    dw   data_01_5f71_Text_TVSecretStation
    dw   data_01_5f80_Text_TVBossTV

data_01_5efd_Text_TVGameStats:
    db   "GAME STATS", END_TEXT
data_01_5f08_Text_TVCircuitCentral:
    db   "CIRCUIT CENTRAL", END_TEXT
data_01_5f18_Text_TVKungFuTheatre:
    db   "KUNG-FU THEATRE", END_TEXT
data_01_5f28_Text_TVPrehistChannel:
    db   "PREHIST CHANNEL", END_TEXT
data_01_5f38_Text_TVRezopolis:
    db   "REZOPOLIS", END_TEXT
data_01_5f42_Text_TVRocketChannel:
    db   "ROCKET CHANNEL", END_TEXT
data_01_5f51_Text_TVScreamTV:
    db   "SCREAM TV", END_TEXT
data_01_5f5b_Text_TVToonTV:
    db   "TOON TV", END_TEXT
data_01_5f63_Text_TVBonusBonanza:
    db   "BONUS BONANZA", END_TEXT
data_01_5f71_Text_TVSecretStation:
    db   "SECRET STATION", END_TEXT
data_01_5f80_Text_TVBossTV:
    db   "BOSS TV", END_TEXT

; ------------------------------------------------------------------
; Per-map text blocks: level name, then missions 0, 1 and 2
; ------------------------------------------------------------------
data_01_5f88:
    dw   .data_01_5f90
    dw   .data_01_5fa4
    dw   .data_01_5fa5
    dw   .data_01_5fa6

.data_01_5f90:
    db   "THE MEDIA DIMENSION", END_TEXT
.data_01_5fa4:
    db   END_TEXT
.data_01_5fa5:
    db   END_TEXT
.data_01_5fa6:
    db   END_TEXT

data_01_5fa7:
    dw   .data_01_5faf
    dw   .data_01_5fbb
    dw   .data_01_5fd6
    dw   .data_01_5feb

.data_01_5faf:
    db   "OUT OF TOON", END_TEXT
.data_01_5fbb:
    db   "JUMP TO THE TEETERING ROCK", END_TEXT
.data_01_5fd6:
    db   "HUNT THE TWO HUNTERS", END_TEXT
.data_01_5feb:
    db   "WHACK FIVE PURPLE MUSHROOMS", END_TEXT

data_01_6007:
    dw   .data_01_600f
    dw   .data_01_601b
    dw   .data_01_6037
    dw   .data_01_6050

.data_01_600f:
    db   "SMELLRAISER", END_TEXT
.data_01_601b:
    db   "SURVIVE THE HAUNTED MANSION", END_TEXT
.data_01_6037:
    db   "SMASH FIVE BLOOD COOLERS", END_TEXT
.data_01_6050:
    db   "RIDE THE HAUNTED ELEVATOR", END_TEXT

data_01_606a:
    dw   .data_01_6072
    dw   .data_01_6083
    dw   .data_01_6098
    dw   .data_01_60ab

.data_01_6072:
    db   "FRANKENSTEINFELD", END_TEXT
.data_01_6083:
    db   "RUN THE AXE GAUNTLET", END_TEXT
.data_01_6098:
    db   "HEAD DOWN THE RAMP", END_TEXT
.data_01_60ab:
    db   "STICK ACROSS THE TOWER OF DOOM", END_TEXT

data_01_60ca:
    dw   .data_01_60d2
    dw   .data_01_60e1
    dw   .data_01_60ff
    dw   .data_01_611a

.data_01_60d2:
    db   "WWW.DOTCOM.COM", END_TEXT
.data_01_60e1:
    db   "SCALE THE BIONIC LAUNCH TOWER", END_TEXT
.data_01_60ff:
    db   "CROSS THE DATA BUS BRIDGES", END_TEXT
.data_01_611a:
    db   END_TEXT

data_01_611b:
    dw   .data_01_6123
    dw   .data_01_6132
    dw   .data_01_614b
    dw   .data_01_615e
    
.data_01_6123:
    db   "MAO TSE TONGUE", END_TEXT
.data_01_6132:
    db   "DEFEAT THE DEADLY DRAGON", END_TEXT
.data_01_614b:
    db   "TRAVERSE THE STEPS", END_TEXT
.data_01_615e:
    db   END_TEXT

data_01_615f:
    dw   .data_01_6167, .data_01_6168, .data_01_6169, .data_01_616a

.data_01_6167:
    db   END_TEXT
.data_01_6168:
    db   END_TEXT
.data_01_6169:
    db   END_TEXT
.data_01_616a:
    db   END_TEXT

data_01_616b:
    dw   .data_01_6173, .data_01_6181, .data_01_6199, .data_01_61ab
.data_01_6173:
    db   "PANGAEA 90210", END_TEXT
.data_01_6181:
    db   "ASSAULT THE LAVA ISLAND", END_TEXT
.data_01_6199:
    db   "CLIMB THE VOLCANO", END_TEXT
.data_01_61ab:
    db   END_TEXT

data_01_61ac:    
    dw   .data_01_61b4, .data_01_61c1, .data_01_61d0, .data_01_61e1
    
.data_01_61b4:
    db   "FINE TOONING", END_TEXT
.data_01_61c1:
    db   "CLIMB THE TREE", END_TEXT
.data_01_61d0:
    db   "STORM THE CASTLE", END_TEXT
.data_01_61e1:
    db   END_TEXT

data_01_61e2:    
    dw   .data_01_61ea, .data_01_61f8, .data_01_620f, .data_01_6224
    
.data_01_61ea:
    db   "THIS OLD CAVE", END_TEXT
.data_01_61f8:
    db   "WATCH FOR FALLING LAVA", END_TEXT
.data_01_620f:
    db   "RIDE THE STEAM VENTS", END_TEXT
.data_01_6224:
    db   "BOUNCE UP OVER THE CHASM", END_TEXT

data_01_623d:    
    dw   .data_01_6245, .data_01_625e, .data_01_6270, .data_01_6283
    
.data_01_6245:
    db   "HONEY I SHRUNK THE GECKO", END_TEXT
.data_01_625e:
    db   "CHARGE TO THE TOP", END_TEXT
.data_01_6270:
    db   "FIND THE I.O TOWER", END_TEXT
.data_01_6283:
    db   "CHARGE THE A.C.T. STEPS", END_TEXT

data_01_629b:    
    dw   .data_01_62a3, .data_01_62ad, .data_01_62c4, .data_01_62e0
    
.data_01_62a3:
    db   "POLTERGEX", END_TEXT
.data_01_62ad:
    db   "ASCEND THE GHOST TOWER", END_TEXT
.data_01_62c4:
    db   "REACH THE TOP OF THE MORGUE", END_TEXT
.data_01_62e0:
    db   "SMASH EIGHT BLOOD COOLERS", END_TEXT

data_01_62fa:    
    dw   .data_01_6302, .data_01_6303, .data_01_6304, .data_01_6305
    
.data_01_6302:
    db   END_TEXT
.data_01_6303:
    db   END_TEXT
.data_01_6304:
    db   END_TEXT
.data_01_6305:
    db   END_TEXT

data_01_6306:    
    dw   .data_01_630e, .data_01_6322, .data_01_633c, .data_01_6358
    
.data_01_630e:
    db   "SAMURAI NIGHT FEVER", END_TEXT
.data_01_6322:
    db   "NAVIGATE THE POWER TOWERS", END_TEXT
.data_01_633c:
    db   "RIDE THE FLOATING PLATFORMS", END_TEXT
.data_01_6358:
    db   "CLIMB THE TOWERING TEMPLE", END_TEXT

data_01_6372:    
    dw   .data_01_637a, .data_01_6394, .data_01_63b2, .data_01_63b3
    
.data_01_637a:
    db   "NO WEDDINGS AND A FUNERAL", END_TEXT
.data_01_6394:
    db   "PENETRATE REZ'S INNER SANCTUM", END_TEXT
.data_01_63b2:
    db   END_TEXT
.data_01_63b3:
    db   END_TEXT

data_01_63b4:    
    dw   .data_01_63bc, .data_01_63bd, .data_01_63be, .data_01_63bf

.data_01_63bc:    
    db   END_TEXT
.data_01_63bd:
    db   END_TEXT
.data_01_63be:
    db   END_TEXT
.data_01_63bf:
    db   END_TEXT

data_01_63c0:    
    dw   .data_01_63c8, .data_01_63da, .data_01_63fb, .data_01_63fc

.data_01_63c8:
    db   "THURSDAY THE 12TH", END_TEXT
.data_01_63da:
    db   "FIND THE ITEMS IN THE GIVEN TIME", END_TEXT
.data_01_63fb:
    db   END_TEXT
.data_01_63fc:
    db   END_TEXT

data_01_63fd:    
    dw   .data_01_6405, .data_01_6406, .data_01_6407, .data_01_6408
    
.data_01_6405:
    db   END_TEXT
.data_01_6406:
    db   END_TEXT
.data_01_6407:
    db   END_TEXT
.data_01_6408:
    db   END_TEXT

data_01_6409:    
    dw   .data_01_6411, .data_01_6412, .data_01_6413, .data_01_6414
    
.data_01_6411:
    db   END_TEXT
.data_01_6412:
    db   END_TEXT
.data_01_6413:
    db   END_TEXT
.data_01_6414:
    db   END_TEXT

data_01_6415:    
    dw   .data_01_641d, .data_01_641e, .data_01_641f, .data_01_6420
    
.data_01_641d:
    db   END_TEXT
.data_01_641e:
    db   END_TEXT
.data_01_641f:
    db   END_TEXT
.data_01_6420:
    db   END_TEXT

data_01_6421:    
    dw   .data_01_6429, .data_01_642a, .data_01_642b, .data_01_642c
    
.data_01_6429:
    db   END_TEXT
.data_01_642a:
    db   END_TEXT
.data_01_642b:
    db   END_TEXT
.data_01_642c:
    db   END_TEXT

data_01_642d:    
    dw   .data_01_6435, .data_01_644c, .data_01_646d, .data_01_646e
    
.data_01_6435:
    db   "LIZARD IN A CHINA SHOP", END_TEXT
.data_01_644c:
    db   "FIND THE ITEMS IN THE GIVEN TIME", END_TEXT
.data_01_646d:
    db   END_TEXT
.data_01_646e:
    db   END_TEXT

data_01_646f:    
    dw   .data_01_6477, .data_01_6482, .data_01_64a3, .data_01_64a4
    
.data_01_6477:
    db   "BUGGED OUT", END_TEXT
.data_01_6482:
    db   "FIND THE ITEMS IN THE GIVEN TIME", END_TEXT
.data_01_64a3:
    db   END_TEXT
.data_01_64a4:
    db   END_TEXT

data_01_64a5:    
    dw   .data_01_64ad, .data_01_64bc, .data_01_64dd, .data_01_64de
    
.data_01_64ad:
    db   "CHIPS AND DIPS", END_TEXT
.data_01_64bc:
    db   "FIND THE ITEMS IN THE GIVEN TIME", END_TEXT
.data_01_64dd:
    db   END_TEXT
.data_01_64de:
    db   END_TEXT

data_01_64df:    
    dw   .data_01_64e7, .data_01_64f5, .data_01_6510, .data_01_6511
    
.data_01_64e7:
    db   "LAVA DABA DOO", END_TEXT
.data_01_64f5:
    db   "NAVIGATE THE RIVER OF FIRE", END_TEXT
.data_01_6510:
    db   END_TEXT
.data_01_6511:
    db   END_TEXT

data_01_6512:    
    dw   .data_01_651a, .data_01_6532, .data_01_654e, .data_01_654f
    
.data_01_651a:
    db   "TEXAS CHAINSAW MANICURE", END_TEXT
.data_01_6532:
    db   "RIDE THE FLOATING FURNITURE", END_TEXT
.data_01_654e:
    db   END_TEXT
.data_01_654f:
    db   END_TEXT

data_01_6550:    
    dw   .data_01_6558, .data_01_656b, .data_01_6580, .data_01_65a6
    
.data_01_6558:
    db   "MAZED AND CONFUSED", END_TEXT
.data_01_656b:
    db   "PASS THE T.V. FOREST", END_TEXT
.data_01_6580:
    db   "CROSS THE BLUE BEAMS TO THE REZ TOWER", END_TEXT
.data_01_65a6:
    db   END_TEXT

data_01_65a7:    
    dw   .data_01_65af, .data_01_65b0, .data_01_65b1, .data_01_65b2
    
.data_01_65af:
    db   END_TEXT
.data_01_65b0:
    db   END_TEXT
.data_01_65b1:
    db   END_TEXT
.data_01_65b2:
    db   END_TEXT

data_01_65b3:    
    dw   .data_01_65bb, .data_01_65bc, .data_01_65bd, .data_01_65be
    
.data_01_65bb:
    db   END_TEXT
.data_01_65bc:
    db   END_TEXT
.data_01_65bd:
    db   END_TEXT
.data_01_65be:
    db   END_TEXT

data_01_65bf:    
    dw   .data_01_65c7, .data_01_65c8, .data_01_65c9, .data_01_65ca
    
.data_01_65c7:
    db   END_TEXT
.data_01_65c8:
    db   END_TEXT
.data_01_65c9:
    db   END_TEXT
.data_01_65ca:
    db   END_TEXT

data_01_65cb:    
    dw   .data_01_65d3, .data_01_65dd, .data_01_65fc, .data_01_65fd,
    
.data_01_65d3:
    db   "CHANNEL Z", END_TEXT
.data_01_65dd:
    db   "DEFEAT REZ IN THE FINAL BATTLE", END_TEXT
.data_01_65fc:
    db   END_TEXT
.data_01_65fd:
    db   END_TEXT
