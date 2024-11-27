.data

# Postconditiond: %Ax is acceleration in x direction - FPU register
.macro Ax(%Ax, %Tx, %m)
    mtc1 %Tx, $f2
    mtc1 %m, $f4
    cvt.d.w $f2, $f2
    cvt.d.w $f4, $f4
    
    div.d %Ax, $f2, $f4
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