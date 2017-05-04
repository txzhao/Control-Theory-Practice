% setup
s = tf('s');
G = 1e4*(s + 2)/(s + 3)/(s + 100)^2;
G0 = minreal(1e4*(s + 2)*(s - 1)/(s + 3)/(s + 2)/(s + 100)^2);
Hinf(G);

% run simulation
Fsim = F;
Gsim = G;
% Gsim = G0;
macro

% verify small gain theorem
T = G0*F/(1 + G0*F);
dG = 3/(s + 2);
figure()
bode(T)
hold on
bode(1/dG)