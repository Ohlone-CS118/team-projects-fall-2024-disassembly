.include "utilities.asm"

.data
	cutoff: .float  0.2617994

.text

.globl angle_aprox
.globl redraw_rocket

angle_aprox:
	pushfloat($f2)
	pushfloat($f3)
	pushfloat($f25)
	l.s $f25, flt_zero
	#c.eq.s Vx, $f25
	
	bc1f special_case_skip
	special_case_skip:
	div.s $f25, Vy, Vx
	# Step 2: Compute second term (-x^3/3)
	mul.s $f2, $f25, $f25	# f2 = x^2
	mul.s $f2, $f2, $f25	# f2 = x^3
	l.s $f3, flt_three		# f3 = 3.0
	div.s $f2, $f2, $f3		# f2 = x^3/3
	mov.s drawangle, $f25	# f23 = x
	sub.s drawangle, drawangle, $f2 # f23 = x - x^3/3
	# Step 3: Compute third term (+x^5/5)
	mul.s $f2, $f25, $f25	# f2 = x^2
	mul.s $f2, $f2, $f25	# f2 = x^3
	mul.s $f2, $f2, $f25	# f2 = x^4
	mul.s $f2, $f2, $f25	# f2 = x^5
	l.s $f3, flt_five		# f3 = 5.0
	div.s $f2, $f2, $f3		# f2 = x^5/5
	add.s drawangle drawangle, $f2 # f23 = x - x^3/3 + x^5/5
	# Step 3: Compute third term (-x^7/7)
	mul.s $f2, $f25, $f25	# f2 = x^2
	mul.s $f2, $f2, $f25	# f2 = x^3
	mul.s $f2, $f2, $f25	# f2 = x^4
	mul.s $f2, $f2, $f25	# f2 = x^5
	mul.s $f2, $f2, $f25	# f2 = x^6
	mul.s $f2, $f2, $f25	# f2 = x^7
	l.s $f3, flt_seven		# f3 = 7.0
	div.s $f2, $f2, $f3		# f2 = x^7/7
	sub.s drawangle, drawangle, $f2 # f23 = x - x^3/3 + x^5/5 - x^7/7
	# Step 3: Compute third term (+x^9/9)
	mul.s $f2, $f25, $f25	# f2 = x^2
	mul.s $f2, $f2, $f25	# f2 = x^3
	mul.s $f2, $f2, $f25	# f2 = x^4
	mul.s $f2, $f2, $f25	# f2 = x^5
	mul.s $f2, $f2, $f25	# f2 = x^6
	mul.s $f2, $f2, $f25	# f2 = x^7
	mul.s $f2, $f2, $f25	# f2 = x^8
	mul.s $f2, $f2, $f25	# f2 = x^9
	l.s $f3, flt_nine		# f3 = 9.0
	div.s $f2, $f2, $f3		# f2 = x^9/9
	add.s drawangle, drawangle, $f2 # f23 = x - x^3/3 + x^5/5 - x^7/7 + x^9/9
	
	l.s $f2, flt_zero
	c.le.s Vx, $f2
	#bc1t 2nd_3rd
	#j skip
	c.le.s Vy, $f2
	#bc1t 3rd_4th
	
	popfloat($f25)
	popfloat($f3)
	popfloat($f2)	
	jr $ra
																
redraw_rocket:
	push($t5)
	pushfloat($f6)
	push($ra)
	
	la $s0, HEIGHT
	subi $s0, $s0, 1
	sub $t5, $s0, $t5	
	
	l.s $f6, pi
	c.le.s drawangle, $f6
	bc1t correct_angle
	sub.s drawangle, drawangle, $f6
	
	correct_angle:
	
	l.s $f29, cutoff
	l.s $f28, cutoff
	c.le.s drawangle, $f29
	bc1t rocket_1
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_2
	add.s $f29, $f29, $f28
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_3
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_4
	add.s $f29, $f29, $f28
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	c.le.s drawangle, $f29
	bc1t rocket_5
	add.s $f29, $f29, $f28
	c.le.s drawangle, $f29
	bc1t rocket_6
	add.s $f29, $f29, $f28
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
