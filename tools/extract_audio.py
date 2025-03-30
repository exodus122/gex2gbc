import os
import struct

os.system('mkdir -p ./banks')
os.system('mkdir -p ./banks/audio')

banks = [0x21, 0x22, 0x23, 0x24]
end_audio_data = [0x33ed-2, 0x2747-2, 0x2bce-2, 0xcce-2]
unique_audio = []
unique_audio_ids = []
unique_audio_ids2 = []
#banks = [0x21]

b = 0
for bank in banks:
    bank_str = "{:02x}".format(bank)
    
    os.system('mkdir -p ./banks/audio/bank_'+bank_str)
    
    # read audio bank data
    audio_data = open('./banks/bank_0'+bank_str+'.bin', 'rb').read()[0x460:]
    #print(audio_data)
    
    # get list of audio files in this bank
    audio_pointers_start = struct.unpack('<H', audio_data[0x2:0x4])[0]
    
    audio_pointers = []
    audio_pointers.append(audio_pointers_start)
    #print("{:04x}".format(audio_pointers_start))
    
    current_addr = 0x04
    while current_addr < audio_pointers_start + 2:
        audio_pointers.append(struct.unpack('<H', audio_data[current_addr:current_addr+2])[0])
        
        current_addr = current_addr + 2
    
    audio_pointers.append(end_audio_data[b])
    
    print(audio_pointers)
    
    # extract audio
    out2 = open('./banks/audio/bank_'+bank_str+'/text.txt', "w")
    for i in range(0, len(audio_pointers)-1):
        audio = audio_data[audio_pointers[i]+2:audio_pointers[i+1]+2]
        addr_str = "{:04x}".format(0x4460+audio_pointers[i])
        
        already_known_addr = ""
        
        if audio not in unique_audio:
            unique_audio.append(audio)
            unique_audio_ids.append(addr_str)
            unique_audio_ids2.append(bank_str)
        else:
            index = unique_audio.index(audio)
            already_known_addr = unique_audio_ids[index]
            already_known_bank = unique_audio_ids2[index]
            print(bank_str+'_'+addr_str+" is already known: "+unique_audio_ids[index])
        
        if already_known_addr == "":
            out = open('./banks/audio/bank_'+bank_str+'/audio_'+bank_str+'_'+addr_str+'.bin', "wb")
            out.write(audio)
            out.close()
        
            out2.write('audio_'+bank_str+'_'+addr_str+':\n    INCBIN \"./audio/bank_'+bank_str+'/audio_'+bank_str+'_'+addr_str+'.bin\"\n')
        else:
            out2.write('audio_'+bank_str+'_'+already_known_addr+':\n    INCBIN \"./audio/bank_'+already_known_bank+'/audio_'+already_known_bank+'_'+already_known_addr+'.bin\"\n')
    out2.close()
        
    b = b + 1

print(len(unique_audio))