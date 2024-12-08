# Team Disassembly

"Operation Ironwing"
Danny Huang, Mohammed Aziz Quraishi, Anthony Ryabov, Zahid Khan

# Assembling
Assemble from main.asm
Make sure Settings -> "Assemble all files in directory" is checked
In Tools, open "Bitmap Display" and "Keyboard and Display MMIO Simulator", connect both to MIPS

# Recommended Bitmap Display Settings:
Unit Width in Pixels: 8
Unit Height in Pixels: 8
Display Width in Pixels: 512
Display Height in Pixels: 512
Base address for display: 0x10040000 (heap)

# Controls
1: yes
0: no
w: increase thrust
s: decrease thrust
a: change angle to the left
d: change angle to the right
