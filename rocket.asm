.include "utilities.asm"

.text

.globl redraw_rocket
						
redraw_rocket:
	push($ra)	
	jal rocket1
	pop($ra)
	jr $ra

# 0 degrees, 180 degrees
rocket1:
	push($a0)
	push($a1)
	draw_pixel($a0, $a1, $a2)
	subi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)
	subi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)
	addi $a0, $a0, 3
	draw_pixel($a0, $a1, $a2)
	addi $a0, $a0, 1
	draw_pixel($a0, $a1, $a2)
	pop($a1)
	pop($a0)
	jr $ra

# 22.5 degrees
rocket2:
	push($a0)
	push($a1)
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
	pop($a1)
	pop($a0)
	jr $ra

# 45 degrees, 
rocket3:
	push($a0)
	push($a1)
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 3
	subi $a1, $a1, 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 1
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	pop($a1)
	pop($a0)
	jr $ra

# 67.5 degrees	
rocket4:
	push($a0)
	push($a1)
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 2
	subi $a1, $a1, 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	pop($a1)
	pop($a0)
	jr $ra

# 90 degrees	
rocket5:
	push($a0)
	push($a1)
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1, $a1, 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	pop($a1)
	pop($a0)
	jr $ra

# 112.5 degrees
rocket6:
	push($a0)
	push($a1)
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 2
	addi $a1, $a1, 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	pop($a1)
	pop($a0)
	jr $ra

# 135 degrees
rocket7:
	push($a0)
	push($a1)
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	subi $a0, $a0, 1
	subi $a1, $a1, 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 3	# right 3
	addi $a1, $a1, 3	# down 3
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	addi $a0, $a0, 1	# right 1
	addi $a1 $a1, 1	# down 1
	draw_pixel($a0, $a1, $a2)	# calls draw_pixel
	pop($a1)
	pop($a0)
	jr $ra
	
# 157.5 degrees
rocket8:
	push($a0)
	push($a1)
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
	pop($a1)
	pop($a0)
	jr $ra