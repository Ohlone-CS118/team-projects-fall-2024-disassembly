# Main Program File

# BITMAP DISPLAY RECOMMENDED SETTINGS
# Unit Width in Pixels: 8
# Unit Height in Pixels: 8
# Display Width in Pixels: 512
# Display Height in Pixels: 512
# Base address for display: 0x10040000 (heap)

.include "utilities.asm"

.data
	# messages
	welcome_message: .asciiz "Welcome to our program! Insert information here. "
	welcome_prompt: .asciiz "\n\nWould you like to participate? Type 1 for yes or 0 for no: "
	retry_prompt: .asciiz "\n\nWould you like to retry? Type 1 for yes or 0 for no: "
	exit_message: .asciiz "\n\nExiting program..."
	error_message: .asciiz "\n\nExiting due to errors..."
	level_one_message: .asciiz "\nLevel 1: \n\n"
	fail_message: .asciiz "\nLevel Failed\n"
	success_message: .asciiz "\nLevel Complete\n"
	msg_Xf: .asciiz "\nNext X: "
	msg_Yf: .asciiz "  Next Y: "
	msg_t:  .asciiz "  Time to next pixel: "
	msg_angle:  .asciiz "  Angle: "

.text

.globl main

main:
	# set up keyboard input detection through interrupts
	# set hold counter to 0
	move $s2, $zero
	# predefined length to be counted as holding
	li $s3, 4
	# Get value of the memory mapped receiver control register
  	lw $s0, 0xffff0000		
	# Set bit 1 (interrupt enable) in receiver control to 1.
	# Bits are numbered from 0 to 31 with 0 beeing the least significant bit.
	# Use the bitmask 0x2 = [bin] = 0000 ..... 0010
	# Use the ori (bitwise or immediate) instruction and store result in $s1.
	ori $s1, $s1, 0x2
	# Update the memory mapped receiver control register
	sw $s1, 0xffff0000


	# print welcome message and prompt
	li $v0, 4
	la $a0, welcome_message
	syscall
	la $a0, welcome_prompt
	syscall

# loop to check if user entered Y, N, enter
level_one_prompt_loop:
	# waiting for keyboard interrupt
	# if $a0 is set to respective value from interrupt, jump to location
	beq $a0, 1, level_one
	beq $a0, 2, exit
	j level_one_prompt_loop

# LEVEL 1
level_one:
	# print entrance message
	li $v0, 4
	la $a0, level_one_message
	syscall

	# draw background
	jal background
	
	# load starting rocket conditions
	l.s newangle, start_angle
	li newT, 520
	li M, 50
	
	# reset accumulating registers
	l.s eVx, flt_zero
	l.s eVy, flt_zero
	l.s px, flt_zero
	l.s py, flt_zero
	l.s Vx, flt_zero
	l.s Vy, flt_zero
	
	# set starting coords
	li xi, 10	
	li yi, 5
	
	# draw rocket
	mov.s drawangle, newangle
	li $a2, DARK_GREEN
	jal redraw_rocket

level_one_loop:
	# update input
	mov.s angle, newangle
	move T, newT
	
	# calculate
	jal rocketMath
	
	# print new data
	jal print_status
	
	# wait
	l.s $f17, millisecond	# load 1000 as multiplier into $f17
	mul.s dt, dt, $f17		# multiply time by 1000 (to count milliseconds)
	cvt.w.s dt, dt		# convert to word
	push($a0)			# store $a0 temporarily
	mfc1 $a0, dt		# move converted time to $a0
	blt $a0, 1000, dont_limit_time # if time is not more than 1 second
	li $a0, 1000		# if it is, set it to 1 second to avoid waiting
	dont_limit_time:
	li $v0, 32		# set syscall to sleep based on time in milliseconds in $a0
	syscall
	pop($a0)			# restore $a0

	# erase rocket at old position
	li $a2, SHADEDBLUE
	jal redraw_rocket

	move xi, xf # set x coord to new x coord
	move yi, yf # set y coord to new y coord
	
	# error collision
	#if out of bounds collision, end loop, level failed
	blt yi, 1, out_of_bounds
	bgt yi, 63, out_of_bounds
	blt xi, 0, out_of_bounds
	bgt xi, 63, out_of_bounds
	
	# WIP
	#if incorrect building collision, end loop, level failed
    	#if correct building collision, end loop, level succeeded
    	
	# estimate rocket angle
	#jal angle_aprox
	
	# draw rocket at new coodinates
	mov.s drawangle, angle
	li $a2, DARK_GREEN
	jal redraw_rocket  
	
	j level_one_loop

out_of_bounds:
	# display level failed message and retry prompt
	li $v0, 4
	la $a0, fail_message
	syscall
	la $a0, retry_prompt
	syscall
	
# loop to check if user entered Y, N, enter
retry_prompt_loop:
	# waiting for keyboard interrupt
	# if $a0 is set to respective value from interrupt, jump to location
	beq $a0, 1, level_one
	beq $a0, 2, exit
	j retry_prompt_loop

exit:
	# print exit message, exit safely
	li $v0, 4
	la $a0, exit_message
	syscall
	li $v0, 10
	syscall
	
# subroutine to print rocket data for next position
print_status:
	pushfloat($f6)
	pushfloat($f12)
	
	# Print results
	li $v0, 4		# Print string syscall
	la $a0, msg_Xf	# Message: "Final X: "
	syscall
	li $v0, 1		# Print integer syscall
	move $a0, xf	# Load final X
	syscall
	li $v0, 4		# Print string syscall
	la $a0, msg_Yf	# Message: "Final Y: "
	syscall
	li $v0, 1		# Print integer syscall
	move $a0, yf	# Load final Y
	syscall
	li $v0, 4		# Print string syscall
	la $a0, msg_t	# Message: "Time to next pixel: "
	syscall
	li $v0, 2		# Print float syscall
	mov.s $f12, dt	# Load time to next pixel
	syscall
	li $v0, 4		# Print string syscall
	la $a0, msg_angle	# Message: "Angle: "
	syscall
	li $v0, 2		# Print float syscall
	mov.s $f12, angle	# Load angle
	# convert angle to degrees from radians (angle * 180/pi)
	l.s $f6, flt_hundredeighty
	mul.s $f12, $f12, $f6 
	l.s $f6, pi
	div.s $f12, $f12, $f6
	syscall
	
	popfloat($f12)
	popfloat($f6)
	jr $ra
	

###############################################################################
# KERNEL DATA SEGMENT
###############################################################################

.kdata
		
	UNHANDLED_EXCEPTION:	.asciiz "\n===>      Unhandled exception       <===\n"
	UNHANDLED_INTERRUPT:	.asciiz "\n===>      Unhandled interrupt       <===\n"
	OVERFLOW_EXCEPTION:		.asciiz "\n===>      Arithmetic overflow       <===\n" 
	TRAP_EXCEPTION:		.asciiz "\n===>         Trap exception         <===\n"
	BAD_ADDRESS_EXCEPTION:	.asciiz "\n===>   Bad data address exception   <===\n"
		
###############################################################################
# KERNEL TEXT SEGMENT 
# 
# The kernel handles all exceptions and interrupts.
# 
# The registers $k0 and $k1 should never be used by user level programs and 
# can be used exclusively by the kernel. 
#
# In a real system the kernel must make sure not to alter any registers
# in usr by any of the user level programs. For all such registers, the kernel
# must make sure to save the register valued to memory before use. Later, before 
# resuming execution of a user level program the kernel must restore the 
# register values from memory. 
# 
# Note, that if the kernel uses any pseudo instruction that translates 
# to instructions using $at, this may interfere with  user level programs 
# using $at. In a real system, the kernel must  also save and restore the 
# value of $at. 
# 
# For simplicity, this kernel will not save and retore any register values. 
# Instead, the kernel can freely use any registers but $s0 which is used 
# in the user program infinite loop to simulate an executing program.  
###############################################################################

# The exception vector address for MIPS32.
.ktext 0x80000180  
   
__kernel_entry_point:
	move $s7, $1	# SAVE $at TEMPORARILY
	mfc0 $k0, $13		# Get value in cause register.
	andi $k1, $k0, 0x00007c	# Mask all but the exception code (bits 2 - 6) to zero.
	srl  $k1, $k1, 2	# Shift two bits to the right to get the exception code. 
	# Now $k0 = value of cause register
	#     $k1 = exception code 
	# The exception code is zero for an interrupt and none zero for all exceptions. 
	beqz $k1, __interrupt 	# branch is interrupt
	
__exception:
	# Branch on value of the the exception code in $k1. 
	beq $k1, 12, __overflow_exception	# branch is overflow code 12
	beq $k1, 4, __bad_address_exception 	#branch to label __bad_address_exception for exception code 4. 	
	beq $k1, 13, __trap_exception 	#branch to label __trap_exception for exception code 13. 
	
__unhandled_exception: 	
	li $v0, 4		# Print the unhandled exception notice
	la $a0, UNHANDLED_EXCEPTION
	syscall
 	j __resume_from_exception
	
__overflow_exception:
	li $v0, 4		# Print the overflow exception notice
	la $a0, OVERFLOW_EXCEPTION
	syscall
 	j __resume_from_exception
 	
 __bad_address_exception:
	li $v0, 4		# Print the bad address exception notice
	la $a0, BAD_ADDRESS_EXCEPTION
	syscall
 	j __resume_from_exception	
 
__trap_exception: 
	li $v0, 4		# Print the bad trap notice
	la $a0, TRAP_EXCEPTION
	syscall
 	j __resume_from_exception

__interrupt: 
	# Value of cause register should already be in $k0. 
    	andi $k1, $k0, 0x00000100	# Mask all but bit 8 (interrupt pending) to zero. 
    	srl  $k1, $k1, 8	# Shift 8 bits to the right to get the inerrupt pending bit as the least significant bit.
    	beq  $k1, 1, __keyboard_interrupt	# Branch on the interrupt pedning bit. 

__unhandled_interrupt: 
  	#  Use the MARS built-in system call 4 (print string) to print error messsage.
	li $v0, 4		# Print the unhandled Interupt notice
	la $a0, UNHANDLED_INTERRUPT
	syscall
 	j __resume

__keyboard_interrupt:     	
	
	# Get ASCII value of pressed key from the memory mapped receiver data register. 
	lw $k1, 0xffff0004  # Store content of the memory mapped receiver data register in $k1.
	# Use the MARS built-in system call 11 (print char) to print the character
	# from receiver data.
	#beq $t0, $k1, holdCounter	# if key pressed is the same as previous key pressed
	#li $s2, 1 # reset hold counter to 1
	#j notHolding	
#holdCounter:
	#addi $s2, $s2, 1		# hold counter++

#notHolding:
	#move $t0, $k1	# save current character to next comparison
	
	#li $v0, 11 		# print the character entered 
	#move $a0, $k1 
	#syscall       

	beq $k1, '1', yes
	beq $k1, '0', no
	beq $k1, 'w', wInput
	beq $k1, 'a', aInput
	beq $k1, 's', sInput
	beq $k1, 'd', dInput
	
	# example for holding detection
	#beq $k1, '2', pressed2 # if key 2 is being pressed

#pressed2:
	#bge $s2, $s3, held2 # if key 2 is being held
	#pressed2 content

#held2:
	#held2 content

yes:
	li $v0, 11	# print the character entered 
	move $a0, $k1 
	syscall
	li $a0, 1
	j __resume
no:
	li $v0, 11	# print the character entered 
	move $a0, $k1 
	syscall
	li $a0, 2
	j __resume

wInput:
	addi newT, newT, 50
	j __resume

aInput:
	l.s $f30, radianoffset
	add.s newangle, newangle, $f30
	j __resume

sInput:
	ble $t1, $zero, sInputSkip
	subi newT, newT, 50
sInputSkip:
	j __resume

dInput:
	l.s $f30, radianoffset
	sub.s newangle, newangle, $f30
	j __resume

__resume_from_exception: 
	# When an exception or interrupt occurs, the value of the program counter 
	# ($pc) of the user level program is automatically stored in the exception 
	# program counter (ECP), the $14 in Coprocessor 0.
	
	# Get value of EPC (Address of instruction causing the exception).
	mfc0 $k0, $14
	
	# Skip offending instruction by adding 4 to the value stored in EPC.
	# Otherwise the same instruction would be executed again causing the same
	# exception again.
	
	addi $k0, $k0, 4 	# Skip offending instruction by adding 4 to the value stored in EPC.     
	
	# Update EPC in coprocessor 0.
	mtc0 $k0, $14
	
	li $v0, 4
	la $a0, error_message
	syscall
	li $v0, 10
	syscall

__resume:
	# Use the eret (Exception RETurn) instruction to set the program counter
	# (PC) to the value saved in the ECP register (register 14 in coporcessor 0).
	move $1, $s7 	# RESTORE $at
	eret # Look at the value of $14 in Coprocessor 0 before single stepping.
