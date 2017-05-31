figure(11);
plot(yout);
title('Closed Loop Command Response:Outputs - Minimum Phase');
legend('y1', 'y2');
grid on;

figure(12);
plot(uout);
title('Closed Loop Command Response:Inputs - Minimum Phase');
legend('u1', 'u2');
grid on;

figure(13);
plot(yout);
title('Closed Loop Command Response:Outputs - Non-Minimum Phase');
legend('y1', 'y2');
grid on;

figure(14);
plot(uout);
title('Closed Loop Command Response:Inputs - Non-Minimum Phase');
legend('u1', 'u2');
grid on;

