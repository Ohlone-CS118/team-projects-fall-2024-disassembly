# Implemented by Anthony Ryabov

.data
	# Important constants
	flt_neg_one: .float -1.0
	flt_one: .float 1.0
	flt_half: .float 0.5
	flt_zero: .float 0.0
	
	flt_three: .float 3.0
	flt_five: .float 5.0
	flt_seven: .float 7.0
	flt_nine: .float 9.0
	flt_hundredeighty: .float 180.0
	
	pi: .float 3.14159265
	twopi: .float 6.2831853
	
	grav_const: .float 9.80
	flt_threshold: .float 0.5
	
	millisecond: .float 1000

define:
	# screen information
	.eqv WIDTH 64
	.eqv HEIGHT 64
	.eqv DISPLAY 0x10040000

	# colors used
	.eqv BLACK	0x00000000
	#eqv ORANGE	0x00FF8000
	.eqv YELLOW	0x00FFFF00
	#.eqv WHITE	0x00FFFFFF
	#.eqv GREY	0x00808080
	#.eqv BLUE	0x003399FF
	.eqv GREEN	0x0000CC00
	.eqv BROWN	0x00663300
	#.eqv RED		0x00FF0000
	.eqv SHADEDBLUE	0x00CCCCFF	
	.eqv DARK_GREEN	0x00003300
	
	# register names/equivalencies 
	# warning: not organized
	.eqv newangle $f27
	.eqv angle $f0
	.eqv drawangle $f23
	.eqv ax $f1 
	.eqv ay $f3 
	.eqv Tx $f5 
	.eqv Ty $f10 
	.eqv Vx $f12 
	.eqv Vy $f14 
	.eqv dt $f16 
	.eqv T $t1
	.eqv newT $t3
	.eqv M $t2 
	.eqv xi $t4 
	.eqv yi $t5 
	.eqv xf $t6 
	.eqv yf $t7
	.eqv px $f11
	.eqv py $f13
	.eqv eVx $f7
	.eqv eVy $f9
	
.macro draw_pixel(%x, %y, %color)
	mul $t0, %y, WIDTH	# the product from (y * WIDTH)
	add $t0, %x, $t0	# (x + (y * WIDTH))
	mul $t0, $t0, 4	# 4 * (x + (y * WIDTH)), 4 bytes in one word
	add $t0, $t0, DISPLAY
	sw %color, 0($t0)
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
