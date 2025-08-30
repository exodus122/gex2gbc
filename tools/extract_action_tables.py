import os
import struct

object_names = [
    "Object_Gex",
    "Object_CollectibleSpawn",
    "Object_unk_02",
    "Object_TVButton",
    "Object_RedRemote",
    "Object_SilverRemote",
    "Object_GoldRemote",
    "Object_EnemyDefeated",
    "Object_unk_08",
    "Object_ScreamTV_FallingPlatform",
    "Object_ScreamTV_MovingPlatform",
    "Object_ScreamTV_PushBlock",
    "Object_ScreamTV_Pumpkin",
    "Object_ScreamTV_Frankie",
    "Object_ScreamTV_HeadGhost",
    "Object_ScreamTV_HeadGhostHead",
    "Object_ScreamTV_FloatingSkull",
    "Object_ScreamTV_FloatingSkullProjectile",
    "Object_ScreamTV_Zombie",
    "Object_ScreamTV_ZombieHead",
    "Object_ScreamTV_FallingAxe",
    "Object_ScreamTV_Lantern",
    "Object_ScreamTV_Bat",
    "Object_ScreamTV_OrangeMovingPlatform",
    "Object_ScreamTV_DoorOpening",
    "Object_ScreamTV_Ghost",
    "Object_ScreamTV_ClimbWallSunEnemy",
    "Object_ScreamTV_VanishingPlatform",
    "Object_ScreamTV_MonaLisaElevator",
    "Object_ToonTV_HardHeadAreaObject",
    "Object_ToonTV_StationaryBearTrap",
    "Object_ToonTV_MovingBearTrap",
    "Object_ToonTV_Bumblebee",
    "Object_ToonTV_FallingBowlingBall",
    "Object_ToonTV_Cactus",
    "Object_ToonTV_Domino",
    "Object_ToonTV_Shark",
    "Object_ToonTV_Flower",
    "Object_ToonTV_Hunter",
    "Object_ToonTV_Mushroom",
    "Object_unk_28",
    "Object_ToonTV_Lizard",
    "Object_ToonTV_HappyFace",
    "Object_ToonTV_VanishingBlock",
    "Object_ToonTV_MovingBlock",
    "Object_ToonTV_MovingLogPlatform",
    "Object_ToonTV_StationaryLogPlatform",
    "Object_ToonTV_FlowerHammerAttack",
    "Object_ToonTV_HunterBullet",
    "Object_ToonTV_Rocket",
    "Object_PreHistory_FastDinosaur",
    "Object_PreHistory_Dragonfly",
    "Object_PreHistory_Egg",
    "Object_unk_35",
    "Object_unk_36",
    "Object_PreHistory_FallingLava",
    "Object_PreHistory_LavaRaft",
    "Object_PreHistory_MovingPlatform",
    "Object_unk_3A",
    "Object_unk_3B",
    "Object_PreHistory_Pterosaur",
    "Object_unk_3D",
    "Object_PreHistory_FallingBoulder",
    "Object_unk_3F",
    "Object_PreHistory_BeetleHorizontal",
    "Object_PreHistory_BeetleVertical",
    "Object_PreHistory_Ant",
    "Object_PreHistory_FirePlant",
    "Object_PreHistory_FirePlantProjectiles",
    "Object_PreHistory_Geyser",
    "Object_unk_46",
    "Object_PreHistory_Dinosaur",
    "Object_PreHistory_Triceratops",
    "Object_PreHistory_TriceratopsHorn",
    "Object_unk_4A",
    "Object_KungFuTheater_HangingBlade",
    "Object_KungFuTheater_Cannon",
    "Object_KungFuTheater_CannonProjectile",
    "Object_KungFuTheater_Dragonfly",
    "Object_KungFuTheater_DragonBodySegment",
    "Object_KungFuTheater_DragonHead",
    "Object_unk_51",
    "Object_KungFuTheater_DragonProjectile",
    "Object_KungFuTheater_WalkingNinja",
    "Object_KungFuTheater_JumpingNinja",
    "Object_KungFuTheater_SamuraiBody",
    "Object_KungFuTheater_SamuraiHead",
    "Object_KungFuTheater_Lizard",
    "Object_KungFuTheater_NinjaProjectile",
    "Object_KungFuTheater_SpikyLog",
    "Object_KungFuTheater_TallJar",
    "Object_KungFuTheater_Jar",
    "Object_unk_5C",
    "Object_unk_5D",
    "Object_KungFuTheater_VanishingPlatform",
    "Object_KungFuTheater_MovingPlatform",
    "Object_unk_60",
    "Object_KungFuTheater_MovingRaft",
    "Object_KungFuTheater_StationaryRaft",
    "Object_unk_63",
    "Object_unk_64",
    "Object_Rezopolis_SpecialMovingPlatform",
    "Object_Rezopolis_MovingPlatform",
    "Object_Rezopolis_RedPlatform",
    "Object_Rezopolis_ActivatedRedPlatform",
    "Object_Rezopolis_TailspinPlatform",
    "Object_Rezopolis_TailspinGear",
    "Object_unk_6B",
    "Object_unk_6C",
    "Object_unk_6D",
    "Object_Rezopolis_GreenMonster",
    "Object_unk_6F",
    "Object_unk_70",
    "Object_Rezopolis_Pincer",
    "Object_Rezopolis_Flamethrower",
    "Object_Rezopolis_UFO",
    "Object_Rezopolis_Ant",
    "Object_Rezopolis_AntSpawner",
    "Object_CircuitCentral_Ant",
    "Object_CircuitCentral_Capacitor",
    "Object_CircuitCentral_PowerUp",
    "Object_unk_79",
    "Object_CircuitCentral_LittleRobot",
    "Object_CircuitCentral_LittleRobotGear",
    "Object_CircuitCentral_ElectricBall",
    "Object_CircuitCentral_MovingPlatform",
    "Object_CircuitCentral_PoweredPlaform",
    "Object_CircuitCentral_LoweringPlatform",
    "Object_CircuitCentral_WalkerRobot",
    "Object_CircuitCentral_PoweredWalkway",
    "Object_CircuitCentral_WalkwayActivator",
    "Object_ChannelZ_ArcedGunProjectile",
    "Object_ChannelZ_ArcedGunProjectile2",
    "Object_ChannelZ_GunProjectile",
    "Object_ChannelZ_Rez",
    "Object_unk_87",
    "Object_unk_88",
    "Object_ChannelZ_RezFollowingFire",
    "Object_ChannelZ_GunProjectileExplosion",
    "Object_unk_8B",
    "Object_ChannelZ_FinalBattleButton",
    "Object_unk_8D",
    "Object_unk_8E",
    "Object_MediaDimension_MovingPlatform",
]

bank002_data = open('./banks/bank_002.bin', 'rb').read()

# get list of jump tables, starts at 0x4000
jump_table_list_data = bank002_data[0x0000:0x089a]
#print(jump_table_list_data)

# get the data at each of those

out = open('./object_actions.asm', "w")

data_list_pointers = []

first = True
i = 0
while i < 0x8F:
    jump_table_ptr = struct.unpack('<H',jump_table_list_data[0x0000 + 2*i:0x0000 + 2*i + 2])[0]
    next_jump_table_ptr = struct.unpack('<H',jump_table_list_data[0x0000 + 2*(i+1):0x0000 + 2*(i+1) + 2])[0]
    #print("{:02x}".format(jump_table_ptr-0x4000)+", "+"{:02x}".format(next_jump_table_ptr-0x4000))
    
    line_string = "data_02_{:02x}:                  ;; ".format(jump_table_ptr)
    line_string += object_names[i] + "\n"
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

out2 = open('./action_data.asm', "w")

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
