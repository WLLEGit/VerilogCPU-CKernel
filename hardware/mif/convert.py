f = open("vga_font.txt")
ofs = open("font.mif", "w")

head = r'''
WIDTH=192;
DEPTH=256;
ADDRESS_RADIX=HEX;
DATA_RADIX=HEX;

CONTENT BEGIN
'''
end = "END;"

lines = f.read().splitlines()

ofs.write(head)
for i in range(256):
    str = "{:03X} : ".format(i)
    for j in range(16):
        str += lines[i*16 + j]
    str += ';\n'
    ofs.write(str)
ofs.write(end)

f.close()
ofs.close()