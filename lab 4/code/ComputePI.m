function [K, T] = ComputePI(pm_cmd_rad, wc_cmd_rad_s, G)
s = tf('s');
[~, phase_g_deg] = bode(G, wc_cmd_rad_s);
phase_g_rad = phase_g_deg / 180*pi;
T = tan(-pi/2 + pm_cmd_rad - phase_g_rad) / wc_cmd_rad_s;
F = 1 + 1/(T*s);
L = G * F;
[mag_l, ~] = bode(L, wc_cmd_rad_s);
K = 1 / mag_l;
end