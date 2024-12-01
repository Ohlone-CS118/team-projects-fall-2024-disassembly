# Source: https://en.wikipedia.org/wiki/CORDIC
# Implemented by Mohammed Aziz Quraishi

# Preconditions: Angle in radians in $f0
# Postcondition: cos(theta) in $f4
#                sin(theta) in $f6

.data
arctan_table: .float 0.785398163, 0.463647609, 0.244978663, 0.124354995, 0.062418810,
                     0.031239833, 0.015623729, 0.007812341, 0.003906230, 0.001953123,
                     0.000976562, 0.000488281, 0.000244141, 0.000122070, 0.000061035,
                     0.000030518

scaling_factor: .float 0.607252935 # Scaling factor K

flt_neg_one: .float -1.0
flt_one: .float 1.0
flt_zero: .float 0.0

pi: .float 3.14159265

testconst: .float 0.0
thrustconst: .float 1       # Thrust scaling value of 1 for unscaled testing

.text


# Preconditions:
    # %angle: Input angle in radians (in $f0 or other floating-point register)
# Postcondition:
    # %cosine: Cosine value 
    # %sine: Sine value 
# Macro to perform the entire CORDIC algorithm
.macro CORDIC(%angle, %cosine, %sine)
    # Initialize variables
    l.s $f2, scaling_factor   # x = K (cosine component)
    l.s $f3, flt_zero         # y = 0 (sine component)
    mov.s $f1, %angle         # z = theta (input angle in radians)

    # Iterate through the arctan table
    li $t0, 0                 # Iteration index
    CORDIC_LOOP_M0:
        li $t1, 16                # Number of iterations
        bge $t0, $t1, CORDIC_DONE_M0

        # Load arctan(2^-i) for this iteration
        la $a0, arctan_table
        mul $t2, $t0, 4           # Index into the table (4 bytes per float)
        add $a1, $a0, $t2
        l.s $f10, 0($a1)          # arctan(2^-i) -> $f10

        # Determine direction of rotation (d_i)
        l.s $f30, flt_zero        # Load 0.0 into $f30
        c.lt.s $f1, $f30          # If z < 0
        bc1f CORDIC_POSITIVE_M0
        l.s $f12, flt_neg_one     # d = -1
        j CORDIC_ROTATE_M0
    CORDIC_POSITIVE_M0:
        l.s $f12, flt_one         # d = 1

    CORDIC_ROTATE_M0:
        # Compute new x, y, z
        mov.s $f20, $f2           # Save x in $f20
        mov.s $f22, $f3           # Save y in $f22

        # Correct calculation of 2^-i
        li $t2, 1                 # Load 1
        sllv $t2, $t2, $t0        # Left shift by $t0 to compute 2^i
        mtc1 $t2, $f28            # Move integer to $f28
        cvt.s.w $f28, $f28        # Convert $f28 to floating-point
        l.s $f29, flt_one         # Load 1.0 into $f29
        div.s $f26, $f29, $f28    # Compute 2^-i

        # x = x - d * y * 2^-i
        mul.s $f24, $f12, $f3     # d * y
        mul.s $f24, $f24, $f26    # d * y * 2^-i
        sub.s $f2, $f2, $f24      # Update x

        # y = y + d * x * 2^-i
        mul.s $f24, $f12, $f20    # d * x
        mul.s $f24, $f24, $f26    # d * x * 2^-i
        add.s $f3, $f3, $f24      # Update y

        # z = z - d * arctan(2^-i)
        mul.s $f24, $f12, $f10    # d * arctan(2^-i)
        sub.s $f1, $f1, $f24      # Update z

        # Increment iteration index
        addi $t0, $t0, 1
        j CORDIC_LOOP_M0

    CORDIC_DONE_M0:
        # Scale results by thrust magnitude
        # mul.s $f2, $f2, %thrust    # Final cosine value scaled
        # mul.s $f3, $f3, %thrust    # Final sine value scaled
        mov.s %cosine, $f2           # Cosine in %cosine
        mov.s %sine, $f3             # Sine in %sine

.end_macro

.globl CORDIC
# Example usage of the macro
main:
    l.s $f0, testconst        # Load test angle (theta)
    CORDIC $f0, $f4, $f6      # Compute cosine in $f4, sine in $f6

    # li $v0, 2             
    # mov.s $f12, $f4       
    # syscall
    # mov.s $f12, $f6
    # syscall
