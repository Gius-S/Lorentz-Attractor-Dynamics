function lyap_exponents = lyapunov_exponents(f, J, x0, T, h)
%LYAPUNOV_EXPONENTS Calcolo degli esponenti di Lyapunov 
%
% lyap_exponents = lyapunov_exponents(f, J, x0, T, h)
%
% INPUT:
%   f  = @(t,x)   sistema dinamico (dx/dt = f(t,x))
%   J  = @(x)     Jacobiana del sistema in x
%   x0 = condizione iniziale
%   T  = tempo totale di integrazione
%   h  = passo di integrazione
%
% OUTPUT:
%   lyap_exponents = vettore degli esponenti di Lyapunov (dimensione = dim sistema)

    dim = numel(x0);
    steps = round(T/h);
    x = x0(:);
    Q = eye(dim);
    le_sum = zeros(1, dim);

    % Integrazione
    for k = 1:steps
        K1 = f(0, x);
        K2 = f(0, x + 0.5*h*K1);
        K3 = f(0, x + 0.5*h*K2);
        K4 = f(0, x + h*K3);
        x = x + (h/6)*(K1 + 2*K2 + 2*K3 + K4);
        A = J(x);
        Z = Q + h*A*Q;
        [Q, R] = qr(Z,0);
        le_sum = le_sum + log(abs(diag(R)))';
    end
    lyap_exponents = le_sum / (steps*h);
end
