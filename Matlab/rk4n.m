function [t_vals, x_vals] = rk4n(f, tspan, x0, h)
% RK4N  Metodo Runge-Kutta del quarto ordine
% [t_vals, x_vals] = rk4n(f, tspan, x0, h)
%   f      = funzione @(t,x) che restituisce un vettore colonna (dim n)
%   tspan  = [t0 T] intervallo temporale
%   x0     = condizione iniziale (colonna o scalare)
%   h      = passo di integrazione
%   t_vals = vettore colonna dei tempi
%   x_vals = matrice (ogni riga è lo stato corrispondente)

t0 = tspan(1); 
tf = tspan(2);
x0 = x0(:);              % forza colonna
N  = ceil((tf - t0)/h);  % numero passi

dim = numel(x0);
t_vals = zeros(N+1,1);
x_vals = zeros(N+1, dim);

t = t0;
x = x0;
t_vals(1) = t;
x_vals(1,:) = x.';

for n = 1:N
    % adatta ultimo passo per arrivare esattamente a tf
    if t + h > tf
        h_local = tf - t;
    else
        h_local = h;
    end

    K1 = f(t, x);
    K2 = f(t + h_local/2, x + (h_local/2) * K1);
    K3 = f(t + h_local/2, x + (h_local/2) * K2);
    K4 = f(t + h_local, x + h_local * K3);

    x = x + (h_local/6) * (K1 + 2*K2 + 2*K3 + K4);
    t = t + h_local;

    t_vals(n+1) = t;
    x_vals(n+1,:) = x.';
end

end
