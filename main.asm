# Main Program File

.data

# open BitMap Display under Tools
# set display to:
#	Pixels width and height to 2x2
#	Display width and height to 64x64
#	Base address = 0x10010000

define:
# screen information
	.eqv PIXEL_SIZE 4
	.eqv WIDTH 64
	.eqv HEIGHT 32
	.eqv DISPLAY 0x10010000

# the colors used in my artwork
	.eqv BLACK      0x00000000
	.eqv ORANGE	0x00FF8000
	.eqv YELLOW	0x00FFFF00
	.eqv WHITE	0x00FFFFFF
	.eqv GREY	0x00808080
	.eqv BLUE	0x003399FF
	.eqv GREEN	0x0000CC00
	.eqv BROWN	0x00663300
	.eqv RED	0x00FF0000
	.eqv SHADEDBLUE	0x00CCCCFF	
	.eqv DARK_GREEN 0x00003300
	
.text

main:

	li $a0, SHADEDBLUE		# this will be a sky blue background
	jal background_color
	
#------------------------------GRASS------------------------------------------#
	
	li $a0, 0          # x-coordinate 
	li $a1, 58         # y-coordinate 
	li $a3, 128         # length of the grass line (entire width)
	li $a2, GREEN      # grass color
	jal draw_horizontal_line
	
	li $a0, 0          # x-coordinate 
	li $a1, 59         # y-coordinate 
	li $a3, 128        # length of the grass line (entire width)
	li $a2, GREEN      # grass color
	jal draw_horizontal_line
	
	li $a0, 0          # x-coordinate 
	li $a1, 60         # y-coordinate 
	li $a3, 128        # length of the grass line (entire width)
	li $a2, GREEN      # grass color
	jal draw_horizontal_line


	
#-----------------------------BUILDINGS----------------------------#

	# BUILDING 1
	
	li $a0, 250        # x-coordinate
	li $a1, 30         # y-coordinate
	li $a3, 30         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 248        # x-coordinate
	li $a1, 30         # y-coordinate
	li $a3, 30         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 246        # x-coordinate
	li $a1, 30         # y-coordinate
	li $a3, 30         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 244        # x-coordinate
	li $a1, 30         # y-coordinate
	li $a3, 30         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 59		# x-coordinate 
	li $a1, 18		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 60		# x-coordinate 
	li $a1, 18		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 59		# x-coordinate 
	li $a1, 20		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 59		# x-coordinate 
	li $a1, 20		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 60		# x-coordinate 
	li $a1, 22		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 60		# x-coordinate 
	li $a1, 22		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	#######################################################
	# BUILDING 2
	
	li $a0, 230        # x-coordinate
	li $a1, 20         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 228        # x-coordinate
	li $a1, 20         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 226        # x-coordinate
	li $a1, 20         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 224        # x-coordinate
	li $a1, 20         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 222        # x-coordinate
	li $a1, 20         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 49		# x-coordinate 
	li $a1, 15		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 50		# x-coordinate 
	li $a1, 15		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 48		# x-coordinate 
	li $a1, 17		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 48		# x-coordinate 
	li $a1, 18		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 50		# x-coordinate 
	li $a1, 19		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 50		# x-coordinate 
	li $a1, 20		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 48		# x-coordinate 
	li $a1, 22		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 50		# x-coordinate 
	li $a1, 24		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	
	#######################################################
	# BUILDING 3
	
	li $a0, 214        # x-coordinate
	li $a1, 24         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 212        # x-coordinate
	li $a1, 24         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 210        # x-coordinate
	li $a1, 24         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 208        # x-coordinate
	li $a1, 24         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 206        # x-coordinate
	li $a1, 24         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 40		# x-coordinate 
	li $a1, 15		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 42		# x-coordinate 
	li $a1, 15		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 40		# x-coordinate 
	li $a1, 17		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 42		# x-coordinate 
	li $a1, 17		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 40		# x-coordinate 
	li $a1, 19		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 42		# x-coordinate 
	li $a1, 19		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 40		# x-coordinate 
	li $a1, 22		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 40		# x-coordinate 
	li $a1, 23		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 42		# x-coordinate 
	li $a1, 23		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 42		# x-coordinate 
	li $a1, 24		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 42		# x-coordinate 
	li $a1, 25		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	#######################################################
	# BUILDING 4
	
	li $a0, 196        # x-coordinate
	li $a1, 14         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 194        # x-coordinate
	li $a1, 14         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 192        # x-coordinate
	li $a1, 14         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 190        # x-coordinate
	li $a1, 14         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 188        # x-coordinate
	li $a1, 14         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 31		# x-coordinate 
	li $a1, 10		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 31		# x-coordinate 
	li $a1, 11		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 31		# x-coordinate 
	li $a1, 13		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 32		# x-coordinate 
	li $a1, 13		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 33		# x-coordinate 
	li $a1, 13		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 31		# x-coordinate 
	li $a1, 15		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 33		# x-coordinate 
	li $a1, 15		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 31		# x-coordinate 
	li $a1, 17		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 33		# x-coordinate 
	li $a1, 17		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 32		# x-coordinate 
	li $a1, 19		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 32		# x-coordinate 
	li $a1, 20		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 33		# x-coordinate 
	li $a1, 19		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 31		# x-coordinate 
	li $a1, 22		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 31		# x-coordinate 
	li $a1, 23		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	
	#######################################################
	# BUILDING 5
	
	
	li $a0, 178        # x-coordinate
	li $a1, 34         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 176        # x-coordinate
	li $a1, 34         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 174        # x-coordinate
	li $a1, 34         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 172        # x-coordinate
	li $a1, 34         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 170        # x-coordinate
	li $a1, 34         # y-coordinate
	li $a3, 40         # height of building
	li $a2, BLACK      # building color
	jal draw_vertical_line
	
	li $a0, 22		# x-coordinate 
	li $a1, 20		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 23		# x-coordinate 
	li $a1, 20		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 24		# x-coordinate 
	li $a1, 22		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 24		# x-coordinate 
	li $a1, 23		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 22		# x-coordinate 
	li $a1, 23		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_
	
	li $a0, 22		# x-coordinate 
	li $a1, 24		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	li $a0, 22		# x-coordinate 
	li $a1, 25		# y-coordinate
	li $a2, YELLOW      	# color
	jal draw_pixel		# calls draw_pixel
	
	#################################################
	# ROCKET
	
#	li $a0, 12		# x-coordinate 
#	li $a1, 20		# y-coordinate
#	li $a2, RED      	# color
#	jal increment_x
#	jal draw_pixel		# calls draw_pixel
#	jal increment_pixel
	
#	li $a0, 12		# x-coordinate 
#	li $a1, 21		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 13		# x-coordinate 
#	li $a1, 21		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 11		# x-coordinate 
#	li $a1, 21		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 12		# x-coordinate 
#	li $a1, 22		# y-coordinate
#	li $a2, BLUE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 13		# x-coordinate 
#	li $a1, 22		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 11		# x-coordinate 
#	li $a1, 22		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 11		# x-coordinate 
#	li $a1, 23		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 12		# x-coordinate 
#	li $a1, 23		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 13		# x-coordinate 
#	li $a1, 23		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 11		# x-coordinate 
#	li $a1, 24		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 12		# x-coordinate 
#	li $a1, 24		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 13		# x-coordinate 
#	li $a1, 24		# y-coordinate
#	li $a2, WHITE      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 14        # x-coordinate
#	li $a1, 26         # y-coordinate
#	li $a3, 4         # height of building
#	li $a2, BLACK      # building color
#	jal draw_vertical_line
	
#	li $a0, 10		# x-coordinate 
#	li $a1, 22		# y-coordinate
#	li $a2, RED      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 10		# x-coordinate 
#	li $a1, 23		# y-coordinate
#	li $a2, RED      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 14		# x-coordinate 
#	li $a1, 22		# y-coordinate
#	li $a2, RED      	# color
#	jal draw_pixel		# calls draw_pixel
	
#	li $a0, 14		# x-coordinate 
#	li $a1, 23		# y-coordinate
#	li $a2, RED      	# color
#	jal draw_pixel		# calls draw_pixel

	li $a0, 14        	# x-coordinate
	li $a1, 48         	# y-coordinate
	li $a3, 5         	# height of rocket
	li $a2, DARK_GREEN     	# rocket color
	jal draw_vertical_line
	
#	jal redraw_rocket
	
#	li $v0, 10		# exits the program safely
#	syscall
	

#	li $v0, 10		# exits the program safely
#	syscall
	
	
#increment_x:
#	addi $a0, $a0, 1
#j end_pixel_move
	
	
#decrement_x:
#	subi $a0, $a0, 1
	
#increment_y:
#	addi $a1, $a1, 1
	
#decrement_y:
#	subi $a1, $a1, 1

end_pixel_move:
	
#draw_rocket:
#	li $a0, 14		# x-coordinate 
#	li $a1, 48		# y-coordinate
#	li $a2, DARK_GREEN      # color
#	jal draw_pixel		# calls draw_pixel
		
redraw_rocket:
	li $a0, 14        	# x-coordinate
	li $a1, 48         	# y-coordinate
	li $a3, 5         	# height of rocket
	li $a2, SHADEDBLUE     	
#	jal draw_rocket
	jal draw_vertical_line
	
#	li $a0, SHADEDBLUE		# this will be a sky blue background
#	jal background_color
	
	li $a0, 20        	# x-coordinate
	li $a1, 48         	# y-coordinate
	li $a3, 5         	# height of rocket
	li $a2, DARK_GREEN     	
#	jal draw_rocket
	jal draw_vertical_line

	
#	li $a0, 18        	# x-coordinate
#	li $a1, 42         	# y-coordinate
#	li $a3, 5         	# height of rocket
#	li $a2, DARK_GREEN     	
#	jal draw_vertical_line
#	jr $ra

	li $v0, 10		# exits the program safely
	syscall

horizontal_rocket1:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 3
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra
	

rightUp_rocket2:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a1 $a1, 2
	addi $a0, $a0, 3
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra
	
diagonalUp_rocket3:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1
	subi $a1, $a1, 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a1 $a1, 3
	addi $a0, $a0, 3
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 1
	subi $a1 $a1, 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra
	
rightUp_rocket4:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	addi $a1, $a1, 1	# down 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a1, $a1, 1	# down 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 2	# right 2
	subi $a1 $a1, 3		# up 3
	jal draw_pixel		# calls draw_pixel
	
	subi $a1 $a1, 1		# up 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra
	
	
vertical_rocket5:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a1 $a1, 3		# down 3
	jal draw_pixel		# calls draw_pixel
	
	addi $a1 $a1, 1		# down 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra
	
	
rightDown_rocket6:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 2	# right 2
	addi $a1 $a1, 3		# down 3
	jal draw_pixel		# calls draw_pixel
	
	addi $a1 $a1, 1		# down 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra
	
diagonalDown_rocket7:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 3	# right 3
	addi $a1 $a1, 3		# down 3
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 1	# right 1
	addi $a1 $a1, 1		# down 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra

rightDown_rocket8:
	li $a2, DARK_GREEN      # color
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel		# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 3	# right 3
	addi $a1 $a1, 2		# down 2
	jal draw_pixel		# calls draw_pixel
	
	addi $a0, $a0, 1	# right 1
	jal draw_pixel		# calls draw_pixel
	
	jr $ra


sleep:
	li $v0, 32
	syscall
	jr $ra
	
# Preconditons:
#	$a0 = color
background_color:
	li $s0, DISPLAY		#setting the $s0 to starting memory
	
	li $s1, WIDTH		#setting the $s1 to the number of pixels
	mul $s1, $s1, HEIGHT
	
	mul $s1, $s1, 4		# Multiplies the size of a word
	
	add $s2, $s0, $s1	# sets $s2 to the last pixel of memory

paintLoop:
	sw $a0, 0($s0)			# Writing the pixel
	addi $s0, $s0, 4		# Moving it to the next address
	blt $s0, $s2, paintLoop	  	# Looping while $s0 is less than $s2
	
	jr $ra				#Return address
	

# Preconditons:
#	$a0 = x
#	$a1 = y
#	$a2 = color
draw_pixel:
	mul $s1, $a1, WIDTH	# the product from (y * WIDTH)
	add $s1, $a0, $s1	# (x + (y * WIDTH))
	mul $s1, $s1, 4		# 4 * (x + (y * WIDTH)), 4 bytes in one word
	
	sw $a2, DISPLAY($s1)
	
	jr $ra
	
#sleep:
#	li $v0, 32
#	syscall
#	jr $ra
			

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
	


draw_pixel_loop:
	sw $a2, 0($s1)        # Store color in memory address
	add $s1, $s1, $t1     # Move to the next row (increment by WIDTH * 4 bytes)
	addi $t0, $t0, 1      # Increment the loop counter
	blt $t0, $a3, draw_pixel_loop # Repeat until all pixels are drawn

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
	sw $a2, 0($s1)         		# Store the color in the current pixel's address
	addi $s1, $s1, 4       		# Move to the next pixel horizontally (4 bytes per pixel)
	addi $t0, $t0, 1       		# Increment loop counter
	blt $t0, $a3, draw_horizontal_loop # Continue drawing until the specified number of pixels

	jr $ra


