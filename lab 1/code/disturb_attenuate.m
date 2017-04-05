clear;
s = tf('s');
G = 20/((s + 1)*((s/20)^2) + s/20 + 1);
Gd = 10/(s + 1);

%% exe 4.2.1
% calculate cross-over frequency; note: 20log10(mag) > 0
[~, ~, ~, wc] = margin(Gd);
L = wc/s;
Fy = L/G;

% approximation to make controller proper
p1 = 30*wc;
p2 = 30*wc;
Fy_prop = Fy*p1*p2/((s + p1)*(s + p2));

% plot the result
figure(1)
margin(minreal(Fy*G));
hold on;
margin(minreal(Fy_prop*G));

figure(2)
bode(minreal(Gd/(1 + Fy*G)));
hold on;
bode(minreal(Gd/(1 + Fy_prop*G)));

figure(3)
step(minreal(Gd/(1 + Fy*G)));
hold on;
step(minreal(Gd/(1 + Fy_prop*G)));

%% exe 4.2.2
% define integral controller
wi = 0.5*wc;
Fy = (s + wi)*Gd/(s*G);

% approximation to make controller proper
p1 = 5*wc;
p2 = 5*wc;
Fy_prop = Fy*p1*p2/((s + p1)*(s + p2));

% plot the result
figure(4)
margin(minreal(Fy*G));
hold on;
margin(minreal(Fy_prop*G));

figure(5)
bode(minreal(Gd/(1 + Fy*G)));
hold on;
bode(minreal(Gd/(1 + Fy_prop*G)));

figure(6)
step(minreal(Gd/(1 + Fy*G)));
hold on;
step(minreal(Gd/(1 + Fy_prop*G)));

%% exe 4.2.3
% define parameters
pm = 30;
wd = wc + 6;
tau = 0.12;

% construct lead compensator
[~, p_lag] = bode(Fy_prop*G, wd);
p_lead = 180 - (p_lag - pm);
beta = (1 - sin(deg2rad(p_lead)))/(1 + sin(deg2rad(p_lead)));
Td = 1/(wd*sqrt(beta));
F_lead = (Td*s + 1)/(beta*Td*s + 1);
K = 1/abs(evalfr(Fy_prop*G*F_lead, j*wd));
F_lead = K*(Td*s + 1)/(beta*Td*s + 1);

% obtain Fy and Fr
Fy = Fy_prop*F_lead;
Fr = 1/(tau*s + 1);

% plot the results
figure(7)
bode(minreal(1/(1 + Fy*G)));
hold on;
bode(minreal(Fy*G/(1 + Fy*G)));

figure(8)
step(minreal(Fr*Fy*G/(1 + Fy*G)));

figure(9)
step(minreal(Gd/(1 + Fy*G)));





