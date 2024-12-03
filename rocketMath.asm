.include "rocketCORDIC.asm"

.data

grav_const: .float 9.80

# Calculate components of thrust
# Preconditions: Angle in radians, T as integer
# Postconditions: Tx in FPU register
#                 Ty in FPU register
# Blacklisted FPU registers: f2, f4, f6
.macro thrust_components(%Tx, %Ty, %T, %angle)
    pushfloat($f2)
    pushfloat($f4)
    pushfloat($f6)

    CORDIC %angle, $f4, $f6

    mtc1 %T, $f2
    cvt.s.w $f2, $f2

    mul.s %Tx, $f2, $f4     # Tx = T * cos(angle)
    mul.s %Ty, $f2, $f6     # Ty = T * sin(angle)

    popfloat($f6)
    popfloat($f4)
    popfloat($f2)
.end_macro

# Calculate Ax
# Preconditions: %Tx is thrust in x direction as float in FPU, %m is mass
# Postconditions: %Ax is acceleration in x direction in FPU register
# Blacklisted FPU registers: f4
.macro Ax(%Ax, %Tx, %m)
    #pushfloat($f2)
    pushfloat($f4)

    # Ax = Tx/m
    #mtc1 %Tx, $f2
    mtc1 %m, $f4
    #cvt.s.w $f2, $f2
    cvt.s.w $f4, $f4
    
    div.s %Ax, %Tx, $f4
    
    popfloat($f4)
    #popfloat($f2)
.end_macro

# Calculate Ay
# Preconditions: %Ty is thrust in y direction as float in FPU, %m is mass
# Postconditions: %Ay is acceleration in y direction in FPU register
# Blacklisted FPU registers: f4, f6
.macro Ay(%Ay, %Ty, %m)
    pushfloat($f4)
    pushfloat($f6)
    #pushfloat($f8)

    # Ay = (Ty-mg)/m
    mtc1 %m, $f4            # mass -> $f4
    #mtc1 %Ty, $f8           # Thrust -> $f8
    cvt.s.w $f4, $f4
    #cvt.s.w $f8, $f8
    
    l.s $f6, grav_const     # gravitational constant -> $f6
    mul.s $f6, $f4, $f6     # mass * gravity
    sub.s %Ty, %Ty, $f6     # Thrust - (mg)
    div.s %Ay, %Ty, $f4     # (Ty-mg)/m
    
    #popfloat($f8)
    popfloat($f6)
    popfloat($f4)
.end_macro

# Calculate Vf
# Preconditions: %a is acceleration in the respective direction, %Vi is initial velocity in the respective direction
#                All input components should be in FPU registers as floats
# Postconditions: %Vf is final velocity in respective direction as float
# Blacklisted FPU registers: none
.macro vel_component(%a, %Vi, %Vf)
    # Vf = Vi + a => Assuming time step of 1
    add.s %Vf, %Vi, %a
.end_macro

# Calculate Xf and Yf
# Preconditions: Xi and Yi must be valid integers
#                Vx and Vy must be calculated from vel_component and remain in FPU
# Postconditions: %Xf and %Yf are final coordinates of the rocket
#                 %dt is the time it takes to get to final coordinate (float)
# Blacklisted FPU registers: f2, f4, f6, f8
.macro coordinate(%Xi, %Yi, %Vx, %Vy, %Xf, %Yf, %dt)
    pushfloat($f2)
    pushfloat($f4)
    pushfloat($f6)
    pushfloat($f8)

    # Calculate velocity magnitude: sqrt(Vx^2 + Vy^2)
    mul.s $f2, %Vx, %Vx        # Vx^2
    mul.s $f4, %Vy, %Vy        # Vy^2
    add.s $f6, $f2, $f4        # Vx^2 + Vy^2
    sqrt.s $f8, $f6            # Magnitude = sqrt(Vx^2 + Vy^2)

    # Calculate time to travel 1 meter: t = 1 / Magnitude
    l.s $f2, flt_one           # Distance to next pixel = 1 meter
    div.s %dt, $f2, $f8        # t = 1 / Magnitude

    # Normalize velocity components
    div.s $f6, %Vx, $f8        # Normalized Vx
    div.s $f8, %Vy, $f8        # Normalized Vy

    # Determine direction of movement
    check_x_direction:
        c.lt.s $f6, $f2            # Check if Vx < 0
        bc1t move_left_or_down     # If true, move left or diagonal down
        addi %Xf, %Xi, 1           # Otherwise, move right

    check_y_direction:
        c.lt.s $f8, $f2            # Check if Vy < 0
        bc1t move_down             # If true, move down
        addi %Yf, %Yi, 1           # Otherwise, move up
        j coordinate_done

    move_left_or_down:
        subi %Xf, %Xi, 1           # Move left
        c.lt.s $f8, $f2            # Check if Vy < 0
        bc1t move_down             # If true, continue moving down
        j coordinate_done

    move_down:
        subi %Yf, %Yi, 1           # Move down

    coordinate_done:
        popfloat($f8)
        popfloat($f6)
        popfloat($f4)
        popfloat($f2)
.end_macro


.text

.globl rocketMath

rocketMath:
    # $f0 = angle
    # $t1 = thrust
    # $t2 = mass
    # $a2 = initial x coordinate
    # $a3 = initial y coordinate
    # $a0 = final x coordinate
    # $a1 = final y coordinate
    # $f16 = time to next pixel


    thrust_components($f8, $f10, $t1, $f0)

    Ax($f4, $f8, $t2)
    Ay($f6, $f10, $t2)

    # Update velocities
    vel_component($f4, $f12, $f12) # Vfx = Vix + Ax
    vel_component($f6, $f14, $f14) # Vfy = Viy + Ay

    # Determine next pixel
    coordinate($a2, $a3, $f12, $f14, $a0, $a1, $f16)  # New x in $a0, new y in $a1, time in $f16

    jr $ra