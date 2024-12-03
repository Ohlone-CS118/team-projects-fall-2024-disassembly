.include "rocketCORDIC.asm"
.include "utilities.asm"

.data

grav_const: .float 9.80

# Calculate components of thrust
# Preconditions: Angle in radians, T as integer
# Postconditions: Tx in FPU register
#                 Ty in FPU register
.macro thrust_components(%Tx, %Ty, %T, %angle)
    pushfloat($f2)
    pushfloat($f4)
    pushfloat($f6)

    CORDIC %angle, $f4, $f6

    mtc1 %T, $f2
    cvt.s.w $f2, $f2

    mul.s %Tx, $f2, $f4
    mul.s %Ty, $f2, $f6

    popfloat($f6)
    popfloat($f4)
    popfloat($f2)
.end_macro

# Calculate Ax
# Preconditions: %Tx is thrust in x direction as float in FPU, %m is mass
# Postconditions: %Ax is acceleration in x direction in FPU register
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
.macro vel_component(%a, %Vi, %Vf)
    # Vf = Vi + a => Assuming time step of 1
    add.s %Vf, %Vi, %a
.end_macro

# Calculate Xf and Yf
# Preconditions: Xi and Yi must be valid integers
#                Vx and Vy must be calculated from vel_component and remain in FPU
# Postconditions: %Xf and %Yf are final coordinates of the rocket
.macro coordinate(%Xi, %Yi, %Vx, %Vy ,%Xf, %Yf)
    cvt.w.s %Vx, %Vx
    cvt.w.s %Vy, %Vy

    mtc0 %Vx, $s0
    mtc0 %Vy, $s1

    add %Xf, %Xi, $s0
    add %Yf, %Yi, $s1
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


    thrust_components($f8, $f10, $t1, $f0)

    Ax($f4, $t1, $t2)
    Ay($f6, $t1, $t2)

    jr $ra