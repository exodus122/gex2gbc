; Player action jump table
data_02_4120:
; Jump table with 32 entries (action ID × 4 bytes). Each entry is a pair of pointers: 
; the action update function and its animation data table. Action IDs $00–$1F defined here plus sentinel $FF
    DEF  PLAYER_ACTION_SPAWN                      EQU $00
    dw   call_02_41a0_PlayerAction_Spawn, data_02_755c
    DEF  PLAYER_ACTION_INTRO_WARP                 EQU $01
    dw   call_02_41ad_PlayerAction_IntroWarp, data_02_756d
    DEF  PLAYER_ACTION_STAND                      EQU $02
    dw   call_02_41b7_PlayerAction_Stand, data_02_7573
    DEF  PLAYER_ACTION_IDLE_ANIMATION             EQU $03
    dw   call_02_422b_PlayerAction_None, data_02_757c
    DEF  PLAYER_ACTION_WALK                       EQU $04
    dw   call_02_422c_PlayerAction_Walk, data_02_7582
    DEF  PLAYER_ACTION_RUN                        EQU $05
    dw   call_02_4248_PlayerAction_Run, data_02_758f
    DEF  PLAYER_ACTION_SKID                       EQU $06
    dw   call_02_425a_PlayerAction_SkidDecel, data_02_759c
    DEF  PLAYER_ACTION_STOP_ON_CERTAIN_FLOOR      EQU $07
    dw   call_02_426b_PlayerAction_StopOnCertainFloor, data_02_75a4
    DEF  PLAYER_ACTION_CROUCH                     EQU $08
    dw   call_02_4270_PlayerAction_Crouch, data_02_75ad
    DEF  PLAYER_ACTION_JUMP                       EQU $09
    dw   call_02_4275_PlayerAction_Jump, data_02_75b3
    DEF  PLAYER_ACTION_DOUBLE_JUMP                EQU $0A
    dw   call_02_42ac_PlayerAction_DoubleJump, data_02_75bb
    DEF  PLAYER_ACTION_NONE                       EQU $0B
    dw   call_02_42e0_PlayerAction_None, data_02_75c1
    DEF  PLAYER_ACTION_KARATE_KICK                EQU $0C
    dw   call_02_42e1_PlayerAction_KarateKick, data_02_75c7
    DEF  PLAYER_ACTION_TAIL_SPIN                  EQU $0D
    dw   call_02_42f7_PlayerAction_TailSpin, data_02_75ce
    DEF  PLAYER_ACTION_EAT_FLY                    EQU $0E
    dw   call_02_434d_PlayerAction_EatFly, data_02_75d9
    DEF  PLAYER_ACTION_TAKE_DAMAGE                EQU $0F
    dw   call_02_435b_PlayerAction_TakeDamage, data_02_75df
    DEF  PLAYER_ACTION_DEATH                      EQU $10
    dw   call_02_4371_PlayerAction_Death, data_02_75e9
    DEF  PLAYER_ACTION_DEATH_SET_UP_WARP          EQU $11
    dw   call_02_437b_PlayerAction_DeathSetUpWarp, data_02_75f2
    DEF  PLAYER_ACTION_ENTER_TV                   EQU $12
    dw   call_02_43a7_PlayerAction_EnterTV, data_02_75f9
    DEF  PLAYER_ACTION_ENTER_TV_ALT               EQU $13
    dw   call_02_43c6_PlayerAction_EnterTVAlt, data_02_75f9
    DEF  PLAYER_ACTION_EXIT_TV                    EQU $14
    dw   call_02_43e5_PlayerAction_ExitTV, data_02_7608
    DEF  PLAYER_ACTION_STANDING_PUSH              EQU $15 ; pushing bg wall
    dw   call_02_43f6_PlayerAction_StandingPush, data_02_7617
    DEF  PLAYER_ACTION_WALKING_PUSH               EQU $16 ; pushing entity, such as tv button
    dw   call_02_4407_PlayerAction_WalkingPush, data_02_761d
    DEF  PLAYER_ACTION_FREEFALL                   EQU $17
    dw   call_02_4418_PlayerAction_Freefall, data_02_762a
    DEF  PLAYER_ACTION_STOP_IMMEDIATE             EQU $18
    dw   call_02_4443_PlayerAction_StopImmediate, data_02_7633
    DEF  PLAYER_ACTION_COLLAPSE                   EQU $19 ; crushed by enemy, or landed from large fall
    dw   call_02_4448_PlayerAction_Collapse, data_02_7639
    DEF  PLAYER_ACTION_ENTER_DOOR                 EQU $1A
    dw   call_02_4459_PlayerAction_EnterDoor, data_02_7647
    DEF  PLAYER_ACTION_LEAVE_DOOR                 EQU $1B
    dw   call_02_447e_PlayerAction_LeaveDoor, data_02_7658
    DEF  PLAYER_ACTION_HIT_BOUNCE                 EQU $1C
    dw   call_02_4483_PlayerAction_HitBounce, data_02_7665
    DEF  PLAYER_ACTION_CLIMB                      EQU $1D ; used for both types of climbing
    dw   call_02_44af_PlayerAction_Climb, data_02_766d
    DEF  PLAYER_ACTION_GOLD_REMOTE_WARP           EQU $1E
    dw   call_02_481b_PlayerAction_GoldRemoteWarp, data_02_7673
    DEF  PLAYER_ACTION_RIDING_ROCKET              EQU $1F ; disables collision updating?
    dw   call_02_4828_PlayerAction_RidingRocket, data_02_7684
    DEF  PLAYER_ACTION_NONE_PENDING               EQU $FF
    
call_02_41a0_PlayerAction_Spawn:
; On first frame (bit 5 of wD209 set): plays spawn SFX
    ld   A, [wD209_Player_ActionState]                                    ;; 02:41a0 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:41a3 $e6 $20
    jr   Z, .jr_02_41ac                                ;; 02:41a5 $28 $05
    ld   C, SFX_GEX_SPAWN                                        ;; 02:41a7 $0e $11
    call call_00_112f_QueueSFX                                  ;; 02:41a9 $cd $2f $11
.jr_02_41ac:
    ret                                                ;; 02:41ac $c9
    
call_02_41ad_PlayerAction_IntroWarp:
; On non-Media-Dimension levels calls call_00_0634_FlyPowerup_StartEntry (unknown, likely outro warp/level entry effect). 
; Then calls Entity_RequestQueuedAction to advance to next action
    ld   A, [wD624_CurrentLevelId]                                    ;; 02:41ad $fa $24 $d6
    and  A, A                                          ;; 02:41b0 $a7
    call NZ, call_00_0634_FlyPowerup_StartEntry                              ;; 02:41b1 $c4 $34 $06
    jp   call_02_70f1_Entity_RequestQueuedAction                                    ;; 02:41b4 $c3 $f1 $70
    
call_02_41b7_PlayerAction_Stand:
; On first frame: sets B-lock flag (bit 6 of wD759), zeroes X speed and Y velocity, sets idle timer to max(health, 50). 
; Each frame: checks floor tile type — if tile $08 and facing right, or $09 and facing left 
; (directional conveyor/slope), requests action $07 (StopOnCertainFloor). Otherwise decrements idle timer; 
; when it hits zero, requests action $03 (IdleAnimation)
    ld   A, [wD209_Player_ActionState]                                    ;; 02:41b7 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:41ba $e6 $20
    jr   Z, .jr_02_41da                                ;; 02:41bc $28 $1c
    ld   HL, wD759_ButtonBlockingFlags                                     ;; 02:41be $21 $59 $d7
    set  6, [HL]                                       ;; 02:41c1 $cb $f6
    xor  A, A                                          ;; 02:41c3 $af
    ld   [wD75D_PlayerXSpeedPrev], A                                    ;; 02:41c4 $ea $5d $d7
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:41c7 $ea $60 $d7
    xor  A, A                                          ;; 02:41ca $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:41cb $ea $5e $d7
    call call_02_4dd8_Player_GetMaxHealth                                  ;; 02:41ce $cd $d8 $4d
    cp   A, $32                                        ;; 02:41d1 $fe $32
    jr   NC, .jr_02_41d7                               ;; 02:41d3 $30 $02
    ld   A, $32                                        ;; 02:41d5 $3e $32
.jr_02_41d7:
    ld   [wD75B_IdleTimer], A                                    ;; 02:41d7 $ea $5b $d7
.jr_02_41da:
    ld   A, [wD767_FloorTileType]                                    ;; 02:41da $fa $67 $d7
    cp   A, $08                                        ;; 02:41dd $fe $08
    jr   Z, .jr_02_41ee                                ;; 02:41df $28 $0d
    cp   A, $09                                        ;; 02:41e1 $fe $09
    jr   NZ, .jr_02_41fa                               ;; 02:41e3 $20 $15
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 02:41e5 $fa $0d $d2
    cp   A, $00                                        ;; 02:41e8 $fe $00
    jr   NZ, .jr_02_41fa                               ;; 02:41ea $20 $0e
    jr   .jr_02_41f5                                   ;; 02:41ec $18 $07
.jr_02_41ee:
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 02:41ee $fa $0d $d2
    cp   A, $20                                        ;; 02:41f1 $fe $20
    jr   NZ, .jr_02_41fa                               ;; 02:41f3 $20 $05
.jr_02_41f5:
    ld   A, PLAYER_ACTION_STOP_ON_CERTAIN_FLOOR                                        ;; 02:41f5 $3e $07
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:41f7 $c3 $cd $4c
.jr_02_41fa:
    ld   HL, wD75B_IdleTimer                                     ;; 02:41fa $21 $5b $d7
    dec  [HL]                                          ;; 02:41fd $35
    ret  NZ                                            ;; 02:41fe $c0
    ld   A, PLAYER_ACTION_IDLE_ANIMATION                                        ;; 02:41ff $3e $03
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:4201 $c3 $cd $4c

call_02_4204_Player_CheckWallPush:
; Checks if Gex should transition to a push animation. If wD74E (platform entity) is nonzero: 
; if directional input is held, sets C=$16 (WalkingPush). If zero: checks bit 6 of 
; collision flags (wall contact) → C=$15 (StandingPush). Calls Player_RequestAction with C
    ld   A, [wD74E_Player_PlatformRelated]                                    ;; 02:4204 $fa $4e $d7
    and  A, A                                          ;; 02:4207 $a7
    jr   NZ, .jr_02_4215                               ;; 02:4208 $20 $0b
    ld   HL, wD585_CollisionFlags                                     ;; 02:420a $21 $85 $d5
    bit  6, [HL]                                       ;; 02:420d $cb $76
    jr   Z, .jr_02_4227                                ;; 02:420f $28 $16
    ld   C, PLAYER_ACTION_STANDING_PUSH                                        ;; 02:4211 $0e $15
    jr   .jr_02_4227                                   ;; 02:4213 $18 $12
.jr_02_4215:
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4215 $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT                                        ;; 02:4218 $e6 $30
    jr   Z, .jr_02_4227                                ;; 02:421a $28 $0b
    ld   C, PLAYER_ACTION_STANDING_PUSH                                        ;; 02:421c $0e $15
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:421e $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT                                        ;; 02:4221 $e6 $30
    jr   Z, .jr_02_4227                                ;; 02:4223 $28 $02
    ld   C, PLAYER_ACTION_WALKING_PUSH                                        ;; 02:4225 $0e $16
.jr_02_4227:
    ld   A, C                                          ;; 02:4227 $79
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:4228 $c3 $cd $4c

call_02_422b_PlayerAction_None:
; Does nothing, returns immediately
    ret                                                ;; 02:422b $c9

call_02_422c_PlayerAction_Walk:
; On first frame: sets X speed to 1. Sets C=$04, calls Player_CheckWallPush. 
; If bit 2 of wD20A is set (run threshold reached), requests action $05 (Run)
    ld   A, [wD209_Player_ActionState]                                    ;; 02:422c $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:422f $e6 $20
    jr   Z, .jr_02_4238                                ;; 02:4231 $28 $05
    ld   A, $01                                        ;; 02:4233 $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4235 $ea $5e $d7
.jr_02_4238:
    ld   C, $04                                        ;; 02:4238 $0e $04
    call call_02_4204_Player_CheckWallPush                                  ;; 02:423a $cd $04 $42
    ld   A, [wD20A_Player_UnkFlags2]                                    ;; 02:423d $fa $0a $d2
    and  A, $04                                        ;; 02:4240 $e6 $04
    ld   A, PLAYER_ACTION_RUN                                        ;; 02:4242 $3e $05
    call NZ, call_02_4ccd_Player_RequestAction                              ;; 02:4244 $c4 $cd $4c
    ret                                                ;; 02:4247 $c9

call_02_4248_PlayerAction_Run:
; On first frame: sets X speed to 2. Sets C=$05, calls Player_CheckWallPush
    ld   A, [wD209_Player_ActionState]                                    ;; 02:4248 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:424b $e6 $20
    jr   Z, .jr_02_4254                                ;; 02:424d $28 $05
    ld   A, $02                                        ;; 02:424f $3e $02
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4251 $ea $5e $d7
.jr_02_4254:
    ld   C, $05                                        ;; 02:4254 $0e $05
    call call_02_4204_Player_CheckWallPush                                  ;; 02:4256 $cd $04 $42
    ret                                                ;; 02:4259 $c9

call_02_425a_PlayerAction_SkidDecel:
; Decelerates X speed from 2 to 0 over the animation duration using the 
; sprite frame counter: speed = max(0, 2 − (frame+1)>>1)
    ld   A, [wD207_Player_SpriteCounter]                                    ;; 02:425a $fa $07 $d2
    inc  A                                             ;; 02:425d $3c
    srl  A                                             ;; 02:425e $cb $3f
    ld   C, A                                          ;; 02:4260 $4f
    ld   A, $02                                        ;; 02:4261 $3e $02
    sub  A, C                                          ;; 02:4263 $91
    jr   NC, .jr_02_4267                               ;; 02:4264 $30 $01
    xor  A, A                                          ;; 02:4266 $af
.jr_02_4267:
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4267 $ea $5e $d7
    ret                                                ;; 02:426a $c9

call_02_426b_PlayerAction_StopOnCertainFloor:
; Zeroes X speed and returns. Used when standing on a directional floor tile
    xor a
    ld [wD75E_PlayerXSpeed], a
    ret

call_02_4270_PlayerAction_Crouch:
; Zeroes X speed and returns
    xor  A, A                                          ;; 02:4270 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4271 $ea $5e $d7
    ret                                                ;; 02:4274 $c9

call_02_4275_PlayerAction_Jump:
; On first frame: calls PlayerJump_Sub with C=$2A to get jump velocity (may be boosted by special floor tiles), 
; stores to wD760/wD762, sets B-lock flag, plays jump SFX, ensures X speed ≥ 1. 
; Each frame: if wD762 (initial Y velocity) is nonzero, returns (still in jump arc). 
; If B is held, requests double jump ($0A). Otherwise calls Player_SetLandingAction
    ld   A, [wD209_Player_ActionState]                                    ;; 02:4275 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:4278 $e6 $20
    jr   Z, .jr_02_429a                                ;; 02:427a $28 $1e
    ld   C, $2a                                        ;; 02:427c $0e $2a
    call call_02_480f_Player_GetJumpVelocity                                  ;; 02:427e $cd $56 $48
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4281 $ea $60 $d7
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:4284 $ea $62 $d7
    call call_02_4a3a_Player_LockBPress                                  ;; 02:4287 $cd $3a $4a
    ld   C, SFX_GEX_JUMP                                        ;; 02:428a $0e $0c
    call call_00_112f_QueueSFX                                  ;; 02:428c $cd $2f $11
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:428f $fa $5e $d7
    and  A, A                                          ;; 02:4292 $a7
    jr   NZ, .jr_02_429a                               ;; 02:4293 $20 $05
    ld   A, $01                                        ;; 02:4295 $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4297 $ea $5e $d7
.jr_02_429a:
    ld   A, [wD762_PlayerInitialYVelocity]                                    ;; 02:429a $fa $62 $d7
    and  A, A                                          ;; 02:429d $a7
    ret  NZ                                            ;; 02:429e $c0
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:429f $fa $5a $d7
    and  A, PADF_B                                        ;; 02:42a2 $e6 $02
    ld   A, PLAYER_ACTION_DOUBLE_JUMP                                        ;; 02:42a4 $3e $0a
    jp   NZ, call_02_4ccd_Player_RequestAction                              ;; 02:42a6 $c2 $cd $4c
    jp   call_02_489a_Player_SetLandingAction                                    ;; 02:42a9 $c3 $9a $48

call_02_42ac_PlayerAction_DoubleJump:
; On first frame: calls PlayerJump_Sub with C=$36 (higher velocity), stores to wD760/wD762, sets B-lock, 
; plays double-jump SFX, ensures X speed ≥ 1. 
; Each frame: if wD762 nonzero, returns. If B is still held, re-executes the first-frame 
; logic (allows continuous re-fire while B held). Otherwise calls Player_SetLandingAction
    ld   A, [wD209_Player_ActionState]                                    ;; 02:42ac $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:42af $e6 $20
    jr   Z, .jr_02_42d1                                ;; 02:42b1 $28 $1e
.jr_02_42b3:
    ld   C, $36                                        ;; 02:42b3 $0e $36
    call call_02_480f_Player_GetJumpVelocity                                  ;; 02:42b5 $cd $56 $48
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:42b8 $ea $60 $d7
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:42bb $ea $62 $d7
    call call_02_4a3a_Player_LockBPress                                  ;; 02:42be $cd $3a $4a
    ld   C, SFX_GEX_DOUBLE_JUMP                                        ;; 02:42c1 $0e $0d
    call call_00_112f_QueueSFX                                  ;; 02:42c3 $cd $2f $11
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:42c6 $fa $5e $d7
    and  A, A                                          ;; 02:42c9 $a7
    jr   NZ, .jr_02_42d1                               ;; 02:42ca $20 $05
    ld   A, $01                                        ;; 02:42cc $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:42ce $ea $5e $d7
.jr_02_42d1:
    ld   A, [wD762_PlayerInitialYVelocity]                                    ;; 02:42d1 $fa $62 $d7
    and  A, A                                          ;; 02:42d4 $a7
    ret  NZ                                            ;; 02:42d5 $c0
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:42d6 $fa $5a $d7
    and  A, PADF_B                                        ;; 02:42d9 $e6 $02
    jr   NZ, .jr_02_42b3                               ;; 02:42db $20 $d6
    jp   call_02_489a_Player_SetLandingAction                                    ;; 02:42dd $c3 $9a $48

call_02_42e0_PlayerAction_None:                             ;; 02:42e0
; Does nothing, returns immediately
    ret

call_02_42e1_PlayerAction_KarateKick:
; On first frame: sets wD74C = $30 (duration timer). 
; Each frame: decrements wD74C; when it reaches zero, requests Stand
    ld a, [wD209_Player_ActionState]
    and a,ACTION_STATE_IS_FIRST_FRAME
    jr z, .jr_02_42ed
    ld a, $30
    ld [wD74C], a
.jr_02_42ed:
    ld hl, wD74C
    dec [hl]
    ret nz
    ld a, PLAYER_ACTION_STAND
    jp call_02_4ccd_Player_RequestAction

call_02_42f7_PlayerAction_TailSpin:
; On first frame: sets A-button lock (bit 0 of wD759), sets wD76B=1 (attacking), ensures X speed ≥ 1. 
; Each frame: reads tile behind Gex — if type < $C0 (interactive tile), calls 
; HandlePlayerAttackingSpecialTiles. When animation ends (bit 2 of wD20A): clears attacking flag, 
; sets B-lock. If on ground, requests Stand/Walk/Run based on directional input and current X speed; 
; if airborne, requests Freefall
    ld   A, [wD209_Player_ActionState]                                    ;; 02:42f7 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:42fa $e6 $20
    jr   Z, .jr_02_4313                                ;; 02:42fc $28 $15
    ld   HL, wD759_ButtonBlockingFlags                                     ;; 02:42fe $21 $59 $d7
    set  0, [HL]                                       ;; 02:4301 $cb $c6
    ld   A, $01                                        ;; 02:4303 $3e $01
    ld   [wD76B_Player_IsAttacking], A                                    ;; 02:4305 $ea $6b $d7
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:4308 $fa $5e $d7
    and  A, A                                          ;; 02:430b $a7
    jr   NZ, .jr_02_4313                               ;; 02:430c $20 $05
    ld   A, $01                                        ;; 02:430e $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4310 $ea $5e $d7
.jr_02_4313:
    ld   A, [wD764_TileTypeBehindGexsBody]                                    ;; 02:4313 $fa $64 $d7
    cpl                                                ;; 02:4316 $2f
    ld   C, A                                          ;; 02:4317 $4f
    cp   A, $40                                        ;; 02:4318 $fe $40
    call C, call_00_1f46_SpecialTile_OnPlayerAttack                               ;; 02:431a $dc $46 $1f
    ld   A, [wD20A_Player_UnkFlags2]                                    ;; 02:431d $fa $0a $d2
    and  A, $04                                        ;; 02:4320 $e6 $04
    ret  Z                                             ;; 02:4322 $c8
    xor  A, A                                          ;; 02:4323 $af
    ld   [wD76B_Player_IsAttacking], A                                    ;; 02:4324 $ea $6b $d7
    ld   HL, wD759_ButtonBlockingFlags                                     ;; 02:4327 $21 $59 $d7
    set  6, [HL]                                       ;; 02:432a $cb $f6
    ld   C, PLAYER_ACTION_FREEFALL                                        ;; 02:432c $0e $17
    ld   HL, wD585_CollisionFlags                                     ;; 02:432e $21 $85 $d5
    bit  7, [HL]                                       ;; 02:4331 $cb $7e
    jr   Z, .jr_02_4349                                ;; 02:4333 $28 $14
    ld   C, PLAYER_ACTION_STAND                                        ;; 02:4335 $0e $02
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4337 $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT                                        ;; 02:433a $e6 $30
    jr   Z, .jr_02_4349                                ;; 02:433c $28 $0b
    ld   C, PLAYER_ACTION_RUN                                        ;; 02:433e $0e $05
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:4340 $fa $5e $d7
    cp   A, $02                                        ;; 02:4343 $fe $02
    jr   NC, .jr_02_4349                               ;; 02:4345 $30 $02
    ld   C, PLAYER_ACTION_WALK                                        ;; 02:4347 $0e $04
.jr_02_4349:
    ld   A, C                                          ;; 02:4349 $79
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:434a $c3 $cd $4c

call_02_434d_PlayerAction_EatFly:
; Zeroes X speed. On first frame: calls call_00_0647_Player_SetUpOrEatFlyPowerup (likely applies fly power-up effect
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    ret  z
    xor  a
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup

call_02_435b_PlayerAction_TakeDamage:
; On first frame: plays hurt SFX. Zeroes X speed. Sets wD750_Player_DamageCooldownTimer = $77 (invincibility timer)
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_4367
    ld   c,SFX_GEX_HURT
    call call_00_112f_QueueSFX
.jr_02_4367:
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   a,$77
    ld   [wD750_Player_DamageCooldownTimer],a
    ret  

call_02_4371_PlayerAction_Death:
; Zeroes X speed. Sets wD750_Player_DamageCooldownTimer = $77. Used as the "lying dead" hold state before respawn warp
    xor  A, A                                          ;; 02:4371 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4372 $ea $5e $d7
    ld   A, $77                                        ;; 02:4375 $3e $77
    ld   [wD750_Player_DamageCooldownTimer], A                                    ;; 02:4377 $ea $50 $d7
    ret                                                ;; 02:437a $c9

call_02_437b_PlayerAction_DeathSetUpWarp:
; On first frame: zeroes X speed, calls call_00_0f5d (set up respawn warp data), plays death SFX. 
; Each frame: sets wD750_Player_DamageCooldownTimer=$77. On animation end: sets spawn action to $00, sets bit 1 of 
; wD621 (warp flags) to trigger respawn warp
    ld   A, [wD209_Player_ActionState]                                    ;; 02:437b $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:437e $e6 $20
    jr   Z, .jr_02_438e                                ;; 02:4380 $28 $0c
    xor  A, A                                          ;; 02:4382 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4383 $ea $5e $d7
    call call_00_0f5d                                  ;; 02:4386 $cd $5d $0f
    ld   C, SFX_GEX_DEATH                                        ;; 02:4389 $0e $0f
    call call_00_112f_QueueSFX                                  ;; 02:438b $cd $2f $11
.jr_02_438e:
    ld   A, $77                                        ;; 02:438e $3e $77
    ld   [wD750_Player_DamageCooldownTimer], A                                    ;; 02:4390 $ea $50 $d7
    ld   A, [wD20A_Player_UnkFlags2]                                    ;; 02:4393 $fa $0a $d2
    and  A, $04                                        ;; 02:4396 $e6 $04
    ret  Z                                             ;; 02:4398 $c8
    ld   A, PLAYER_ACTION_SPAWN                                        ;; 02:4399 $3e $00
    ld   [wD744_Player_SpawnAction], A                                    ;; 02:439b $ea $44 $d7
    ld   A, [wD621_WarpFlags]                                    ;; 02:439e $fa $21 $d6
    or   A, $02                                        ;; 02:43a1 $f6 $02
    ld   [wD621_WarpFlags], A                                    ;; 02:43a3 $ea $21 $d6
    ret                                                ;; 02:43a6 $c9

call_02_43a7_PlayerAction_EnterTV:
; On first frame: plays spawn SFX. 
; Zeroes X speed. On animation end (bit 2 of wD20A): sets bit 2 of wD621 (warp into TV)
    ld   A, [wD209_Player_ActionState]                                    ;; 02:43a7 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:43aa $e6 $20
    jr   Z, .jr_02_43b3                                ;; 02:43ac $28 $05
    ld   C, SFX_GEX_SPAWN                                        ;; 02:43ae $0e $11
    call call_00_112f_QueueSFX                                  ;; 02:43b0 $cd $2f $11
.jr_02_43b3:
    xor  A, A                                          ;; 02:43b3 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:43b4 $ea $5e $d7
    ld   HL, wD20A_Player_UnkFlags2                                     ;; 02:43b7 $21 $0a $d2
    bit  2, [HL]                                       ;; 02:43ba $cb $56
    ret  Z                                             ;; 02:43bc $c8
    ld   A, [wD621_WarpFlags]                                    ;; 02:43bd $fa $21 $d6
    or   A, $04                                        ;; 02:43c0 $f6 $04
    ld   [wD621_WarpFlags], A                                    ;; 02:43c2 $ea $21 $d6
    ret                                                ;; 02:43c5 $c9

call_02_43c6_PlayerAction_EnterTVAlt:
; On first frame: plays spawn SFX. Zeroes X speed. 
; On animation end: sets bit 2 of wD621. 
; Functionally identical to EnterTV, likely used for a different entry/exit direction
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_43D2
    ld   c,SFX_GEX_SPAWN
    call call_00_112f_QueueSFX
.jr_02_43D2:
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   a,[wD20A_Player_UnkFlags2]
    and  a,$04
    ret  z
    ld   a,[wD621_WarpFlags]
    or   a,$04
    ld   [wD621_WarpFlags],a
    ret

call_02_43e5_PlayerAction_ExitTV:
; On first frame: plays spawn SFX. Zeroes X speed.
    ld   A, [wD209_Player_ActionState]                                    ;; 02:43e5 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:43e8 $e6 $20
    jr   Z, .jr_02_43f1                                ;; 02:43ea $28 $05
    ld   C, SFX_GEX_SPAWN                                        ;; 02:43ec $0e $11
    call call_00_112f_QueueSFX                                  ;; 02:43ee $cd $2f $11
.jr_02_43f1:
    xor  A, A                                          ;; 02:43f1 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:43f2 $ea $5e $d7
    ret                                                ;; 02:43f5 $c9

call_02_43f6_PlayerAction_StandingPush:
; On first frame: sets X speed to 1. 
; Sets C=$02, calls Player_CheckWallPush
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_4402
    ld   a,$01
    ld   [wD75E_PlayerXSpeed],a
.jr_02_4402:
    ld   c,$02
    jp   call_02_4204_Player_CheckWallPush

call_02_4407_PlayerAction_WalkingPush:
; On first frame: sets X speed to 1. 
; Sets C=$02, calls Player_CheckWallPush. Used when pushing a moveable entity like a TV button
    ld   A, [wD209_Player_ActionState]                                    ;; 02:4407 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:440a $e6 $20
    jr   Z, .jr_02_4413                                ;; 02:440c $28 $05
    ld   A, $01                                        ;; 02:440e $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4410 $ea $5e $d7
.jr_02_4413:
    ld   C, $02                                        ;; 02:4413 $0e $02
    jp   call_02_4204_Player_CheckWallPush                                  ;; 02:4415 $c3 $04 $42

call_02_4418_PlayerAction_Freefall:
; On first frame: sets wD762=1 (falling), ensures X speed ≥ 1. 
; Each frame: if wD762 nonzero, returns. On landing: if directional input held, 
; requests Walk; otherwise requests Stand
    ld   A, [wD209_Player_ActionState]                                    ;; 02:4418 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:441b $e6 $20
    jr   Z, .jr_02_442f                                ;; 02:441d $28 $10
    ld   A, $01                                        ;; 02:441f $3e $01
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:4421 $ea $62 $d7
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:4424 $fa $5e $d7
    and  A, A                                          ;; 02:4427 $a7
    jr   NZ, .jr_02_442f                               ;; 02:4428 $20 $05
    ld   A, $01                                        ;; 02:442a $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:442c $ea $5e $d7
.jr_02_442f:
    ld   A, [wD762_PlayerInitialYVelocity]                                    ;; 02:442f $fa $62 $d7
    and  A, A                                          ;; 02:4432 $a7
    ret  NZ                                            ;; 02:4433 $c0
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4434 $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT                                        ;; 02:4437 $e6 $30
    ld   A, PLAYER_ACTION_WALK                                        ;; 02:4439 $3e $04
    jp   NZ, call_02_4ccd_Player_RequestAction                              ;; 02:443b $c2 $cd $4c
    ld   A, PLAYER_ACTION_STAND                                        ;; 02:443e $3e $02
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:4440 $c3 $cd $4c

call_02_4443_PlayerAction_StopImmediate:
; Zeroes X speed immediately and returns
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ret  

call_02_4448_PlayerAction_Collapse:
; On first frame: plays collapse SFX. 
; Zeroes X speed. Used for hard landings and enemy crush
    ld   A, [wD209_Player_ActionState]                                    ;; 02:4448 $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:444b $e6 $20
    jr   Z, .jr_02_4454                                ;; 02:444d $28 $05
    ld   C, SFX_GEX_COLLAPSE                                        ;; 02:444f $0e $0e
    call call_00_112f_QueueSFX                                  ;; 02:4451 $cd $2f $11
.jr_02_4454:
    xor  A, A                                          ;; 02:4454 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4455 $ea $5e $d7
    ret                                                ;; 02:4458 $c9

call_02_4459_PlayerAction_EnterDoor:
; On first frame: calls Player_SpawnLevelSpecificDoor with A=0. 
; Zeroes X speed. Calls PlayerWarp_Sub; if warp triggers: sets bit 3 of wD621 (door warp), 
; sets spawn action to LeaveDoor, despawns all entities
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_4465
    ld   a,$00
    call call_02_48b7_Player_SpawnLevelSpecificDoor
.jr_02_4465:
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    call call_02_4894_Player_CheckWarpReady
    ret  z
    ld   a,[wD621_WarpFlags]
    or   a,$08
    ld   [wD621_WarpFlags],a
    ld   a,PLAYER_ACTION_LEAVE_DOOR
    ld   [wD744_Player_SpawnAction],a
    call call_00_38f0_Entity_ClearAllSlots
    ret  

call_02_447e_PlayerAction_LeaveDoor:
; Zeroes X speed and returns. Holds Gex stationary while the door-entry transition completes
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ret  

call_02_4483_PlayerAction_HitBounce:
; On first frame: plays a SFX, calls DealDamageToPlayer, sets Y velocity to $50 (bounce upward), sets wD762=$50. 
; Ensures X speed ≥ 1. On Y velocity expiry: requests Stand. Used when hit by an enemy that bounces Gex upward
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_44A5
    ld   c,SFX_GEX_HIT_BOUNCE
    call call_00_112f_QueueSFX
    call call_00_06bf_DealDamageToPlayer
    ld   a,$50
    ld   [wD760_PlayerYVelocity],a
    ld   [wD762_PlayerInitialYVelocity],a
    ld   a,[wD75E_PlayerXSpeed]
    and  a
    jr   nz,.jr_02_44A5
    ld   a,$01
    ld   [wD75E_PlayerXSpeed],a
.jr_02_44A5:
    ld   a,[wD762_PlayerInitialYVelocity]
    and  a
    ret  nz
    ld   a,PLAYER_ACTION_STAND
    jp   call_02_4ccd_Player_RequestAction

call_02_44af_PlayerAction_Climb:
; On first frame: sets B-lock, zeroes climb counter/X speed/Y velocity/falling flag. 
; Sets climb state to 0 (background) or 2 (wall) based on tile type $26 in wD769. 
; Each frame: dispatches via .data_02_44e5 jump table on wD746 (climb state 0–9)
    ld   A, [wD209_Player_ActionState]                                    ;; 02:44af $fa $09 $d2
    and  A, ACTION_STATE_IS_FIRST_FRAME                                        ;; 02:44b2 $e6 $20
    jr   Z, .jr_02_44d6                                ;; 02:44b4 $28 $20
    ld   HL, wD759_ButtonBlockingFlags                                     ;; 02:44b6 $21 $59 $d7
    set  6, [HL]                                       ;; 02:44b9 $cb $f6
    xor  A, A                                          ;; 02:44bb $af
    ld   [wD747_Player_ClimbingUnkCounter], A                                    ;; 02:44bc $ea $47 $d7
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:44bf $ea $5e $d7
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:44c2 $ea $60 $d7
    ld   [wD761_PlayerFallingFlag], A                                    ;; 02:44c5 $ea $61 $d7
    ld   A, [wD769]                                    ;; 02:44c8 $fa $69 $d7
    cp   A, $26                                        ;; 02:44cb $fe $26
    ld   A, $00                                        ;; 02:44cd $3e $00
    jr   Z, .jr_02_44d3                                ;; 02:44cf $28 $02
    ld   A, $02                                        ;; 02:44d1 $3e $02
.jr_02_44d3:
    ld   [wD746_Player_ClimbingState], A                                    ;; 02:44d3 $ea $46 $d7
.jr_02_44d6:
    ld   HL, wD746_Player_ClimbingState                                     ;; 02:44d6 $21 $46 $d7
    ld   L, [HL]                                       ;; 02:44d9 $6e
    ld   H, $00                                        ;; 02:44da $26 $00
    add  HL, HL                                        ;; 02:44dc $29
    ld   DE, .data_02_44e5                             ;; 02:44dd $11 $e5 $44
    add  HL, DE                                        ;; 02:44e0 $19
    ld   A, [HL+]                                      ;; 02:44e1 $2a
    ld   H, [HL]                                       ;; 02:44e2 $66
    ld   L, A                                          ;; 02:44e3 $6f
    jp   HL                                            ;; 02:44e4 $e9
.data_02_44e5:
    dw   .jp_02_44f9_PlayerClimbAction_Background ; climbing background
    dw   .jp_02_455f_PlayerClimbAction_BackgroundTailSpin ; climbing background and tail spinning
    dw   .jp_02_45b0_PlayerClimbAction_Wall ; climbing wall
    dw   .jp_02_4626_PlayerClimbAction_WallTailSpin ; climbing wall and tail spinning
    dw   .jp_02_45b0_PlayerClimbAction_Wall
    dw   .jp_02_4626_PlayerClimbAction_WallTailSpin
    dw   .jp_02_4667_PlayerClimbAction_BackgroundBottom ; climbing background: reached bottom
    dw   .jp_02_468f_PlayerClimbAction_WallBottom ; climbing wall: reached bottom
    dw   .jp_02_46b3_PlayerClimbAction_WallTop ; climbing wall: reached top
    dw   .jp_02_46b8_PlayerClimbAction_PipeTransition
    
.jp_02_44f9_PlayerClimbAction_Background:
; Background climbing movement. Calls PlayerBackgroundClimb_Sub to get a direction index; 
; if valid, stores to wD748, looks up facing/flag/sprite base from .data_02_4557/.data_02_454f. 
; Increments climb counter, derives animation frame (counter >> 2 & 7 + base), updates sprite if changed, 
; triggers VRAM load. If B pressed → requests Freefall. If A pressed → switches to 
; climb state 1 (BackgroundTailSpin)
    call call_02_4777_PlayerBackgroundClimb_GetDirection                                  ;; 02:44f9 $cd $77 $47
    cp   A, $ff                                        ;; 02:44fc $fe $ff
    jr   Z, .jr_02_4531                                ;; 02:44fe $28 $31
    ld   [wD748_Player_ClimbingRelated], A                                    ;; 02:4500 $ea $48 $d7
    ld   E, A                                          ;; 02:4503 $5f
    ld   D, $00                                        ;; 02:4504 $16 $00
    ld   HL, .data_02_4557                             ;; 02:4506 $21 $57 $45
    add  HL, DE                                        ;; 02:4509 $19
    ld   A, [HL]                                       ;; 02:450a $7e
    and  A, $20                                        ;; 02:450b $e6 $20
    ld   [wD20D_PlayerFacingAngle], A                                    ;; 02:450d $ea $0d $d2
    ld   A, [HL]                                       ;; 02:4510 $7e
    and  A, $40                                        ;; 02:4511 $e6 $40
    ld   [wD74B], A                                    ;; 02:4513 $ea $4b $d7
    ld   HL, .data_02_454f                             ;; 02:4516 $21 $4f $45
    add  HL, DE                                        ;; 02:4519 $19
    ld   C, [HL]                                       ;; 02:451a $4e
    ld   HL, wD747_Player_ClimbingUnkCounter                                     ;; 02:451b $21 $47 $d7
    inc  [HL]                                          ;; 02:451e $34
    ld   A, [HL]                                       ;; 02:451f $7e
    rrca                                               ;; 02:4520 $0f
    rrca                                               ;; 02:4521 $0f
    and  A, $07                                        ;; 02:4522 $e6 $07
    add  A, C                                          ;; 02:4524 $81
    ld   HL, wD208_Player_SpriteID                                     ;; 02:4525 $21 $08 $d2
    cp   A, [HL]                                       ;; 02:4528 $be
    jr   Z, .jr_02_4531                                ;; 02:4529 $28 $06
    ld   [HL], A                                       ;; 02:452b $77
    ld   HL, wD60F_HDMATransferFlags                                     ;; 02:452c $21 $0f $d6
    set  0, [HL]                                       ;; 02:452f $cb $c6
.jr_02_4531:
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4531 $fa $5a $d7
    and  A, PADF_B                                        ;; 02:4534 $e6 $02
    jr   Z, .jr_02_453d                                ;; 02:4536 $28 $05
    ld   A, PLAYER_ACTION_FREEFALL                                        ;; 02:4538 $3e $17
    call call_02_4ccd_Player_RequestAction                                  ;; 02:453a $cd $cd $4c
.jr_02_453d:
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:453d $fa $5a $d7
    and  A, PADF_A                                        ;; 02:4540 $e6 $01
    jr   Z, .jr_02_454e                                ;; 02:4542 $28 $0a
    ld   A, $01                                        ;; 02:4544 $3e $01
    ld   [wD746_Player_ClimbingState], A                                    ;; 02:4546 $ea $46 $d7
    xor  A, A                                          ;; 02:4549 $af
    ld   [wD747_Player_ClimbingUnkCounter], A                                    ;; 02:454a $ea $47 $d7
    ret                                                ;; 02:454d $c9
.jr_02_454e:
    ret                                                ;; 02:454e $c9
.data_02_454f:
    db   $40, $50, $48, $97, $40, $50, $48, $97        ;; 02:454f ........
.data_02_4557:
    db   $00, $00, $00, $00, $60, $60, $60, $60        ;; 02:4557 ........

.jp_02_455f_PlayerClimbAction_BackgroundTailSpin:
; Background climbing while tail-spinning. Calls PlayerBackgroundClimb_Sub for movement. 
; Increments counter, computes reverse-rotating sprite frame using .data_02_45a8 (countdown 
; offset table). Forces facing right and wD74B=0. After $20 frames, returns to climb state 0
    call call_02_4777_PlayerBackgroundClimb_GetDirection
    cp   a,$FF
    jr   z,.jr_02_4569
    ld   [wD748_Player_ClimbingRelated],a
.jr_02_4569:
    ld   hl,wD747_Player_ClimbingUnkCounter
    inc  [hl]
    ld   a,[hl]
    rrca 
    rrca 
    and  a,$07
    ld   c,a
    ld   hl,wD748_Player_ClimbingRelated
    ld   l,[hl]
    ld   h,$00
    ld   de,.data_02_45a8
    add  hl,de
    ld   a,[hl]
    add  c
    and  a,$07
    add  a,$58
    ld   hl,wD208_Player_SpriteID
    cp   [hl]
    ret  z
    ld   [hl],a
    ld   a,$00
    ld   [wD20D_PlayerFacingAngle],a
    ld   a,$00
    ld   [wD74B],a
    ld   hl,wD60F_HDMATransferFlags
    set  0,[hl]
    ld   a,[wD747_Player_ClimbingUnkCounter]
    cp   a,$20
    ret  c
    ld   a,$00
    ld   [wD746_Player_ClimbingState],a
    xor  a
    ld   [wD747_Player_ClimbingUnkCounter],a
    ret  
.data_02_45a8:
    db   $00, $07, $06, $05, $04, $03, $02, $01        ;; 02:45a7 ????????

.jp_02_45b0_PlayerClimbAction_Wall:
; Wall climbing movement. Calls PlayerWallClimb_Sub for direction index. Looks up facing angle 
; from .data_02_460e, flag from .data_02_4616, sprite base from .data_02_461e. Updates sprite/counter 
; same as background. If B → Freefall. If A → climb state 3 (WallTailSpin)
    call call_02_47d5_PlayerWallClimb_GetDirection
    cp   a,$FF
    jr   z,.jr_02_45F0
    ld   [wD748_Player_ClimbingRelated],a
    ld   e,a
    ld   d,$00
    ld   hl, .data_02_460e
    add  hl,de
    ld   a,[hl]
    cp   a,$FF
    jr   z,.jr_02_45C9
    ld   [wD20D_PlayerFacingAngle],a
.jr_02_45C9:
    ld   hl, .data_02_4616
    add  hl,de
    ld   a,[hl]
    cp   a,$FF
    jr   z,.jr_02_45D5
    ld   [wD74B],a
.jr_02_45D5:
    ld   hl, .data_02_461e
    add  hl,de
    ld   c,[hl]
    ld   hl,wD747_Player_ClimbingUnkCounter
    inc  [hl]
    ld   a,[hl]
    rrca 
    rrca 
    and  a,$07
    add  c
    ld   hl,wD208_Player_SpriteID
    cp   [hl]
    jr   z,.jr_02_45F0
    ld   [hl],a
    ld   hl,wD60F_HDMATransferFlags
    set  0,[hl]
.jr_02_45F0:
    ld   a,[wD75A_CurrentInputsAlt]
    and  a,PADF_B
    jr   z,.jr_02_45FC
    ld   a,PLAYER_ACTION_FREEFALL
    call call_02_4ccd_Player_RequestAction
.jr_02_45FC:
    ld   a,[wD75A_CurrentInputsAlt]
    and  a,PADF_A
    jr   z,.jr_02_460D
    ld   a,$03
    ld   [wD746_Player_ClimbingState],a
    xor  a
    ld   [wD747_Player_ClimbingUnkCounter],a
    ret  
.jr_02_460D:
    ret  
.data_02_460e:
    db   $ff, $00, $00, $00, $ff, $20, $20, $20
.data_02_4616:
    db   $00, $00, $00, $40, $40, $40, $00, $00
.data_02_461e:
    db   $60, $60, $68, $60, $60, $60, $68, $60

.jp_02_4626_PlayerClimbAction_WallTailSpin:
; Wall climbing while tail-spinning. Calls PlayerWallClimb_Sub for movement. Computes spinning sprite 
; frame from .data_02_465f (alternating $70/$78 pairs indexed by direction × counter). After $20 frames, 
; returns to climb state 2
    call call_02_47d5_PlayerWallClimb_GetDirection
    cp   a,$FF
    jr   z,.jr_02_4630
    ld   [wD748_Player_ClimbingRelated],a
.jr_02_4630:
    ld   hl,wD747_Player_ClimbingUnkCounter
    inc  [hl]
    ld   a,[hl]
    rrca 
    rrca 
    and  a,$07
    ld   hl,wD748_Player_ClimbingRelated
    ld   l,[hl]
    ld   h,$00
    ld   de, .data_02_465f
    add  hl,de
    add  [hl]
    ld   hl,wD208_Player_SpriteID
    cp   [hl]
    ret  z
    ld   [hl],a
    ld   hl,wD60F_HDMATransferFlags
    set  0,[hl]
    ld   a,[wD747_Player_ClimbingUnkCounter]
    cp   a,$20
    ret  c
    ld   a,$02
    ld   [wD746_Player_ClimbingState],a
    xor  a
    ld   [wD747_Player_ClimbingUnkCounter],a
    ret  
.data_02_465f:
    db   $70, $00, $78, $00, $70, $00, $78, $00        ;; 02:465f ????????

.jp_02_4667_PlayerClimbAction_BackgroundBottom:
; Dismount animation at the bottom of a background climbable. Clears wD74B. 
; Increments counter up to $18; uses (counter >> 2) to index .data_02_4689 (6 sprite IDs $C2–$C7) 
; and calls PlayerClimb_DismountBottom_Sub to update sprite. At $18 frames, requests Stand
    ld   A, $00                                        ;; 02:4667 $3e $00
    ld   [wD74B], A                                    ;; 02:4669 $ea $4b $d7
    ld   HL, wD747_Player_ClimbingUnkCounter                                     ;; 02:466c $21 $47 $d7
    ld   A, [HL]                                       ;; 02:466f $7e
    cp   A, $18                                        ;; 02:4670 $fe $18
    jr   Z, .jr_02_4684                                ;; 02:4672 $28 $10
    inc  [HL]                                          ;; 02:4674 $34
    srl  A                                             ;; 02:4675 $cb $3f
    srl  A                                             ;; 02:4677 $cb $3f
    ld   L, A                                          ;; 02:4679 $6f
    ld   H, $00                                        ;; 02:467a $26 $00
    ld   DE, .data_02_4689                             ;; 02:467c $11 $89 $46
    add  HL, DE                                        ;; 02:467f $19
    ld   A, [HL]                                       ;; 02:4680 $7e
    jp   call_02_480f_Player_UpdateSpriteIfChanged                                    ;; 02:4681 $c3 $0f $48
.jr_02_4684:
    ld   A, PLAYER_ACTION_STAND                                        ;; 02:4684 $3e $02
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:4686 $c3 $cd $4c
.data_02_4689:
    db   $c2, $c3, $c4, $c5, $c6, $c7

.jp_02_468f_PlayerClimbAction_WallBottom:  
; Dismount animation at the bottom of a wall climbable. Same structure as BackgroundBottom 
; but only 8 frames, using .data_02_46b1 (2 sprite IDs $C8–$C9)  
    ld   a,$00
    ld   [wD74B],a
    ld   hl,wD747_Player_ClimbingUnkCounter
    ld   a,[hl]
    cp   a,$08
    jr   z,.jr_02_46AC
    inc  [hl]
    srl  a
    srl  a
    ld   l,a
    ld   h,$00
    ld   de, .data_02_46b1
    add  hl,de
    ld   a,[hl]
    jp   call_02_480f_Player_UpdateSpriteIfChanged
.jr_02_46AC:
    ld   a,PLAYER_ACTION_STAND
    jp   call_02_4ccd_Player_RequestAction
.data_02_46b1:
    db   $c8, $c9

.jp_02_46b3_PlayerClimbAction_WallTop:  
; Dismount at the top of a wall: immediately requests Jump action
    ld   a,PLAYER_ACTION_JUMP
    jp   call_02_4ccd_Player_RequestAction

.jp_02_46b8_PlayerClimbAction_PipeTransition:  
; Handles pipe entry transition (climb state 9). Runs every $20 frames. Uses 
; wD749 (pipe direction) × 4 + facing bit to index .data_02_4737 (X/Y delta pairs), 
; applies position delta. Uses wD747 (counter >> 1) to index .data_02_472e (sprite IDs $C8–$D0) 
; for dismount animation. Increments counter; at $11, reads 4 bytes from .data_02_4757 
; (new climb state, facing, wD74B, sprite ID) and applies them to complete the transition
    ld   a,[wD73C_FrameCounter2]
    and  a,$1F
    ret  nz
    ld   a,[wD749_Player_ClimbingDirection]
    add  a
    add  a
    ld   hl,wD20D_PlayerFacingAngle
    bit  5,[hl]
    jr   z,.jr_02_46CC
    add  a,$02
.jr_02_46CC:
    add  a
    ld   l,a
    ld   h,$00
    ld   de, .data_02_4737
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    inc  hl
    push bc
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    call call_02_4c19_Player_AddToYPosition
    pop  bc
    call call_02_4c0a_Player_AddToXPosition
    ld   a,[wD747_Player_ClimbingUnkCounter]
    srl  a
    ld   l,a
    ld   h,$00
    ld   de, .data_02_472e
    add  hl,de
    ld   a,[hl]
    call call_02_480f_Player_UpdateSpriteIfChanged
    ld   a,$00
    ld   [wD74B],a
    ld   hl,wD747_Player_ClimbingUnkCounter
    inc  [hl]
    ld   a,[hl]
    cp   a,$11
    ret  nz
    ld   [hl],$00
    ld   a,[wD749_Player_ClimbingDirection]
    add  a
    add  a
    add  a
    ld   hl,wD20D_PlayerFacingAngle
    bit  5,[hl]
    jr   z,.jr_02_4711
    add  a,$04
.jr_02_4711:
    ld   l,a
    ld   h,$00
    ld   de, .data_02_4757
    add  hl,de
    ldi  a,[hl]
    ld   [wD746_Player_ClimbingState],a
    ldi  a,[hl]
    ld   [wD20D_PlayerFacingAngle],a
    ldi  a,[hl]
    ld   [wD74B],a
    ldi  a,[hl]
    ld   [wD208_Player_SpriteID],a
    ld   hl,wD60F_HDMATransferFlags
    set  0,[hl]
    ret     
.data_02_472e:
    db   $08, $ca, $cb        ;; 02:4729 ????????
    db   $cc, $cd, $ce, $cf, $d0, $d0
.data_02_4737:
    db   $00, $00        ;; 02:4731 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4739 ????????
    db   $00, $00, $00, $00, $00, $00, $01, $00        ;; 02:4741 ????????
    db   $01, $00, $ff, $ff, $ff, $ff, $01, $00        ;; 02:4749 ????????
    db   $ff, $ff, $ff, $ff, $01, $00
.data_02_4757:
    db   $00, $00        ;; 02:4751 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4759 ????????
    db   $00, $00, $00, $00, $00, $00, $04, $00        ;; 02:4761 ????????
    db   $00, $68, $02, $00, $00, $60, $02, $20        ;; 02:4769 ????????
    db   $00, $60, $04, $20, $00, $68                  ;; 02:4771 ??????

call_02_4777_PlayerBackgroundClimb_GetDirection:
; Reads directional input ($F0 mask from wD75A). Searches .data_02_47a5 (8 × 6-byte records: 
; input, direction index, Y delta lo, Y delta hi, X delta lo, X delta hi) for a match. On match: 
; applies Y delta via Player_AddToYPosition, X delta via Player_AddToXPosition. Returns direction 
; index in A, or $FF if no input
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4777 $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT | PADF_UP | PADF_DOWN                                        ;; 02:477a $e6 $f0
    jr   Z, .jr_02_478d                                ;; 02:477c $28 $0f
    ld   HL, .data_02_47a5                             ;; 02:477e $21 $a5 $47
    ld   DE, $06                                       ;; 02:4781 $11 $06 $00
    ld   B, $08                                        ;; 02:4784 $06 $08
.jr_02_4786:
    cp   A, [HL]                                       ;; 02:4786 $be
    jr   Z, .jr_02_4790                                ;; 02:4787 $28 $07
    add  HL, DE                                        ;; 02:4789 $19
    dec  B                                             ;; 02:478a $05
    jr   NZ, .jr_02_4786                               ;; 02:478b $20 $f9
.jr_02_478d:
    ld   A, $ff                                        ;; 02:478d $3e $ff
    ret                                                ;; 02:478f $c9
.jr_02_4790:
    inc  HL                                            ;; 02:4790 $23
    ld   A, [HL+]                                      ;; 02:4791 $2a
    push AF                                            ;; 02:4792 $f5
    ld   A, [HL+]                                      ;; 02:4793 $2a
    ld   C, A                                          ;; 02:4794 $4f
    ld   A, [HL+]                                      ;; 02:4795 $2a
    ld   B, A                                          ;; 02:4796 $47
    push BC                                            ;; 02:4797 $c5
    ld   A, [HL+]                                      ;; 02:4798 $2a
    ld   C, A                                          ;; 02:4799 $4f
    ld   A, [HL+]                                      ;; 02:479a $2a
    ld   B, A                                          ;; 02:479b $47
    call call_02_4c19_Player_AddToYPosition                                  ;; 02:479c $cd $19 $4c
    pop  BC                                            ;; 02:479f $c1
    call call_02_4c0a_Player_AddToXPosition                                  ;; 02:47a0 $cd $0a $4c
    pop  AF                                            ;; 02:47a3 $f1
    ret                                                ;; 02:47a4 $c9
.data_02_47a5:
    db   $40, $00, $00, $00, $ff, $ff, $80, $04        ;; 02:47a5 ?w....?w
    db   $00, $00, $01, $00, $20, $06, $ff, $ff        ;; 02:47ad ....?w..
    db   $00, $00, $10, $02, $01, $00, $00, $00        ;; 02:47b5 ..?w....
    db   $60, $07, $ff, $ff, $ff, $ff, $a0, $05        ;; 02:47bd ?w....?w
    db   $ff, $ff, $01, $00, $50, $01, $01, $00        ;; 02:47c5 ....?w..
    db   $ff, $ff, $90, $03, $01, $00, $01, $00        ;; 02:47cd ..?w....

call_02_47d5_PlayerWallClimb_GetDirection:
; Same structure as PlayerBackgroundClimb_GetDirection but only checks Up/Down input 
; ($C0 mask) and uses .data_02_4803 (2 × 6-byte records). Returns direction index or $FF
    ld   a,[wD75A_CurrentInputsAlt]
    and  a,PADF_UP | PADF_DOWN
    jr   z,.jr_02_47EB
    ld   hl, .data_02_4803
    ld   de,$0006
    ld   b,$02
.jr_02_47E4:
    cp   [hl]
    jr   z,.jr_02_47EE
    add  hl,de
    dec  b
    jr   nz,.jr_02_47E4
.jr_02_47EB:
    ld   a,$FF
    ret  
.jr_02_47EE:
    inc  hl
    ldi  a,[hl]
    push af
    ldi  a,[hl]
    ld   c,a
    ldi  a,[hl]
    ld   b,a
    push bc
    ldi  a,[hl]
    ld   c,a
    ldi  a,[hl]
    ld   b,a
    call call_02_4c19_Player_AddToYPosition
    pop  bc
    call call_02_4c0a_Player_AddToXPosition
    pop  af
    ret  
.data_02_4803:    
    db   $40, $00        ;; 02:47fd ????????
    db   $00, $00, $ff, $ff, $80, $04, $00, $00        ;; 02:4805 ????????
    db   $01, $00                                      ;; 02:480d ??

call_02_480f_Player_UpdateSpriteIfChanged:
; Compares A against current sprite ID in wD208. If different, stores it and sets bit 0 of 
; wD60F (VRAM load flag). Called during climb dismount animations to advance sprite frames
    ld   HL, wD208_Player_SpriteID                                     ;; 02:480f $21 $08 $d2
    cp   A, [HL]                                       ;; 02:4812 $be
    ret  Z                                             ;; 02:4813 $c8
    ld   [HL], A                                       ;; 02:4814 $77
    ld   HL, wD60F_HDMATransferFlags                                     ;; 02:4815 $21 $0f $d6
    set  0, [HL]                                       ;; 02:4818 $cb $c6
    ret                                                ;; 02:481a $c9

call_02_481b_PlayerAction_GoldRemoteWarp:
; Calls PlayerWarp_Sub; if warp ready (nonzero), sets bit 2 of wD621 (TV warp flag). 
; Used by the gold remote collectible to warp Gex
    call call_02_4894_Player_CheckWarpReady
    ret  z
    ld   a,[wD621_WarpFlags]
    or   a,$04
    ld   [wD621_WarpFlags],a
    ret  

call_02_4828_PlayerAction_RidingRocket:
; Zeroes X speed. Scans entity slots at $D220 for the rocket entity. Reads that entity's 
; Y position field (offset $10), stores to player Y. If resulting block Y < $55, requests Jump. 
; Used for rocket ride where Gex is placed at a specific Y coordinate and launched upward
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   h,$D2
    ld   a,$20
.jr_02_4830:
    ld   l,a
    ld   a,[hl]
    cp   a,ENTITY_TOON_TV_ROCKET
    jr   z,.jr_02_483C
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_4830
    ret  
.jr_02_483C:
    ld   a,l
    or   a,$10
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    ld   [wD210_Player_YPositionLo],a
    ld   a,h
    ld   [wD211_Player_YPositionHi],a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   a,$55
    ret  nc
    ld   a,PLAYER_ACTION_JUMP
    jp   call_02_4ccd_Player_RequestAction

call_02_480f_Player_GetJumpVelocity:
; Checks wD758_UnkCollisionRelated (jump suppression flag) — returns 0 if set. Reads floor tile type from wD765. 
; Tile $CE → returns $4C (spring low boost). 
; Tile $CF → returns $60 (spring high boost). 
; Tile $F0 → if wD751_Player_CircuitPowerUpTimerLo (timer) nonzero, plays SFX and returns $4C (trampoline low). 
; Tile $F1 → if wD751_Player_CircuitPowerUpTimerLo nonzero, plays SFX and returns $60 (trampoline high). 
; Otherwise returns C unchanged (normal jump velocity)
    ld   A, [wD758_UnkCollisionRelated]                                    ;; 02:4856 $fa $58 $d7
    and  A, A                                          ;; 02:4859 $a7
    ret  NZ                                            ;; 02:485a $c0
    ld   A, [wD765_TileTypeBehindGexsBody]                                    ;; 02:485b $fa $65 $d7
    cp   A, $f0                                        ;; 02:485e $fe $f0
    jr   Z, .jr_02_4876                                ;; 02:4860 $28 $14
    cp   A, $f1                                        ;; 02:4862 $fe $f1
    jr   Z, .jr_02_4885                                ;; 02:4864 $28 $1f
    cp   A, $ce                                        ;; 02:4866 $fe $ce
    jr   Z, .jr_02_4870                                ;; 02:4868 $28 $06
    cp   A, $cf                                        ;; 02:486a $fe $cf
    jr   Z, .jr_02_4873                                ;; 02:486c $28 $05
.jr_02_486e:
    ld   A, C                                          ;; 02:486e $79
    ret                                                ;; 02:486f $c9
.jr_02_4870:
    ld   A, $4c                                        ;; 02:4870 $3e $4c
    ret                                                ;; 02:4872 $c9
.jr_02_4873:
    ld   A, $60                                        ;; 02:4873 $3e $60
    ret                                                ;; 02:4875 $c9
.jr_02_4876:
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 02:4876 $21 $51 $d7
    ld   A, [HL+]                                      ;; 02:4879 $2a
    or   A, [HL]                                       ;; 02:487a $b6
    jr   Z, .jr_02_486e                                ;; 02:487b $28 $f1
    ld   C, SFX_GEX_JUMP_UNK                                        ;; 02:487d $0e $2a
    call call_00_112f_QueueSFX                                  ;; 02:487f $cd $2f $11
    ld   A, $4c                                        ;; 02:4882 $3e $4c
    ret                                                ;; 02:4884 $c9
.jr_02_4885:
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 02:4885 $21 $51 $d7
    ld   A, [HL+]                                      ;; 02:4888 $2a
    or   A, [HL]                                       ;; 02:4889 $b6
    jr   Z, .jr_02_486e                                ;; 02:488a $28 $e2
    ld   C, SFX_GEX_JUMP_UNK                                        ;; 02:488c $0e $2a
    call call_00_112f_QueueSFX                                  ;; 02:488e $cd $2f $11
    ld   A, $60                                        ;; 02:4891 $3e $60
    ret                                                ;; 02:4893 $c9

call_02_4894_Player_CheckWarpReady:
; Reads bit 2 of wD20A (animation-end flag) and returns it in A. Zero flag set if not ready, 
; nonzero if warp should fire. Used as a gate in door/TV warp actions
    ld   a,[wD20A_Player_UnkFlags2]
    and  a,$04
    ret     
