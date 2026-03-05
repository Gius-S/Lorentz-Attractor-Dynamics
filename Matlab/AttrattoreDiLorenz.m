% ATTRATTORE DI LORENZ
% Sistema dinamico caotico descritto da tre equazioni differenziali ordinarie


% Parametri fisici
sigma = 10;      
rho = 28;        
beta = 8/3;      

% Equazioni del sistema di Lorenz,  Jacobiano, P.ti Equilibrio.
dxdt = @(t, x) [
    sigma * (x(2) - x(1));                         %|  dx = sigma*(x-y)
    x(1) * (rho - x(3)) - x(2);                    %|  dy = (rho - z) * x - y 
    x(1) * x(2) - beta * x(3)                      %|  dz = x * y - beta * z
 ];

Jf = @(x) [  -sigma     ,      sigma      ,    0 ;

           rho - x(3)   ,       -1        , -x(1);

               x(2)     ,       x(1)      , -beta];

disp('Esponenti di Lyapunov:');
disp(lyapunov_exponents(dxdt, Jf, [1; 1; 1], 1000, 0.01));
disp(-(sigma+1+beta))

P0=[0,0,0];
x_eq = sqrt(beta*(rho - 1));   
z_eq = rho - 1;                
P1 = [x_eq,  x_eq,  z_eq];
P2 = [-x_eq, -x_eq, z_eq];

% Condizione iniziale e intervallo di studio
x0 = [1; 1; 1];  
x01 = [1.01; 1.01; 1.01];
T = 100;         
tspan = [0 T];   

% Soluzione numerica

[t, x] = rk4n(dxdt, tspan, x0, 0.01);
[t1,x1]= rk4n(dxdt, tspan, x01,0.01);


%studio autovalori-----------------------------------------------------------------

sigma = 10;
b = 8/3;
r_values = 0:1.1:28;   % intervallo valori di r

lambda_store = zeros(length(r_values),3);

for k = 1:length(r_values)
    r = r_values(k);
    coeffs = [1, (sigma+b+1), b*(r+sigma), 2*b*sigma*(r-1)];
    lambda = roots(coeffs); 
    % Salva solo la parte reale (per analisi stabilità)
    lambda_store(k,:) = real(lambda(:)).';
end
f1=figure;
plot(r_values, lambda_store(:,1), 'r', 'LineWidth', 1.5);
xlabel('r'); ylabel('Re(\lambda_1)'); grid on;
title('Parte reale di \lambda_1 in funzione di r');

f2=figure;
plot(r_values, lambda_store(:,2), 'b', 'LineWidth', 1.5);
xlabel('r'); ylabel('Re(\lambda_2)'); grid on;
title('Parte reale di \lambda_2 in funzione di r');

f3=figure;
plot(r_values, lambda_store(:,3), 'g', 'LineWidth', 1.5);
xlabel('r'); ylabel('Re(\lambda_3)'); grid on;
title('Parte reale di \lambda_3 in funzione di r');


% test errore rk4------------------------------------------------------------------
% f = @(t,y) -y;
% x0 = 1;
% T = 1;
% 
% 
% y_exact = exp(-T);%soluzione esatta 
% 
% hs = [0.1 0.05 0.025 0.0125];
% err = zeros(size(hs));
% 
% for k=1:length(hs)
%     h = hs(k);
%     [t_h, y_h] = rk4n(f, [0 T], x0, h);
%     err(k) = abs(y_h(end) - y_exact);
% end
% 
% % Plot log-log
% loglog(hs, err, '-o'); grid on;
% xlabel('h'); ylabel('errore');
% title('Convergenza RK4 (test su y''=-y)');
% 
% % Stima della pendenza
% p = polyfit(log(hs), log(err), 1);
% disp(['slope approx = ', num2str(p(1))]);

%-------------------------------------------------------------------------------------

% Spazio delle fasi 
fig = figure('Color', [0.1 0.1 0.1], 'Position', [100 100 800 600]);
ax = gca;
hold on;
grid on;
ax.Color = [0.1 0.1 0.1];
ax.GridColor = [0.3 0.3 0.3];
ax.GridAlpha = 0.3;
ax.XColor = [0.8 0.8 0.8];
ax.YColor = [0.8 0.8 0.8];
title('Attrattore di Lorenz', 'FontSize', 14, 'Color', [0.9 0.9 0.9]);
xlabel('x', 'FontSize', 12, 'Color', [0.8 0.8 0.8]);
ylabel('y', 'FontSize', 12, 'Color', [0.8 0.8 0.8]);
zlabel('z', 'FontSize', 12, 'Color', [0.8 0.8 0.8]);
x_limits = [min(x(:,1)) max(x(:,1))];
y_limits = [min(x(:,2)) max(x(:,2))];
z_limits = [min(x(:,3)) max(x(:,3))];
axis([x_limits y_limits z_limits]);

% Animazione
trail_length = 10000;  % Lunghezza percorso

h_trail = animatedline('Color', [0.1 0.9 0.2], 'LineWidth', 1.5);  % Green
h_trail2 = animatedline('Color', [1 0 1], 'LineWidth', 1.5);  % Fuchsia 
plot3(P1(1), P1(2), P1(3), 'ro', 'MarkerFaceColor','r', 'MarkerSize', 8)
plot3(P2(1), P2(2), P2(3), 'bo', 'MarkerFaceColor','r', 'MarkerSize', 8)
h_head = plot3(x(1,1), x(1,2), x(1,3), 'o', 'MarkerSize', 8, 'MarkerFaceColor', [0.1 0.9 0.2], 'MarkerEdgeColor', 'none');
h_head2 = plot3(x1(1,1), x1(1,2), x1(1,3), 'o', 'MarkerSize', 8, 'MarkerFaceColor', [1 0 1], 'MarkerEdgeColor', 'none');
view(20, 20);  % Angolo di visualizzazione iniziale
rotate3d on;   % Abilita rotazione 3D interattiva

v = VideoWriter('AttrattoreLorenz.mp4', 'MPEG-4');
v.FrameRate = 50;
v.Quality = 100;
open(v);

% Animazione
num_frames = length(t);
step = 10;  % Frame da saltare
for i = 1:step:num_frames
    if ~ishandle(fig)
        break;
    end
    idx_start = max(1, i-trail_length);

    clearpoints(h_trail);
    clearpoints(h_trail2);

    addpoints(h_trail, x(idx_start:i,1), x(idx_start:i,2), x(idx_start:i,3));
    addpoints(h_trail2, x1(idx_start:i,1), x1(idx_start:i,2), x1(idx_start:i,3));

    set(h_head, 'XData', x(i,1), 'YData', x(i,2), 'ZData', x(i,3));
    set(h_head2, 'XData', x1(i,1), 'YData', x1(i,2), 'ZData', x1(i,3));
    
    drawnow;
    frame = getframe(fig);
    writeVideo(v, frame);
end
close(v);


