# Main Program File

.include "utilities.asm"

.data
keyboard_input: .word 0    # Address for keyboard input (MMIO location)
radianoffset: .float 0.392699 #22.5 degrees
angle: .float 1.5708    # 90 degrees in radians
millisecond: .float 1000

welcome_message: .asciiz "Welcome to our program! Insert information here. "
welcome_prompt: .asciiz "\n\nWould you like to participate? Press 1 to continue, 0 to exit: "
#retry_prompt: .asciiz "\n\nWould you like to retry? Type Y or N for your response: "
#exit_message: .asciiz "\n\nExiting program..."
level_one_message: .asciiz "\nLevel 1: \n\n"
fail_message: .asciiz "\nLevel Failed\n"
#success_message: .asciiz "\nLevel Complete\n"

.text

.globl main

main:

.globl level_one
.globl exit
.globl wInput
.globl aInput
.globl sInput
.globl dInput

	move $s2, $zero # set hold counter to 0
	li $s3, 4	# predefined length to be counted as holding

  	lw $s0, 0xffff0000 # Get value of the memory mapped receiver control register.		

	# Set bit 1 (interrupt enable) in receiver control to 1.
	
	# Bits are numbered from 0 to 31 with 0 beeing the least significant bit.
	# Use the bitmask 0x2 = [bin] = 0000 ..... 0010
	# Use the ori (bitwise or immediate) instruction and store result in $s1.
	
	ori $s1, $s1, 0x2 
	
	sw $s1, 0xffff0000	# Update the memory mapped receiver control register.


	li $v0, 4
	la $a0, welcome_message
	syscall

	la $a0, welcome_prompt
	syscall

# loop to check if user entered Y, N, enter
level_one_prompt_loop:
# waiting for input
	j level_one_prompt_loop


# LEVEL 1
level_one:
	li $v0, 4
	la $a0, level_one_message
	syscall

#jal background

	l.s $f0, angle # Load angle into $f0
	li $t1, 400       # Load starting thrust into $t1
	li $t2, 50         # Load mass into $t2

	li $t4, 10	# starting coords
	li $t5, 5
	
	# draw rocket
	li $a2, DARK_GREEN
	jal redraw_rocket

level_one_loop:
	# calculate
	jal rocketMath
	
	# wait
	l.s $f17, millisecond	# load 1000 as multiplier into $f17
	mul.s $f16, $f16, $f17 # multiply time by 1000 (to count milliseconds)
	cvt.w.s $f16, $f16	# convert to word
	push($a0) # store $a0 temporarily
	mfc1 $a0, $f16 # move converted time to $a0
	li $v0, 32 # set syscall to sleep based on time in milliseconds in $a0
	syscall
	pop($a0) # restore $a0

	li $a2, SHADEDBLUE	# erase rocket at old position
	jal redraw_rocket

	move $t4, $t6 # set $t4 to $t6 (set x coord to new x)
	move $t5, $t7 # set $t5 to $t7 (set y coord to new y)
	
	# error collision
	#if out of bounds collision, end loop, level failed
	blt $t5, 1, out_of_bounds
	bgt $t5, 32, out_of_bounds
	blt $t4, 0, out_of_bounds
	bgt $t4, 63, out_of_bounds
	
	#if incorrect building collision, end loop, level failed
    	#if correct building collision, end loop, level succeeded
	
	
	li $a2, DARK_GREEN
	jal redraw_rocket # draw rocket at new coodinates  

	j level_one_loop

out_of_bounds:
	li $v0, 4
	la $a0, fail_message
	syscall

exit:
	li $v0, 10      #exit safely
	syscall

wInput:
li $t1, 200
li $v0, 4
la $a0, fail_message
syscall

addi $t1, $t1, 10
eret

aInput:
l.s $f30, radianoffset
add.s $f16, $f16, $f30
eret

sInput:
ble $t1, $zero, sInputSkip
subi $t1, $t1, 10
sInputSkip:
eret

dInput:
l.s $f30, radianoffset
sub.s $f16, $f16, $f30
eret