close all;
clear all;
clc;

s = tf('s');

%% Minimum Phase Model
disp('Minimum Phase Model: ****************');
G = nonminphase;
G0_mp = dcgain(G) % Steady State Matrix
RGA_mp = G0_mp .* (inv(G0_mp))'

%% Static Decoupling
% disp('Exercise 3.1.1:');
% W1 = inv(G0_mp)
% G_tilde = G * W1;
% figure(1);
% bode(G_tilde);
% grid on;
% 
% disp('Exercise 3.1.2:');
% pm_cmd_rad = pi / 3;
% wc_cmd_rad_s = 0.1;
% 
% g11 = G_tilde(1, 1);
% [k11, t11] = ComputePI(pm_cmd_rad, wc_cmd_rad_s, g11);
% f11 = k11 * (1 + 1/(t11*s));
% l11 = g11 * f11; % Loop Gain
% 
% g22 = G_tilde(2, 2);
% [k22, t22] = ComputePI(pm_cmd_rad, wc_cmd_rad_s, g22);
% f22 = k22 * (1 + 1/(t22*s));
% l22 = g22 * f22; % Loop Gain
% 
% F_tilde = tf('s');
% F_tilde(1, 1) = f11;
% F_tilde(2, 2) = f22;
% F_tilde(1, 2) = 0;
% F_tilde(2, 1) = 0;
% F_tilde
% F = W1 * F_tilde
% 
% figure(2);
% subplot(1, 2, 1);
% margin(l11);
% grid on;
% legend('l11');
% subplot(1, 2, 2);
% margin(l22);
% grid on;
% legend('l22');
% 
% disp('Exercise 3.1.3:');
% S = minreal(inv((eye(2) + G) * F));
% figure(3);
% subplot(1, 2, 1);
% sigma(S);
% legend('S');
% grid on;
% T = minreal(S * G * F);
% subplot(1, 2, 2);
% sigma(T);
% legend('T');
% grid on;

%% Dynamical Decoupling
w11 = tf(1); 
w22 = tf(1);
g11 = G(1, 1);
g22 = G(2, 2);
g12 = G(1, 2);
g21 = G(2, 1);
% w12 = - g12 / g11;
% w21 = - g21 / g22;
w12 = - g11 / g12;
w21 = - g22 / g21;

disp('Exercise 3.2.1:');
% W1 = [w11 w12; w21 w22]
W1 = [w12 w11; w22 w21]
W1 = W1*0.2/(s + 0.2);
G_tilde = minreal(G * W1);
figure(4);
bode(G_tilde);
grid on;

disp('Exercise 3.2.2:');
pm_cmd_rad = pi / 3;
wc_cmd_rad_s = 0.02;

g11 = G_tilde(1, 1);
[k11, t11] = ComputePI(pm_cmd_rad, wc_cmd_rad_s, g11);
f11 = k11 * (1 + 1/(t11*s));
l11 = g11 * f11; % Loop Gain

g22 = G_tilde(2, 2);
[k22, t22] = ComputePI(pm_cmd_rad, wc_cmd_rad_s, g22);
f22 = k22 * (1 + 1/(t22*s));
l22 = g22 * f22; % Loop Gain

F_tilde = tf('s');
F_tilde(1, 1) = f11;
F_tilde(2, 2) = f22;
F_tilde(1, 2) = 0;
F_tilde(2, 1) = 0;
F_tilde = minreal(F_tilde)
F = minreal(W1 * F_tilde)

figure(5);
subplot(1, 2, 1);
margin(l11);
grid on;
legend('l11');
subplot(1, 2, 2);
margin(l22);
grid on;
legend('l22');

disp('Exercise 3.2.3:');
S = minreal(inv((eye(2) + G) * F));
figure(6);
subplot(1, 2, 1);
sigma(S);
legend('S');
grid on;
T = minreal(S * G * F);
subplot(1, 2, 2);
sigma(T);
legend('T');
grid on;

%% Glover-McFarlane robust loop-shaping
disp('Exercise 3.3.1:');
L0 = minreal(G * W1 * F_tilde)
figure(7);
bode(L0);
grid on;
 
disp('Exercise 3.3.2:');
alpha = 1.1;
[Fr, gama] = rloop(L0, alpha);
disp(['gama = ', num2str(gama)]);
F = minreal(W1 * F_tilde * Fr)
 
disp('Exercise 3.3.3:');
S = inv((eye(2) + G) * F);
figure(8);
subplot(1, 2, 1);
sigma(S);
legend('S');
grid on;
T = minreal(S * G * F);
subplot(1, 2, 2);
sigma(T);
legend('T');
grid on;
