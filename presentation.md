---
marp: true
theme: default
---

# Team Disassembly
"Operation Ironwing"
Danny Huang, Mohammed Aziz Quraishi, Anthony Ryabov, Zahid Khan

---

# Rationale
Inspired by UN SDG 16 "Peace and Justice," our goal is to promote peaceful and inclusive societies by exposing the user to the stark contrast of a dystopian society where war and suffering is commonplace, and in which the user is complacent and involved in unmitigated violence and mass destruction.

---

# The Game

The user will be given control of an Intercontinental Ballistic Missile (ICBM), whose goal will be to eradicate a designated target. Though the scheme of gameplay is straightforward, the user will be exposed to substantial amounts of suggestions that what they are doing is not quite morally or ethically correct (death toll numbers, lack of consequences, visually non-militant targets, etc).

---

![bg left:40% 80%](https://web.mit.edu/16.unified/www/SPRING/propulsion/notes/fig5RocketFBD_web.jpg)

# Rocket Physics
This program implements a rudimentary, yet mathematically accurate physics simulation of a rocket using principles of Newtonian Mechanics.

---

## Vectors
To keep things relatively simple, we have limited the simulation to only utilize two vectors to represent the forces acting on our rocket and calculate its movement:

$$
\begin{align}
\vec{T}&:\text{Thrust} \\
\vec{F_g}&: \text{Gravity}
\end{align}
$$

In component form, these vectors are:

$$
\begin{align}
\vec{T}&=T_x\hat i+T_y\hat j\\
\vec{F_g}&= -mg\hat j
\end{align}
$$

---
## Applying Newton's Second Law

According to Newton's Second Law, the sum of all the forces on an object is equal to the mass of the object multiplied by its acceleration vector, or $\sum{\vec{F}_{net}}=m\vec{a}$.

This remains true when considering the components of these vectors. As such, we can apply this to the forces that act on our rocket:

$$
\begin{align}
\vec{T}+\vec{F_g}&=m\vec{a}\\
\vec{T}_x&=m\vec{a}_x\\
\vec{T}_y-mg&=m\vec{a}_y
\end{align}
$$

---

## Determining Thrust Components
Using right-triangle trigonometry, we can determine the components of our thrust vector using only the total magnitude of thrust and the angle at which the force is applied.

$$
\begin{align}
\vec{T}_x&=Tcos(\theta) \\
\vec{T}_x&=Tsin(\theta)
\end{align}
$$

We calculate sines and cosines using the CORDIC algorithm covered later.
```MIPS
CORDIC %angle, $f4, $f6
mtc1 %T, $f2
cvt.s.w $f2, $f2
mul.s %Tx, $f2, $f4     # Tx = T * cos(angle)
mul.s %Ty, $f2, $f6     # Ty = T * sin(angle)
```

---
## Equation Implementation
Since our goal is to calculate the movement of the rocket, we implement our equations in terms of $\vec{a}$ for each component.

$$
\begin{align}
\vec{a}_x = \frac{\vec{T}_x}{m}
\end{align}
$$
```MIPS
# Ax = Tx/m
div.s %Ax, %Tx, $f4
```

$$
\begin{align}
\vec{a}_y = \frac{\vec{T}_y-mg}{m}
\end{align}
$$
```MIPS
l.s $f6, grav_const     # gravitational constant -> $f6
mul.s $f6, $f4, $f6     # mass * gravity
sub.s %Ty, %Ty, $f6     # Thrust - (mg)
div.s %Ay, %Ty, $f4     # (Ty-mg)/m
```
---

## Velocity Calculation

The final velocity of the rocket is equal to the initial velocity + acceleration.
$$V_f=V_i+a$$
```MIPS
# Vf = Vi + a => Assuming time step of 1
add.s %Vf, %Vi, %a
```
The components of the final velocity are then used to determine the pixel unit displacement of the rocket.

---

![bg left:40% 80%](https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/CORDIC-illustration.png/300px-CORDIC-illustration.png)

# CORDIC Algorithm

This program implements the **CORDIC algorithm** for calculating trigonometric functions, in our case, **sine** and **cosine** values. CORDIC (Coordinate Rotation Digital Computer) uses iterative calculations to converge on resultant sine and cosine values by rotating vectors in a coordinate plane.

---

## Basic Principle
The core idea behind the CORDIC algorithm is to represent trigonometric functions as rotations in a 2D coordinate plane. The angle of rotation is adjusted incrementally in small steps based on a series of precomputed arctangent values.

Given an angle $\theta$ in radians, the goal is to compute the cosine and sine of $\theta$ without using multiplication or division. Instead, the algorithm uses vector rotations in the 2D plane to iteratively converge on the desired angle.

Initially, the algorithm starts with a vector pointing along the x-axis (with coordinates $(x_0, y_0)$ and a direction of $\theta_0 = 0$). The input angle $\theta$ is the angle we want to calculate the sine and cosine for.

---

## Constants and Precomputed Values

1. **Arctan Lookup Table**: A table containing pre-calculated values of arctan(2^-i), used in each iteration to converge angle approximation.
2. **Scaling Factor (K)**: A constant value used to scale the final result, ensuring accurate sine and cosine values.

```MIPS
arctan_table: .float 0.785398163, 0.463647609, 0.244978663, 0.124354995, 0.062418810,
                     0.031239833, 0.015623729, 0.007812341, 0.003906230, 0.001953123,
                     0.000976562, 0.000488281, 0.000244141, 0.000122070, 0.000061035,
                     0.000030518

scaling_factor: .float 0.607252935 # Scaling factor K
```

---
## Iterative Rotation

In each iteration, the vector is rotated by a small fixed angle, called the **angle step**. The total rotation angle is adjusted iteratively to converge on the target angle. The small angle is chosen as $\theta_i = \arctan(2^{-i})$, where $i$ is the iteration index. These small angle steps get progressively smaller as the iterations increase.
```MIPS
CORDIC_LOOP_M0:
    li $t1, 16                # Number of iterations
    bge $t0, $t1, CORDIC_DONE_M0

    # Load arctan(2^-i) for this iteration
    la $a0, arctan_table
    mul $t2, $t0, 4           # Index into the table (4 bytes per float)
    add $a1, $a0, $t2
    l.s $f10, 0($a1)          # arctan(2^-i) -> $f10
```

---

For each step $i$, the angle of rotation $\theta_i = \arctan(2^{-i})$ is used to update coordinates.
The new vector coordinates after the rotation are calculated as:
$$\begin{aligned}
x_{i+1} &= x_i - d_i \cdot y_i \cdot 2^{-i} \\
y_{i+1} &= y_i + d_i \cdot x_i \cdot 2^{-i} \\
\theta_{i+1} &= \theta_i - d_i \cdot \theta_i
\end{aligned}$$

```MIPS
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
```
---
## Equation Components
$d_i$ is the direction of rotation, determined by the sign of the angle at each step:
  - $d_i = 1$ if $\theta_i \geq 0$ (clockwise rotation).
  - $d_i = -1$ if $\theta_i < 0$ (counterclockwise rotation).
```MIPS
# Determine direction of rotation (d_i)
l.s $f30, flt_zero        # Load 0.0 into $f30
c.lt.s $f1, $f30          # If z < 0
bc1f CORDIC_POSITIVE_M0
l.s $f12, flt_neg_one     # d = -1
j CORDIC_ROTATE_M0
```

---

$x_i$ and $y_i$ are the current vector components.
```MIPS
# Initialize variables
l.s $f2, scaling_factor   # x = K (cosine component)
l.s $f3, flt_zero         # y = 0 (sine component)
mov.s $f1, %angle         # z = theta (input angle in radians)
```
 $2^{-i}$ is the scaling factor for each step.
```MIPS
# Correct calculation of 2^-i
li $t2, 1                 # Load 1
sllv $t2, $t2, $t0        # Left shift by $t0 to compute 2^i
mtc1 $t2, $f28            # Move integer to $f28
cvt.s.w $f28, $f28        # Convert $f28 to floating-point
l.s $f29, flt_one         # Load 1.0 into $f29
div.s $f26, $f29, $f28    # Compute 2^-i
```
---
## Final Result
Once the algorithm has iterated for a total of 16 times, the resultant cosine and sine values for a given $\theta$ will be accurate to four decimal places.
```MIPS
CORDIC_DONE_M0:
    mov.s %cosine, $f2           # Cosine in %cosine
    mov.s %sine, $f3             # Sine in %sine
```
```
Input Angle: 0.785398163 (pi/4)
Output:
  cos: 0.707134267
  sin: 0.707097582
```
---

# Stuff down here i guess?