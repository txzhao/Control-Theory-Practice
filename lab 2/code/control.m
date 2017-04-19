clear all

% minphase
display('minphase')
sysmp = minphase;
%transfer function
display('transfer function of minphase')
G = tf(sysmp)
poles = pole(sysmp);
zeros = tzero(sysmp);

[A,B,C,D] = ssdata(sysmp);
[NUM,DEN] = tfdata(sysmp);

figure(1)
sigma(sysmp)
title('singular values for minphase');
% H infinity norm
peak = getPeakGain(sysmp);

G0 = dcgain(sysmp);
RGA = G0.*(inv(G0))'

%step response:
figure(2)
subplot(2,2,1)
step(G(1,1));
title('u1 to y1');
subplot(2,2,2)
step(G(1,2));
title('u2 to y1');
subplot(2,2,3)
step(G(2,1));
title('u1 to y2');
subplot(2,2,4)
step(G(2,2));
title('u2 to y2');

clear all

% nonminphase
display('nominphase')
sysnmp = nonminphase;
%transfer function
display('transfer function of nonminphase')
G = tf(sysnmp);
poles = pole(sysnmp);
zeros = tzero(sysnmp);

[A,B,C,D] = ssdata(sysnmp);
[NUM,DEN] = tfdata(sysnmp);

figure(3)
sigma(sysnmp)
title('singular values for nonminphase');
% H infinity norm
peak = getPeakGain(sysnmp);

G0 = dcgain(sysnmp);
RGA = G0.*(inv(G0))'

%step response:
figure(4)
subplot(2,2,1)
step(G(1,1));
title('u1 to y1');
subplot(2,2,2)
step(G(1,2));
title('u2 to y1');
subplot(2,2,3)
step(G(2,1));
title('u1 to y2');
subplot(2,2,4)
step(G(2,2));
title('u2 to y2');





