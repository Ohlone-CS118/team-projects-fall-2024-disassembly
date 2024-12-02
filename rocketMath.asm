.data

grav_const: .float 9.80

# Postconditiond: %Ax is acceleration in x direction - FPU register 
# USE FLOATS
.macro Ax(%Ax, %Tx, %m)
    # Ax = (Thrust) * cos(theta)
    mtc1 %Tx, $f2
    mtc1 %m, $f4
    cvt.d.w $f2, $f2
    cvt.d.w $f4, $f4
    
    div.d %Ax, $f2, $f4
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


.text

main:

    li $t1, 5
    li $t2, 1000

    Ax($f12, $t1, $t2)

    li $v0, 3
    syscall
    

li $v0, 10  # exit safely
syscall