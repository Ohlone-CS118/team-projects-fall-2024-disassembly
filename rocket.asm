.include "utilities.asm"

.data

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

.globl redraw_rocket
				
redraw_rocket:
    push($ra)

	li $a0, 14        	# x-coordinate
	li $a1, 48         	# y-coordinate
	li $a3, 5         	# height of rocket
	li $a2, SHADEDBLUE     	
	#jal draw_vertical_line
	
	li $a0, 20        	# x-coordinate
	li $a1, 48         	# y-coordinate
	li $a3, 5         	# height of rocket
	li $a2, DARK_GREEN     	
	#jal draw_vertical_line

    pop($ra)
    jr $ra

horizontal_rocket1:
	li $a2, DARK_GREEN  # color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 3
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra
	

rightUp_rocket2:
	li $a2, DARK_GREEN  # color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a1 $a1, 2
	addi $a0, $a0, 3
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra
	
diagonalUp_rocket3:
	li $a2, DARK_GREEN	# color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1
	subi $a1, $a1, 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a1 $a1, 3
	addi $a0, $a0,3
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 1
	subi $a1 $a1, 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra
	
rightUp_rocket4:
	li $a2, DARK_GREEN	# color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	addi $a1, $a1, 1	# down 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a1, $a1, 1	# down 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 2	# right 2
	subi $a1 $a1, 3	# up 3
	jal draw_pixel	# calls draw_pixel
	
	subi $a1 $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra
	
	
vertical_rocket5:
	li $a2, DARK_GREEN	# color
	jal draw_pixel	# calls draw_pixel
	
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a1 $a1, 3	# down 3
	jal draw_pixel	# calls draw_pixel
	
	addi $a1 $a1, 1	# down 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra
	
	
rightDown_rocket6:
	li $a2, DARK_GREEN  # color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 2	# right 2
	addi $a1 $a1, 3	# down 3
	jal draw_pixel	# calls draw_pixel
	
	addi $a1 $a1, 1	# down 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra
	
diagonalDown_rocket7:
	li $a2, DARK_GREEN  # color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 3	# right 3
	addi $a1, $a1, 3	# down 3
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 1	# right 1
	addi $a1 $a1, 1	# down 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra

rightDown_rocket8:
	li $a2, DARK_GREEN	# color
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	jal draw_pixel	# calls draw_pixel
	
	subi $a0, $a0, 1	# left 1
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 3	# right 3
	addi $a1 $a1, 2	# down 2
	jal draw_pixel	# calls draw_pixel
	
	addi $a0, $a0, 1	# right 1
	jal draw_pixel	# calls draw_pixel
	
	jr $ra