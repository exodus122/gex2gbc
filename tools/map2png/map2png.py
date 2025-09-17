import PIL.Image # type: ignore
import PIL.ImageDraw # type: ignore
import struct
import os

# level_data 
TV_PALETTE_ID = 0
REMOTE_PROGRESS_ID = 1
TEXT_PTR = 2
MAP_BANK = 3
BLOCKSET_OVERRIDE_BANK = 4
BLOCKSET_AND_COLLISION_BANK = 5
LEVEL_DATA_UNK6 = 6 # seems unused
BLOCKSET_OVERRIDE_BIT = 7
TILESET_BANK = 8
TILESET_BANK_OFFSET = 9

level_names = ["MediaDimension", "ToonTV_OutOfToon", "ScreamTV_Smellraiser", "ScreamTV_Frankensteinfeld", 
               "CircuitCentral_wwwdotcomcom", "KungFuTheater_MaoTseTongue", "unused_04", "PreHistoryChannel_Pangaea90210", 
               "ToonTV_FineTooning", "PreHistoryChannel_ThisOldCave", "CircuitCentral_HoneyIShrunkTheGecko", 
               "ScreamTV_Poltergex", "unused_0C", "KungFuTheater_SamuraiNightFever", "Rezopolis_NoWeddingsAndAFuneral", 
               "unused_0F", "ScreamTV_ThursdayThe12th", "unused_11", "unused_12", "unused_13", "unused_14", 
               "KungFuTheater_LizardInAChinaShop", "Rezopolis_BuggedOut", "CircuitCentral_ChipsAndDips", 
               "PreHistoryChannel_LavaDabbaDoo", "ScreamTV_TexasChainsawManicure", "Rezopolis_MazedAndConfused", 
               "unused_1B", "unused_1C", "unused_1D", "BossTV_ChannelZ"]
level_channel_names = ["media_dimension", "toon_tv", "scream_tv", "scream_tv", 
               "circuit_central", "kung_fu_theater", "media_dimension", "prehistory_channel", 
               "toon_tv", "prehistory_channel", "circuit_central", 
               "scream_tv", "media_dimension", "kung_fu_theater", "rezopolis", 
               "media_dimension", "scream_tv", "media_dimension", "media_dimension", "media_dimension", "media_dimension", 
               "kung_fu_theater", "rezopolis", "circuit_central", 
               "prehistory_channel", "scream_tv", "rezopolis", 
               "media_dimension", "media_dimension", "media_dimension", "channel_z"]
level_palette_names = ["media_dimension", "toon_tv", "scream_tv", "scream_tv", 
               "circuit_central", "kung_fu_theater", "media_dimension", "prehistory_channel", 
               "toon_tv", "prehistory_channel", "circuit_central", 
               "scream_tv", "media_dimension", "kung_fu_theater", "rezopolis", 
               "media_dimension", "scream_tv", "media_dimension", "media_dimension", "media_dimension", "media_dimension", 
               "kung_fu_theater2", "rezopolis", "circuit_central", 
               "prehistory_channel", "scream_tv", "rezopolis", 
               "media_dimension", "media_dimension", "media_dimension", "channel_z"]

# run flags
create_tilesets = False
create_blocksets = False
create_maps = True
collision_override = True # if True, create collision maps instead of regular maps
show_kill_tiles = False # displays kill tiles on map images as a pink square

draw_tile_ids = False
draw_block_ids = False

collision_tiles = []
if collision_override:
    os.system('mkdir -p tileset_images')
    collision_tileset_data = open("../../maps/bg_collision_data.bin", "rb").read()
    
    tileset_img = PIL.Image.new("RGB", (128, 128))
    draw2 = PIL.ImageDraw.Draw(tileset_img)
    
    tile_counter = 0
    for y in range(0, 16):
        for x in range(0, 16):
            tile_img =  PIL.Image.new("RGB", (8, 8), "white")
            draw3 = PIL.ImageDraw.Draw(tile_img)
            
            color = "black"
            flags = collision_tileset_data[0x800 + tile_counter]
            # flags & 0x80 might be kill flag
            # flags & 0x40 is floor flag
            # flags & 0x02 is ceiling flag
            # flags & 0x01 is wall flag
            if flags & 0x03 == 0x3: # wall and ceiling flag?
                color = "red"
            elif flags & 0x02 == 0x2: # ceiling flag?
                color = "orange"
            elif flags & 0x01 == 0x1: # wall flag?
                color = "blue"
            
            row_count = 0
            while row_count < 8:
                data = collision_tileset_data[row_count*0x100 + tile_counter]
                if data & 0x80:
                    draw3.point((0,row_count), color)
                if data & 0x40:
                    draw3.point((1,row_count), color)
                if data & 0x20:
                    draw3.point((2,row_count), color)
                if data & 0x10:
                    draw3.point((3,row_count), color)
                if data & 0x08:
                    draw3.point((4,row_count), color)
                if data & 0x04:
                    draw3.point((5,row_count), color)
                if data & 0x02:
                    draw3.point((6,row_count), color)
                if data & 0x01:
                    draw3.point((7,row_count), color);
                
                row_count = row_count + 1
            
            collision_tiles.append(tile_img)
            tileset_img.paste(tile_img, (x*8, y*8))
            
            #draw2.rectangle(((x*8, y*8), ((x+1)*8, (y+1)*8)), None, "pink")
            
            tile_counter = tile_counter + 1
    
    tileset_img.save("./tileset_images/collision_tileset.png")

bank00_file = "../banks/bank_000.bin"
bank_00_level_data = open(bank00_file, "rb").read()[0x2ebf:0x30af]

for level_counter in range(0, len(level_names)):
    level_data = struct.unpack("<BBHBBBBBBHBBBB", bank_00_level_data[level_counter*0x10:(level_counter+1)*0x10])
    level_name = level_names[level_counter]
    level_channel_name = level_channel_names[level_counter]
    level_palette_name = level_palette_names[level_counter]

    tiles = []
    secondary_tiles = []

    # create the colored tilesets
    if create_tilesets and collision_override == False:
        tileset_file = "../banks/bank_0"+f"{level_data[TILESET_BANK]:x}"+".bin"
        tileset_data = open(tileset_file, 'rb').read()[level_data[TILESET_BANK_OFFSET]-0x4000:level_data[TILESET_BANK_OFFSET]-0x3000]

        palette_file = "../../gfx/tilesets/palettes/palette_"+level_palette_name+".bin"
        palette_data = open(palette_file, "rb").read()

        palette_ids_file = "../../gfx/tilesets/palette_ids/palette_ids_"+level_channel_name+".bin"
        palette_ids = open(palette_ids_file, "rb").read()

        # create a colored version of the level's primary tileset, using the palette
        os.system('mkdir -p tile_bins')
        os.system('mkdir -p tile_bins/'+level_name)
        count = 0
        for i in range(0, len(tileset_data), 0x10):
            tile_data = tileset_data[i:i + 0x10]
            if not tile_data:
                break
            
            out = open('./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.bin', "wb")
            out.write(tile_data)
            out.close()
            
            palette_index = palette_ids[count]
            temp_palette_data = palette_data[0x8*palette_index:0x8*palette_index+0x8]
            f = open("./temp.bin", "wb")
            f.write(temp_palette_data)
            f.close()
            
            os.system("rgbgfx --reverse 1 -p './temp.bin' --columns -o ./tile_bins/"+level_name+'/tile_'+f"{count:0{2}x}"+'.bin ./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.png')
            
            count = count + 1
        
        os.system('mkdir -p tileset_images')
        new_tileset_img = PIL.Image.new("RGB", (128, 128))
        count = 0
        for y in range(0, 16):
            for x in range(0, 16):
                tile_img = PIL.Image.open('./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.png')
                new_tileset_img.paste(tile_img, (x*8, y*8))
                tiles.append(tile_img)
                count = count + 1
        new_tileset_img.save('./tileset_images/'+level_name+'_tileset.png')

        os.system('rm -r tile_bins')
        os.system('rm temp.bin')

        # create colored versions of the level's secondary tilesets, using palettes
        secondary_tileset_folder = "../../.gfx/secondary_tilesets/"+level_channel_name
        secondary_tileset_palette_ids_folder = "../../gfx/secondary_tilesets/"+level_channel_name+"/palette_ids"
        
        media_dimension_tv_order = ["scream_tv", "scream_tv", "toon_tv", "prehistory_channel", "circuit_central", "kung_fu_theater", "channel_z", "rezopolis", "bonus_tv"]
        media_dimension_tv_order2 = ["image_013_00", "image_013_12", "image_013_13", "image_013_14", "image_013_15", "image_013_16", "image_013_17", "image_013_18", "image_013_19"]
        
        os.system('mkdir -p secondary_tile_bins/')
        os.system('mkdir -p secondary_tile_bins/'+level_name)
        os.system('mkdir -p secondary_tileset_images/')
        os.system('mkdir -p secondary_tileset_images/'+level_name)
        
        for secondary_tileset_file in os.listdir(secondary_tileset_folder):
            if secondary_tileset_file == "image_00f_12.bin" or secondary_tileset_file == "image_00e_18.bin":
                continue # no palette ids
            
            filename2 = secondary_tileset_file.split(".", 1)[0]
        
            with open(secondary_tileset_folder+"/"+secondary_tileset_file, 'rb') as bf:
                count = 0
                #print(secondary_tileset_folder+"/"+secondary_tileset_file)
                for data in iter(lambda: bf.read(0x10), ''):
                    if not data:
                        break
                        
                    os.system('mkdir -p secondary_tile_bins/'+level_name+'/'+filename2+'/')
                    
                    out = open('./secondary_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.bin', "wb")
                    out.write(data)
                    out.close()
                    
                    palette_ids = open(secondary_tileset_palette_ids_folder+"/"+filename2+"_palette_ids.bin", "rb").read()
                    palette_index = palette_ids[count]
                    #print(palette_index)
                    temp_palette_data = palette_data[0x8*palette_index:0x8*palette_index+0x8]
                    
                    # special case for television palettes in media dimension
                    if level_channel_name == "media_dimension":
                        television = -1
                        q = 0
                        for q in range (0, len(media_dimension_tv_order2)):
                            if media_dimension_tv_order2[q] in secondary_tileset_file:
                                television = q
                                break
                            q = q + 1
                        
                        if television != -1:
                            palette_file2 = "../../gfx/secondary_tilesets/"+level_channel_name+"/palettes/"+media_dimension_tv_order[q]+"_television_palette.bin"
                            if media_dimension_tv_order[q] == "circuit_central":
                                temp_palette_data = open(palette_file2, "rb").read()[8:]
                            else:
                                temp_palette_data = open(palette_file2, "rb").read()[:8]
                        
                    f = open("./temp.bin", "wb")
                    f.write(temp_palette_data)
                    f.close()
                    
                    os.system('rgbgfx --reverse 1 -p '+"./temp.bin"+' --columns -o ./secondary_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.bin ./secondary_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.png')
                    
                    count = count + 1
            
            os.system('mkdir -p secondary_tileset_images/'+level_name+'/')
            new_tileset_img = PIL.Image.new("RGB", (48, 48))
            count = 0
            for y in range(0, 6):
                for x in range(0, 6):
                    tile_img = PIL.Image.open('./secondary_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.png')
                    new_tileset_img.paste(tile_img, (x*8, y*8))
                    secondary_tiles.append(tile_img)
                    count = count + 1
            new_tileset_img.save('./secondary_tileset_images/'+level_name+'/'+filename2+'_tileset.png')

            os.system('rm -r secondary_tile_bins')
            os.system('rm temp.bin')

    # create the level's blockset from the tileset
    blockset_file = "../banks/bank_0"+f"{level_data[BLOCKSET_AND_COLLISION_BANK]:x}"+".bin"
    blockset_data = open(blockset_file, "rb").read()
    secondary_tileset_data_file = "../../maps/"+level_channel_name+"/secondary_tileset_data_"+level_channel_name+".bin"
    
    os.system('mkdir -p blockset_images')
    
    if collision_override == True:
        blockset_image_path = "./blockset_images/collision/"
        os.system('mkdir -p blockset_images/collision')
    elif show_kill_tiles == True:
        blockset_image_path = "./blockset_images/with_kill_tiles/"
        os.system('mkdir -p blockset_images/with_kill_tiles')
    else:
        blockset_image_path = "./blockset_images/"

    if create_blocksets:   
        kill_tile = PIL.Image.new("RGB", (8, 8), (255, 192, 203))

        blockset_img = PIL.Image.new("RGB", (512, 512))
        draw2 = PIL.ImageDraw.Draw(blockset_img)
        
        block_counter = 0
        for y in range(0, 16):
            for x in range(0, 16):
                #draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
                
                block_img =  PIL.Image.new("RGB", (32, 32))
                draw3 = PIL.ImageDraw.Draw(block_img)
                
                # add the regular tiles to the blockset
                val = block_counter
                tile_counter = 0
                for inner_y in range(0, 4):
                    for inner_x in range(0, 4):
                        #blockset_img.paste(tiles[blockset_data[block_counter]], (x*32, y*32))
                        
                        if collision_override == True:
                            block_img.paste(collision_tiles[blockset_data[0x2000+val]], (inner_x*8, inner_y*8))
                        elif blockset_data[0x2000+val] == 0x23 and show_kill_tiles == True:
                            block_img.paste(kill_tile, (inner_x*8, inner_y*8))
                        else:
                            block_img.paste(tiles[blockset_data[val]], (inner_x*8, inner_y*8))
                        
                        val = val + 0x100
                        tile_counter = tile_counter + 1
                
                if draw_block_ids == True:
                    draw3.text((0, 0), "0x%02X" % block_counter, "magenta")
                
                #block_img.save("./block_images/block"+str(block_counter)+".png")
                blockset_img.paste(block_img, (x*32, y*32))
                
                block_counter = block_counter + 1
        
        blockset_img.save(blockset_image_path+level_name+"_blockset.png")
        
        #second blockset for each level
        
        blockset_img2 = PIL.Image.new("RGB", (512, 512))
        secondary_tileset_data = open(secondary_tileset_data_file, "rb").read()
        draw2 = PIL.ImageDraw.Draw(blockset_img2)
        
        #print("secondary_tileset_data[0] is: "+str(secondary_tileset_data[0]))
        
        block_counter = 0
        count = 0x1000
        for y in range(0, 16):
            for x in range(0, 16):
                draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
                
                block_img =  PIL.Image.new("RGB", (32, 32))
                draw3 = PIL.ImageDraw.Draw(block_img)
                
                secondary_tile_override = False
                if block_counter >= secondary_tileset_data[0]: # and blockset_data[val] 
                    secondary_tileset_to_open = secondary_tileset_data[block_counter-secondary_tileset_data[0]+1]
                    if secondary_tileset_to_open > 0:
                        secondary_tile_override = True
                    #block_img.paste(secondary_tiles[(secondary_tileset_to_open*16)+blockset_data[val]]], (inner_x*8, inner_y*8))
                
                val = count
                for inner_y in range(0, 4):
                    for inner_x in range(0, 4):
                        if collision_override == True:
                            block_img.paste(collision_tiles[blockset_data[0x2000+val]], (inner_x*8, inner_y*8))
                        else:
                            if secondary_tile_override != False and blockset_data[val] < 0x24:
                                tile_to_paste = secondary_tiles[(0x24*(secondary_tileset_to_open-1))+blockset_data[val]]
                            else:
                                tile_to_paste = tiles[blockset_data[val]]
                            
                            if blockset_data[0x2000+val] == 0x23 and show_kill_tiles == True:
                                block_img.paste(kill_tile, (inner_x*8, inner_y*8))
                            else:
                                block_img.paste(tile_to_paste, (inner_x*8, inner_y*8))
                        val = val + 0x100
                
                #draw3.text((0, 0), "0x%02X" % block_counter, 33)
                #block_img.save("./block_images/block"+str(count)+".png")
                
                if draw_block_ids == True:
                    draw3 = PIL.ImageDraw.Draw(block_img)
                    draw3.text((0, 0), "0x%02X" % (block_counter), (137, 243, 54))
                
                blockset_img2.paste(block_img, (x*32, y*32))
                
                count = count + 1
                block_counter = block_counter + 1
        
        blockset_img2.save(blockset_image_path+level_name+"_blockset2.png")
    
    # create the level's map from the blocksets
    if create_maps:
        map_file = "../banks/bank_0"+f"{level_data[MAP_BANK]:x}"+".bin"
        map_data = open(map_file, 'rb').read()

        blockset_override_file = "../banks/bank_0"+f"{level_data[BLOCKSET_OVERRIDE_BANK]:x}"+".bin"
        blockset_override_data = open(blockset_override_file, 'rb').read()

        level_override_bit = level_data[BLOCKSET_OVERRIDE_BIT]

        os.system('mkdir -p map_images')
        
        if collision_override:
            map_image_path = "./map_images/collision/"
            os.system('mkdir -p map_images/collision/')
        elif show_kill_tiles == True:
            map_image_path = "./map_images/with_kill_tiles/"
            os.system('mkdir -p map_images/with_kill_tiles/')
        else:
            map_image_path = "./map_images/"
        
        if not create_blocksets:
            blockset_img = PIL.Image.open(blockset_image_path+level_name+"_blockset.png")
            blockset_img2 = PIL.Image.open(blockset_image_path+level_name+"_blockset2.png")
        
        blockset = []
        for y in range(0, 16):
            for x in range(0, 16):
                blockset.append(blockset_img.crop((x*32, y*32, (x+1)*32, (y+1)*32)))
                
        blockset2 = []
        for y in range(0, 16):
            for x in range(0, 16):
                blockset2.append(blockset_img2.crop((x*32, y*32, (x+1)*32, (y+1)*32)))

        count = 0
        img = PIL.Image.new("RGB", (4096, 4096))
        draw = PIL.ImageDraw.Draw(img)
        for y in range(0, 128):
            for x in range(0, 128):
                draw.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), map_data[count],3)
                
                if blockset_override_data[y*128+x] & level_override_bit != 0:
                    img.paste(blockset2[map_data[count]], (x*32, y*32))
                else:
                    img.paste(blockset[map_data[count]], (x*32, y*32))
                
                count = count+1
        
        img.save(map_image_path+level_name+"_map.png")

    print("completed: "+level_name)
    #break


nothing_color = "white"
unknown_color = "black"
special_color = "silver"

floor_color = "red"
floor_passable_color = "salmon"
stairs_color = "magenta"
floor_passable_wobble_on_edge_color = "salmon" 
ceiling_color = "yellow"
ceiling_and_wall_color = "purple"
ceiling_and_wall_color2 = "orange"
floor_and_wall_color = "green"
wall_color = "blue"

water_color = "cyan"
lava_color = "orange"
kill_color = "pink"
door_color = "brown"
climbable_background_color = "lime"
climbable_wall_color = "lime"

surface_type_colors = { # this is basically the collision tilset, but with more info
    0x00: wall_color, # wall (right) # this is only used in prehistory, channel z, and part of toon tv
    0x01: wall_color, # wall (left) # this is only used in prehistory, channel z, and part of toon tv
    0x02: floor_passable_color, # floor that you can pass through from below
    0x03: unknown_color,
    0x04: wall_color, # wall (left) # this is used everywhere else
    0x05: floor_color, # floor that blocks you from passing from below, far left and right side act like stairs to try pushing you back on top
    0x06: wall_color, # wall (right) # this is used everywhere else
    0x07: ceiling_color, # ceiling (cannot pass through from above)
    0x08: floor_passable_wobble_on_edge_color, # floor (wobble on the edge)
    0x09: floor_passable_wobble_on_edge_color, # floor (wobble on the edge)
    0x0A: ceiling_and_wall_color, # ceiling and wall?
    0x0B: ceiling_and_wall_color,
    0x0C: floor_and_wall_color, # floor and wall?
    0x0D: floor_and_wall_color, # floor and wall?
    0x0E: ceiling_and_wall_color2, # ceiling and wall?
    0x0F: ceiling_and_wall_color2, # ceiling and wall?
    0x10: stairs_color, # steep stairs
    0x11: stairs_color, # steep stairs
    0x12: stairs_color, # stairs
    0x13: stairs_color, # stairs
    0x14: stairs_color, # stairs
    0x15: stairs_color, # stairs
    0x16: stairs_color, # channel z door stairs
    0x17: stairs_color, # channel z door stairs
    0x18: stairs_color, # some rezopolis ceilings
    0x19: stairs_color, # some rezopolis ceilings
    0x1A: stairs_color, # some rezopolis ceilings
    0x1B: stairs_color, # some rezopolis ceilings
    0x1C: stairs_color, # toon tv rock slopes
    0x1D: stairs_color, # toon tv rock slopes
    0x1E: stairs_color, # circuit central machine you can jump on
    0x1F: stairs_color, # circuit central machine you can jump on
    0x20: stairs_color, # circuit central machine you can jump on
    0x21: stairs_color, # circuit central machine you can jump on
    0x22: door_color, # door
    0x23: kill_color, # kill tile
    0x24: lava_color, # lava
    0x25: water_color, # water
    0x26: climbable_background_color, # climbable background
    0x27: nothing_color, # used for bottom of flowers in fine tooning? seems to have no effect on collision
    0x2A: unknown_color, # used for many tvs, seems to have no effect on collision
    0x2C: climbable_wall_color, # climbable wall (left)
    0x2D: climbable_wall_color, # climbable wall (right)
    0x2E: climbable_wall_color, # climbable ceiling
    0x2F: nothing_color, # the main "nothing" surface
    0x30: unknown_color, # top of climbable wall (left)
    0x31: unknown_color, # top of climbable wall (right)
    0x32: unknown_color, # botttom of climbable wall (left)
    0x33: unknown_color, # botttom of climbable wall (right)
    0xC1: special_color,
    0xC2: special_color,
    0xC3: special_color,
    0xC4: special_color,
    0xC5: special_color,
    0xC6: special_color,
    0xC7: special_color,
    0xCD: special_color,
    0xCE: special_color,
    0xCF: special_color,
    0xDF: special_color,
    0xE9: special_color,
    0xF0: special_color,
    0xF1: special_color,
    0xF5: special_color,
    0xF6: special_color,
    0xF7: special_color,
    0xF8: special_color,
    0xF9: special_color,
    0xFA: special_color,
    0xFB: special_color,
    0xFC: special_color,
    0xFD: special_color,
    0xFE: special_color,
    0xFF: special_color,
}
