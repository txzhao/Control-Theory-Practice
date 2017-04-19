function [K, T] = PIcontroller(G, wc, pm)

s = tf('s');
[~, phi] = bode(G, wc);
phi = wrapToPi(pi/180*phi);
T = tan(pm - pi/2 - phi)/ wc;
l = G * (1 + 1/(s*T));
K = 1 / abs(evalfr(l, j*wc));

end