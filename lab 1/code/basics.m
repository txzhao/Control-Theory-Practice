% initialize parameters
pm = 30;
wc = 0.4;
r = 0.001;
Ti = 10/wc;

% define G(s) and F_lag(s)
s = tf('s');
G = 3*(-s + 1)/((5*s + 1)*(10*s + 1));
F_lag = (Ti*s + 1)/(Ti*s + r);

% calculate required phase for lead compensator
[~, p_lag] = bode(G*F_lag, wc);
p_lead = pm - (p_lag + 180) + 6;

% calculate parameters of lead compensator
beta = (1 - sin(deg2rad(p_lead)))/(1 + sin(deg2rad(p_lead)));
Td = 1/(wc*sqrt(beta));
F_lead = (Td*s + 1)/(beta*Td*s + 1);
K = sqrt(beta)/abs(evalfr(G, j*wc)); 

% obtain lead-lag controller and closed-loop system
F_lead = K*F_lead;
F = F_lag*F_lead;
sys = G*F/(1 + G*F);

% plot result
figure(1)
margin(G)
hold on
margin(G*F)

figure(2)
step(sys)
hold on
step(G)

% output system properties
fb = bandwidth(sys);
gpeak = getPeakGain(sys);
S = stepinfo(sys);
rt = S.RiseTime;
overshoot = S.Overshoot;
disp('=== system properties ===');
disp(['Bandwidth: ' num2str(fb)]);
disp(['Resonance Peak: ' num2str(gpeak)]);
disp(['Rise Time: ' num2str(rt)]);
disp(['Overshoot: ' num2str(overshoot) '%']);



