import PIL.Image
import PIL.ImageDraw
import numpy
import struct
import os

palette = []
palette_ids = []

'''

    ["toon_tv", ""],
    ["scream_tv", "1"],
    ["scream_tv", "2"],
    ["kung_fu_theater", "1"],
    ["kung_fu_theater", "2"],
    ["circuit_central", "1"],
    ["circuit_central", "2"],
    ["circuit_central", "3"],
    ["prehistory_channel", "1"],
    ["prehistory_channel", "2"],
    ["rezopolis", ""],
    ["channel_z", ""], 
'''

levels = [
    ["media_dimension", ""],
]

create_tilesets = True
create_special_tilesets = True
create_blocksets = False
create_maps = False

for i in range(0, len(levels)):

    level_name = levels[i][0]
    channel_map_number = levels[i][1]
    map_file = "../../maps/"+level_name+"/map_"+level_name+channel_map_number+".bin"
    blockset_data_file = "../../maps/"+level_name+"/blockset_data_"+level_name+".bin"
    tileset_file = "../../.gfx/tilesets/tileset_"+level_name+".bin"
    palette_ids_file = "../../gfx/tilesets/palette_ids/palette_ids_"+level_name+".bin"
    palette_file = "../../gfx/tilesets/palettes/palette_"+level_name+".bin"
    special_tileset_folder = "../../.gfx/special_tilesets/"+level_name+"/"
    special_tileset_palette_ids_folder = "../../gfx/special_tilesets/"+level_name+"/palette_ids/"
    
    
    palette_data = open(palette_file, "rb").read()
    palette_ids = open(palette_ids_file, "rb").read()
    
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
                
                os.system('rgbgfx --reverse 1 -p '+"./temp.bin"+' --columns -o ./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.bin ./tile_bins/'+level_name+'/tile_'+f"{count:0{2}x}"+'.png')
                
                count = count + 1
        
        os.system('mkdir -p tileset_images')
        tiles = []
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
    media_dimension_tv_order = ["scream_tv", "toon_tv", "prehistory_channel", "circuit_central", "kung_fu_theater", "channel_z", "rezopolis", "bonus_tv"]
    media_dimension_tv_order2 = ["image_013_12", "image_013_13", "image_013_14", "image_013_15", "image_013_16", "image_013_17", "image_013_18", "image_013_19"]
    
    if create_special_tilesets and level_name != "channel_z":

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
                    
                    television = -1
                    q = 0
                    for q in range (0, len(media_dimension_tv_order2)):
                        if media_dimension_tv_order2[q] in tileset_file:
                            television = q
                            break
                        q = q + 1
                    
                    if level_name == "media_dimension" and television != -1:
                        palette_file2 = "../../gfx/special_tilesets/"+level_name+"/palettes/"+media_dimension_tv_order[q]+"_television_palette.bin"
                        temp_palette_data = open(palette_file2, "rb").read()[:8]
                    
                    f = open("./temp.bin", "wb")
                    f.write(temp_palette_data)
                    f.close()
                    
                    os.system('rgbgfx --reverse 1 -p '+"./temp.bin"+' --columns -o ./special_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.bin ./special_tile_bins/'+level_name+'/'+filename2+'/tile_'+f"{count:0{2}x}"+'.png')
                    
                    count = count + 1
            
            os.system('mkdir -p special_tileset_images/'+level_name+'/')
            special_tiles = []
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
    if create_blocksets:
        os.system('mkdir -p blockset_images')
        
        blockset_data = open(blockset_data_file, "rb").read()
        blockset_img = PIL.Image.new("RGB", (512, 512))
        draw2 = PIL.ImageDraw.Draw(blockset_img)
        
        count = 0
        for y in range(0, 16):
            for x in range(0, 16):
                draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
                
                block_img =  PIL.Image.new("RGB", (32, 32))
                
                # add the regular tiles to the blockset
                val = count
                for inner_y in range(0, 4):
                    for inner_x in range(0, 4):
                        #blockset_img.paste(tiles[blockset_data[count]], (x*32, y*32))
                        block_img.paste(tiles[blockset_data[val]], (inner_x*8, inner_y*8))
                        val = val + 0x100
                
                #block_img.save("./block_images/block"+str(count)+".png")
                blockset_img.paste(block_img, (x*32, y*32))
                
                count = count + 1
        
        blockset_img.save("./blockset_images/"+level_name+"_blockset.png")
        
        #second blockset for each level
        os.system('mkdir -p blockset_images')
        
        blockset_data = open(blockset_data_file, "rb").read()
        blockset_img = PIL.Image.new("RGB", (512, 512))
        draw2 = PIL.ImageDraw.Draw(blockset_img)
        
        count = 0x1000
        for y in range(0, 16):
            for x in range(0, 16):
                draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
                
                block_img =  PIL.Image.new("RGB", (32, 32))
                
                val = count
                for inner_y in range(0, 4):
                    for inner_x in range(0, 4):
                        #blockset_img.paste(tiles[blockset_data[count]], (x*32, y*32))
                        #if blockset_data[val] != 0xff and blockset_data[val] < 0x24:
                        
                        #    block_img.paste(tiles[0], (inner_x*8, inner_y*8)) #
                        #if blockset_data[val] >= 0x24:
                        block_img.paste(tiles[blockset_data[val]], (inner_x*8, inner_y*8))
                        val = val + 0x100
                
                #block_img.save("./block_images/block"+str(count)+".png")
                blockset_img.paste(block_img, (x*32, y*32))
                
                count = count + 1
        
        blockset_img.save("./blockset_images/"+level_name+"_blockset2.png")
    
    
    # create the level's map from the blockset
    if create_maps:
        blockset_img2 = PIL.Image.open("./blockset_images/"+level_name+"_blockset.png")
        blockset = []
        for y in range(0, 16):
            for x in range(0, 16):
                blockset.append(blockset_img2.crop((x*32, y*32, (x+1)*32, (y+1)*32)))

        data = open(map_file, "rb").read()

        count = 0
        img = PIL.Image.new("RGB", (4096, 4096))
        draw = PIL.ImageDraw.Draw(img)
        for y in range(0, 128):
            for x in range(0, 128):
                draw.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), data[count],3)
                
                img.paste(blockset[data[count]], (x*32, y*32))
                
                count = count+1
        
        os.system('mkdir -p map_images')
        img.save("./map_images/"+level_name+channel_map_number+"_map.png")
    
