
# .globl __resume

# ###############################################################################
# # KERNEL DATA SEGMENT
# ###############################################################################

# .kdata
		
# 	UNHANDLED_EXCEPTION:	.asciiz "===>      Unhandled exception       <===\n\n"
# 	UNHANDLED_INTERRUPT: 	.asciiz "===>      Unhandled interrupt       <===\n\n"
# 	OVERFLOW_EXCEPTION: 	.asciiz "===>      Arithmetic overflow       <===\n\n" 
# 	TRAP_EXCEPTION: 	.asciiz "===>         Trap exception         <===\n\n"
# 	BAD_ADDRESS_EXCEPTION: 	.asciiz "===>   Bad data address exception   <===\n\n"
		
# ###############################################################################
# # KERNEL TEXT SEGMENT 
# # 
# # The kernel handles all exceptions and interrupts.
# # 
# # The registers $k0 and $k1 should never be used by user level programs and 
# # can be used exclusively by the kernel. 
# #
# # In a real system the kernel must make sure not to alter any registers
# # in usr by any of the user level programs. For all such registers, the kernel
# # must make sure to save the register valued to memory before use. Later, before 
# # resuming execution of a user level program the kernel must restore the 
# # register values from memory. 
# # 
# # Note, that if the kernel uses any pseudo instruction that translates 
# # to instructions using $at, this may interfere with  user level programs 
# # using $at. In a real system, the kernel must  also save and restore the 
# # value of $at. 
# # 
# # For simplicity, this kernel will not save and retore any register values. 
# # Instead, the kernel can freely use any registers but $s0 which is used 
# # in the user program infinite loop to simulate an executing program.  
# ###############################################################################

# # The exception vector address for MIPS32.
# .ktext 0x80000180  
   
# __kernel_entry_point:

# 	mfc0 $k0, $13		# Get value in cause register.

# 	andi $k1, $k0, 0x00007c	# Mask all but the exception code (bits 2 - 6) to zero.
	
	
	
# 	srl  $k1, $k1, 2	# Shift two bits to the right to get the exception code. 
	
# 	# Now $k0 = value of cause register
# 	#     $k1 = exception code 
	
# 	# The exception code is zero for an interrupt and none zero for all exceptions. 
	
# 	beqz $k1, __interrupt 	# branch is interrupt
	
# __exception:

# 	# Branch on value of the the exception code in $k1. 
	
# 	beq $k1, 12, __overflow_exception	# branch is overflow code 12
	
# 	beq $k1, 4, __bad_address_exception 	#branch to label __bad_address_exception for exception code 4. 	
	
# 	beq $k1, 13, __trap_exception 	#branch to label __trap_exception for exception code 13. 
	
# __unhandled_exception: 
    	
# 	li $v0, 4		# Print the unhandled exception notice
# 	la $a0, UNHANDLED_EXCEPTION
# 	syscall
 
#  	j __resume_from_exception
	
# __overflow_exception:
	
# 	li $v0, 4		# Print the overflow exception notice
# 	la $a0, OVERFLOW_EXCEPTION
# 	syscall
 
#  	j __resume_from_exception
 	
#  __bad_address_exception:
	
# 	li $v0, 4		# Print the bad address exception notice
# 	la $a0, BAD_ADDRESS_EXCEPTION
# 	syscall
 
#  	j __resume_from_exception	
 
# __trap_exception: 
	
# 	li $v0, 4		# Print the bad trap notice
# 	la $a0, TRAP_EXCEPTION
# 	syscall
 
#  	j __resume_from_exception

# __interrupt: 

# 	# Value of cause register should already be in $k0. 
    	
#     	andi $k1, $k0, 0x00000100	# Mask all but bit 8 (interrupt pending) to zero. 
    	
#     	# Shift 8 bits to the right to get the inerrupt pending bit as the 
#     	# least significant bit. 
#     	srl  $k1, $k1, 8
    	
#     	beq  $k1, 1, __keyboard_interrupt	# Branch on the interrupt pedning bit. 

# __unhandled_interrupt: 
   
#   	#  Use the MARS built-in system call 4 (print string) to print error messsage.
	
# 	li $v0, 4		# Print the unhandled Interupt notice
# 	la $a0, UNHANDLED_INTERRUPT
# 	syscall
 
#  	j __resume

# __keyboard_interrupt:     	
	
# 	# Get ASCII value of pressed key from the memory mapped receiver data register. 

# 	lw $k1, 0xffff0004  # Store content of the memory mapped receiver data register in $k1.

# 	# Use the MARS built-in system call 11 (print char) to print the character
# 	# from receiver data.

# 	# beq $t0, $k1, holdCounter	# if key pressed is the same as previous key pressed

# 	# li $s2, 1 # reset hold counter to 1

# 	# j notHolding	

# 	# holdCounter:
# 	# addi $s2, $s2, 1		# hold counter++

# 	# notHolding:
# 	# move $t0, $k1	# save current character to next comparison
	
# 	li $v0, 11 		# print the character entered 
# 	move $a0, $k1 
# 	syscall       


# beq $k1, '1', level_one
# beq $k1, '0', exit

# beq $k1, 'w', wInput
# beq $k1, 'a', aInput
# beq $k1, 's', sInput
# beq $k1, 'd', dInput
    
# # # example for holding detection
# # beq $k1, '2', pressed2 # if key 2 is being pressed

# # pressed2:
# # bge $s2, $s3, held2 # if key 2 is being held
# # #pressed2 content


# # held2:
# # #held2 content

# # ###

# #wInput:
# #addi $t1, $t1, 10
# #j __resume

# #aInput:
# #l.s $f30, radianoffset
# #add.s $f16, $f16, $f30
# #j __resume

# #sInput:
# #ble $t1, $zero, sInputSkip
# #subi $t1, $t1, 10
# #sInputSkip:
# #j __resume

# #dInput:
# #l.s $f30, radianoffset
# #sub.s $f16, $f16, $f30
# #j __resume

# j __resume
	

# __resume_from_exception: 
	
# 	# When an exception or interrupt occurs, the value of the program counter 
# 	# ($pc) of the user level program is automatically stored in the exception 
# 	# program counter (ECP), the $14 in Coprocessor 0. 

#         # Get value of EPC (Address of instruction causing the exception).
       
#         mfc0 $k0, $14
        
#         # Skip offending instruction by adding 4 to the value stored in EPC. 
#         # Otherwise the same instruction would be executed again causing the same 
#         # exception again.
        
#         addi $k0, $k0, 4 	# Skip offending instruction by adding 4 to the value stored in EPC.     
        
#         mtc0 $k0, $14		# Update EPC in coprocessor 0.
        
# __resume:
            
# 	# Use the eret (Exception RETurn) instruction to set the program counter
# 	# (PC) to the value saved in the ECP register (register 14 in coporcessor 0).
	
# 	eret # Look at the value of $14 in Coprocessor 0 before single stepping.

