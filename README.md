# Lorentz-Attractor-Dynamics
Numerical study and 3D visualization of the Lorenz Attractor in MATLAB. Features custom RK4 integration, Lyapunov exponents calculation, stability analysis, and chaotic system animation.


This repository contains a numerical and mathematical study of the Lorenz attractor, a chaotic dynamic system originally developed as a simplified mathematical model for atmospheric convection. The focus of this project is the numerical integration, stability analysis, and 3D visualization of the chaotic behavior, particularly the sensitive dependence on initial conditions (the "butterfly effect").



## Repository Structure and Files

Here is a breakdown of the files included in this repository and how they interact.

### `AttrattoreDiLorenz.m`
* **What it does:** This is the main execution script. It defines the Lorenz system's parameters and Ordinary Differential Equations (ODEs), calculates the equilibrium points and eigenvalues to study stability, and plots the results. It also generates a 3D animation comparing two trajectories with nearly identical initial conditions and exports it as an `.mp4` video.
* **What it needs:** It requires the helper functions `rk4n.m` and `lyapunov_exponents.m` to be in the same directory.
* **What it's for:** Run this file to execute the entire simulation, visualize the chaotic attractor, and generate the eigenvalue plots and animation.

### `rk4n.m`
* **What it does:** A custom implementation of the classic 4th-order Runge-Kutta (RK4) numerical method. 
* **What it needs:** A function handle defining the system of ODEs, a time span `[t0, tf]`, initial conditions `x0`, and an integration step `h`.
* **What it's for:** It is used by the main script to accurately solve the non-linear differential equations of the Lorenz system over time.

### `lyapunov_exponents.m`
* **What it does:** Computes the Lyapunov exponents of the dynamical system using QR decomposition. 
* **What it needs:** The system's function handle, its Jacobian matrix function, initial conditions, total integration time, and the time step.
* **What it's for:** It provides a quantitative measure of chaos. A positive maximal Lyapunov exponent mathematically confirms the system's sensitive dependence on initial conditions.

### `THEORY.md`
* **What it does:** Provides the mathematical background of the project.
* **What it needs:** Nothing (Markdown text file).
* **What it's for:** Read this to understand the fixed points calculation, the Jacobian linearization, and the stability analysis of the system using Lyapunov functions.

## Results and Stability Analysis

During the execution, the main script evaluates the system's eigenvalues as the Rayleigh parameter ($\rho$) changes.
