# Mathematical Background of the Lorenz System

The Lorenz system was originally formulated as a highly simplified mathematical model for fluid convection. However, from a mathematical standpoint, it is most famous for being a prime example of a non-linear continuous dynamical system that exhibits deterministic chaos. 

The defining characteristic of this chaotic system is its **sensitive dependence on initial conditions**. Two trajectories starting arbitrarily close to each other will exponentially diverge over time, making long-term prediction impossible—a phenomenon popularly known as the "butterfly effect".

## The Dynamical System

The continuous dynamical system is described by a set of three coupled, non-linear ordinary differential equations:

$$\dot x = \sigma(y - x)$$
$$\dot y = x(\rho - z) - y$$
$$\dot z = xy - \beta z$$

Where the physical parameters (all positive) dictate the system's behavior:
* $\sigma$ (Prandtl number)
* $\rho$ (Rayleigh number)
* $\beta$ (Geometric factor)

## Fixed Points (Equilibria)

To find the fixed points, we set the derivatives to zero:

$$\begin{cases} x = y \\ x(\rho - 1 - z) = 0 \\ z = \frac{1}{\beta}x^2 \end{cases}$$

Solving this system yields the following equilibrium points:
1. The origin: $P_0 = (0,0,0)$
2. For $\rho > 1$, two additional fixed points emerge: 
   $P_1 = (\sqrt{\beta(\rho - 1)}, \sqrt{\beta(\rho - 1)}, \rho - 1)$
   $P_2 = (-\sqrt{\beta(\rho - 1)}, -\sqrt{\beta(\rho - 1)}, \rho - 1)$

## Linearization and Jacobian Matrix

To study the local stability around these fixed points, we linearize the system using the Jacobian matrix:

$$J(x,y,z) = \begin{bmatrix} -\sigma & \sigma & 0 \\ \rho - z & -1 & -x \\ y & x & -\beta \end{bmatrix}$$

Evaluating the Jacobian at the origin $P_0(0,0,0)$ gives:

$$J(0,0,0) = \begin{bmatrix} -\sigma & \sigma & 0 \\ \rho & -1 & 0 \\ 0 & 0 & -\beta \end{bmatrix}$$

The characteristic equation $\det(J - \lambda I) = 0$ yields the eigenvalues:

$$\lambda_{1,2} = \frac{-(\sigma + 1) \pm \sqrt{(\sigma + 1)^2 - 4\sigma(1 - \rho)}}{2}$$
$$\lambda_3 = -\beta$$

If $\rho < 1$, all three eigenvalues have negative real parts, meaning the origin is an attractive fixed point.

## Stability Analysis (Standard Parameters)

Let's fix $\sigma = 10$ and $\beta = 8/3$ and analyze the behavior as $\rho$ changes.

### Case $0 < \rho \leq 1$
The origin $(0,0,0)$ is the only fixed point. The eigenvalues are real and negative, making the origin an asymptotically stable equilibrium node. 

This can be rigorously proven using the **Lyapunov function**:
$$L(x, y, z) = \rho x^2 + \sigma y^2 + \sigma z^2$$
Where $L(0,0,0) = 0$ and $L(p) > 0$ for all $p \neq (0,0,0)$.
Its time derivative is strictly negative for all $(x,y,z) \neq (0,0,0)$:
$$\dot L(x, y, z) = -2\sigma \Big(\rho(x - y)^2 + (1 - \rho)y^2 + \beta z^2 \Big) < 0$$
According to Lyapunov's theorem, this confirms that the origin is globally asymptotically stable.

### Case $\rho > 1$
The system undergoes a pitchfork bifurcation. The origin loses stability, and the two new fixed points ($P_1, P_2$) appear. The stability of these new points depends heavily on the specific value of $\rho$. At $\rho = 28$, all three fixed points are unstable, and the system enters the chaotic regime, forming the famous strange attractor. 

*For a detailed numerical analysis of the eigenvalue behavior as $\rho$ varies, refer to the main MATLAB script.*
