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

for i in range(0, len(levels)):

    level_name = levels[i][0]
    channel_map_number = levels[i][1]
    map_file = "../../maps/"+level_name+"/map_"+level_name+channel_map_number+".bin"
    blockset_data_file = "../../maps/"+level_name+"/blockset_data_"+level_name+".bin"
    tileset_file = "../../.gfx/tilesets/tileset_"+level_name+".bin"
    palette_ids_file = "../../gfx/tilesets/palette_ids/palette_ids_"+level_name+".bin"
    palette_file = "../../gfx/tilesets/palettes/palette_"+level_name+".bin"
    
    # update the level's tileset to have color, using palettes
    palette_data = open(palette_file, "rb").read()
    palette_ids = open(palette_ids_file, "rb").read()
    
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
    
    # create the level's blockset from the tileset
    os.system('mkdir -p blockset_images')
    
    blockset_data = open(blockset_data_file, "rb").read()
    blockset_img = PIL.Image.new("RGB", (512, 512))
    draw2 = PIL.ImageDraw.Draw(blockset_img)
    
    count = 0
    for y in range(0, 16):
        for x in range(0, 16):
            draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
            
            block_img =  PIL.Image.new("RGB", (32, 32))
            
            val = count
            for inner_y in range(0, 4):
                for inner_x in range(0, 4):
                    #blockset_img.paste(tiles[blockset_data[count]], (x*32, y*32))
                    block_img.paste(tiles[blockset_data[val]], (inner_x*8, inner_y*8))
                    val = val + 0x100
            
            #block_img.save("./block_images/block"+str(count)+".png")
            blockset_img.paste(block_img, (x*32, y*32))
            
            count = count + 1
    
    # add the special tiles to the blockset
    count = 0x1000
    for y in range(0, 16):
        for x in range(0, 16):
            #draw2.rectangle(((x*32,y*32), ((x+1)*32,(y+1)*32)), 0,3)
            
            #block_img =  PIL.Image.new("RGB", (32, 32))
            
            val = count
            for inner_y in range(0, 4):
                for inner_x in range(0, 4):
                    #blockset_img.paste(tiles[blockset_data[count]], (x*32, y*32))
                    #block_img.paste(tiles[blockset_data[val]], (inner_x*8, inner_y*8))
                    val = val + 0x100
            
            #block_img.save("./block_images/block"+str(count)+".png")
            #blockset_img.paste(block_img, (x*32, y*32))
            
            count = count + 1
    
    blockset_img.save("./blockset_images/"+level_name+"_blockset.png")
    
    # create the level's map from the blockset
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
    
