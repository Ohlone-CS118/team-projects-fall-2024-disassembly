.include "utilities.asm"

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
	draw_pixel($a0, $a1, $a2)
	subi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)
	subi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)
	addi $a0, $a0, 3
	draw_pixel($a0, $a1, $a2)
	addi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)
	jr $ra
	

rightUp_rocket2:
	li $a2, DARK_GREEN  # color
	draw_pixel($a0, $a1, $a2)
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)
	subi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1 $a1, 2
	addi $a0, $a0, 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra
	
diagonalUp_rocket3:
	li $a2, DARK_GREEN	# color
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1 $a1, 3
	addi $a0, $a0,3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 1
	subi $a1 $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra
	
rightUp_rocket4:
	li $a2, DARK_GREEN	# color
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1	# left 1
	addi $a1, $a1, 1	# down 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1, $a1, 1	# down 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 2	# right 2
	subi $a1 $a1, 3	# up 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1 $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra
	
vertical_rocket5:
	li $a2, DARK_GREEN	# color
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1 $a1, 3	# down 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1 $a1, 1	# down 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra
	
rightDown_rocket6:
	li $a2, DARK_GREEN  # color
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 2	# right 2
	addi $a1 $a1, 3	# down 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1 $a1, 1	# down 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra
	
diagonalDown_rocket7:
	li $a2, DARK_GREEN  # color
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 3	# right 3
	addi $a1, $a1, 3	# down 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 1	# right 1
	addi $a1 $a1, 1	# down 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra

rightDown_rocket8:
	li $a2, DARK_GREEN	# color
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1	# left 1
	subi $a1, $a1, 1	# up 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1	# left 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 3	# right 3
	addi $a1 $a1, 2	# down 2
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 1	# right 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	jr $ra