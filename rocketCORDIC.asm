.data
arctan_table: .float 0.785398163, 0.463647609, 0.244978663, 0.124354995, 0.062418810,
                     0.031239833, 0.015623729, 0.007812341, 0.003906230, 0.001953123,
                     0.000976562, 0.000488281, 0.000244141, 0.000122070, 0.000061035,
                     0.000030518
scaling_factor: .float 0.607252935 # Scaling factor K

flt_neg_one: .float -1.0
flt_one: .float 1.0
flt_zero: .float 0.0

testconst: .float 1.5707963
thrustconst: .float 160.0

.text


# Preconditions:
    # %angle: Input angle in radians (in $f0 or other floating-point register)
    # %thrust: Input thrust magnitude (in $f1 or other floating-point register)
# Postcondition:
    # %cosine: Cosine value scaled by thrust magnitude
    # %sine: Sine value scaled by thrust magnitude
# Macro to perform the entire CORDIC algorithm
.macro CORDIC(%angle, %thrust, %cosine, %sine)
    # Initialize variables
    l.s $f8, scaling_factor   # Load scaling factor K
    mul.s $f8, $f8, %thrust   # Scale K by thrust magnitude
    mov.s $f2, $f8            # x = K * thrust (cosine component)
    l.s $f3, flt_zero         # y = 0 (sine component)
    mov.s $f1, %angle         # z = theta (input angle)

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

        # x = x - d * y * 2^-i
        mul.s $f24, $f12, $f3     # d * y
        mtc1 $t0, $f28            # Move $t0 to $f28 (integer to float)
        cvt.s.w $f28, $f28        # Convert $f28 to floating-point
        l.s $f29, flt_one         # Load 1.0 into $f29
        div.s $f26, $f29, $f28    # 2^-i = 1.0 / (2^i)
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
        mov.s %cosine, $f2        # Final cosine value -> %cosine
        mov.s %sine, $f3          # Final sine value -> %sine
.end_macro

# Example usage of the macro
main:
    l.s $f0, testconst        # Load test angle (theta)
    l.s $f1, thrustconst         # Load thrust magnitude = 1.0
    CORDIC $f0, $f1, $f4, $f6 # Compute cosine in $f4, sine in $f6

    l.s $f1, thrustconst

    mul.s $f8, $f1, $f4   # x-component = thrust * cos(theta)
    mul.s $f9, $f1, $f6     # y-component = thrust * sin(theta)


    # Exit
    li $v0, 10
    syscall
