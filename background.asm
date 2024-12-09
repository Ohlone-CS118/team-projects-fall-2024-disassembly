# Implemented by Zahid Khan

.include "utilities.asm"

.text

.globl background

background:
	push($a0)
	push($a1)
	push($a2)
	push($a3)
	push($t0)
	push($t1)
	push($ra)

	li $a0, SHADEDBLUE	# this will be a sky blue background
	jal background_color
	
	# draw moon (WIP)
	#jal moon
	
#------------------------------GRASS------------------------------------------#
	
	li $a0, 0		# x-coordinate 
	li $a1, 61	# y-coordinate
	li $a3, 192	# length of the grass line (entire width)
	li $a2, BROWN	# grass color
	jal draw_horizontal_line
	
#-----------------------------BUILDINGS----------------------------#

	# BUILDING 1
	
	li $a1, 48	# y-coordinate
	li $a0, 58	# x-coordinate
	li $a2, BLACK	# building color
	li $a3, 15	# height of building
	jal draw_vertical_line
	li $a0, 59	# x-coordinate
	jal draw_vertical_line
	li $a0, 60	# x-coordinate
	jal draw_vertical_line
	li $a0, 61	# x-coordinate
	jal draw_vertical_line
	
	li $a2, YELLOW	# color
	li $a0, 59	# x-coordinate
	li $a1, 50	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 60	# x-coordinate
	li $a1, 50	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 59	# x-coordinate
	li $a1, 52	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 59	# x-coordinate
	li $a1, 52	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 60	# x-coordinate
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 60	# x-coordinate
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	
	#######################################################
	# BUILDING 2
	
	li $a0, 47	# x-coordinate
	li $a1, 43	# y-coordinate
	li $a2, BLACK	# building color
	li $a3, 20	# height of building
	jal draw_vertical_line
	li $a0, 48	# x-coordinate
	jal draw_vertical_line
	li $a0, 49	# x-coordinate
	jal draw_vertical_line
	li $a0, 50	# x-coordinate
	jal draw_vertical_line
	li $a0, 51	# x-coordinate
	jal draw_vertical_line
	
	li $a2, YELLOW      # color
	li $a0, 49	# x-coordinate 
	li $a1, 47	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 47	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 48	# x-coordinate 
	li $a1, 49	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 48	# x-coordinate 
	li $a1, 50	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 51	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 52	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 48	# x-coordinate 
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 56	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
		
	#######################################################
	# BUILDING 3
	
	li $a0, 39	# x-coordinate
	li $a1, 45	# y-coordinate
	li $a2, BLACK	# building color
	li $a3, 18	# height of building
	jal draw_vertical_line
	li $a0, 40	# x-coordinate
	jal draw_vertical_line
	li $a0, 41	# x-coordinate
	jal draw_vertical_line
	li $a0, 42	# x-coordinate
	jal draw_vertical_line
	li $a0, 43	# x-coordinate
	jal draw_vertical_line
	
	li $a2, YELLOW      # color
	li $a0, 40	# x-coordinate 
	li $a1, 47	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 47	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 49	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 49	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 51	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 51	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 55	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 56	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 57	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	
	#######################################################
	# BUILDING 4
	
	li $a0, 30	# x-coordinate
	li $a1, 40	# y-coordinate
	li $a2, BLACK	# building color
	li $a3, 23	# height of building
	
	jal draw_vertical_line
	li $a0, 31	# x-coordinate
	jal draw_vertical_line
	li $a0, 32	# x-coordinate
	jal draw_vertical_line
	li $a0, 33	# x-coordinate
	jal draw_vertical_line	
	li $a0, 34	# x-coordinate
	jal draw_vertical_line
	
	li $a2, YELLOW	# color
	li $a0, 31	# x-coordinate 
	li $a1, 42	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 31	# x-coordinate 
	li $a1, 43	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 31	# x-coordinate 
	li $a1, 45	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel	
	li $a0, 32	# x-coordinate 
	li $a1, 45	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel	
	li $a0, 33	# x-coordinate 
	li $a1, 45	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 31	# x-coordinate 
	li $a1, 47	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 33	# x-coordinate 
	li $a1, 47	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 31	# x-coordinate 
	li $a1, 49	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 33	# x-coordinate 
	li $a1, 49	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 32	# x-coordinate 
	li $a1, 51	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel	
	li $a0, 32	# x-coordinate 
	li $a1, 52	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 33	# x-coordinate 
	li $a1, 51	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 31	# x-coordinate 
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 31	# x-coordinate 
	li $a1, 55	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	
	#######################################################
	# BUILDING 5
	
	li $a0, 21	# x-coordinate
	li $a1, 50	# y-coordinate
	li $a2, BLACK	# building color
	li $a3, 13	# height of building
	jal draw_vertical_line
	li $a0, 22	# x-coordinate
	jal draw_vertical_line
	li $a0, 23	# x-coordinate
	jal draw_vertical_line
	li $a0, 24	# x-coordinate
	jal draw_vertical_line
	li $a0, 25	# x-coordinate
	jal draw_vertical_line
	
	li $a2, YELLOW	# color
	li $a0, 22	# x-coordinate 
	li $a1, 52	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 23	# x-coordinate 
	li $a1, 52	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 24	# x-coordinate 
	li $a1, 54	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 24	# x-coordinate 
	li $a1, 55	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 22	# x-coordinate 
	li $a1, 55	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 22	# x-coordinate 
	li $a1, 56	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 22	# x-coordinate 
	li $a1, 57	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	
	pop($ra)
	pop($t1)
	pop($t0)
	pop($a3)
	pop($a2)
	pop($a1)
	pop($a0)
	
	jr $ra
	
# Preconditions:
#	$a0 = color
background_color:
	li $s1, DISPLAY	# $s1 = the first pixel on the display
	li $s2, WIDTH	# $s2 = last memory address of the display
	mul $s2, $s2, HEIGHT
	mul $s2, $s2, 4	# multiply by amount of bytes in a word
	add $s2, $s1, $s2	# add $s2 to address of first pixel (gives last memory address)
backgroundLoop:
	sw $a0, 0($s1)
	addi $s1, $s1, 4
	ble $s1, $s2, backgroundLoop
	jr $ra

# Preconditions: 
#	$a0 = starting x 
#	$a1 = y 
#	$a3 = number of pixels 
#	$a2 = color
draw_vertical_line:
	mul $s1, $a1, WIDTH   # $s1 = y * WIDTH
	add $s1, $a0, $s1     # $s1 = x + (y * WIDTH)
	mul $s1, $s1, 4       # $s1 = 4 * (x + (y * WIDTH))
	add $s1, $s1, DISPLAY # $s1 = DISPLAY + 4 * (x + (y * WIDTH))
	li $t1, WIDTH
	mul $t1, $t1, 4       # $t1 = WIDTH * 4
	li $t0, 0             # Loop counter for number of pixels	
draw_vertical_loop:
	sw $a2, 0($s1)        # Store color in memory address
	add $s1, $s1, $t1     # Move to the next row (increment by WIDTH * 4 bytes)
	addi $t0, $t0, 1      # Increment the loop counter
	blt $t0, $a3, draw_vertical_loop # Repeat until all pixels are drawn
	jr $ra

# Preconditions: 
#	$a0 = starting x 
#	$a1 = y 
#	$a3 = number of pixels 
#	$a2 = color
draw_horizontal_line:
	mul $s1, $a1, WIDTH    # $s1 = y * WIDTH
	add $s1, $s1, $a0      # $s1 = (y * WIDTH) + x
	mul $s1, $s1, 4        # $s1 = ((y * WIDTH) + x) * 4 (offset into the array for this pixel)
	add $s1, $s1, DISPLAY  # $s1 = DISPLAY + ((y * WIDTH) + x) * 4 => pixel address
	li $t0, 0              # Loop counter (number of pixels drawn)
draw_horizontal_loop:
	sw $a2, 0($s1)         # Store the color in the current pixel's address
	addi $s1, $s1, 4       # Move to the next pixel horizontally (4 bytes per pixel)
	addi $t0, $t0, 1       # Increment loop counter
	blt $t0, $a3, draw_horizontal_loop # Continue drawing until the specified number of pixels
	jr $ra
