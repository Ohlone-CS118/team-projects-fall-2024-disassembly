.data

# Test values
test_angle: .float 0.7854    # 45 degrees in radians
test_thrust: .word 141       # Thrust value
test_mass: .word 50          # Mass of the rocket
test_Xi: .word 5             # Initial X coordinate
test_Yi: .word 5             # Initial Y coordinate

# Output placeholders
output_Xf: .word 0           # Final X coordinate
output_Yf: .word 0           # Final Y coordinate
output_t: .float 0.0         # Time to next pixel

msg_Xf: .asciiz "Final X: "
msg_Yf: .asciiz "Final Y: "
msg_t:  .asciiz "Time to next pixel: "

.text

.globl main

main:
    # Load test values
    l.s $f0, test_angle       # Load angle into $f0
    lw $t1, test_thrust       # Load thrust into $t1
    lw $t2, test_mass         # Load mass into $t2
    lw $a2, test_Xi           # Load initial X coordinate into $a2
    lw $a3, test_Yi           # Load initial Y coordinate into $a3

    # Call rocketMath
    jal rocketMath

    # Store results
    sw $a0, output_Xf         # Store final X coordinate
    sw $a1, output_Yf         # Store final Y coordinate
    s.s $f16, output_t        # Store time to next pixel as float

     # Print results
    li $v0, 4                 # Print string syscall
    la $a0, msg_Xf            # Message: "Final X: "
    syscall

    li $v0, 1                 # Print integer syscall
    lw $a0, output_Xf         # Load final X
    syscall

    li $v0, 4                 # Print string syscall
    la $a0, msg_Yf            # Message: "Final Y: "
    syscall

    li $v0, 1                 # Print integer syscall
    lw $a0, output_Yf         # Load final Y
    syscall

    li $v0, 4                 # Print string syscall
    la $a0, msg_t             # Message: "Time to next pixel: "
    syscall

    li $v0, 2                 # Print float syscall
    l.s $f12, output_t        # Load time to next pixel
    syscall

    # Exit
    li $v0, 10                # Exit syscall
    syscall
    