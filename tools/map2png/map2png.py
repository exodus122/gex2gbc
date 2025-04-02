import PIL.Image
import PIL.ImageDraw
import numpy
import struct
import os

'''
    
    
    
    
 
'''

levels = [
    ["media_dimension", "", 34, 0x04],
    ["toon_tv", "", 34, 0x08], # out of toon, fine tooning
    ["scream_tv", "1", 34, 0x02], # smellraiser, poltergex, thursday the 12th
    ["scream_tv", "2", 34, 0x01], # frankensteinfeld, texas chainsaw
    ["circuit_central", "3", 35, 0x02], # www.dotcom.com
    ["kung_fu_theater", "2", 34, 0x80], # mao tse tongue
    ["prehistory_channel", "1", 34, 0x10], # pangaea 90210
    ["prehistory_channel", "2", 34, 0x20], # this old cave, lava dabba doo
    ["circuit_central", "1", 35, 0x08], # honey I shrunk the gecko
    ["kung_fu_theater", "1", 34, 0x40], # samurai night fever, lizard in a china shop
    ["rezopolis", "", 35, 0x01], # no weddings and a funeral, bugged out, mazed and confused
    ["circuit_central", "2", 35, 0x04], # chips and dips
    ["channel_z", "", 35, 0x10], 
]

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

surface_type_colors = {
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


create_tilesets = False
create_special_tilesets = False
create_blocksets = True
create_maps = True

show_kill_tiles = False
draw_tile_ids = False
draw_block_ids = False
create_collision_blocksets = True
create_collision_maps = True


for i in range(0, len(levels)):

    level_name = levels[i][0]
    channel_map_number = levels[i][1]
    map_file = "../../maps/"+level_name+"/map_"+level_name+channel_map_number+".bin"
    blockset_data_file = "../../maps/"+level_name+"/blockset_data_"+level_name+".bin"
    blockset_override_data_file = "../../maps/blockset_override_data_bank"+str(levels[i][2])+".bin"
    special_tile_data_file = "../../maps/"+level_name+"/special_tile_data_"+level_name+".bin"
    
    tileset_file = "../.././gfx/tilesets/tileset_"+level_name+".bin"
    palette_ids_file = "../../gfx/tilesets/palette_ids/palette_ids_"+level_name+".bin"
    palette_file = "../../gfx/tilesets/palettes/palette_"+level_name+".bin"
    special_tileset_folder = "../.././gfx/special_tilesets/"+level_name+"/"
    special_tileset_palette_ids_folder = "../../gfx/special_tilesets/"+level_name+"/palette_ids/"
    
    palette_data = open(palette_file, "rb").read()
    palette_ids = open(palette_ids_file, "rb").read()
    
    special_tiles = []
    tiles = []
    
    # create a colored version of the level's tileset, using palettes
    if create_tilesets:
        
        os.system('mkdir -p tile_bins')
        os.system('mkdir -p tile_bins/'+level_name)
        with open(tileset_file, 'rb') as bf:
            count = 0
            for data in iter(lambda: bf.read(0x10), ''):
                if not data:
                    break
                
                out = open('./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.bin', "wb")
                out.write(data)
                out.close()
                
                palette_index = palette_ids[count]
                #print(palette_index)
                temp_palette_data = palette_data[0x8*palette_index:0x8*palette_index+0x8]
                f = open("./temp.bin", "wb")
                f.write(temp_palette_data)
                f.close()
                
                os.system('rg./gfx --reverse 1 -p '+"./temp.bin"+' --columns -o ./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.bin ./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.png')
                
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
    
    # create a colored version of the level's special tilesets, using palettes
    media_dimension_tv_order = ["scream_tv", "scream_tv", "toon_tv", "prehistory_channel", "circuit_central", "kung_fu_theater", "channel_z", "rezopolis", "bonus_tv"]
    media_dimension_tv_order2 = ["image_013_00", "image_013_12", "image_013_13", "image_013_14", "image_013_15", "image_013_16", "image_013_17", "image_013_18", "image_013_19"]
    
    if create_special_tilesets:

        os.system('mkdir -p special_tile_bins/')
        os.system('mkdir -p special_tile_bins/'+level_name)
        os.system('mkdir -p special_tileset_images/')
        os.system('mkdir -p special_tileset_images/'+level_name)
        
        for tileset_file in os.listdir(special_tileset_folder):
            if tileset_file == "image_00f_12.bin" or tileset_file == "image_00e_18.bin":
                continue # no palette ids
            
            filename2 = tileset_file.split(".", 1)[0]
        
            with open(special_tileset_folder+"/"+tileset_file, 'rb') as bf:
                count = 0
                for data in iter(lambda: bf.read(0x10), ''):
                    if not data:
                        break
                        
                    os.system('mkdir -p special_tile_bins/'+level_name+'/'+filename2+'/')
                    
                    out = open('./special_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.bin', "wb")
                    out.write(data)
                    out.close()
                    
                    palette_ids = open(special_tileset_palette_ids_folder+"/"+filename2+"_palette_ids.bin", "rb").read()
                    palette_index = palette_ids[count]
                    #print(palette_index)
                    temp_palette_data = palette_data[0x8*palette_index:0x8*palette_index+0x8]
                    
                    # special case for television palettes in media dimension
                    if level_name == "media_dimension":
                        television = -1
                        q = 0
                        for q in range (0, len(media_dimension_tv_order2)):
                            if media_dimension_tv_order2[q] in tileset_file:
                                television = q
                                break
                            q = q + 1
                        
                        if television != -1:
                            palette_file2 = "../../gfx/special_tilesets/"+level_name+"/palettes/"+media_dimension_tv_order[q]+"_television_palette.bin"
                            if media_dimension_tv_order[q] == "circuit_central":
                                temp_palette_data = open(palette_file2, "rb").read()[8:]
                            else:
                                temp_palette_data = open(palette_file2, "rb").read()[:8]
                        
                    f = open("./temp.bin", "wb")
                    f.write(temp_palette_data)
                    f.close()
                    
                    os.system('rg./gfx --reverse 1 -p '+"./temp.bin"+' --columns -o ./special_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.bin ./special_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.png')
                    
                    count = count + 1
            
            os.system('mkdir -p special_tileset_images/'+level_name+'/')
            new_tileset_img = PIL.Image.new("RGB", (48, 48))
            count = 0
            for y in range(0, 6):
                for x in range(0, 6):
                    tile_img = PIL.Image.open('./special_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.png')
                    new_tileset_img.paste(tile_img, (x*8, y*8))
                    special_tiles.append(tile_img)
                    count = count + 1
            new_tileset_img.save('./special_tileset_images/'+level_name+'/'+filename2+'_tileset.png')
    
    
    # create the level's blockset from the tileset
    blockset_data = open(blockset_data_file, "rb").read()
    if create_blocksets:
        kill_tile = PIL.Image.new("RGB", (8, 8), (255, 192, 203))
    
        if create_collision_blocksets == True:
            blockset_image_path = "./blockset_images/collision_detailed/"
        elif show_kill_tiles == True:
            blockset_image_path = "./blockset_images/with_kill_tiles/"
        else:
            blockset_image_path = "./blockset_images/"
        
        os.system('mkdir -p blockset_images')
        os.system('mkdir -p blockset_images/with_kill_tiles')
        os.system('mkdir -p blockset_images/collision_detailed')
        
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
                        
                        if create_collision_blocksets == True:
                            draw3.rectangle(((inner_x*8, inner_y*8), ((inner_x+1)*8, (inner_y+1)*8)), surface_type_colors[blockset_data[0x2000+val]])
                            if draw_tile_ids == True and blockset_data[0x2000+val] != 0x2f:
                                draw3.text((inner_x*8, inner_y*8), "%x" % blockset_data[0x2000+val], "magenta")
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
        os.system('mkdir -p blockset_images')
        os.system('mkdir -p blockset_images/with_kill_tiles')
        
        blockset_img2 = PIL.Image.new("RGB", (512, 512))
        special_tile_data = open(special_tile_data_file, "rb").read()
        draw2 = PIL.ImageDraw.Draw(blockset_img2)
        
        #print("special_tile_data[0] is: "+str(special_tile_data[0]))
        
        block_counter = 0
        count = 0x1000
        for y in range(0, 16):
            for x in range(0, 16):
                draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
                
                block_img =  PIL.Image.new("RGB", (32, 32))
                draw3 = PIL.ImageDraw.Draw(block_img)
                
                special_tile_override = False
                if block_counter >= special_tile_data[0]: # and blockset_data[val] 
                    special_tileset_to_open = special_tile_data[block_counter-special_tile_data[0]+1]
                    if special_tileset_to_open > 0:
                        special_tile_override = True
                    #block_img.paste(special_tiles[(special_tileset_to_open*16)+blockset_data[val]]], (inner_x*8, inner_y*8))
                
                val = count
                for inner_y in range(0, 4):
                    for inner_x in range(0, 4):
                        if create_collision_blocksets == True:
                            draw3.rectangle(((inner_x*8, inner_y*8), ((inner_x+1)*8, (inner_y+1)*8)), surface_type_colors[blockset_data[0x2000+val]])
                            if draw_tile_ids == True and blockset_data[0x2000+val] != 0x2f:
                                draw3.text((inner_x*8, inner_y*8), "%x" % blockset_data[0x2000+val], "magenta")
                        else:
                            if special_tile_override != False and blockset_data[val] < 0x24:
                                tile_to_paste = special_tiles[(0x24*(special_tileset_to_open-1))+blockset_data[val]]
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
        if create_collision_maps:
            map_image_path = "./map_images/collision_detailed/"
        elif show_kill_tiles == True:
            map_image_path = "./map_images/with_kill_tiles/"
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

        data = open(map_file, "rb").read()
        blockset_override_data = open(blockset_override_data_file, "rb").read()
        level_override_bit = levels[i][3]

        count = 0
        img = PIL.Image.new("RGB", (4096, 4096))
        draw = PIL.ImageDraw.Draw(img)
        for y in range(0, 128):
            for x in range(0, 128):
                draw.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), data[count],3)
                
                if blockset_override_data[y*128+x] & level_override_bit != 0:
                    img.paste(blockset2[data[count]], (x*32, y*32))
                else:
                    img.paste(blockset[data[count]], (x*32, y*32))
                
                count = count+1
        
        os.system('mkdir -p map_images')
        os.system('mkdir -p map_images/with_kill_tiles/')
        os.system('mkdir -p map_images/collision_detailed/')
        img.save(map_image_path+level_name+channel_map_number+"_map.png")
    
    print("completed: "+level_name)
