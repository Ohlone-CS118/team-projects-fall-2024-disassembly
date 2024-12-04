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

	li $a0, SHADEDBLUE		# this will be a sky blue background
	#jal background_color
	
#------------------------------GRASS------------------------------------------#
	
	li $a0, 0          # x-coordinate 
	li $a1, 58         # y-coordinate 
	li $a3, 128        # length of the grass line (entire width)
	li $a2, GREEN      # grass color
	#jal draw_horizontal_line
	li $a1, 59         # y-coordinate 
	#jal draw_horizontal_line
	li $a1, 60         # y-coordinate 
	#jal draw_horizontal_line
	
#-----------------------------BUILDINGS----------------------------#

	# BUILDING 1
	
	li $a2, BLACK      # building color
	li $a3, 30         # height of building
	li $a1, 30         # y-coordinate
	li $a0, 250        # x-coordinate
	#jal draw_vertical_line
	li $a0, 248        # x-coordinate
	#jal draw_vertical_line
	li $a0, 246        # x-coordinate
	#jal draw_vertical_line
	li $a0, 244        # x-coordinate
	#jal draw_vertical_line
	
	li $a2, YELLOW	# color
	li $a0, 59	# x-coordinate 
	li $a1, 18	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 60	# x-coordinate 
	li $a1, 18	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 59	# x-coordinate 
	li $a1, 20	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 59	# x-coordinate 
	li $a1, 20	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 60	# x-coordinate 
	li $a1, 22	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 60	# x-coordinate 
	li $a1, 22	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	
	#######################################################
	# BUILDING 2
	
	li $a3, 40	# height of building
	li $a2, BLACK	# building color
	li $a1, 20	# y-coordinate
	li $a0, 230	# x-coordinate
	#jal draw_vertical_line
	li $a0, 228	# x-coordinate
	#jal draw_vertical_line
	li $a0, 226	# x-coordinate
	#jal draw_vertical_line
	li $a0, 224	# x-coordinate
	#jal draw_vertical_line
	li $a0, 222	# x-coordinate
	#jal draw_vertical_line
	
	li $a2, YELLOW      # color
	li $a0, 49	# x-coordinate 
	li $a1, 15	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 15	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 48	# x-coordinate 
	li $a1, 17	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 48	# x-coordinate 
	li $a1, 18	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 19	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 20	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 48	# x-coordinate 
	li $a1, 22	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 50	# x-coordinate 
	li $a1, 24	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
		
	#######################################################
	# BUILDING 3
	
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	li $a0, 214        # x-coordinate
	li $a1, 24         # y-coordinate
	#jal draw_vertical_line
	li $a0, 212        # x-coordinate
	#jal draw_vertical_line
	li $a0, 210        # x-coordinate
	#jal draw_vertical_line
	li $a0, 208        # x-coordinate
	#jal draw_vertical_line
	li $a0, 206        # x-coordinate
	#jal draw_vertical_line
	
	li $a2, YELLOW      # color
	li $a0, 40	# x-coordinate 
	li $a1, 15	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 15	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 17	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 17	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 19	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 19	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 22	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 40	# x-coordinate 
	li $a1, 23	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 23	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 24	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	li $a0, 42	# x-coordinate 
	li $a1, 25	# y-coordinate
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	
	#######################################################
	# BUILDING 4
	
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	li $a1, 14         # y-coordinate
	li $a0, 196        # x-coordinate
	#jal draw_vertical_line
	li $a0, 194        # x-coordinate
	#jal draw_vertical_line
	li $a0, 192        # x-coordinate
	#jal draw_vertical_line
	li $a0, 190        # x-coordinate
	#jal draw_vertical_line	
	li $a0, 188        # x-coordinate
	#jal draw_vertical_line
	
	li $a2, YELLOW      	# color
	li $a0, 31		# x-coordinate 
	li $a1, 10		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 31		# x-coordinate 
	li $a1, 11		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 31		# x-coordinate 
	li $a1, 13		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel	
	li $a0, 32		# x-coordinate 
	li $a1, 13		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel	
	li $a0, 33		# x-coordinate 
	li $a1, 13		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 31		# x-coordinate 
	li $a1, 15		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 33		# x-coordinate 
	li $a1, 15		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 31		# x-coordinate 
	li $a1, 17		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 33		# x-coordinate 
	li $a1, 17		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 32		# x-coordinate 
	li $a1, 19		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel	
	li $a0, 32		# x-coordinate 
	li $a1, 20		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 33		# x-coordinate 
	li $a1, 19		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 31		# x-coordinate 
	li $a1, 22		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 31		# x-coordinate 
	li $a1, 23		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel	
	
	#######################################################
	# BUILDING 5
	
	li $a0, 178        # x-coordinate
	li $a1, 34         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	#jal draw_vertical_line
	li $a0, 176        # x-coordinate
	#jal draw_vertical_line
	li $a0, 174        # x-coordinate
	#jal draw_vertical_line
	li $a0, 172        # x-coordinate
	#jal draw_vertical_line
	li $a0, 170        # x-coordinate
	#jal draw_vertical_line
	
	li $a2, YELLOW      	# color
	li $a0, 22		# x-coordinate 
	li $a1, 20		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 23		# x-coordinate 
	li $a1, 20		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 24		# x-coordinate 
	li $a1, 22		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 24		# x-coordinate 
	li $a1, 23		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 22		# x-coordinate 
	li $a1, 23		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 22		# x-coordinate 
	li $a1, 24		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	li $a0, 22		# x-coordinate 
	li $a1, 25		# y-coordinate
	draw_pixel($a0, $a1, $a2)		# calls draw_pixel
	
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
	mul $s1, $s1, 2       # $s1 = 4 * (x + (y * WIDTH))
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
	mul $s1, $s1, 2        # $s1 = ((y * WIDTH) + x) * 4 (offset into the array for this pixel)
	add $s1, $s1, DISPLAY  # $s1 = DISPLAY + ((y * WIDTH) + x) * 4 => pixel address
	li $t0, 0              # Loop counter (number of pixels drawn)
draw_horizontal_loop:
	sw $a2, 0($s1)         # Store the color in the current pixel's address
	addi $s1, $s1, 4       # Move to the next pixel horizontally (4 bytes per pixel)
	addi $t0, $t0, 1       # Increment loop counter
	blt $t0, $a3, draw_horizontal_loop # Continue drawing until the specified number of pixels
	jr $ra
