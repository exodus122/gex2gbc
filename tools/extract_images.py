import os

def extract_banks():
    os.system('mkdir -p banks/')
    with open('../rom.gb', 'rb') as bf:
        count = 0
        for data in iter(lambda: bf.read(0x4000), ''):
            if not data:
                break
            
            out = open('./banks/bank_'+f"{count:0{3}x}"+'.bin', "wb")
            out.write(data)
            out.close()
            count = count + 1

def extract_sprites_vertical():
    banks = [0x4, 0x5, 0x6, 0x7, 0x11, 0x12, 0x14, 0x18, 0x19, 0x1a, 0x1b, 0x1c]
    
    for b in banks:
        bank = f"{b:0{3}x}"
        with open('./banks/bank_'+bank+'.bin', 'rb') as bf:
            addr = 0x4000
            os.system('mkdir -p banks/bank_'+bank+'/')
            
            next_chunk = 0x100
            width = 4
            
            next_chunk = 0x2000
            width = 0x80
            
            if b == 0x14:
                next_chunk = 0x100
                width = 0x8
            
            count = 0
            for data in iter(lambda: bf.read(next_chunk), ''):
                addr_str = f"{addr:0{4}x}"
                if not data:
                    break
                out = open('./banks/bank_'+bank+'/image_'+bank+'_'+addr_str+".bin", "wb")
                out.write(data)
                out.close()
                
                os.system('rgbgfx --reverse '+str(width)+' --columns -o banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.png')
                
                out2 = open('./banks/bank_'+bank+'/text.txt', "a")
                out2.write('image_'+bank+'_'+addr_str+'.bin:\n    INCBIN \"./gfx/image_'+bank+'_'+addr_str+'.bin\"\n\n')
                out2.close()
                
                addr = addr + next_chunk
                
                count = count + 1
                
def extract_special_tilesets_horizontal():
    
    banks = [0x9, 0xd, 0xe, 0xf, 0x10, 0x13, 0x1d, 0x1e, 0x1f, 0x26, 0x36, 0x37, 0x3d]
    banks = [0xd, 0xe, 0xf, 0x10, 0x13]
    banks = [0x9]
    
    chunk_counter = 0
    for b in banks:
        bank = f"{b:0{3}x}"
        with open('./banks/bank_'+bank+'.bin', 'rb') as bf:
            addr = 0x4000
            
            next_chunk = 0x100
            width = 4
            
            next_chunk = 0x2000
            width = 16
            
            if b == 0x36 or b == 0x37 or b == 0x26:
                next_chunk = 0x1000
                width = 16
                
                
            if b == 0x10:
                next_chunk = 0x2600
                width = 16
                
            if b == 0x1e or b == 0x1d or b == 0x3d:
                next_chunk = 0x1600
                width = 16
            
            if b == 0x1f:
                next_chunk = 0x1900
                width = 16
                
            if b == 0xd or b == 0xe or b == 0xf or b == 0x10 or b == 0x13:
                next_chunk = 0x240
            elif b != 0xc:
                width = 0x6
            
            if b == 0x9:
                next_chunk = 0x2d0
                width = 5
            
            os.system('mkdir -p banks/bank_'+bank+'/')
            count = 0
            count2 = 0
            for data in iter(lambda: bf.read(next_chunk), ''):
            
                
                #print("next chunk is: "+f"{next_chunk:0{4}x}"+" and addr is "+f"{addr:0{4}x}")
                addr_str = f"{addr:0{4}x}"
                if not data:
                    break
                    
                if b == 0xc:
                    if count == 1 or count == 4:
                        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+f"{count2:02d}"+"_palette_ids.bin", "wb")
                    else:
                        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+f"{count2:02d}"+".bin", "wb")
                        
                else:
                    if count % 2 == 0:
                        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+f"{count2:02d}"+".bin", "wb")
                    else:
                        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+f"{count2:02d}"+"_palette_ids.bin", "wb")
                out.write(data)
                out.close()
                
                if (b != 0xd and b != 0xe and b != 0xf and b != 0x10 and b != 0x13) or count % 2 == 0:
                    os.system('rgbgfx --reverse '+str(width)+' -o banks/bank_'+bank+'/image_'+bank+'_'+f"{count2:02d}"+'.bin banks/bank_'+bank+'/image_'+bank+'_'+f"{count2:02d}"+'.png')
                
                out2 = open('./banks/bank_'+bank+'/text.txt', "a")
                if count % 2 == 0:
                    out2.write('image_'+bank+'_'+f"{count2:02d}"+'.bin:\n    INCBIN \"./gfx/special_tilesets/image_'+bank+'_'+f"{count2:02d}"+'.bin\"\n\n')
                else:    
                    out2.write('image_'+bank+'_'+f"{count2:02d}"+'_palette_ids.bin:\n    INCBIN \"../gfx/special_tilesets/palette_ids/image_'+bank+'_'+f"{count2:02d}"+'_palette_ids.bin\"\n\n')
                out2.close()
                
                if b == 0xd or b == 0xe or b == 0xf or b == 0x10 or b == 0x13:
                    if count % 2 == 0:
                        next_chunk = 0xC0
                        addr = addr + next_chunk
                    else:
                        next_chunk = 0x240
                        count2 = count2 + 1
                    if b == 0xd and count2 == 17:
                        next_chunk = 0x480
                        width = 9
                    elif b == 0xe and count2 == 18:
                        next_chunk = 0x900
                        width = 16
                    elif b == 0xf and count2 == 12:
                        next_chunk = 0x300
                        width = 2
                
                count = count + 1
                
def extract_splash():
    
    banks = [0xc, 0x8, 0x3d, 0x1d, 0x1e, 0x1f]
    
    for b in banks:
        count2 = 0
        if b == 0xc:
            bank_chunks = [0x1680, 0x168, 0x900, 0x1680, 0x168]
        elif b == 0x8:
            bank_chunks = [0x1680, 0x168, 0x1680, 0x168, 0x480, 0x690] #b40
        elif b == 0x3d:
            bank_chunks = [0x1680]
        elif b == 0x1d or b == 0x1e or b == 0x1f:
            bank_chunks = [0x1680, 0x168, 0x1680, 0x168]
        bank = f"{b:0{3}x}"
        with open('./banks/bank_'+bank+'.bin', 'rb') as bf:
            addr = 0x4000
                
            next_chunk = bank_chunks[0]
            #print("now next_chunk is: "+f"{next_chunk:0{4}x}")
            chunk_counter = 0
            
            os.system('mkdir -p banks/bank_'+bank+'/')
            
            for data in iter(lambda: bf.read(next_chunk), ''):
                if not data:
                    break
                
                if (b == 0xc and (chunk_counter == 1 or chunk_counter == 4)) or (b == 0x8 and (chunk_counter == 1 or chunk_counter == 3)) or ((b == 0x1d or b == 0x1e or b == 0x1f) and (chunk_counter == 1 or chunk_counter == 3)):
                    out = open('./banks/bank_'+bank+'/image_'+bank+'_'+str(count2)+"_palette_ids.bin", "wb")
                else:
                    out = open('./banks/bank_'+bank+'/image_'+bank+'_'+str(count2)+".bin", "wb")
                out.write(data)
                out.close()
                
                if b == 0x8 and chunk_counter == 4:
                    width = 6
                elif b == 0x8 and chunk_counter == 5:
                    width = 5
                elif b == 0xc and chunk_counter == 2:
                    width = 6
                else: 
                    width = 20
                
                if (b == 0xc and (chunk_counter == 1 or chunk_counter == 4)) or (b == 0x8 and (chunk_counter == 1 or chunk_counter == 3)) or ((b == 0x1d or b == 0x1e or b == 0x1f) and (chunk_counter == 1 or chunk_counter == 3)):
                    dummy = 0
                else:
                    os.system('rgbgfx --reverse '+str(width)+' -o banks/bank_'+bank+'/image_'+bank+'_'+str(count2)+'.bin banks/bank_'+bank+'/image_'+bank+'_'+str(count2)+'.png')
                
                
                if (b == 0xc and (chunk_counter == 1 or chunk_counter == 2)) or (b == 0x8 and (chunk_counter == 1 or chunk_counter == 3 or chunk_counter == 4)) or ((b == 0x1d or b == 0x1e or b == 0x1f) and (chunk_counter == 1 or chunk_counter == 3)):
                    count2 = count2 + 1
                    #print("count2 is now: "+str(count2))
                chunk_counter = chunk_counter + 1
                #print("now chunk_counter is: "+str(chunk_counter))
                if chunk_counter == len(bank_chunks):
                    break
                next_chunk = bank_chunks[chunk_counter]
                #print("now next_chunk is: "+f"{next_chunk:0{4}x}")
                    

def extract_bank03():
    banks = [0x3]
    
    # 0 is a fake chunk
    chunk_addresses = [0x4000, 0x66e1, 0x6821, 0x6921, 0x6941, 0x69a5, 0x6be5, 0x6d9d, 0x6E4D, 0x6efd, 0x76fd]
    chunk_sizes =     [0x26e1, 0x140,  0x100,  0x20,   0x64,   0x240,  0x1b8,  0xb0,   0xb0,   0x800,  0x500]
    chunk_widths =    [999,    10,     8,      1,      999,    18,      999,    11,     11,    999,    16]
    
    for b in banks:
        count = 0
        bank = f"{b:0{3}x}"
        with open('./banks/bank_'+bank+'.bin', 'rb') as bf:
            addr = 0x4000
            next_chunk = chunk_sizes[0]
            
            os.system('mkdir -p banks/bank_'+bank+'/')
            
            for data in iter(lambda: bf.read(next_chunk), ''):
                if not data:
                    break
                
                size = chunk_sizes[count]
                addr = chunk_addresses[count]
                addr2 = f"{chunk_addresses[count]:0{3}x}"
                width = chunk_widths[count]
                    
                out = open('./banks/bank_'+bank+'/image_'+bank+'_'+str(addr2)+".bin", "wb")
                out.write(data)
                out.close()
                
                if chunk_widths[count] != 999:
                    os.system('rgbgfx --reverse '+str(width)+' --columns -o banks/bank_'+bank+'/image_'+bank+'_'+str(addr2)+'.bin banks/bank_'+bank+'/image_'+bank+'_'+str(addr2)+'.png')
                
                count = count + 1
                if count == len(chunk_sizes):
                    break
                next_chunk = chunk_sizes[count]
            

def extract_bank03_new():
    bank = "003"
    bank2 = "03"
    bank_03_data = open('./banks/bank_'+bank+'.bin', 'rb').read()
    os.system('mkdir -p banks/bank_'+bank+'/')
    
    # extract collectible sprites
    start_collectible_addr = 0x69a5
    levels = ["toon_tv", "scream_tv", "circuit_central", "kung_fu_theater", "prehistory_channel", "rezopolis"]
    
    for i in range(0, len(levels)):
        size = 0x60
        width = 3
        level_name = levels[i]
        start_addr = start_collectible_addr + i*size
        addr_str = f"{start_addr:0{4}x}"
        
        data = bank_03_data[start_addr-0x4000:start_addr-0x4000+size]
        
        out = open('./banks/bank_'+bank+'/image_collectibles_'+level_name+'_'+bank+'_'+addr_str+".bin", "wb")
        out.write(data)
        out.close()
        
        os.system('rgbgfx --reverse '+str(width)+' --columns -o banks/bank_'+bank+'/image_collectibles_'+level_name+'_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_collectibles_'+level_name+'_'+bank+'_'+addr_str+'.png')
    
    # extract moving backgrounds
    addrs = [0x747D, 0x74BD, 0x74FD, 0x753D, 0x757D, 0x759D, 0x75BD, 0x75DD, 0x75FD, 0x763D, 0x767D, 0x76BD, 0x76FD, 0x775D, 0x77BD, 0x781D, 0x787D, 0x789D, 0x78BD, 0x78FD, 0x793D, 0x797D, 0x79BD, 0x79FD, 0x7A3D, 0x7A7D, 0x7ABD, 0x7ADD, 0x7AFD, 0x7B0D, 0x7B1D, 0x7B2D, 0x7B3D, 0x7B4D, 0x7B5D, 0x7B6D, 0x7B7D, 0x7B9D, 0x7BBD, 0x7BDD, 0x7BFD]
    
    for i in range(0, len(addrs)-1):
        addr = addrs[i]
        addr_str = f"{addr:0{4}x}"
        
        data = bank_03_data[addr-0x4000:addrs[i+1]-0x4000]
        width = int((addrs[i+1] - addr) / 0x10)
        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin', "wb")
        out.write(data)
        out.close()
        
        os.system('rgbgfx --reverse '+str(width)+' --columns -o banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.png')
        
        out2 = open('./banks/bank_'+bank+'/text.txt', "a")
        out2.write('data_'+bank2+'_'+addr_str+':\n    INCBIN \"./gfx/moving_tiles/image_'+bank+'_'+addr_str+'.bin\"\n')
        out2.close()

def extract_bank_01():
    bank = "001"
    bank2 = "01"
    bank_01_data = open('./banks/bank_'+bank+'.bin', 'rb').read()
    os.system('mkdir -p banks/bank_'+bank+'/')
    
    # extract menu images
    addrs = [0x66a7, 0x689f, 0x6add, 0x71e9, 0x7c4d, 0x7cc5, 0x7d3d, 0x7db5, 0x7e2d, 0x7ea5]
    sizes = [0x1f8,  0x23E,  0x70C,  0x300,  0x60,   0x60,   0x60,   0x60,   0x60,   0x60]
    widths = [1,     1,      1,      24,     3,      3,      3,      3,      3,      3]
    
    for i in range(0, len(addrs)):
        addr = addrs[i]
        addr_str = f"{addr:0{4}x}"
        
        data = bank_01_data[addr-0x4000:addr-0x4000+sizes[i]]
        #width = int((addrs[i+1] - addr) / 0x10)
        width = widths[i]
        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin', "wb")
        out.write(data)
        out.close()
        
        os.system('rgbgfx --reverse '+str(width)+' --columns -o banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.png')
        
        out2 = open('./banks/bank_'+bank+'/text.txt', "a")
        out2.write('data_'+bank2+'_'+addr_str+':\n    INCBIN \"./gfx/misc_sprites/menus/image_'+bank+'_'+addr_str+'.bin\"\n')
        out2.close()
        
    addrs = [0x7500, 0x7543, 0x7586, 0x7709, 0x7b8c, 0x7bcf]
    sizes = [0x40,   0x40,   0x180,  0x480,  0x40,   0x40]
    widths = [2,     2,      12,      18,      2,      2]
    
    for i in range(0, len(addrs)):
        addr = addrs[i]
        addr_str = f"{addr:0{4}x}"
        
        data = bank_01_data[addr-0x4000:addr-0x4000+sizes[i]]
        width = widths[i]
        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin', "wb")
        out.write(data)
        out.close()
        
        os.system('rgbgfx --reverse '+str(width)+' -o banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.png')
        
        out2 = open('./banks/bank_'+bank+'/text.txt', "a")
        out2.write('data_'+bank2+'_'+addr_str+':\n    INCBIN \"./gfx/menu_sprites/image_'+bank+'_'+addr_str+'.bin\"\n')
        out2.close()

def extract_bank_09():
    bank = "009"
    bank2 = "09"
    bank_data = open('./banks/bank_'+bank+'.bin', 'rb').read()
    os.system('mkdir -p banks/bank_'+bank+'/')
    
    # extract menu images
    addrs = [0x4000]
    sizes = [0x2d0]
    widths = [9]
    
    for i in range(0, len(addrs)):
        addr = addrs[i]
        addr_str = f"{addr:0{4}x}"
        
        data = bank_data[addr-0x4000:addr-0x4000+sizes[i]]
        #width = int((addrs[i+1] - addr) / 0x10)
        width = widths[i]
        out = open('./banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin', "wb")
        out.write(data)
        out.close()
        
        os.system('rgbgfx --reverse '+str(width)+' -o banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.png')
        
        out2 = open('./banks/bank_'+bank+'/text.txt', "a")
        out2.write('data_'+bank2+'_'+addr_str+':\n    INCBIN \"./gfx/misc_sprites/menus/image_'+bank+'_'+addr_str+'.bin\"\n')
        out2.close()

#extract_banks()
#extract_sprites_vertical()
#extract_special_tilesets_horizontal()
#extract_splash()
#extract_bank03()
#extract_bank03_new()
#extract_bank_01()
extract_bank_09()