# Main Program File

.include "utilities.asm"

.data

angle: .float 1.5708    # 90 degrees in radians
millisecond: .float 1000

welcome_message: .asciiz "Welcome to our program! Insert information here. "
welcome_prompt: .asciiz "\n\nWould you like to participate? Press 1 to continue, 0 to exit: "
retry_prompt: .asciiz "\n\nWould you like to retry? Type Y or N for your response: "
exit_message: .asciiz "\n\nExiting program..."
level_one_message: .asciiz "\nLevel 1: \n\n"
fail_message: .asciiz "\nLevel Failed\n"
success_message: .asciiz "\nLevel Complete\n"

.text

.globl main

main:
keyboard:
    # li $s0, 0x7fffffff  	# The largest 32 bit positive two's complement number.
       	
	# addi $s1, $s0, 1 	# Trigger an arithmetic overflow exception. 
	
	# lw $s0, 0($zero)	# Trigger a bad data address (on load) exception.
	
	# teqi $zero, 0 		# Trigger a trap exception. 


	# Enable keyboard interrupts. 

	move $s2, $zero # set hold counter to 0
	li $s3, 4	# predefined length to be counted as holding
	
	
  	
  	lw $s0, 0xffff0000 # Get value of the memory mapped receiver control register.		

	# Set bit 1 (interrupt enable) in receiver control to 1.
	
	# Bits are numbered from 0 to 31 with 0 beeing the least significant bit.
	# Use the bitmask 0x2 = [bin] = 0000 ..... 0010
	# Use the ori (bitwise or immediate) instruction and store result in $s1.
	
        ori $s1, $s1, 0x2 
 	
        sw $s1, 0xffff0000	# Update the memory mapped receiver control register.
        
        # NOTE: If you use Mars, the status register is set to 0x0000ff11 on
        # start-up, i.e., the interrupt enable bit (bit 0) is alredy set and
        # all interrupt mask bits (bits 8-15) are set to 1.
          
        # NOTE: If you use Spim, the status register is set to 0x3000ff10 on
        # start-up, .e., the interrupt enable (bit 0) is not set but all 
        # interrupt mask bits (bits 8-15) are set. You must manually     
        # enable interrupts by setting the interruptenable bit in the status
        # register to 1. 
	
	
infinite_loop: 
	
	# This infinite loop simulates the CPU doing something useful such as
	# executing another job while waiting for user keyboard inut. 
	
	addi $s0, $s0, 1
	j infinite_loop


###############################################################################
# KERNEL DATA SEGMENT
###############################################################################

.kdata
		
	UNHANDLED_EXCEPTION:	.asciiz "===>      Unhandled exception       <===\n\n"
	UNHANDLED_INTERRUPT: 	.asciiz "===>      Unhandled interrupt       <===\n\n"
	OVERFLOW_EXCEPTION: 	.asciiz "===>      Arithmetic overflow       <===\n\n" 
	TRAP_EXCEPTION: 	.asciiz "===>         Trap exception         <===\n\n"
	BAD_ADDRESS_EXCEPTION: 	.asciiz "===>   Bad data address exception   <===\n\n"
		
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
    	
    	# Shift 8 bits to the right to get the inerrupt pending bit as the 
    	# least significant bit. 
    	srl  $k1, $k1, 8
    	
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

	beq $t0, $k1, holdCounter	# if key pressed is the same as previous key pressed

	li $s2, 1 # reset hold counter to 1

	j notHolding	

	holdCounter:
	addi $s2, $s2, 1		# hold counter++

	notHolding:
	move $t0, $k1	# save current character to next comparison
	
	li $v0, 11 		# print the character entered 
	move $a0, $k1 
	syscall       


beq $k1, '1', level_one
beq $k1, '0', exit

    
# example for holding detection
beq $k1, '2', pressed2 # if key 2 is being pressed

pressed2:
bge $s2, $s3, held2 # if key 2 is being held
#pressed2 content


held2:
#held2 content

###
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
        
        mtc0 $k0, $14		# Update EPC in coprocessor 0.
        
__resume:
            
	# Use the eret (Exception RETurn) instruction to set the program counter
	# (PC) to the value saved in the ECP register (register 14 in coporcessor 0).
	
	eret # Look at the value of $14 in Coprocessor 0 before single stepping.

li $v0, 4
la $a0, welcome_message
syscall

la $a0, welcome_prompt
syscall

# loop to check if user entered Y, N, enter
level_one_prompt_loop:

j level_one_prompt_loop


# LEVEL 1
level_one:
li $v0, 4
la $a0, level_one_message
syscall


	l.s $f0, angle # Load angle into $f0
	li $t1, 500       # Load thrust into $t1
	li $t2, 50         # Load mass into $t2

	li $t4, 10	# starting coords
	li $t5, 5

level_one_loop:

	# draw rocket
	li $a2, DARK_GREEN
	jal redraw_rocket
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
	
	
	li $a2, DARK_GREEN
	jal redraw_rocket # draw rocket at new coodinates

# error collision
    #if out of bounds collision, end loop, level failed
    #if incorrect building collision, end loop, level failed
    #if correct building collision, end loop, level succeeded

j level_one_loop

exit:

li $v0, 10      #exit safely
syscall