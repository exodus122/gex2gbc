; MBC1
DEF MBC1SRamEnable      EQU $0001
DEF MBC1RomBank         EQU $2001
DEF MBC1SRamBank        EQU $4001
DEF MBC1SRamBankingMode EQU $6001

; ROM Banks
DEF BANK_00      EQU $00
DEF BANK_01      EQU $01
DEF BANK_02      EQU $02
DEF BANK_03      EQU $03
DEF BANK_04      EQU $04
DEF BANK_05      EQU $05
DEF BANK_06      EQU $06
DEF BANK_07      EQU $07
DEF BANK_08      EQU $08
DEF BANK_09      EQU $09
DEF BANK_0A      EQU $0A
DEF BANK_0B      EQU $0B
DEF BANK_0C      EQU $0C
DEF BANK_0D      EQU $0D
DEF BANK_0E      EQU $0E
DEF BANK_0F      EQU $0F
DEF BANK_10      EQU $10
DEF BANK_11      EQU $11
DEF BANK_12      EQU $12
DEF BANK_13      EQU $13
DEF BANK_14      EQU $14
DEF BANK_15      EQU $15
DEF BANK_16      EQU $16
DEF BANK_17      EQU $17
DEF BANK_18      EQU $18
DEF BANK_19      EQU $19
DEF BANK_1A      EQU $1A
DEF BANK_1B      EQU $1B
DEF BANK_1C      EQU $1C
DEF BANK_1D      EQU $1D
DEF BANK_1E      EQU $1E
DEF BANK_1F      EQU $1F
DEF BANK_20      EQU $20
DEF BANK_21      EQU $21
DEF BANK_22      EQU $22
DEF BANK_23      EQU $23
DEF BANK_24      EQU $24
DEF BANK_25      EQU $25
DEF BANK_26      EQU $26
DEF BANK_27      EQU $27
DEF BANK_28      EQU $28
DEF BANK_29      EQU $29
DEF BANK_2A      EQU $2A
DEF BANK_2B      EQU $2B
DEF BANK_2C      EQU $2C
DEF BANK_2D      EQU $2D
DEF BANK_2E      EQU $2E
DEF BANK_2F      EQU $2F
DEF BANK_30      EQU $30
DEF BANK_31      EQU $31
DEF BANK_32      EQU $32
DEF BANK_33      EQU $33
DEF BANK_34      EQU $34
DEF BANK_35      EQU $35
DEF BANK_36      EQU $36
DEF BANK_37      EQU $37
DEF BANK_38      EQU $38
DEF BANK_39      EQU $39
DEF BANK_3A      EQU $3A
DEF BANK_3B      EQU $3B
DEF BANK_3C      EQU $3C
DEF BANK_3D      EQU $3D
DEF BANK_3E      EQU $3E
DEF BANK_3F      EQU $3F

; Inputs (defined in hardware.inc)
; DEF PADF_DOWN   EQU $80
; DEF PADF_UP     EQU $40
; DEF PADF_LEFT   EQU $20
; DEF PADF_RIGHT  EQU $10
; DEF PADF_START  EQU $08
; DEF PADF_SELECT EQU $04
; DEF PADF_B      EQU $02
; DEF PADF_A      EQU $01
DEF PADF_DOWN_BIT   EQU 7
DEF PADF_UP_BIT     EQU 6
DEF PADF_LEFT_BIT   EQU 5
DEF PADF_RIGHT_BIT  EQU 4
DEF PADF_START_BIT  EQU 3
DEF PADF_SELECT_BIT EQU 2
DEF PADF_B_BIT      EQU 1
DEF PADF_A_BIT      EQU 0

; Menu Types
DEF MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION   EQU $00
DEF MENU_TYPE_EXIT_GAME                   EQU $01
DEF MENU_TYPE_PAUSED_IN_LEVEL             EQU $02
DEF MENU_TYPE_EXIT_TO_MAP                 EQU $03
DEF MENU_TYPE_GAME_OVER_TOTALS            EQU $04
DEF MENU_TYPE_VIEW_TOTALS                 EQU $05
DEF MENU_TYPE_VIEW_PASSWORD               EQU $06
DEF MENU_TYPE_TITLE_OPTIONS               EQU $07
DEF MENU_TYPE_ENTERING_LEVEL_NAME         EQU $08
DEF MENU_TYPE_MISSION_SELECT_1_OPTION     EQU $09
DEF MENU_TYPE_MISSION_SELECT_2_OPTIONS    EQU $0A
DEF MENU_TYPE_MISSION_SELECT_3_OPTIONS    EQU $0B
DEF MENU_TYPE_GAME_OVER                   EQU $0C
DEF MENU_TYPE_BLACK_SCREEN                EQU $0D
DEF MENU_TYPE_CONGRATULATIONS             EQU $0E
DEF MENU_TYPE_ENTER_PASSWORD              EQU $0F
DEF MENU_TYPE_TITLE_SCREEN                EQU $10
DEF MENU_TYPE_AUDIO_OPTIONS_UNUSED        EQU $11
DEF MENU_TYPE_CREDITS_GREAT_JOB           EQU $12
DEF MENU_TYPE_TITLE_CRAVE                 EQU $13
DEF MENU_TYPE_TITLE_SPLASH                EQU $14
DEF MENU_TYPE_ENTERED_INVALID_PASSWORD    EQU $15
DEF MENU_TYPE_TITLE_DAVID                 EQU $16
DEF MENU_TYPE_CREDITS_1                   EQU $17
DEF MENU_TYPE_CREDITS_2                   EQU $18
DEF MENU_TYPE_CREDITS_3                   EQU $19
DEF MENU_TYPE_CREDITS_4                   EQU $1A
DEF MENU_TYPE_TIME_UP                     EQU $1B

; ------------------------------------------------------------------
; Menu behaviour flags (wD68C_Menu_Flags).
; Byte +2 of each 8-byte record in data_01_5574_MenuTypeRecords. These are the
; only thing that distinguishes one menu from another as far as
; call_01_4000_MenuLoad is concerned - the loop is shared by every screen in
; the game, from the title to the pause menu to the credits
; ------------------------------------------------------------------
DEF MENU_FLAG_TOTALS_PAGING      EQU $01 ; left/right pages wD625_TotalsMenuPage through the levels
DEF MENU_FLAG_GRID_CURSOR        EQU $02 ; 6x5 password keyboard instead of a vertical list
DEF MENU_FLAG_DEMO_COUNTDOWN     EQU $04 ; the demo timer keeps running even though the menu waits
DEF MENU_FLAG_SELECT_DISMISSES   EQU $08
DEF MENU_FLAG_START_DISMISSES    EQU $10
DEF MENU_FLAG_START_OPENS_PAUSE  EQU $20 ; START switches to menu type 0, remembering this one
DEF MENU_FLAG_NO_CANCEL          EQU $40 ; A/SELECT/START cannot back out; only B does anything
DEF MENU_FLAG_WAIT_FOR_INPUT     EQU $80 ; clear = auto-advance once the timer expires

; ------------------------------------------------------------------
; Option codes stored in the wD6C5_Menu_OptionActions table, one per selectable
; row, and returned in A from call_01_4000_MenuLoad when the player picks that
; row with B. The caller decides what to do with them; MenuLoad only handles
; the three that open another menu
; ------------------------------------------------------------------
DEF MENU_OPTION_START_GAME       EQU $10 ; "START" on the title screen, and its only use.
                                         ; The caller's response is to set the starting lives
                                         ; and zero all LEVEL_COUNT entries of
                                         ; wD629_RemoteProgressFlags, so this begins a new
                                         ; game rather than resuming anything
DEF MENU_OPTION_ENTER_PASSWORD   EQU $30
DEF MENU_OPTION_VIEW_PASSWORD    EQU $40
DEF MENU_OPTION_QUIT             EQU $50 ; opens the exit-game or exit-to-map confirmation
DEF MENU_OPTION_CONFIRM_QUIT     EQU $60 ; "OKAY" on either quit confirmation. The only option
                                         ; code the gameplay loop acts on - anything else it
                                         ; gets back means "carry on playing". From a level it
                                         ; sends the player to the Media Dimension; from the
                                         ; hub there is nowhere left to go, so it restarts at
                                         ; the title
DEF MENU_OPTION_RESUME_PLAY      EQU $80 ; "RESUME PLAY" on the totals screen. Returned to the
                                         ; caller, which does nothing special with it - it
                                         ; exists so that the row is selectable at all
DEF MENU_OPTION_AUDIO_OPTIONS    EQU $90

; Extra values call_01_4000_MenuLoad can return that are not option codes
DEF MENU_RESULT_DISMISSED        EQU $00 ; backed out with A/SELECT/START
DEF MENU_RESULT_PASSWORD_GO      EQU $30 ; the password keyboard's GO key was pressed
DEF MENU_RESULT_TIMED_OUT        EQU $70 ; the menu's timer expired without any input

; Bits of wD621_WarpFlags - why the level is being left
DEF WARP_FLAG_DIED               EQU $02
DEF WARP_FLAG_ENTERED_TV         EQU $04 ; also set by collecting a gold remote
DEF WARP_FLAG_ENTERED_DOOR       EQU $08
DEF WARP_FLAG_TIME_UP            EQU $10 ; bonus level countdown expired

; Music
DEF MUSIC_KUNG_FU_THEATER                 EQU $00
DEF MUSIC_CIRCUIT_CENTRAL                 EQU $01
DEF MUSIC_PREHISTORY_CHANNEL              EQU $02
DEF MUSIC_REZOPOLIS                       EQU $03
DEF MUSIC_UNK_04                          EQU $04
DEF MUSIC_SCREAM_TV                       EQU $05
DEF MUSIC_TOON_TV                         EQU $06
DEF MUSIC_MEDIA_DIMENSION                 EQU $07

; Sound Effects
DEF SFX_EMPTY                              EQU $00
DEF SFX_01                                 EQU $01 ; unused?
DEF SFX_02                                 EQU $02 ; unused?
DEF SFX_SILVER_REMOTE                      EQU $03
DEF SFX_GOLD_REMOTE                        EQU $04
DEF SFX_05                                 EQU $05 ; unused?
DEF SFX_COLLECTIBLE                        EQU $06 ; also used for ant spawner
DEF SFX_07                                 EQU $07 ; unused?
DEF SFX_08                                 EQU $08 ; unused?
DEF SFX_09                                 EQU $09 ; unused?
DEF SFX_0A                                 EQU $0A ; unused?
DEF SFX_0B                                 EQU $0B ; unused?
DEF SFX_GEX_JUMP                           EQU $0C
DEF SFX_GEX_DOUBLE_JUMP                    EQU $0D
DEF SFX_GEX_COLLAPSE                       EQU $0E
DEF SFX_GEX_DEATH                          EQU $0F
DEF SFX_GEX_HURT                           EQU $10
DEF SFX_GEX_SPAWN                          EQU $11
DEF SFX_GEX_HIT_BOUNCE                     EQU $12
DEF SFX_13                                 EQU $13 ; unused?
DEF SFX_MENU_UNK_1                         EQU $14
DEF SFX_MENU_UNK_2                         EQU $15
DEF SFX_16                                 EQU $16 ; unused?
DEF SFX_ENEMY_DEFEATED                     EQU $17
DEF SFX_18                                 EQU $18 ; unused?
DEF SFX_HARD_HEAD_AREA_HAZARD              EQU $19
DEF SFX_FALLING_HAZARD                     EQU $1A
DEF SFX_1B                                 EQU $1B ; unused?
DEF SFX_FLOWER_HAMMER                      EQU $1C
DEF SFX_BUMBLEBEE                          EQU $1D
DEF SFX_ROCKET                             EQU $1E
DEF SFX_1F                                 EQU $1F ; unused?
DEF SFX_HUNTER                             EQU $20
DEF SFX_21                                 EQU $21 ; unused?
DEF SFX_22                                 EQU $22 ; used: the counted-breakable tile scripts
                                                   ; play it via BLOCKPATCH_STEP_SFX
DEF SFX_23                                 EQU $23 ; unused?
DEF SFX_ENEMY_BOUNCE                       EQU $24
DEF SFX_25                                 EQU $25 ; unused?
DEF SFX_26                                 EQU $26 ; used: .script_0D in bank00_cutscenes.asm
                                                   ; plays it via BLOCKPATCH_STEP_SFX
DEF SFX_FALLING_PLATFORM                   EQU $27
DEF SFX_28                                 EQU $28 ; unused?
DEF SFX_29                                 EQU $29 ; unused?
DEF SFX_GEX_JUMP_UNK                       EQU $2A ; unknown, but related to gex jumping
DEF SFX_POWERED_WALKWAY                    EQU $2B
DEF SFX_2C                                 EQU $2C ; unused?
DEF SFX_JAR                                EQU $2D
DEF SFX_2E                                 EQU $2E ; unused?
DEF SFX_DRAGON                             EQU $2F
DEF SFX_CANNON                             EQU $30
DEF SFX_FALLING_BOULDER                    EQU $31
DEF SFX_32                                 EQU $32 ; unused?
DEF SFX_PTEROSAUR                          EQU $33
DEF SFX_MULTI_PROJECTILE                   EQU $34
DEF SFX_GEAR                               EQU $35
DEF SFX_GUN_PROJECTILE                     EQU $36
DEF SFX_REZ_PROJECTILE                     EQU $37
DEF SFX_FINAL_BATTLE_BUTTON                EQU $38
DEF SFX_REZ_BUTTON                         EQU $39
DEF SFX_NONE                               EQU $FF ; no sfx queued

; Maps
DEF MAP_MEDIA_DIMENSION                           EQU $00
DEF MAP_TOON_TV_OUT_OF_TOON                       EQU $01
DEF MAP_SCREAM_TV_SMELLRAISER                     EQU $02
DEF MAP_SCREAM_TV_FRANKENSTEINFELD                EQU $03
DEF MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM              EQU $04
DEF MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE            EQU $05
DEF MAP_UNUSED_06                                 EQU $06
DEF MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210         EQU $07
DEF MAP_TOON_TV_FINE_TOONING                      EQU $08
DEF MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE         EQU $09
DEF MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO  EQU $0A
DEF MAP_SCREAM_TV_POLTERGEX                       EQU $0B
DEF MAP_UNUSED_0C                                 EQU $0C
DEF MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER       EQU $0D
DEF MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL       EQU $0E
DEF MAP_UNUSED_0F                                 EQU $0F
DEF MAP_SCREAM_TV_THURSDAY_THE_12TH               EQU $10
DEF MAP_UNUSED_11                                 EQU $11
DEF MAP_UNUSED_12                                 EQU $12
DEF MAP_UNUSED_13                                 EQU $13
DEF MAP_UNUSED_14                                 EQU $14
DEF MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP    EQU $15
DEF MAP_REZOPOLIS_BUGGED_OUT                      EQU $16
DEF MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS            EQU $17
DEF MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO        EQU $18
DEF MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE         EQU $19
DEF MAP_REZOPOLIS_MAZED_AND_CONFUSED              EQU $1A
DEF MAP_UNUSED_1B                                 EQU $1B
DEF MAP_UNUSED_1C                                 EQU $1C
DEF MAP_UNUSED_1D                                 EQU $1D
DEF MAP_BOSS_TV_CHANNEL_Z                         EQU $1E

; Levels 0-$1D plus the boss. Every loop over wD629_RemoteProgressFlags, and the
; totals menu's page counter, runs to LEVEL_COUNT
DEF LEVEL_COUNT                                   EQU $1E

; wD6F9_BgMap_LoadingFlags
DEF MAP_PENDING_VRAM_TRANSFER    EQU 7   ;
DEF MAP_SCROLL_LEFT              EQU $08 ;
DEF MAP_SCROLL_RIGHT             EQU $04 ;
DEF MAP_SCROLL_UP                EQU $02 ;
DEF MAP_SCROLL_DOWN              EQU $01 ;

; LCD STAT interrupt handler ids, passed to call_00_0bae_RequestLcdIsr /
; call_00_0bb9_InstallLcdIsr and stored in the low 7 bits of wCCFD_LcdIsrId.
; Each id is a byte offset into .data_00_0bdc_LcdIsrTable (3 bytes per entry).
DEF LCD_ISR_NONE                 EQU $00 ; handler is just a reti
DEF LCD_ISR_VRAM_STREAM          EQU $03 ; copies wD100_TilesToLoadBuffer to a VRAM page, 4 bytes per hblank
DEF LCD_ISR_RASTER_EFFECT        EQU $06 ; hud window split at scanline $5F + horizontal wobble band
DEF LCD_ISR_INSTALLED            EQU $80 ; bit 7 of wCCFD_LcdIsrId

; Opcodes the LCD STAT handler patches into itself (see .data_00_0c54_PushAfOpcode
; and data_00_0d83_RetiOpcode)
DEF OPCODE_PUSH_AF               EQU $F5 ; written to wCCA0_LcdIsrCode to arm the handler
DEF OPCODE_RETI                  EQU $D9 ; written to wCCA0_LcdIsrCode to disable it

; wD60F_GfxTransferFlags - pending VRAM transfers, serviced lowest bit first
DEF GFX_XFER_PLAYER_GFX          EQU 0 ; 256 bytes of Gex tiles -> $8000 / $8100
DEF GFX_XFER_ENTITY_GFX          EQU 1 ; 256 bytes of entity tiles -> $8200 / $8300
DEF GFX_XFER_SECONDARY_TILESET   EQU 2 ; secondary tileset -> $9000
DEF GFX_XFER_QUEUED_ENTITY_GFX   EQU 3 ; descriptor at wD71F_GfxCopy_SrcBank
DEF GFX_XFER_MEDIA_DIMENSION_TV  EQU 4 ; hub tv screen image -> $8600
DEF GFX_XFER_IN_PROGRESS         EQU 7 ; an hblank-driven transfer is currently running

; wD60E_HUDDirtyFlags
DEF HUD_DIRTY_LIVES              EQU 1
DEF HUD_DIRTY_TIMER              EQU 2
DEF HUD_DIRTY_COLLECTIBLES       EQU 3

; wD621_WarpFlags
DEF WARP_TIME_UP                 EQU $10
DEF WARP_ENTERED_DOOR            EQU $08
DEF WARP_ENTERED_TV              EQU $04
DEF WARP_DIED                    EQU $02

; wD629_RemoteProgressFlags bit groups. call_00_3c3f_Remotes_RecountAllTotals counts
; the set bits under each mask across all 30 levels
DEF REMOTE_MISSION_MASK          EQU $07 ; one bit per selectable mission (red remotes)
DEF REMOTE_HIDDEN_MASK           EQU $18 ; silver remote (08) + gold remote (10)
DEF REMOTE_BONUS_MASK            EQU $20 ; collectible-quota mission completed
DEF REMOTE_TOTAL_COUNT_MASK      EQU $7F ; low bits of wD64F/wD650/wD651
DEF REMOTE_TOTAL_CHANGED         EQU $80 ; bit 7 of the same

; wDAD9_FadeMode (DMG only)
DEF FADE_MODE_NONE               EQU $00
DEF FADE_MODE_IN                 EQU $01 ; fade back to wDAD1_LevelBGP / OBP0 / OBP1
DEF FADE_MODE_TO_WHITE           EQU $02 ; fade all selected registers to $00
DEF FADE_MODE_TO_BLACK           EQU $03 ; fade all selected registers to $FF

; Entities
DEF ENTITY_GEX                              EQU $00
DEF ENTITY_COLLECTIBLE_SPAWN                EQU $01
DEF ENTITY_UNK_02                           EQU $02 ; not in level ENTITY lists. may be unused
DEF ENTITY_TV_BUTTON                        EQU $03
DEF ENTITY_RED_REMOTE                       EQU $04
DEF ENTITY_SILVER_REMOTE                    EQU $05 ; hidden remote
DEF ENTITY_GOLD_REMOTE                      EQU $06
DEF ENTITY_ENEMY_DEFEATED                   EQU $07
DEF ENTITY_UNK_08                           EQU $08 ; not in level ENTITY lists. may be unused
DEF ENTITY_SCREAM_TV_FALLING_PLATFORM       EQU $09
DEF ENTITY_SCREAM_TV_MOVING_PLATFORM        EQU $0A
DEF ENTITY_SCREAM_TV_PUSH_BLOCK             EQU $0B ; in poltergex, push the block to cause platform to appear
DEF ENTITY_SCREAM_TV_PUMPKIN                EQU $0C
DEF ENTITY_SCREAM_TV_FRANKIE                EQU $0D
DEF ENTITY_SCREAM_TV_HEAD_GHOST             EQU $0E
DEF ENTITY_SCREAM_TV_HEAD_GHOST_HEAD        EQU $0F
DEF ENTITY_SCREAM_TV_FLOATING_SKULL         EQU $10
DEF ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE EQU $11
DEF ENTITY_SCREAM_TV_ZOMBIE                 EQU $12
DEF ENTITY_SCREAM_TV_ZOMBIE_HEAD            EQU $13
DEF ENTITY_SCREAM_TV_FALLING_AXE            EQU $14
DEF ENTITY_SCREAM_TV_LANTERN                EQU $15
DEF ENTITY_SCREAM_TV_BAT                    EQU $16
DEF ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM EQU $17
DEF ENTITY_SCREAM_TV_DOOR_OPENING           EQU $18
DEF ENTITY_SCREAM_TV_GHOST                  EQU $19
DEF ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY   EQU $1A
DEF ENTITY_SCREAM_TV_VANISHING_PLATFORM     EQU $1B
DEF ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR     EQU $1C
DEF ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD    EQU $1D
DEF ENTITY_TOON_TV_STATIONARY_BEAR_TRAP     EQU $1E
DEF ENTITY_TOON_TV_MOVING_BEAR_TRAP         EQU $1F
DEF ENTITY_TOON_TV_BUMBLEBEE                EQU $20
DEF ENTITY_TOON_TV_BOWLING_BALL              EQU $21
DEF ENTITY_TOON_TV_CACTUS                    EQU $22
DEF ENTITY_TOON_TV_DOMINO                    EQU $23
DEF ENTITY_TOON_TV_SHARK                     EQU $24
DEF ENTITY_TOON_TV_FLOWER                    EQU $25
DEF ENTITY_TOON_TV_HUNTER                    EQU $26
DEF ENTITY_TOON_TV_MUSHROOM                  EQU $27
DEF ENTITY_TOON_TV_MUSHROOM_PROJECTILE       EQU $28 ; not in level ENTITY lists. may be unused
DEF ENTITY_TOON_TV_LIZARD                    EQU $29
DEF ENTITY_TOON_TV_HAPPY_FACE                EQU $2A
DEF ENTITY_TOON_TV_VANISHING_BLOCK           EQU $2B
DEF ENTITY_TOON_TV_MOVING_BLOCK              EQU $2C
DEF ENTITY_TOON_TV_MOVING_LOG                EQU $2D
DEF ENTITY_TOON_TV_STATIONARY_LOG            EQU $2E
DEF ENTITY_TOON_TV_FLOWER_HAMMER             EQU $2F
DEF ENTITY_TOON_TV_HUNTER_BULLET             EQU $30
DEF ENTITY_TOON_TV_ROCKET                    EQU $31
DEF ENTITY_PRE_HISTORY_FAST_DINOSAUR         EQU $32 ; in pangaea 90210 above the happy face on map
DEF ENTITY_PRE_HISTORY_DRAGONFLY             EQU $33
DEF ENTITY_PRE_HISTORY_EGG                   EQU $34
DEF ENTITY_UNK_35                            EQU $35 ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_36                            EQU $36 ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_FALLING_LAVA          EQU $37
DEF ENTITY_PRE_HISTORY_LAVA_RAFT             EQU $38
DEF ENTITY_PRE_HISTORY_MOVING_PLATFORM       EQU $39
DEF ENTITY_UNK_3A                            EQU $3A ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_3B                            EQU $3B ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_PTEROSAUR             EQU $3C
DEF ENTITY_UNK_3D                            EQU $3D ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_FALLING_BOULDER       EQU $3E
DEF ENTITY_UNK_3F                            EQU $3F ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL     EQU $40 ; lava dabba doo on the climbable background
DEF ENTITY_PRE_HISTORY_BEETLE_VERTICAL       EQU $41
DEF ENTITY_PRE_HISTORY_ANT                   EQU $42 ; lava dabba doo at the beginning
DEF ENTITY_PRE_HISTORY_FIRE_PLANT            EQU $43
DEF ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES EQU $44
DEF ENTITY_PRE_HISTORY_GEYSER                EQU $45
DEF ENTITY_UNK_46                            EQU $46 ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_DINOSAUR              EQU $47
DEF ENTITY_PRE_HISTORY_TRICERATOPS           EQU $48
DEF ENTITY_PRE_HISTORY_TRICERATOPS_HORN      EQU $49
DEF ENTITY_UNK_4A                            EQU $4A ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_HANGING_BLADE     EQU $4B
DEF ENTITY_KUNG_FU_THEATER_CANNON            EQU $4C
DEF ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE EQU $4D
DEF ENTITY_KUNG_FU_THEATER_DRAGONFLY         EQU $4E
DEF ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT EQU $4F
DEF ENTITY_KUNG_FU_THEATER_DRAGON_HEAD       EQU $50
DEF ENTITY_UNK_51                            EQU $51 ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE EQU $52
DEF ENTITY_KUNG_FU_THEATER_WALKING_NINJA     EQU $53
DEF ENTITY_KUNG_FU_THEATER_JUMPING_NINJA     EQU $54
DEF ENTITY_KUNG_FU_THEATER_SAMURAI_BODY      EQU $55
DEF ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD      EQU $56
DEF ENTITY_KUNG_FU_THEATER_LIZARD            EQU $57
DEF ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE  EQU $58 ; jumping ninja throws projectiles, but not walking ninja
DEF ENTITY_KUNG_FU_THEATER_SPIKY_LOG         EQU $59
DEF ENTITY_KUNG_FU_THEATER_TALL_JAR          EQU $5A
DEF ENTITY_KUNG_FU_THEATER_JAR               EQU $5B
DEF ENTITY_UNK_5C                            EQU $5C ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_5D                            EQU $5D ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM EQU $5E
DEF ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM   EQU $5F
DEF ENTITY_UNK_60                            EQU $60 ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_MOVING_RAFT       EQU $61
DEF ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT   EQU $62
DEF ENTITY_UNK_63                            EQU $63 ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_64                            EQU $64 ; not in level ENTITY lists. may be unused
DEF ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM EQU $65 ; at the start of no weddings
DEF ENTITY_REZOPOLIS_MOVING_PLATFORM         EQU $66 ; small, yellow, and black
DEF ENTITY_REZOPOLIS_RED_PLATFORM            EQU $67 ; no weddings
DEF ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  EQU $68 ; no weddings
DEF ENTITY_REZOPOLIS_TAILSPIN_PLATFORM       EQU $69
DEF ENTITY_REZOPOLIS_TAILSPIN_GEAR           EQU $6A
DEF ENTITY_UNK_6B                            EQU $6B ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_6C                            EQU $6C ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_6D                            EQU $6D ; not in level ENTITY lists. may be unused
DEF ENTITY_REZOPOLIS_GREEN_MONSTER           EQU $6E
DEF ENTITY_UNK_6F                            EQU $6F ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_70                            EQU $70 ; not in level ENTITY lists. may be unused
DEF ENTITY_REZOPOLIS_PINCER                  EQU $71
DEF ENTITY_REZOPOLIS_FLAMETHROWER            EQU $72
DEF ENTITY_REZOPOLIS_UFO                     EQU $73
DEF ENTITY_REZOPOLIS_ANT                     EQU $74
DEF ENTITY_REZOPOLIS_ANT_SPAWNER             EQU $75
DEF ENTITY_CIRCUIT_CENTRAL_ANT               EQU $76
DEF ENTITY_CIRCUIT_CENTRAL_CAPACITOR         EQU $77
DEF ENTITY_CIRCUIT_CENTRAL_POWER_UP          EQU $78
DEF ENTITY_UNK_79                            EQU $79 ; not in level ENTITY lists. may be unused
DEF ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT      EQU $7A
DEF ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR EQU $7B
DEF ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL     EQU $7C
DEF ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM   EQU $7D
DEF ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM   EQU $7E
DEF ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM EQU $7F
DEF ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT      EQU $80
DEF ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY   EQU $81
DEF ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR EQU $82
DEF ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE    EQU $83
DEF ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2   EQU $84
DEF ENTITY_CHANNEL_Z_GUN_PROJECTILE          EQU $85
DEF ENTITY_CHANNEL_Z_REZ                     EQU $86
DEF ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1       EQU $87 ; not in level ENTITY lists. may be unused
DEF ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2       EQU $88 ; not in level ENTITY lists. may be unused
DEF ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE      EQU $89
DEF ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION EQU $8A
DEF ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE    EQU $8B ; not in level ENTITY lists. may be unused
DEF ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON     EQU $8C
DEF ENTITY_CHANNEL_Z_REZ_PORTAL              EQU $8D
DEF ENTITY_UNK_8E                            EQU $8E ; not in level ENTITY lists. may be unused
DEF ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM   EQU $8F
DEF ENTITY_LIST_TERMINATOR                   EQU $FF

; ------------------------------------------------------------------
; In-level cutscenes (bank00_cutscenes.asm)
; ------------------------------------------------------------------
DEF CUTSCENE_SLOTS_PER_LEVEL                EQU $10 ; entries per level in the index lookup table
DEF CUTSCENE_SLOT_MISSION_BASE              EQU $0A ; slot = this + wD627_CurrentMission
DEF CUTSCENE_NONE                           EQU $FF ; no cutscene for this level/slot
DEF CUTSCENE_MOVE_END                       EQU $FF ; terminator in a movement command list
DEF CUTSCENE_MOVE_SPEED_MAX                 EQU $10 ; 16/16ths = exactly one pixel per frame
DEF CUTSCENE_HOLD_FRAMES                    EQU $B4 ; 180 frames (3s) of dwell before returning

; ------------------------------------------------------------------
; Password system (bank01_menus.asm)
;
; The password is 28 boxes of one letter each, A-H, so 3 bits per box and 84 bits
; total. It carries a 10-byte payload: 8 bytes of packed level progress, then
; lives, then a checksum - 80 bits, leaving four spare.
;
; Encode and decode are not symmetrical implementations. Decoding is a tight
; bit-packing loop; encoding instead walks .data_01_4fef_Password_BitMap, an
; explicit table of (source address, source mask, dest address, dest mask) that
; scatters one bit per entry.
; ------------------------------------------------------------------

DEF PASSWORD_BOX_COUNT                      EQU $1C ; 28 letters
DEF PASSWORD_BITS_PER_BOX                   EQU 3   ; so letters run A-H
DEF PASSWORD_CHAR_BASE                      EQU $41 ; 'A'; value 0-7 plus this is the letter
                                                    ; (PASSWORD_KEY_BLANK above marks an empty
                                                    ; box; any blank rejects the password)
DEF PASSWORD_CHECKSUM_BYTES                 EQU 9   ; progress + lives, summed to 8 bits
DEF PASSWORD_PAYLOAD_BYTES                  EQU 10  ; the above plus the checksum itself

; (PASSWORD_GRID_COLUMNS / _ROWS are defined above; cell index = row * cols + col)
DEF PASSWORD_CELL_TILE_WIDTH                EQU 4   ; tiles backing one cell
DEF PASSWORD_KEYBOARD_TILE_BASE             EQU $3E ; first VRAM tile of the keyboard

; Special keys on the password keyboard, stored in the cell array at
; wD667_PasswordExitButton like any other character
DEF PASSWORD_KEY_BLANK           EQU $20
DEF PASSWORD_KEY_EXIT            EQU $49
DEF PASSWORD_KEY_GO              EQU $4A
DEF PASSWORD_KEY_UNKNOWN         EQU $4B

; The password keyboard is a fixed 6 x 5 grid
DEF PASSWORD_GRID_COLUMNS        EQU $06
DEF PASSWORD_GRID_ROWS           EQU $05

; ------------------------------------------------------------------
; Per-map descriptor record (.data_00_2ebf_MapData in bank00_map_init_data.asm)
;
; One 16-byte record per map, indexed by wD624_CurrentLevelId. Only 11 of the 16
; bytes are used - the record is padded to a power of two so the lookup is four
; `add HL,HL` shifts instead of a multiply. Every MapData_Get* accessor is the same
; three instructions: fetch the record base, add one of these offsets, read.
; ------------------------------------------------------------------
DEF MAPDATA_TV_PALETTE_ID                   EQU $00 ; index into .data_0b_5d62
DEF MAPDATA_REMOTE_PROGRESS_ID              EQU $01 ; row for the mission status tables
DEF MAPDATA_TEXT_BLOCK_PTR                  EQU $02 ; word -> list of text pointers:
                                                    ; entry 0 is the level name, entries
                                                    ; 1..n are the mission descriptions
DEF MAPDATA_BLOCKMAP_BANK                   EQU $04 ; grid of block ids, one byte per
                                                    ; block - see BLOCKMAP below
DEF MAPDATA_ALT_BLOCKSET_BANK               EQU $05 ; bank $34 or $35 - the flag plane
                                                    ; described under ALT BLOCKSET below
DEF MAPDATA_BLOCKSET_COLLISION_BANK         EQU $06 ; block definitions and the collision
                                                    ; table, in that order
                                                    ; $07 unused, always $00
DEF MAPDATA_ALT_BLOCKSET_MASK               EQU $08 ; this map's bit within the flag
                                                    ; plane; $00 opts out entirely
DEF MAPDATA_TILESET_BANK                    EQU $09
DEF MAPDATA_TILESET_OFFSET                  EQU $0A ; word
                                                    ; $0C-$0F unused, always $00
DEF MAPDATA_RECORD_SIZE                     EQU $10

DEF MAPDATA_TEXT_MISSION_BASE               EQU $02 ; mission N is at text block + this + N*2

; ------------------------------------------------------------------
; Player spawn positions (bank0B_map_spawns.asm)
;
; All three spawn tables store BLOCK coordinates - the same grid the blockmap uses,
; 128 x 128 blocks per level. One block is SPAWN_UNITS_PER_BLOCK units of player
; world position, so a table entry becomes a position with block * $20 + an offset.
; The offset differs per spawn source, which is the only thing separating the three
; otherwise identical conversions in call_0b_4efe_Player_SetSpawnPosition
; ------------------------------------------------------------------
DEF SPAWN_UNITS_PER_BLOCK                   EQU $20
DEF SPAWN_LIST_END                          EQU $FF ; ends a door list

DEF DOOR_RECORD_SIZE                        EQU 4   ; from block X/Y, to block X/Y
DEF DOOR_MATCH_X_BIAS                       EQU $0F ; subtracted from the player's X
                                                    ; before it is converted to a block
                                                    ; to look a door up. Y has no
                                                    ; equivalent bias

DEF SPAWN_DOOR_X_OFFSET                     EQU $20 ; arriving through a door
DEF SPAWN_DOOR_Y_OFFSET                     EQU $10
DEF SPAWN_HUB_X_OFFSET                      EQU $20 ; arriving back in the hub from a TV
DEF SPAWN_HUB_Y_OFFSET                      EQU $30
DEF SPAWN_LEVEL_X_OFFSET                    EQU $10 ; level start or checkpoint respawn
DEF SPAWN_LEVEL_Y_OFFSET                    EQU $10

DEF CHECKPOINTS_PER_LEVEL                   EQU 4   ; slots per level in
                                                    ; .data_0b_543f_LevelCheckpointSpawns;
                                                    ; no level fills more than two

; ------------------------------------------------------------------
; Values for MAPDATA_ALT_BLOCKSET_MASK - which bit of the shared flag plane is
; this map's. The bit belongs to a BLOCKMAP rather than to a level: the plane is
; indexed by position within a blockmap, so every level built on the same blockmap
; necessarily reads the same bit. The correspondence is one to one in both
; directions, which is why these are named after the blockmaps in main.asm.
;
; The two planes are independent, so the numbers repeat between them - always use
; the name matching the map's MAPDATA_ALT_BLOCKSET_BANK.
; ------------------------------------------------------------------
DEF ALT_BLOCKSET_NONE                       EQU $00 ; never takes the alt blockset

; bits of alt_blockset_flags1 (bank $34)
DEF ALT_BLOCKSET_SCREAM_TV2                 EQU $01
DEF ALT_BLOCKSET_SCREAM_TV1                 EQU $02
DEF ALT_BLOCKSET_MEDIA_DIMENSION            EQU $04
DEF ALT_BLOCKSET_TOON_TV                    EQU $08
DEF ALT_BLOCKSET_PREHISTORY_CHANNEL1        EQU $10
DEF ALT_BLOCKSET_PREHISTORY_CHANNEL2        EQU $20
DEF ALT_BLOCKSET_KUNG_FU_THEATER1           EQU $40
DEF ALT_BLOCKSET_KUNG_FU_THEATER2           EQU $80

; bits of alt_blockset_flags2 (bank $35). Three of the eight are unused
DEF ALT_BLOCKSET_REZOPOLIS                  EQU $01
DEF ALT_BLOCKSET_CIRCUIT_CENTRAL3           EQU $02
DEF ALT_BLOCKSET_CIRCUIT_CENTRAL2           EQU $04
DEF ALT_BLOCKSET_CIRCUIT_CENTRAL1           EQU $08
DEF ALT_BLOCKSET_CHANNEL_Z                  EQU $10

; ------------------------------------------------------------------
; Menu sprite scripts (bank01_menus.asm, call_01_4dc8_Menu_BuildSpriteBlock)
;
; A sprite script is a starting OAM slot followed by entries of
;   Y, X, tile, attributes, width in 8px columns, height in pixels
; and terminated by SPRITE_SCRIPT_END. Menus run in 8x16 sprite mode, so tile ids
; step by 2 and a rectangle is emitted column by column.
; ------------------------------------------------------------------
DEF SPRITE_SCRIPT_END                       EQU $FF ; ends a sprite script
DEF SPRITE_TILE_INDIRECT                    EQU $01 ; bit 0 of a tile byte: the rest is
                                                    ; (byte >> 1) indexing
                                                    ; wD5AA_Sprite_TileIdTable
DEF SPRITE_TILE_STEP                        EQU 2   ; 8x16 sprites consume tiles in pairs

DEF MENU_CURSOR_NONE                        EQU $FF ; this screen has no cursor
DEF MENU_CURSOR_PASSWORD                    EQU $12 ; password keyboard highlight - takes its
                                                    ; tile from the cell underneath and blinks

; ------------------------------------------------------------------
; Menu script commands (bank01_menus.asm, call_01_44e6_MenuScript_RunCommand)
;
; A menu script is a byte stream: one command id, then one or more 7-byte
; parameter blocks, and MENUSCRIPT_END to finish. The id selects an 8-byte
; descriptor of shared settings; each parameter block then draws one rectangle.
; MENUCMD_LAST_BLOCK on a block's flags byte is what ends the run, so a single id
; can stamp out many rectangles - this is how a whole screen is described in data.
; ------------------------------------------------------------------
DEF MENUSCRIPT_END                          EQU $FF ; terminates a menu script

DEF MENUCMD_CLEAR_BUFFER                    EQU $01 ; bit 0 - blank the wC000 staging
                                                    ;         buffer before drawing
DEF MENUCMD_DRAW_TEXT                       EQU $02 ; bit 1 - run call_01_4a8f_Text_Render
DEF MENUCMD_TRANSPOSED                      EQU $04 ; bit 2 - number and upload tiles down
                                                    ;         columns instead of across rows
DEF MENUCMD_NO_TILE_UPLOAD                  EQU $20 ; bit 5 - skip the VRAM tile-data copy
DEF MENUCMD_NO_TILEMAP_FILL                 EQU $40 ; bit 6 - skip the tilemap/attribute fill
DEF MENUCMD_LAST_BLOCK                      EQU $80 ; bit 7 - last parameter block

; When the high byte of the source pointer is >= this, the parameter block is not
; a string at all: (hi - MENUCMD_SUB_BASE) indexes .data_01_4633_MenuCmd_SubHandlers
; and the low byte is that handler's argument
DEF MENUCMD_SUB_BASE                        EQU $E0

DEF MENUCMD_ATTR_TV_COPY                    EQU $FF ; in CgbAttributes: use
                                                    ; MediaDimension_CopyTVAttributes

; ------------------------------------------------------------------
; Menu command sub-handlers (.data_01_4633_MenuCmd_SubHandlers)
;
; Written as the HIGH byte of a parameter block's source pointer; the LOW byte is
; the handler's single argument. So `db <arg>, MENUCMD_SUB_<NAME>` in a script is
; the escape hatch from pure data into code
; ------------------------------------------------------------------
DEF MENUCMD_SUB_STAGE_IMAGE1                EQU $E0 ; arg = index into data_01_74e9_ImageTable1
DEF MENUCMD_SUB_STAGE_IMAGE2                EQU $E1 ; arg = index into data_01_74ed_ImageTable2
DEF MENUCMD_SUB_STAGE_TV_SCREEN             EQU $E2 ; the Media Dimension TV picture
DEF MENUCMD_SUB_TV_NAME_TEXT                EQU $E3 ; text = the current TV's name
DEF MENUCMD_SUB_LEVEL_NAME_TEXT             EQU $E4 ; text = the current level's name
DEF MENUCMD_SUB_MISSION_TEXT                EQU $E5 ; arg = mission 0-2, or 3 for
                                                    ; wD627_CurrentMission (no marker sprite)
DEF MENUCMD_SUB_LOAD_SCREEN                 EQU $E6 ; a full tileset + tilemap descriptor
DEF MENUCMD_SUB_DRAW_CURSOR                 EQU $E7 ; arg = cursor sprite image
DEF MENUCMD_SUB_COUNTER_TEXT                EQU $E8 ; arg = MENU_COUNTER_*
DEF MENUCMD_SUB_REMOTE_ICONS                EQU $E9 ; arg = MENU_SPRITE_GROUP_* base
DEF MENUCMD_SUB_TOTALS_PAGE_TEXT            EQU $EA ; text = the totals page's level name
DEF MENUCMD_SUB_PASSWORD_CHAR_TEXT          EQU $EB ; arg = password cell index
DEF MENUCMD_SUB_CHAIN_SCRIPT                EQU $EC ; arg = MENU_CHAINED_*
DEF MENUCMD_SUB_FULLSCREEN_IMAGE            EQU $ED ; arg = MENU_IMAGE_*
DEF MENUCMD_SUB_MISSION_STATUS_TEXT         EQU $EE ; "n OF m RED REMOTES FOUND"
DEF MENUCMD_SUB_COLLECTIBLE_ICON            EQU $EF ; this level's collectible, 3x2 tiles

; Fonts, indexed by wD69A_Text_FontId into data_01_65fe_FontDescriptors. Note that
; wD69A only means "font" for blocks that actually draw text - the staging
; sub-handlers reuse the same byte as a destination tile id, and
; MENUCMD_SUB_REMOTE_ICONS reuses it as a sprite-hide delay
DEF MENU_FONT_SMALL                         EQU $00 ; 8x6 glyphs
DEF MENU_FONT_MEDIUM                        EQU $01 ; 8x7 glyphs
DEF MENU_FONT_LARGE                         EQU $02 ; 16x11 glyphs
DEF MENU_FONT_PASSWORD                      EQU $03 ; 16x16, restricted charset

; Arguments to MENUCMD_SUB_COUNTER_TEXT - which number the block prints. Handled by
; call_01_47f6_MenuCmd_GetCounterValue, then formatted by call_01_4ce5_Text_FormatByte
DEF MENU_COUNTER_LIVES                      EQU $00
DEF MENU_COUNTER_HEALTH                     EQU $01
DEF MENU_COUNTER_MISSION_REMOTES            EQU $02 ; popcount of REMOTE_MISSION_MASK
                                                    ; across all 30 levels
DEF MENU_COUNTER_HIDDEN_REMOTES             EQU $03 ; popcount of REMOTE_HIDDEN_MASK
DEF MENU_COUNTER_BONUS_REMOTES              EQU $04 ; popcount of REMOTE_BONUS_MASK
DEF MENU_COUNTER_COLLECTIBLES_1             EQU $05 ; the three collectible milestones,
DEF MENU_COUNTER_COLLECTIBLES_2             EQU $06 ; each showing 30 / 40 / 50 once
DEF MENU_COUNTER_COLLECTIBLES_3             EQU $07 ; wD648 has passed it
DEF MENU_COUNTER_PLAYER_X                   EQU $08 ; leftover debug readouts - no menu
DEF MENU_COUNTER_PLAYER_Y                   EQU $09 ; script uses either

; Arguments to MENUCMD_SUB_CHAIN_SCRIPT - index into data_01_568c_ChainedScriptTable
DEF MENU_CHAINED_PASSWORD_CELLS             EQU $00
DEF MENU_CHAINED_MISSION_SELECT             EQU $01
DEF MENU_CHAINED_TOTALS                     EQU $02
DEF MENU_CHAINED_NONE                       EQU $FF ; wD6D7_Menu_ChainedScriptId idle value

; Arguments to MENUCMD_SUB_FULLSCREEN_IMAGE - index into .data_01_4932_FullscreenImages
DEF MENU_IMAGE_TITLE_0                      EQU $00
DEF MENU_IMAGE_TITLE_1                      EQU $01
DEF MENU_IMAGE_AUDIO_MENU                   EQU $02
DEF MENU_IMAGE_GREAT_JOB                    EQU $03
DEF MENU_IMAGE_CRAVE                        EQU $04
DEF MENU_IMAGE_SPLASH                       EQU $05
DEF MENU_IMAGE_DAVID                        EQU $06
DEF MENU_IMAGE_CREDITS_1                    EQU $07
DEF MENU_IMAGE_CREDITS_2                    EQU $08
DEF MENU_IMAGE_CREDITS_3                    EQU $09
DEF MENU_IMAGE_CREDITS_4                    EQU $0A

; Sprite groups - index into data_01_5aa9_SpriteScriptTable, used both as the
; argument to MENUCMD_SUB_REMOTE_ICONS and by call_01_4d3b_Menu_EraseSpriteGroup.
; The first two are bases: the level's remote progress id (0-6) is added on, so the
; icon layout matches how many remotes that level has without any code deciding
DEF MENU_SPRITE_GROUP_TOTALS                EQU $00 ; + progress id
DEF MENU_SPRITE_GROUP_CONGRATS              EQU $07 ; + progress id
DEF MENU_SPRITE_GROUP_ENTER_PASSWORD        EQU $0D
DEF MENU_SPRITE_GROUP_VIEW_PASSWORD         EQU $0E
DEF MENU_SPRITE_GROUP_INVALID_PASSWORD      EQU $0F

; A menu's timer is a 16-bit countdown in wD619/wD61A, reloaded every time
; call_01_4000_MenuLoad redraws. $05FF frames is a little over 20 seconds - how long
; the title screen waits before dropping into the attract-mode demo
DEF MENU_TIMEOUT_LO                         EQU $FF
DEF MENU_TIMEOUT_HI                         EQU $05
DEF MENU_SPLASH_FRAMES                      EQU $B4 ; 180 frames, MENU_TYPE_TITLE_SPLASH

DEF MENU_OPTION_SLOT_NONE                   EQU $0F ; in wD69D_MenuCmd_OptionSlot: row $F,
                                                    ; which no cursor can reach

DEF MENU_REMOTE_ICON_COUNT                  EQU 6   ; icons a totals page can show, one per
                                                    ; bit of wD629_RemoteProgressFlags
DEF MISSION_SLOTS_PER_LEVEL                 EQU 3   ; selectable missions a level can offer
DEF MENUCMD_MISSION_CURRENT                 EQU $03 ; argument to MENUCMD_SUB_MISSION_TEXT
                                                    ; meaning "wD627_CurrentMission", which
                                                    ; also suppresses the marker sprite

; ------------------------------------------------------------------
; Menu text renderer (bank01_menus.asm, call_01_4a8f_Text_Render)
;
; A string is a run of character codes in which bit 7 marks the LAST byte of a
; line, so there is no separate line terminator - the final character of each line
; simply has $80 or'd in. A zero byte after that ends the string. The word wrapper
; works by scanning back to a space and setting bit 7 on it in place.
; ------------------------------------------------------------------
DEF TEXT_LINE_END_BIT                       EQU 7   ; set on a line's last character
DEF TEXT_STRING_END                         EQU $00 ; byte after a line end, ends the string
DEF TEXT_SPACE                              EQU $20 ; also PASSWORD_KEY_BLANK; the wrap point
DEF TEXT_CHAR_SPACING                       EQU 1   ; pixels added after every glyph advance
DEF TEXT_AUTO_ALIGN                         EQU $FE ; in PenX: centre the line horizontally
                                                    ; in PenY: distribute lines down the block
DEF FONT_GLYPH_COUNT                        EQU $2A ; $00 space, $01-$1A A-Z, $1B-$24 0-9,
                                                    ; $25-$29 punctuation
DEF FONT_BYTES_PER_ROW                      EQU 2   ; 2bpp: plane 0 then plane 1

; ------------------------------------------------------------------
; THREE LAYERS BUILD THE BACKGROUND
;
;   BLOCKMAP  MAPDATA_BLOCKMAP_BANK, banks $28-$33. A grid of block ids, one byte
;             per block, the level's actual layout.
;   BLOCKSET  MAPDATA_BLOCKSET_COLLISION_BANK. What each id means: 8 bytes giving
;             the block's 4x2 tile ids. Read from page $40, or $50 when the alt
;             blockset flag is set. The collision table shares the bank.
;   TILEMAP   the result, written into VRAM a strip at a time as the camera moves.
;
; So "blockmap" is the arrangement and "blockset" is the vocabulary - the file names
; in main.asm follow that split. "map" on its own is avoided here because it already
; means a level id (MAP_*) and the per-level record (MapData).
;
; ------------------------------------------------------------------
; TWO SEPARATE SYSTEMS ACT ON THE BACKGROUND MAP
;
; Easy to conflate, so worth stating side by side:
;
;   ALT BLOCKSET - static, per level, a rendering variant. Each metatile in a strip
;     carries a flag byte saying "expand me from blockset page $50 instead of $40".
;     MAPDATA_ALT_BLOCKSET_MASK gates which of those flags survive for this level,
;     and BgMap_MaskAltBlocksetFlags does the gating. Nothing here changes at
;     runtime; it is just which of two blocksets a given metatile draws from.
;
;     The flags live in their own ROM bank named by MAPDATA_ALT_BLOCKSET_BANK - a
;     plane the same shape as the tilemap, read in parallel with it, one byte per
;     metatile. Only ONE bit of each byte belongs to any given map: the bank is
;     shared, and MAPDATA_ALT_BLOCKSET_MASK says which bit is yours. So a single
;     plane serves up to eight maps at a byte per metatile instead of eight planes
;     at a bit each - the same storage, but no bit addressing at read time, which
;     matters because this runs per metatile while the map scrolls.
;
;     Bank $34 carries all eight bits; bank $35 uses five. Maps with a mask of $00
;     never take the alt blockset at all - every flag they read is discarded.
;
;   BLOCK PATCH - dynamic, per playthrough, a world mutation. Rectangles of
;     replacement blocks registered into the wCC00/wCD00/wCE00/wCF00 slot tables by
;     tile hit scripts and cutscene animation blocks, animated a step at a time by
;     BlockPatch_TickSequence, and re-applied to any strip that scrolls back into
;     view by BgMap_ApplyBlockPatchesToRow / ...ToColumn. A smashed block or an
;     opened door.
;
; They meet in exactly one place: each cell of a block patch's replacement data is
; two bytes, and the second is an alt-blockset flag for that cell. So a patch says
; both "put this metatile here" and "draw it from that blockset". Otherwise they
; share no state, no WRAM and no code.
;
; Block patch step flags (wD77C_BlockPatch_StepFlags)
;
; One flag byte heads every step of a block patch sequence, whether the sequence came from a
; tile hit script or from a cutscene's animation block. BlockPatch_TickSequence dispatches on
; the bits in this order: SFX (which consumes an extra argument byte from the step), then
; REGISTER, then COLLISION, then TILES, then LOOP.
; ------------------------------------------------------------------
DEF BLOCKPATCH_STEP_LOOP                      EQU $01 ; bit 0 - run the next step in the same frame
DEF BLOCKPATCH_STEP_REGISTER                  EQU $02 ; bit 1 - BlockPatch_Register: commit
                                                    ;         the rectangle to the wCD00/wCE00
                                                    ;         slot tables so it survives a reload
DEF BLOCKPATCH_STEP_COLLISION                 EQU $04 ; bit 2 - BgMap_FindAndWriteCollisionBlock
DEF BLOCKPATCH_STEP_TILES                     EQU $08 ; bit 3 - BlockPatch_WriteTiles: draw this
                                                    ;         step's blocks into the tilemap
DEF BLOCKPATCH_STEP_SFX                       EQU $20 ; bit 5 - PlaySFX; step carries one extra byte

; bit numbers for the same flags, for `bit n,[hl]` rather than `and`
DEF BLOCKPATCH_STEP_LOOP_BIT                  EQU 0
DEF BLOCKPATCH_STEP_REGISTER_BIT              EQU 1
DEF BLOCKPATCH_STEP_COLLISION_BIT             EQU 2
DEF BLOCKPATCH_STEP_TILES_BIT                 EQU 3
DEF BLOCKPATCH_STEP_SFX_BIT                   EQU 5

; ==================================================================
; ENTITY INSTANCE STRUCT
;
; $20 bytes, 8 instances at wD200_EntityMemory. Slot 0 is Gex, so the player
; goes through the same animation and action machinery as every enemy.
;
; Roughly half the struct is animation/graphics state rather than gameplay
; state. $04-$0C and $0A in particular are the animation player, and nothing
; outside the sprite code should be touching them:
;
;   $04 SPRITE_IDS_PTR        the frame list for the current action
;   $06 SPRITE_FRAME_COUNTER  frames left on the current frame (the tick)
;   $07 SPRITE_COUNTER        which frame of the list we are on
;   $08 SPRITE_ID             the frame that is actually drawn
;   $0A SPRITE_FLAGS          how to draw it (see below)
;   $0B/$0C                   playback speed and length
;
; call_02_7102_Entity_SetAction populates all of them at once from the 4-byte
; header of the action's data block, and call_02_6fda_Entity_TickAction
; advances them once per frame.
; ==================================================================
DEF ENTITY_FIELD_ENTITY_ID                  EQU $00 ; ENTITY_ID_NONE ($FF) = free slot
DEF ENTITY_FIELD_ACTION_ID                  EQU $01 ; masked to 5 bits; indexes the entity's action table
DEF ENTITY_FIELD_ACTION_FUNC                EQU $02 ; word - per-frame update function
DEF ENTITY_FIELD_SPRITE_IDS_PTR             EQU $04 ; word - list of frame ids, 4 bytes into the action data block
DEF ENTITY_FIELD_SPRITE_FRAME_COUNTER       EQU $06 ; counts down to the next frame; $FF freezes the animation entirely
DEF ENTITY_FIELD_SPRITE_COUNTER             EQU $07 ; index into the frame list
DEF ENTITY_FIELD_SPRITE_ID                  EQU $08 ; the frame to draw. For streaming entities this doubles as the
                                                    ; high byte of the ROM address its tiles are fetched from
; ------------------------------------------------------------------
; $09 - action lifecycle. The top three bits come from byte 0 of the action
; data block, so an action declares its own lifecycle rather than the code
; deciding. Bits 0-4 carry the action to move to when this one ends
; ------------------------------------------------------------------
DEF ENTITY_FIELD_ACTION_STATE_FLAGS         EQU $09
    DEF ACTION_STATE_HAS_PENDING_BIT     EQU 7 ; bits 0-4 hold a real action id
    DEF ACTION_STATE_ADVANCE_ON_END_BIT  EQU 6 ; clearer alias for ACTION_STATE_ADVANCE_ON_END_BIT
    DEF ACTION_STATE_IS_FIRST_FRAME_BIT  EQU 5 ; set by SetAction, cleared at the top of the next frame

    DEF ACTION_STATE_HAS_PENDING         EQU $80
    DEF ACTION_STATE_ADVANCE_ON_END      EQU $40
    DEF ACTION_STATE_IS_FIRST_FRAME      EQU $20
    DEF ACTION_STATE_PENDING_ACTION      EQU $1F
; ------------------------------------------------------------------
; $0A - render mode and animation status. Despite the name this is almost
; entirely a graphics field.
;
; Bits 0, 3, 4 and 7 pick which of five sprite-building paths
; call_03_5ebf_Entity_BuildSprites uses, tested in that priority order:
;
;   bit 3 set  no sprites at all - jump straight to collision. Trigger volumes
;              and invisible hazards use this
;   bit 0 set  sprite records are embedded in the entity's own data block
;   bit 7 set  layout comes from the shared frame tables, but the OAM
;              attributes are taken from FACING_FLAGS instead of $0A. Also
;              means the entity streams its own tile page, which is what
;              Entity_NotifyActionChanged and Entities_DrawAll check
;   bit 4 set  layout is chosen by ACTION_ID rather than by animation frame,
;              via .data_03_608e_EntitySpriteLayoutPointerTable
;   none set   the default path, indexed by SPRITE_COUNTER
;
; The rest are status rather than configuration. Note bits 2 and 6 are both
; one-frame pulses - they are raised by TickAction and cleared again at the
; start of the next frame, so they are only meaningful to code that runs
; between the two
; ------------------------------------------------------------------
DEF ENTITY_FIELD_SPRITE_FLAGS               EQU $0A
    ; --- configuration: how this entity is drawn ---
    DEF SPRITE_FLAG_STREAMS_OWN_GFX_BIT   EQU 7 ; streams its own tiles; attributes from FACING_FLAGS
    DEF SPRITE_FLAG_LAYOUT_BY_ACTION_BIT  EQU 4 ; layout selected by action id, not animation frame
    DEF SPRITE_FLAG_INVISIBLE_BIT         EQU 3 ; draws nothing; collision only
    DEF SPRITE_FLAG_LOOP_LAST_FRAME_BIT   EQU 1 ; on wrap, restart at the last frame instead of the first
    DEF SPRITE_FLAG_EMBEDDED_DATA_BIT     EQU 0 ; sprite records embedded in the entity's data block

    ; --- status: written by the engine, read by everyone else ---
    DEF SPRITE_FLAG_ID_CHANGED_BIT        EQU 6 ; pulse: the sprite id changed, tiles need refetching
    DEF SPRITE_FLAG_ON_SCREEN_BIT         EQU 5 ; on screen, in the strict OAM-visible sense
    ; "the current action's animation just finished its last frame". Every
    ; action that ends by handing off to another one polls this
    DEF SPRITE_FLAG_ANIM_ENDED_BIT        EQU 2 ; pulse: the animation just wrapped

    DEF SPRITE_FLAG_STREAMS_OWN_GFX       EQU $80
    DEF SPRITE_FLAG_ID_CHANGED            EQU $40
    DEF SPRITE_FLAG_ON_SCREEN             EQU $20
    DEF SPRITE_FLAG_LAYOUT_BY_ACTION      EQU $10
    DEF SPRITE_FLAG_INVISIBLE             EQU $08
    DEF SPRITE_FLAG_ANIM_ENDED            EQU $04
    DEF SPRITE_FLAG_LOOP_LAST_FRAME       EQU $02
    DEF SPRITE_FLAG_EMBEDDED_DATA         EQU $01
DEF ENTITY_FIELD_SPRITE_FRAME_COUNTER_MAX   EQU $0B ; reload for $06 - the animation's speed
DEF ENTITY_FIELD_SPRITE_COUNTER_MAX         EQU $0C ; number of frames in the sequence
DEF ENTITY_FIELD_FACING_FLAGS               EQU $0D ; OR'd into the OAM attribute byte; bit 5 = FACING_LEFT (X flip)
DEF ENTITY_FIELD_XPOS                       EQU $0E ; word, world space
DEF ENTITY_FIELD_YPOS                       EQU $10 ; word, world space
; Screen position, recomputed every frame by Entity_BuildSprites as
; world - scroll, plus the OAM bias ($08 across, $10 down). Entities are kept
; loaded over a generous window (X -$28..$B7, Y -$10..$EF relative to the
; scroll origin) and only flagged SPRITE_FLAG_ON_SCREEN inside the tighter box
; that is actually visible
DEF ENTITY_FIELD_XPOS_ON_SCREEN             EQU $12
DEF ENTITY_FIELD_YPOS_ON_SCREEN             EQU $13
DEF ENTITY_FIELD_WIDTH                      EQU $14 ; collision box, not sprite size
DEF ENTITY_FIELD_HEIGHT                     EQU $15
DEF ENTITY_FIELD_COLLISION_TYPE             EQU $16 ; COLLISION_TYPE_*; picks the handler in bank 3
DEF ENTITY_FIELD_MISC_FLAGS                 EQU $17 ; different entities use these flags for different purposes
    DEF MISC_FLAGS_BIT_7                 EQU 7 ; for platforms: set = left platform movement, unset = right
    DEF MISC_FLAGS_BIT_6                 EQU 6 ; for platforms: set = up platform movement, unset = down
    DEF MISC_FLAGS_BIT_5                 EQU 5 ; unused?
    DEF MISC_FLAGS_BIT_4                 EQU 4 ; unused?
    DEF MISC_FLAGS_BIT_3                 EQU 3 ; used
    DEF MISC_FLAGS_BIT_2                 EQU 2 ; used
    DEF MISC_FLAGS_BIT_1                 EQU 1 ; for platforms: set = vertical platform movement, unset = horizontal
    DEF MISC_FLAGS_BIT_0                 EQU 0 ; used
DEF ENTITY_FIELD_MISC_TIMER                 EQU $18 ; general countdown; several entities despawn when it hits 0
DEF ENTITY_FIELD_TIMER_2                    EQU $19
; General-purpose per-entity byte. Not a flags field - it is one of the six spawn
; parameter slots (see SPAWN_PARAM_TO_MISC_PARAM), so the entity list supplies a
; value at spawn and each entity type reads it however it likes. Observed uses:
;   - a bitfield      (gun projectiles test bit 0)
;   - a table index   ($FF means none, otherwise masked to the low nibble)
;   - a counter       (read-and-increment, e.g. the multi-shot actions)
;   - a small state id (compared against $01/$03, or multiplied by 8)
;   - an unlock threshold, compared against wD64F_MissionRemoteTotal & $7F
;   - the HIGH half of a 16-bit Y coordinate stored across $1A/$1B by
;     call_00_3125_Entity_SetYFloorToCurrentPos and read back by
;     call_00_3137_Entity_ClampYToStoredFloor
; The last one is why $1B has no meaning of its own in that case
DEF ENTITY_FIELD_MISC_PARAM                 EQU $1A
DEF ENTITY_FIELD_UNK_1B                     EQU $1B ; never referenced through the field macros
DEF ENTITY_FIELD_XVEL                       EQU $1C
DEF ENTITY_FIELD_XVEL_RELATED               EQU $1D
DEF ENTITY_FIELD_YVEL                       EQU $1E
DEF ENTITY_FIELD_UNK_1F                     EQU $1F ; unused?

; ------------------------------------------------------------------
; Entity slots. wD200_EntityMemory is 8 consecutive $20-byte instances: slot 0
; is always Gex, the other 7 are whatever the level spawned. Because the block
; is $100 bytes aligned at $D200, code walks it by keeping only the low byte of
; the address in wD300_CurrentEntityAddrLo and letting it wrap to zero - that
; is why every loop here ends with "add $20 / jr NZ" rather than a counter
; ------------------------------------------------------------------
DEF ENTITY_SLOT_SIZE                        EQU $20
DEF ENTITY_SLOT_PLAYER                      EQU $00
DEF ENTITY_SLOT_FIRST_NPC                   EQU $20
DEF ENTITY_NPC_SLOT_COUNT                   EQU 7
DEF ENTITY_ID_NONE                          EQU $FF ; an empty slot

; Shadow OAM budget for entity sprites. The player owns the first $20 bytes
; (8 sprites); entities fill from there and are cut off at the end of the
; region that call_03_6484_OAM_ClearUnusedEntries blanks
DEF OAM_ENTITY_FIRST_BYTE                   EQU $20
DEF OAM_ENTITY_LAST_BYTE                    EQU $A0

; call_02_7211_EntityGfxQueue_Enqueue collects at most this many pending
; entity graphics loads; anything beyond is silently dropped until a slot frees
DEF ENTITY_GFX_QUEUE_SIZE                   EQU 4

; Entity Spawn Struct
DEF ENTITY_SPAWN_ID_OFFSET                  EQU $00
DEF ENTITY_SPAWN_XPOS_OFFSET                EQU $01
DEF ENTITY_SPAWN_YPOS_OFFSET                EQU $03
DEF ENTITY_SPAWN_BOUNDINGBOX_XMAX_OFFSET    EQU $05
DEF ENTITY_SPAWN_BOUNDINGBOX_XMIN_OFFSET    EQU $06
DEF ENTITY_SPAWN_BOUNDINGBOX_YMIN_OFFSET    EQU $07
DEF ENTITY_SPAWN_BOUNDINGBOX_YMAX_OFFSET    EQU $08
DEF ENTITY_SPAWN_PARAMETER_OFFSET           EQU $09
DEF ENTITY_SPAWN_PARAMETER2_OFFSET          EQU $0A
DEF ENTITY_SPAWN_PARAMETER3_OFFSET          EQU $0B
DEF ENTITY_SPAWN_RECORD_SIZE                EQU $10 ; 4 bytes of the record are spare

; Byte +0 of an entity's record in data_0a_75fd_EntityAttributeTable. One bit per
; entity field $18..$1F, high bit first: set means "initialise this field from the
; next spawn parameter", clear means "zero it". So the mask both selects the
; destination fields and, by its population count, says how many of the spawn
; record's parameter bytes this entity type consumes
DEF SPAWN_PARAM_TO_MISC_TIMER               EQU $80 ; -> ENTITY_FIELD_MISC_TIMER   ($18)
DEF SPAWN_PARAM_TO_TIMER_2                  EQU $40 ; -> ENTITY_FIELD_TIMER_2      ($19)
DEF SPAWN_PARAM_TO_MISC_PARAM               EQU $20 ; -> ENTITY_FIELD_MISC_PARAM   ($1A)
DEF SPAWN_PARAM_TO_UNK_1B                   EQU $10 ; -> ENTITY_FIELD_UNK_1B       ($1B)
DEF SPAWN_PARAM_TO_XVEL                     EQU $08 ; -> ENTITY_FIELD_XVEL         ($1C)
DEF SPAWN_PARAM_TO_XVEL_RELATED             EQU $04 ; -> ENTITY_FIELD_XVEL_RELATED ($1D)
DEF SPAWN_PARAM_TO_YVEL                     EQU $02 ; -> ENTITY_FIELD_YVEL         ($1E)
DEF SPAWN_PARAM_TO_UNK_1F                   EQU $01 ; -> ENTITY_FIELD_UNK_1F       ($1F)

; Entity child spawn id's
DEF SPAWN_CHILD_ENTITY_GHOST_HEAD                       EQU $00
DEF SPAWN_CHILD_ENTITY_FLOATING_SKULL_PROJECTILE        EQU $01
DEF SPAWN_CHILD_ENTITY_ZOMBIE_HEAD                      EQU $02
DEF SPAWN_CHILD_ENTITY_FLOWER_HAMMER                    EQU $03
DEF SPAWN_CHILD_ENTITY_NINJA_PROJECTILE                 EQU $04
DEF SPAWN_CHILD_ENTITY_SAMURAI_HEAD                     EQU $05
DEF SPAWN_CHILD_ENTITY_FIRE_PLANT_PROJECTILES           EQU $06
DEF SPAWN_CHILD_ENTITY_TRICERATOPS_HORN                 EQU $07
DEF SPAWN_CHILD_ENTITY_MUSHROOM_PROJECTILE              EQU $08
DEF SPAWN_CHILD_ENTITY_LITTLE_ROBOT_GEAR                EQU $09
DEF SPAWN_CHILD_ENTITY_GUN_PROJECTILE_EXPLOSION         EQU $0A
DEF SPAWN_CHILD_ENTITY_HUNTER_BULLET                    EQU $0B
DEF SPAWN_CHILD_ENTITY_DRAGON_PROJECTILE                EQU $0C
DEF SPAWN_CHILD_ENTITY_CANNON_PROJECTILE                EQU $0D
DEF SPAWN_CHILD_ENTITY_ANT                              EQU $0E
DEF SPAWN_CHILD_ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE_1 EQU $0F
DEF SPAWN_CHILD_ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE_2 EQU $10
DEF SPAWN_CHILD_ENTITY_REZ_PORTAL                       EQU $11

; Player vs Entity interaction events
DEF PLAYER_TOUCHED_ENTITY   EQU $00
DEF PLAYER_ATTACKED_ENTITY  EQU $01
DEF PLAYER_STOMPED_ENTITY   EQU $02

; Player interactions supported by an entity
DEF ENTITY_INTERACT_NONE    EQU $00
DEF ENTITY_INTERACT_TOUCH   EQU $01
DEF ENTITY_INTERACT_ATTACK  EQU $02
DEF ENTITY_INTERACT_STOMP   EQU $04

DEF PLAYER_ACTION_MASK                       EQU $1F

; Entity Collision Types
DEF COLLISION_TYPE_NONE                       EQU $00
DEF COLLISION_TYPE_COLLECTIBLE                EQU $01
DEF COLLISION_TYPE_EXTRA_LIFE                 EQU $02
DEF COLLISION_TYPE_STATIONARY_PLATFORM        EQU $03
DEF COLLISION_TYPE_MOVING_PLATFORM            EQU $04
DEF COLLISION_TYPE_ONE_WAY_PLATFORM           EQU $05
DEF COLLISION_TYPE_GENERIC_ENEMY              EQU $06
DEF COLLISION_TYPE_SILVER_REMOTE              EQU $07
DEF COLLISION_TYPE_GOLD_REMOTE                EQU $08
DEF COLLISION_TYPE_TOUCH_DAMAGE               EQU $09
DEF COLLISION_TYPE_LANTERN                    EQU $0A
DEF COLLISION_TYPE_ZOMBIE                     EQU $0B
DEF COLLISION_TYPE_GHOST_HEAD                 EQU $0C
DEF COLLISION_TYPE_GHOST                      EQU $0D
DEF COLLISION_TYPE_ZOMBIE_HEAD                EQU $0E
DEF COLLISION_TYPE_FALLING_HAZARD             EQU $0F
DEF COLLISION_TYPE_HUNTER                     EQU $10
DEF COLLISION_TYPE_MUSHROOM                   EQU $11
DEF COLLISION_TYPE_NONE_2                     EQU $12
DEF COLLISION_TYPE_MULTI_PROJECTILE           EQU $13
DEF COLLISION_TYPE_JAR                        EQU $14
DEF COLLISION_TYPE_NINJA                      EQU $15
DEF COLLISION_TYPE_HANGING_BLADE              EQU $16
DEF COLLISION_TYPE_LAUNCH_PAD                 EQU $17 ; only effect is to set wD758_JumpVelocityOverride
DEF COLLISION_TYPE_SAMURAI_BODY               EQU $18
DEF COLLISION_TYPE_SAMURAI_HEAD               EQU $19
DEF COLLISION_TYPE_GEYSER                     EQU $1A
DEF COLLISION_TYPE_TRICERATOPS                EQU $1B
DEF COLLISION_TYPE_GEAR                       EQU $1C
DEF COLLISION_TYPE_ELECTRIC_BALL              EQU $1D
DEF COLLISION_TYPE_GUN_PROJECTILE             EQU $1E
DEF COLLISION_TYPE_ROCKET                     EQU $1F
DEF COLLISION_TYPE_CANNON                     EQU $20
DEF COLLISION_TYPE_POWERED_WALKWAY            EQU $21
DEF COLLISION_TYPE_POWER_UP                   EQU $22
DEF COLLISION_TYPE_DRAGON_PROJECTILE          EQU $23
DEF COLLISION_TYPE_REZ                        EQU $24
DEF COLLISION_TYPE_PLATFORM                   EQU $80

; Text
DEF END_TEXT        EQU $80

; VRAM memory address constants
DEF VRAM_HUD_TILES                                    EQU $8600
DEF VRAM_HUD_DEMO_MODE_OR_TIMER                       EQU $8680
DEF VRAM_DIGIT_HUNDREDS                               EQU $8748
DEF VRAM_DIGIT_TENS                                   EQU $8768
DEF VRAM_DIGIT_ONES                                   EQU $8788
DEF VRAM_LIVES_TENS                                   EQU $87a8
DEF VRAM_LIVES_ONES                                   EQU $87c8
DEF VRAM_COLLECTIBLE_SPRITES                          EQU $87e0

DEF VRAM_TILESET_ADDR_2                               EQU $8800
DEF VRAM_TILESET_ADDR_1                               EQU $9000

DEF VRAM_ANIMATED_BG_TILE_TOON_TV_GROUP_1                EQU $8b30
DEF VRAM_ANIMATED_BG_TILE_TOON_TV_GROUP_2                EQU $8a50
DEF VRAM_ANIMATED_BG_TILE_TOON_TV_GROUP_3                EQU $8c40
DEF VRAM_ANIMATED_BG_TILE_SCREAM_TV_GROUP_1              EQU $97e0
DEF VRAM_ANIMATED_BG_TILE_SCREAM_TV_GROUP_2              EQU $96a0
DEF VRAM_ANIMATED_BG_TILE_SCREAM_TV_GROUP_3              EQU $8ac0
DEF VRAM_ANIMATED_BG_TILE_SCREAM_TV_GROUP_4              EQU $8b00
DEF VRAM_ANIMATED_BG_TILE_CIRCUIT_CENTRAL_GROUP_1        EQU $91e0
DEF VRAM_ANIMATED_BG_TILE_CIRCUIT_CENTRAL_GROUP_2        EQU $9200
DEF VRAM_ANIMATED_BG_TILE_CIRCUIT_CENTRAL_GROUP_3        EQU $9220
DEF VRAM_ANIMATED_BG_TILE_REZOPOLIS_GROUP_1              EQU $8cb0
DEF VRAM_ANIMATED_BG_TILE_REZOPOLIS_GROUP_2              EQU $8e00
DEF VRAM_ANIMATED_BG_TILE_REZOPOLIS_GROUP_3              EQU $8f00

; Entity Actions
DEF  PLAYER_ACTION_SPAWN                      EQU $00
DEF  PLAYER_ACTION_INTRO_WARP                 EQU $01
DEF  PLAYER_ACTION_STAND                      EQU $02
DEF  PLAYER_ACTION_IDLE_ANIMATION             EQU $03
DEF  PLAYER_ACTION_WALK                       EQU $04
DEF  PLAYER_ACTION_RUN                        EQU $05
DEF  PLAYER_ACTION_SKID                       EQU $06
DEF  PLAYER_ACTION_STOP_ON_CERTAIN_FLOOR      EQU $07
DEF  PLAYER_ACTION_CROUCH                     EQU $08
DEF  PLAYER_ACTION_JUMP                       EQU $09
DEF  PLAYER_ACTION_DOUBLE_JUMP                EQU $0A
DEF  PLAYER_ACTION_NONE                       EQU $0B
DEF  PLAYER_ACTION_KARATE_KICK                EQU $0C
DEF  PLAYER_ACTION_TAIL_SPIN                  EQU $0D
DEF  PLAYER_ACTION_EAT_FLY                    EQU $0E
DEF  PLAYER_ACTION_TAKE_DAMAGE                EQU $0F
DEF  PLAYER_ACTION_DEATH                      EQU $10
DEF  PLAYER_ACTION_DEATH_SET_UP_WARP          EQU $11
DEF  PLAYER_ACTION_ENTER_TV                   EQU $12
DEF  PLAYER_ACTION_ENTER_TV_ALT               EQU $13
DEF  PLAYER_ACTION_EXIT_TV                    EQU $14
DEF  PLAYER_ACTION_STANDING_PUSH              EQU $15 ; pushing bg wall
DEF  PLAYER_ACTION_WALKING_PUSH               EQU $16 ; pushing entity, such as tv button
DEF  PLAYER_ACTION_FREEFALL                   EQU $17
DEF  PLAYER_ACTION_STOP_IMMEDIATE             EQU $18
DEF  PLAYER_ACTION_COLLAPSE                   EQU $19 ; crushed by enemy, or landed from large fall
DEF  PLAYER_ACTION_ENTER_DOOR                 EQU $1A
DEF  PLAYER_ACTION_LEAVE_DOOR                 EQU $1B
DEF  PLAYER_ACTION_HIT_BOUNCE                 EQU $1C ; used when touch lava
DEF  PLAYER_ACTION_CLIMB                      EQU $1D ; used for both types of climbing
DEF  PLAYER_ACTION_GOLD_REMOTE_WARP           EQU $1E
DEF  PLAYER_ACTION_RIDING_ROCKET              EQU $1F ; disables collision updating?
DEF  PLAYER_ACTION_NONE_PENDING               EQU $FF

; ------------------------------------------------------------------
; Player facing (wD20D_Player_FacingFlags).
; Only bit 5 is meaningful; the sprite builder in bank 3 uses it to pick the
; mirrored frame set, and Player_ApplyXMovement uses it to negate the X delta.
; ------------------------------------------------------------------
DEF  FACING_RIGHT                             EQU $00
DEF  FACING_LEFT                              EQU $20
DEF  FACING_LEFT_BIT                          EQU 5

; ------------------------------------------------------------------
; wD746_Player_ClimbingState. $FF means "not climbing" - every routine in
; bank 2 that moves Gex normally (facing, X movement, gravity) bails out
; unless this holds $FF. Values 0-9 index .data_02_44e5 in
; call_02_44af_PlayerAction_Climb.
; ------------------------------------------------------------------
DEF  CLIMB_STATE_BACKGROUND                   EQU $00
DEF  CLIMB_STATE_BACKGROUND_TAIL_SPIN         EQU $01
DEF  CLIMB_STATE_WALL                         EQU $02
DEF  CLIMB_STATE_WALL_TAIL_SPIN               EQU $03
DEF  CLIMB_STATE_WALL_ALT                     EQU $04 ; same handler as CLIMB_STATE_WALL
DEF  CLIMB_STATE_WALL_TAIL_SPIN_ALT           EQU $05 ; same handler as CLIMB_STATE_WALL_TAIL_SPIN
DEF  CLIMB_STATE_BACKGROUND_BOTTOM            EQU $06 ; dismount animation at the bottom
DEF  CLIMB_STATE_WALL_BOTTOM                  EQU $07
DEF  CLIMB_STATE_WALL_TOP                     EQU $08
DEF  CLIMB_STATE_PIPE_TRANSITION              EQU $09
DEF  CLIMB_STATE_NOT_CLIMBING                 EQU $FF

; wD74B_Player_ClimbingFlags. Bit 6 shifts the sprite builder to the alternate
; (rotated) climb frame set - see call_03_5ca8_Entity_BuildPlayerSprites
DEF  CLIMB_FLAG_ALT_FRAMES                    EQU $40
DEF  CLIMB_FLAG_ALT_FRAMES_BIT                EQU 6

; ------------------------------------------------------------------
; wD759_ButtonBlockingFlags. Set by actions to swallow button presses until
; the button is released, so that holding a button cannot re-trigger an action.
; Filtered into wD75A_CurrentInputsAlt by call_02_4939_Player_UpdateMain
; ------------------------------------------------------------------
DEF  BTN_BLOCK_A_BIT                          EQU 0 ; suppress A until released
DEF  BTN_BLOCK_B_UNTIL_RELEASE_BIT            EQU 6 ; suppress B until released
DEF  BTN_BLOCK_B_WHILE_RISING_BIT             EQU 7 ; suppress B while Y velocity is upward
DEF  BTN_BLOCK_B_REPRESS_LATCH_BIT            EQU 4 ; B was released during the rise, so allow one re-press

DEF  BTN_BLOCK_A                              EQU $01
DEF  BTN_BLOCK_B_REPRESS_LATCH                EQU $10
DEF  BTN_BLOCK_B_UNTIL_RELEASE                EQU $40
DEF  BTN_BLOCK_B_WHILE_RISING                 EQU $80

; Sentinels in the per-action input transition lists hanging off
; data_02_4d15_ActionInputTransitionTable
DEF  ACTION_INPUT_ANY                         EQU $FE ; matches any nonzero input
DEF  ACTION_INPUT_END                         EQU $FF ; end of list

; ------------------------------------------------------------------
; Player physics. Y velocity is a signed byte, positive = upward
; ------------------------------------------------------------------
DEF  PLAYER_JUMP_VELOCITY                     EQU $2A
DEF  PLAYER_DOUBLE_JUMP_VELOCITY              EQU $36
DEF  PLAYER_HIT_BOUNCE_VELOCITY               EQU $50
DEF  PLAYER_GRAVITY_PER_FRAME                 EQU $02
DEF  PLAYER_MAX_FALL_VELOCITY                 EQU $C0 ; -$40 as a signed byte
DEF  PLAYER_SPRING_VELOCITY_LOW               EQU $4C
DEF  PLAYER_SPRING_VELOCITY_HIGH              EQU $60
; Launch velocities entities can force through wD758_JumpVelocityOverride
DEF  PLAYER_GEYSER_VELOCITY                   EQU $50
DEF  PLAYER_LAUNCH_PAD_VELOCITY               EQU $7F

DEF  PLAYER_XSPEED_WALK                       EQU $01
DEF  PLAYER_XSPEED_RUN                        EQU $02

; Fall-distance thresholds tested on landing (wD763_FallDistanceCounter)
DEF  FALL_DISTANCE_LANDING_ANIM               EQU $08 ; below this, land with no animation
DEF  FALL_DISTANCE_HARD_LANDING               EQU $10 ; at or above this, PLAYER_ACTION_COLLAPSE

DEF  PLAYER_DAMAGE_COOLDOWN_LENGTH            EQU $77
DEF  PLAYER_IDLE_TIMER_LENGTH                 EQU $7D ; frames of standing still before the idle animation
DEF  PLAYER_KARATE_KICK_LENGTH                EQU $30
DEF  CLIMB_TAIL_SPIN_LENGTH                   EQU $20 ; frames before dropping back to the plain climb state

; ------------------------------------------------------------------
; Background collision tile types (wD764/wD765/wD766/wD767).
; These are the values the player code in bank 2 reacts to; the collision
; data itself lives at wC800_CurrentCollisionData
; ------------------------------------------------------------------
DEF  TILE_TYPE_NO_WALK_LEFT                   EQU $08 ; standing here facing left forces PLAYER_ACTION_STOP_ON_CERTAIN_FLOOR
DEF  TILE_TYPE_NO_WALK_RIGHT                  EQU $09 ; ...and this one facing right
DEF  TILE_TYPE_DOOR                           EQU $22 ; press up to enter
DEF  TILE_TYPE_INSTANT_KILL                   EQU $23
DEF  TILE_TYPE_LAVA                           EQU $24
DEF  TILE_TYPE_WATER                          EQU $25
DEF  TILE_TYPE_CLIMBABLE_BACKGROUND           EQU $26 ; press up to start CLIMB_STATE_BACKGROUND
DEF  TILE_TYPE_CLIMBABLE_WALL_FACING_LEFT     EQU $2C ; only entered while facing left
DEF  TILE_TYPE_CLIMBABLE_WALL_FACING_RIGHT    EQU $2D ; only entered while facing right
DEF  TILE_TYPE_SPRING_LOW                     EQU $CE
DEF  TILE_TYPE_SPRING_HIGH                    EQU $CF
DEF  TILE_TYPE_TRAMPOLINE_LOW                 EQU $F0 ; only springs while the circuit power-up is active
DEF  TILE_TYPE_TRAMPOLINE_HIGH                EQU $F1
; Tile types $C0 and up are the "attackable" scenery (crates, switches, cages).
; PlayerAction_TailSpin tests them in complement form: it does cpl then cp $40,
; which is true exactly when the original tile type is >= $C0
DEF  TILE_TYPE_INTERACTIVE_MIN                EQU $C0
DEF  TILE_TYPE_INTERACTIVE_MIN_CPL            EQU $40 ; 256 - TILE_TYPE_INTERACTIVE_MIN

DEF  HUNTER_ACTION_UNK0  EQU $00
DEF  HUNTER_ACTION_UNK1  EQU $01
DEF  HUNTER_ACTION_UNK2  EQU $02
DEF  HUNTER_ACTION_UNK3  EQU $03
DEF  HUNTER_ACTION_UNK4  EQU $04
DEF  HUNTER_ACTION_UNK5  EQU $05
