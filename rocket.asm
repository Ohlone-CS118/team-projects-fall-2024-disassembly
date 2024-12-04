.include "utilities.asm"

.text

.globl redraw_rocket
						
redraw_rocket:
	push($t5)
	push($ra)
	la $s0, HEIGHT
	subi $s0, $s0, 1
	sub $t5, $s0, $t5	
	jal rocket5
	pop($ra)
	pop($t5)
	jr $ra

# 0 degrees, 180 degrees
rocket1:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)
	subi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)
	subi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)
	addi $t4, $t4, 3
	draw_pixel($t4, $t5, $a2)
	addi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)
	pop($t5)
	pop($t4)
	jr $ra

# 22.5 degrees
rocket2:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)
	subi $t4, $t4, 1
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)
	subi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t5 $t5, 2
	addi $t4, $t4, 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra

# 45 degrees, 
rocket3:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 3
	subi $t5, $t5, 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 1
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra

# 67.5 degrees	
rocket4:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 2
	subi $t5, $t5, 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra

# 90 degrees	
rocket5:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t5, $t5, 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra

# 112.5 degrees
rocket6:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 2
	addi $t5, $t5, 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra

# 135 degrees
rocket7:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 3	# right 3
	addi $t5, $t5, 3	# down 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 1	# right 1
	addi $t5 $t5, 1	# down 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra
	
# 157.5 degrees
rocket8:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1	# left 1
	subi $t5, $t5, 1	# up 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1	# left 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 3	# right 3
	addi $t5 $t5, 2	# down 2
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 1	# right 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra