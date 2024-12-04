# Main Program File

.data

# strings temporarily stored here

welcome_message: .asciiz "Welcome to our program! Insert information here. "
welcome_prompt: .asciiz "\n\nWould you like to participate? Type Y or N for your response: "
retry_prompt: .asciiz "\n\nWould you like to retry? Type Y or N for your response: "
exit_message: .asciiz "\n\nExiting program..."
level_one_message: .asciiz "\nLevel 1: \n\n"
fail_message: .asciiz "\nLevel Failed\n"
success_message: .asciiz "\nLevel Complete\n"

.text

.globl main

main:

li $v0, 4
la $a0, welcome_message
syscall

la $a0, welcome_prompt
syscall

# loop to check if user entered Y, N, enter

# user entered N
#j exit

# user entered Y

# LEVEL 1

la $a0, level_one_message
syscall

# load background

# load rocket

# enter time loop, 
# call rocket math
# wait by time specified in rocketmath
# redraw rocket
# error collision
    #if out of bounds collision, end loop, level failed
    #if incorrect building collision, end loop, level failed
    #if correct building collision, end loop, level succeeded
# loop

# ^ the whole time, listen to interrupts when the user press w a s d
    # if interrupted: modify respective quantites by the amount of press, then continue

la $a0, 


exit:

li $v0, 10      #exit safely
syscall
