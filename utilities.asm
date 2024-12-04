.data

define:
# screen information
	.eqv PIXEL_SIZE 4
	.eqv WIDTH 64
	.eqv HEIGHT 32
	.eqv DISPLAY 0x10010000

# the colors used in my artwork
	.eqv BLACK	0x00000000
	#eqv ORANGE	0x00FF8000
	.eqv YELLOW	0x00FFFF00
	#.eqv WHITE	0x00FFFFFF
	#.eqv GREY	0x00808080
	#.eqv BLUE	0x003399FF
	.eqv GREEN	0x0000CC00
	#.eqv BROWN	0x00663300
	#.eqv RED		0x00FF0000
	.eqv SHADEDBLUE	0x00CCCCFF	
	.eqv DARK_GREEN 0x00003300

.macro draw_pixel(%x, %y, %color)
	mul $s1, %y, WIDTH	# the product from (y * WIDTH)
	add $s1, %x, $s1	# (x + (y * WIDTH))
	mul $s1, $s1, 4	# 4 * (x + (y * WIDTH)), 4 bytes in one word
	sw %color, DISPLAY($s1)
.end_macro

.macro push(%reg)
	sw %reg, -4($sp)
	subi $sp, $sp, 4
.end_macro

.macro pop(%reg)
	lw %reg, ($sp)
	addi $sp, $sp, 4
.end_macro

.macro pushfloat(%reg)
	s.s %reg, -4($sp)
	subi $sp, $sp, 4
.end_macro

.macro popfloat(%reg)
	l.s %reg, ($sp)
	addi $sp, $sp, 4
.end_macro
