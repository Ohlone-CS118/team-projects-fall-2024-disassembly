# Implemented by Mohammed Aziz Quraishi and Anthony Ryabov

.include "rocketCORDIC.asm"

.data

# Calculate components of thrust
# Preconditions: Angle in radians, T as integer
# Postconditions: Tx in FPU register
#                 Ty in FPU register
# Blacklisted FPU registers: f2, f4, f6
.macro thrust_components(%Tx, %Ty, %T, %angle)
    pushfloat($f2)
    pushfloat($f4)
    pushfloat($f6)
	
    CORDIC %angle, $f4, $f6 # Get cos(angle) and sin(angle)
    mtc1 %T, $f2            # thrust -> $f2
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
    pushfloat($f4)

    mtc1 %m, $f4            # mass -> $f4
    cvt.s.w $f4, $f4
    
    # Ax = Tx/m
    div.s %Ax, %Tx, $f4
    
    popfloat($f4)
.end_macro

# Calculate Ay
# Preconditions: %Ty is thrust in y direction as float in FPU, %m is mass
# Postconditions: %Ay is acceleration in y direction in FPU register
# Blacklisted FPU registers: f4, f6
.macro Ay(%Ay, %Ty, %m)
    pushfloat($f4)
    pushfloat($f6)

    mtc1 %m, $f4            # mass -> $f4
    cvt.s.w $f4, $f4

    # Ay = (Ty-mg)/m
    l.s $f6, grav_const     # gravitational constant -> $f6
    mul.s $f6, $f4, $f6     # mass * gravity
    sub.s %Ty, %Ty, $f6     # Thrust - (mg)
    div.s %Ay, %Ty, $f4     # (Ty-mg)/m
    
    popfloat($f6)
    popfloat($f4)
.end_macro

# Calculate Vf
# Preconditions: %a is acceleration in the respective direction, %Vi is initial velocity in the respective direction
#                All input components should be in FPU registers as floats
# Postconditions: %Vf is final velocity in respective direction as float
.macro vel_component(%a, %Vi, %Vf)
    # Vf = Vi + a => Assuming time step of 1
    add.s %Vf, %Vi, %a
.end_macro

# Calculate Xf and Yf
# Preconditions: Xi and Yi must be valid integers
#                Vx and Vy must be calculated from vel_component and remain in FPU
# Postconditions: %Xf and %Yf are final coordinates of the rocket
#                 %dt is the time it takes to get to final coordinate (float)
# Blacklisted FPU registers: f2, f4, f6, f8, $f11, $f13, $f7, $f9
.macro coordinate(%Xi, %Yi, %Vx, %Vy, %Xf, %Yf, %dt)
    pushfloat($f2) # working variable
    pushfloat($f4) # working variable
    pushfloat($f6) # working variable
    pushfloat($f8) # working variable
    pushfloat($f15) # flt_threshold
    
    # Calculate velocity magnitude: sqrt(Vx^2 + Vy^2)
    mul.s $f2, %Vx, %Vx	# Vx^2
    mul.s $f4, %Vy, %Vy	# Vy^2
    add.s $f6, $f2, $f4	# Vx^2 + Vy^2
    sqrt.s $f8, $f6		# Magnitude = sqrt(Vx^2 + Vy^2)

    # Calculate time to travel 1 meter: t = 1 / Magnitude
    l.s $f2, flt_one	# Distance to next pixel = 1 meter
    div.s %dt, $f2, $f8	# t = 1 / Magnitude

    # Normalize velocity components
    div.s $f6, %Vx, $f8	# Normalized Vx
    div.s $f8, %Vy, $f8	# Normalized Vy
    
    # Accumulate normalized velocities
    add.s eVx, eVx, $f6
    add.s eVy, eVy, $f8
    
    # subtract previous displacements
    sub.s eVx, eVx, px
    sub.s eVy, eVy, py

    # Threshold for significant movement
    l.s $f15, flt_threshold	# Threshold for movement decision (e.g., 0.5)
    l.s $f21, flt_zero	# Zero for comparisons

    # Initialize Xf and Yf to current position
    move %Xf, %Xi		# Default Xf = Xi
    move %Yf, %Yi		# Default Yf = Yi

    # Determine X movement
    abs.s $f4, eVx		# |Normalized Vx|
    c.le.s $f15, $f4	# Check if |Vx| >= threshold
    bc1f skip_x_movement	# Skip X movement if below threshold
    c.lt.s eVx, $f21	# Check if Vx < 0
    bc1t move_left		# Move left if true
    addi %Xf, %Xi, 1	# Move right
    l.s px, flt_one		# Record positive x movement
    j done_x_movement

move_left:
    subi %Xf, %Xi, 1	# Move left
    l.s px, flt_neg_one	# Record negative x movement
    j done_x_movement

skip_x_movement:
	l.s px, flt_zero	# Record no x movement
done_x_movement:

    # Determine Y movement
    abs.s $f4, eVy		# |Normalized Vy|
    c.le.s $f15, $f4	# Check if |Vy| >= threshold
    bc1f skip_y_movement	# Skip Y movement if below threshold
    c.lt.s eVy, $f21	# Check if Vy < 0
    bc1t move_down		# Move down if true
    addi %Yf, %Yi, 1	# Move up
    l.s py, flt_one		# Record positive y movement
    j done_y_movement

move_down:
    subi %Yf, %Yi, 1	# Move down
    l.s py, flt_neg_one	# Record negative y movement
    j done_y_movement

skip_y_movement:
	l.s py, flt_zero	# Record no y movement
done_y_movement:

    coordinate_done:
        popfloat($f15)
        popfloat($f8)
        popfloat($f6)
        popfloat($f4)
        popfloat($f2)
.end_macro


.text

.globl rocketMath

rocketMath:
    # Calculate thrust components in x and y direction
    thrust_components(Tx, Ty, T, angle)

    # Calculate Acceleration in x and y direction
    Ax(ax, Tx, M)
    Ay(ay, Ty, M)
    
    # Update velocities
    #	       (a,  Vi, Vf)
    vel_component(ax, Vx, Vx) # Ax + Vix = Vfx 
    vel_component(ay, Vy, Vy) # Ay + Viy = Vfy

    # Determine next pixel
    #         (Xi, Yi, Vx, Vy, Xf, Yf, dt)
    coordinate(xi, yi, Vx, Vy, xf, yf, dt)

    jr $ra
