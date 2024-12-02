.data

grav_const: .float 9.80

# Postconditiond: %Ax is acceleration in x direction - FPU register 
# USE FLOATS
.macro Ax(%Ax, %Tx, %m)
    # Ax = Tx/m
    mtc1 %Tx, $f2
    mtc1 %m, $f4
    cvt.s.w $f2, $f2
    cvt.s.w $f4, $f4
    
    div.s %Ax, $f2, $f4
.end_macro

.macro Ay(%Ay, %Ty, %m)
    # Ay = (Ty-mg)/m
    mtc1 %m, $f4            # mass -> $f4
    l.s $f6, grav_const     # gravitational constant -> $f6
    mul.s $f6, $f4, $f6     # mass * gravity
    mtc1 %Ty, $f8           # Thrust -> $f8
    sub.s $f8, $f8, $f6     # Thrust - (mg)
    div.s %Ay, $f8, $f4     # (Ty-mg)/m
.end_macro

# Preconditions: All input components should be in FPU registers as floats
.macro vel_component(%a, %Vi, %Vf)
    # Vf = Vi + a => Assuming time step of 1
    add.s %Vf, %Vi, %a
.end_macro

# Preconditions: Xi and Yi must be valid integers
#                Vx and Vy must be calculated from vel_component and remain in FPU
.macro coordinate(%Xi, %Yi, %Vx, %Vy ,%Xf, %Yf)
    cvt.w.s %Vx, %Vx
    cvt.w.s %Vy, %Vy

    mtc0 $s0, %Vx
    mtc0 $s1, %Vy

    add %Xf, %Xi, $s0
    add %Yf, %Yi, $s1
.end_macro

.text

.globl rocketMath

main:

    li $t1, 5
    li $t2, 1000

    Ax($f12, $t1, $t2)

    li $v0, 3
    syscall
    

li $v0, 10  # exit safely
syscall