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

#extract_banks()

def extract_images_vertical():
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
                next_chunk = 0x1000
                width = 0x80
            
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
                out2.write('image_'+bank+'_'+addr_str+'.bin:\n    INCBIN \".gfx/image_'+bank+'_'+addr_str+'.bin\"\n\n')
                out2.close()
                
                addr = addr + next_chunk
                
                count = count + 1
                
def extract_images_horizontal():
    banks = [0x8, 0x9, 0xc, 0xd, 0xe, 0xf, 0x10, 0x13, 0x1d, 0x1e, 0x1f, 0x26, 0x36, 0x37, 0x3d]
    for b in banks:
        bank = f"{b:0{3}x}"
        with open('./banks/bank_'+bank+'.bin', 'rb') as bf:
            addr = 0x4000
            os.system('mkdir -p banks/bank_'+bank+'/')
            
            next_chunk = 0x100
            width = 4
            
            next_chunk = 0x2000
            width = 16
            
            if b == 0x36 or b == 0x37 or b == 0x26:
                next_chunk = 0x1000
                width = 16
                
            if b == 0x9:
                next_chunk = 0x500
                width = 8
                
            if b == 0x10:
                next_chunk = 0x2600
                width = 16
                
            '''if b == 0x13:
                next_chunk = 0x280
                width = 8'''
                
            if b == 0x1e or b == 0x1d or b == 0x3d:
                next_chunk = 0x1600
                width = 16
            
            if b == 0x1f:
                next_chunk = 0x1900
                width = 16
            
            count = 0
            for data in iter(lambda: bf.read(next_chunk), ''):
                addr_str = f"{addr:0{4}x}"
                if not data:
                    break
                out = open('./banks/bank_'+bank+'/image_'+bank+'_'+addr_str+".bin", "wb")
                out.write(data)
                out.close()
                
                os.system('rgbgfx --reverse '+str(width)+' -o banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.bin banks/bank_'+bank+'/image_'+bank+'_'+addr_str+'.png')
                
                out2 = open('./banks/bank_'+bank+'/text.txt', "a")
                out2.write('image_'+bank+'_'+addr_str+'.bin:\n    INCBIN \".gfx/image_'+bank+'_'+addr_str+'.bin\"\n\n')
                out2.close()
                
                addr = addr + next_chunk
                
                count = count + 1

extract_images_vertical()
extract_images_horizontal()