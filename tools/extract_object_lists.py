import os
import struct

levels = [
    # channel, level_name, start_level_addr, next_level_addr
    ["media_dimension", "media_dimension", 0x4057, 0x4488],
    ["toon_tv", "out_of_toon", 0x4488, 0x48c9],
    ["scream_tv", "smellraiser", 0x48c9, 0x4aba],
    ["scream_tv", "frankensteinfeld", 0x4aba, 0x4ddb],
    ["circuit_central", "wwwdotcomcom", 0x4ddb, 0x51ec],
    ["kung_fu_theater", "mao_tse_tongue", 0x51ec, 0x54ed],
    ["prehistory_channel", "pangaea_90210", 0x54ed, 0x57ee],
    ["toon_tv", "fine_tooning", 0x57ee, 0x5c8f],
    ["prehistory_channel", "this_old_cave", 0x5c8f, 0x5e20],
    ["circuit_central", "honey_i_shrunk_the_gecko", 0x5e20, 0x6331],
    ["scream_tv", "poltergex", 0x6331, 0x6692],
    ["kung_fu_theater", "samurai_night_fever", 0x6692, 0x6a43],
    ["rezopolis", "no_weddings_and_a_funeral", 0x6a43, 0x6c84],
    ["scream_tv", "thursday_the_12th", 0x6c84, 0x6d45],
    ["kung_fu_theater", "lizard_in_a_china_shop", 0x6d45, 0x6dc6],
    ["rezopolis", "bugged_out", 0x6dc6, 0x6df7],
    ["circuit_central", "chips_and_dips", 0x6df7, 0x6e78],
    ["prehistory_channel", "lava_dabba_doo", 0x6e78, 0x7149],
    ["scream_tv", "texas_chainsaw_manicure", 0x7149, 0x734a],
    ["rezopolis", "mazed_and_confused", 0x734a, 0x751b],
    ["channel_z", "channel_z", 0x751b, 0x75fc]
]

entity_names = [
    "ENTITY_GEX",
    "ENTITY_COLLECTIBLE_SPAWN",
    "ENTITY_UNK_02",
    "ENTITY_TV_BUTTON",
    "ENTITY_RED_REMOTE",
    "ENTITY_SILVER_REMOTE",
    "ENTITY_GOLD_REMOTE",
    "ENTITY_ENEMY_DEFEATED",
    "ENTITY_UNK_08",
    "ENTITY_SCREAM_TV_FALLING_PLATFORM",
    "ENTITY_SCREAM_TV_MOVING_PLATFORM",
    "ENTITY_SCREAM_TV_PUSH_BLOCK",
    "ENTITY_SCREAM_TV_PUMPKIN",
    "ENTITY_SCREAM_TV_FRANKIE",
    "ENTITY_SCREAM_TV_HEAD_GHOST",
    "ENTITY_SCREAM_TV_HEAD_GHOST_HEAD",
    "ENTITY_SCREAM_TV_FLOATING_SKULL",
    "ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE",
    "ENTITY_SCREAM_TV_ZOMBIE",
    "ENTITY_SCREAM_TV_ZOMBIE_HEAD",
    "ENTITY_SCREAM_TV_FALLING_AXE",
    "ENTITY_SCREAM_TV_LANTERN",
    "ENTITY_SCREAM_TV_BAT",
    "ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM",
    "ENTITY_SCREAM_TV_DOOR_OPENING",
    "ENTITY_SCREAM_TV_GHOST",
    "ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY",
    "ENTITY_SCREAM_TV_VANISHING_PLATFORM",
    "ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR",
    "ENTITY_TOON_TV_HARD_HEAD_AREA_ENTITY",
    "ENTITY_TOON_TV_STATIONARY_BEAR_TRAP",
    "ENTITY_TOON_TV_MOVING_BEAR_TRAP",
    "ENTITY_TOON_TV_BUMBLEBEE",
    "ENTITY_TOON_TV_FALLING_BOWLING_BALL",
    "ENTITY_TOON_TV_CACTUS",
    "ENTITY_TOON_TV_DOMINO",
    "ENTITY_TOON_TV_SHARK",
    "ENTITY_TOON_TV_FLOWER",
    "ENTITY_TOON_TV_HUNTER",
    "ENTITY_TOON_TV_MUSHROOM",
    "ENTITY_UNK_28",
    "ENTITY_TOON_TV_LIZARD",
    "ENTITY_TOON_TV_HAPPY_FACE",
    "ENTITY_TOON_TV_VANISHING_BLOCK",
    "ENTITY_TOON_TV_MOVING_BLOCK",
    "ENTITY_TOON_TV_MOVING_LOG_PLATFORM",
    "ENTITY_TOON_TV_STATIONARY_LOG_PLATFORM",
    "ENTITY_TOON_TV_FLOWER_HAMMER_ATTACK",
    "ENTITY_TOON_TV_HUNTER_BULLET",
    "ENTITY_TOON_TV_ROCKET",
    "ENTITY_PRE_HISTORY_FAST_DINOSAUR",
    "ENTITY_PRE_HISTORY_DRAGONFLY",
    "ENTITY_PRE_HISTORY_EGG",
    "ENTITY_UNK_35",
    "ENTITY_UNK_36",
    "ENTITY_PRE_HISTORY_FALLING_LAVA",
    "ENTITY_PRE_HISTORY_LAVA_RAFT",
    "ENTITY_PRE_HISTORY_MOVING_PLATFORM",
    "ENTITY_UNK_3A",
    "ENTITY_UNK_3B",
    "ENTITY_PRE_HISTORY_PTEROSAUR",
    "ENTITY_UNK_3D",
    "ENTITY_PRE_HISTORY_FALLING_BOULDER",
    "ENTITY_UNK_3F",
    "ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL",
    "ENTITY_PRE_HISTORY_BEETLE_VERTICAL",
    "ENTITY_PRE_HISTORY_ANT",
    "ENTITY_PRE_HISTORY_FIRE_PLANT",
    "ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES",
    "ENTITY_PRE_HISTORY_GEYSER",
    "ENTITY_UNK_46",
    "ENTITY_PRE_HISTORY_DINOSAUR",
    "ENTITY_PRE_HISTORY_TRICERATOPS",
    "ENTITY_PRE_HISTORY_TRICERATOPS_HORN",
    "ENTITY_UNK_4A",
    "ENTITY_KUNG_FU_THEATER_HANGING_BLADE",
    "ENTITY_KUNG_FU_THEATER_CANNON",
    "ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE",
    "ENTITY_KUNG_FU_THEATER_DRAGONFLY",
    "ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT",
    "ENTITY_KUNG_FU_THEATER_DRAGON_HEAD",
    "ENTITY_UNK_51",
    "ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE",
    "ENTITY_KUNG_FU_THEATER_WALKING_NINJA",
    "ENTITY_KUNG_FU_THEATER_JUMPING_NINJA",
    "ENTITY_KUNG_FU_THEATER_SAMURAI_BODY",
    "ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD",
    "ENTITY_KUNG_FU_THEATER_LIZARD",
    "ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE",
    "ENTITY_KUNG_FU_THEATER_SPIKY_LOG",
    "ENTITY_KUNG_FU_THEATER_TALL_JAR",
    "ENTITY_KUNG_FU_THEATER_JAR",
    "ENTITY_UNK_5C",
    "ENTITY_UNK_5D",
    "ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM",
    "ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM",
    "ENTITY_UNK_60",
    "ENTITY_KUNG_FU_THEATER_MOVING_RAFT",
    "ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT",
    "ENTITY_UNK_63",
    "ENTITY_UNK_64",
    "ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM",
    "ENTITY_REZOPOLIS_MOVING_PLATFORM",
    "ENTITY_REZOPOLIS_RED_PLATFORM",
    "ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM",
    "ENTITY_REZOPOLIS_TAILSPIN_PLATFORM",
    "ENTITY_REZOPOLIS_TAILSPIN_GEAR",
    "ENTITY_UNK_6B",
    "ENTITY_UNK_6C",
    "ENTITY_UNK_6D",
    "ENTITY_REZOPOLIS_GREEN_MONSTER",
    "ENTITY_UNK_6F",
    "ENTITY_UNK_70",
    "ENTITY_REZOPOLIS_PINCER",
    "ENTITY_REZOPOLIS_FLAMETHROWER",
    "ENTITY_REZOPOLIS_UFO",
    "ENTITY_REZOPOLIS_ANT",
    "ENTITY_REZOPOLIS_ANT_SPAWNER",
    "ENTITY_CIRCUIT_CENTRAL_ANT",
    "ENTITY_CIRCUIT_CENTRAL_CAPACITOR",
    "ENTITY_CIRCUIT_CENTRAL_POWER_UP",
    "ENTITY_UNK_79",
    "ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT",
    "ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR",
    "ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL",
    "ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM",
    "ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM",
    "ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM",
    "ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT",
    "ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY",
    "ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR",
    "ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE",
    "ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2",
    "ENTITY_CHANNEL_Z_GUN_PROJECTILE",
    "ENTITY_CHANNEL_Z_REZ",
    "ENTITY_UNK_87",
    "ENTITY_UNK_88",
    "ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE",
    "ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION",
    "ENTITY_UNK_8B",
    "ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON",
    "ENTITY_UNK_8D",
    "ENTITY_UNK_8E",
    "ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM"
]

bank00a_data = open('./banks/bank_00a.bin', 'rb').read()

os.system('mkdir -p ./banks')
os.system('mkdir -p ./banks/maps')
#os.system('mkdir -p ./banks/entity_lists')
for level in levels:
    os.system('mkdir -p ./banks/maps/'+level[0])
    
    
    out = open('./banks/maps/'+level[0]+'/entity_list_'+level[1]+'.asm', "w")
    
    entity_data = bank00a_data[level[2]-0x4000:level[3]-0x4000]

    '''out_bin = open('./banks/entity_lists/entity_list_'+level[1]+'.bin', "wb")
    out_bin.write(entity_data)
    out_bin.close()'''
    
    for i in range(0, len(entity_data)-1, 0x10):
        entityId, xPosition, yPosition, unk05, unk06, unk07, unk08, un09, unk0a, unk0b, unk0c, unk0d, unk0e, unk0f = struct.unpack('<BHHBBBBBBBBBBB',entity_data[i:i+0x10])
        
        entity_name = entity_names[entityId]
        entity_string = "    db   {}\n    dw   ${:04x}, ${:04x}\n    db   ${:02x}, ${:02x}, ${:02x}\n    db   ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}\n\n".format(entity_name, xPosition, yPosition, unk05, unk06, unk07, unk08, un09, unk0a, unk0b, unk0c, unk0d, unk0e, unk0f)
        
        out.write(entity_string)
    
    out.write("    db   ENTITY_LIST_TERMINATOR\n")
    
    out.close()
    