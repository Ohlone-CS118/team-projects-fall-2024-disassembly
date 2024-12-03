.data

.macro push(%reg)
sw %reg, -4($sp)
subi $sp, $sp, 4
.end_macro

.macro pop(%reg)
lw %reg, ($sp)
addi $sp, $sp, 4
.end_macro

.macro pushfloat(%reg)
s.s %reg, -4($sp)
subi $sp, $sp, 4
.end_macro

.macro popfloat(%reg)
l.s %reg, ($sp)
addi $sp, $sp, 4
.end_macro