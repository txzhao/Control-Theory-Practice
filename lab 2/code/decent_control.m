clear all

s = tf('s');
% minphase control
sysmp = minphase; 
G = tf(sysmp);
wc = 0.1;
pm = pi/3;
I = diag([2,2]);
%desigin controller
[K11 T11] = PIcontroller(G(1,1),wc,pm);
[K22 T22] = PIcontroller(G(2,2),wc,pm);

f11 = K11 * (1 + 1 / (s*T11));
f22 = K22 * (1 + 1 / (s*T22));
l11 = f11 * G(1,1);
l22 = f22 * G(2,2);
l12 = f11 * G(1,2);
l21 = f22 * G(2,1);
figure(1)
subplot(2,2,1)
margin(l11);
subplot(2,2,2)
margin(l12);
subplot(2,2,3)
margin(l21);
subplot(2,2,4)
margin(l22);

F = [f11 0; 0 f22];
% sensitivity and complementary
S = minreal(inv(I + G*F));
T = minreal(G*F*S);
%start simulink
sim('closedloop')
figure(2)
subplot(1,2,1)
plot(uout);
legend('u1','u2');
title('control signal response of miniphase system');
subplot(1,2,2)
plot(yout);
legend('y1','y2');
hold on 
plot(input1);
plot(input2);
title('output response of miniphase system');


% nonminphase control
sysnmp = nonminphase; 
G = tf(sysnmp);
G0 = dcgain(sysmp);
RGA = G0.*(inv(G0))'
wc = 0.02;
pm = pi/3;
I = diag([2,2]);
%desigin controller
[K12 T12] = PIcontroller(G(1,2),wc,pm);
[K21 T21] = PIcontroller(G(2,1),wc,pm);

f12 = K12 * (1 + 1 / (s*T12));
f21 = K21 * (1 + 1 / (s*T21));
l12 = f12 * G(1,2);
l21 = f21 * G(2,1);
figure(3)
subplot(2,1,1)
margin(l12);
subplot(2,1,2)
margin(l21);

F = [0 f12; f21 0];
% sensitivity and complementary
S = minreal(inv(I + G*F));
T = minreal(G*F*S);

sim('closedloop');
figure(4)
subplot(1,2,1)
plot(uout);
legend('u1','u2');
title('control signal response of nonminphase system');
subplot(1,2,2)
plot(yout);
legend('y1','y2');
hold on 
plot(input1);
plot(input2);
title('output response of nonminiphase system');


