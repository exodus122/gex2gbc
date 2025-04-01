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

object_names = [


]

bank00a_data = open('./banks/bank_00a.bin', 'rb').read()

os.system('mkdir -p ./banks')
os.system('mkdir -p ./banks/maps')
for level in levels:
    os.system('mkdir -p ./banks/maps/'+level[0])
    
    out = open('./banks/maps/'+level[0]+'/object_list_'+level[1]+'.asm', "w")
    
    object_data = bank00a_data[level[2]-0x4000:level[3]-0x4000]
    
    for i in range(0, len(object_data)-1, 0x10):
        objectId, xPosition, yPosition, unk05, unk06, unk07, unk08, un09, unk0a, unk0b, unk0c, unk0d, unk0e, unk0f = struct.unpack('<BHHBBBBBBBBBBB',object_data[i:i+0x10])
        
        object_string = "    db   Object_{:02x}\n    dw   ${:04x}, ${:04x}\n    db   ${:02x}, ${:02x}, ${:02x}\n    db   ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}, ${:02x}\n\n".format(objectId, xPosition, yPosition, unk05, unk06, unk07, unk08, un09, unk0a, unk0b, unk0c, unk0d, unk0e, unk0f)
        
        out.write(object_string)
    
    out.write("    db   ObjectListTerminator\n")
    
    out.close()
    