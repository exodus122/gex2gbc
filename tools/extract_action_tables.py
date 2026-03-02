import os
import struct

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

bank002_data = open('./banks/bank_002.bin', 'rb').read()

# get list of jump tables, starts at 0x4000
jump_table_list_data = bank002_data[0x0000:0x089a]
#print(jump_table_list_data)

# get the data at each of those

out = open('./banks/entity_actions.asm', "w")

data_list_pointers = []

first = True
i = 0
while i < 0x8F:
    jump_table_ptr = struct.unpack('<H',jump_table_list_data[0x0000 + 2*i:0x0000 + 2*i + 2])[0]
    next_jump_table_ptr = struct.unpack('<H',jump_table_list_data[0x0000 + 2*(i+1):0x0000 + 2*(i+1) + 2])[0]
    #print("{:02x}".format(jump_table_ptr-0x4000)+", "+"{:02x}".format(next_jump_table_ptr-0x4000))
    
    line_string = "data_02_{:02x}:                  ;; ".format(jump_table_ptr)
    line_string += entity_names[i] + "\n"
    out.write(line_string)
    
    if first != True:
        curr_addr = jump_table_ptr
        while curr_addr < next_jump_table_ptr:
            #print("{:02x}".format(curr_addr-0x4000))
            func, data = struct.unpack('<HH',bank002_data[curr_addr-0x4000:curr_addr-0x4000+4])
            #print("{:02x}".format(func)+", "+"{:02x}".format(data))
            curr_addr = curr_addr + 4
            
            line_string = "    dw   ${:02x}, data_02_{:02x}\n".format(func, data)
            out.write(line_string)
            
            if data not in data_list_pointers:
                data_list_pointers.append(data)
            
    first = False
    i = i + 1

out.close()


data_list_pointers.sort()
#print(data_list_pointers)

out2 = open('./banks/action_data.asm', "w")

ptr_count = 0
while ptr_count < len(data_list_pointers):
    line_string = "data_02_{:02x}:\n".format(data_list_pointers[ptr_count])
    out2.write(line_string)

    data = bank002_data[data_list_pointers[ptr_count]-0x4000:data_list_pointers[ptr_count+1]-0x4000]
    print(data)
    line_string = "    db   " + ", ".join(f"${byte:02x}" for byte in data) + "\n"
    
    out2.write(line_string)
    ptr_count = ptr_count + 1

out2.close()
