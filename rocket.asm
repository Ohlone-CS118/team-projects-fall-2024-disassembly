# Implemented by Anthony Ryabov and Zahid Khan

.include "utilities.asm"

.data
	cutoff: .float  0.19634954

.text

.globl redraw_rocket
														
redraw_rocket:
	push($t5)
	pushfloat($f2)
	pushfloat($f3)
	pushfloat($f6)
	push($ra)
	
	# adjust y coordinate with respect to rules of the display
	la $s0, HEIGHT
	subi $s0, $s0, 1
	sub $t5, $s0, $t5	
	
redraw_loop:
	l.s $f29, pi
	
	# if drawangle is less than 180, skip
	c.le.s drawangle, $f29
	bc1t corrected_angle_1
	
	# if not, subtract by 180 until it is less
	sub.s drawangle, drawangle, $f29
	j redraw_loop
corrected_angle_1:
	l.s $f29, flt_zero
	
	# if draw angle is not negative, skip
	c.le.s $f29, drawangle
	bc1t corrected_angle_2
	
	# if it is, take abs value then subtract from pi
	abs.s drawangle, drawangle
	l.s $f29, pi
	sub.s drawangle, $f29, drawangle
	j redraw_loop
corrected_angle_2:
	# repeatedly increase an fpu register by 11.25 degrees
	# check if angle is less than new interval, indicating which rocket frame to draw
	l.s $f29, cutoff
	l.s $f28, cutoff
	add.s $f28, $f28, $f28
	c.le.s drawangle, $f29
	bc1t rocket_1
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_2
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_3
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_4
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_5
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_6
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_7
	j rocket_8
	rocket_1:
	jal rocket1
	j rocket_end
	rocket_2:
	jal rocket2
	j rocket_end
	rocket_3:
	jal rocket3
	j rocket_end
	rocket_4:
	jal rocket4
	j rocket_end
	rocket_5:
	jal rocket5
	j rocket_end
	rocket_6:
	jal rocket6
	j rocket_end
	rocket_7:
	jal rocket7
	j rocket_end
	rocket_8:
	jal rocket8
	j rocket_end
rocket_end:
	pop($ra)
	popfloat($f6)
	popfloat($f3)
	popfloat($f2)
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

# 22.5 degrees, 202.5 degrees
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

# 45 degrees, 225 degrees
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

# 67.5 degrees, 247.5 degrees
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

# 90 degrees, 270 degrees
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

# 112.5 degrees, 292.5 degrees
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

# 135 degrees, 315 degrees
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
	addi $t4, $t4, 3
	addi $t5, $t5, 3
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 1
	addi $t5 $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra
	
# 157.5 degrees, 337 degrees
rocket8:
	push($t4)
	push($t5)
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	subi $t5, $t5, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	subi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 3
	addi $t5 $t5, 2
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	addi $t4, $t4, 1
	draw_pixel($t4, $t5, $a2)	# calls draw_pixel
	pop($t5)
	pop($t4)
	jr $ra
