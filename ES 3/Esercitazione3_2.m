%% Regioni di stabilità per metodi Runge - Kutta
clear;
close all;
clc;

%definisco la mesh complessa
x = -3:0.1:3;
y = x;

[X,Y] = meshgrid(x,y);
Z = X + 1i*Y;

%% Eulero esplicito
A = 0;
b = 1;

r_EE = funz_stabilita(Z,A,b);

figure('Name','Regione di stabilità EE','NumberTitle','off');
subplot(1,2,1)
contour(X,Y,abs(r_EE),0:0.01:1);
xlabel('Re'), ylabel('Im'), axis('equal');
subplot(1,2,2)
surf(X,Y,min(abs(r_EE),1));
sgtitle('Regione di stabilità EE');

%% Eulero implicito
A = 1;
b = 1;

r_EI = funz_stabilita(Z,A,b);

figure('Name','Regione di stabilità EI','NumberTitle','off');
subplot(1,2,1)
contour(X,Y,abs(r_EI),0:0.01:1);
xlabel('Re'), ylabel('Im'), axis('equal');
subplot(1,2,2)
surf(X,Y,min(abs(r_EI),1));
sgtitle('Regione di stabilità EI');

%% RK2 con alpha = 1/2
alpha = 1/2;
A = [0 0; alpha 0];
b = [1-1/(2*alpha); 1/(2*alpha)];

r_RK2_05 = funz_stabilita(Z,A,b);

figure('Name','Regione di stabilità RK2','NumberTitle','off');
subplot(1,2,1)
contour(X,Y,abs(r_RK2_05),0:0.01:1);
xlabel('Re'), ylabel('Im'), axis('equal');
subplot(1,2,2)
surf(X,Y,min(abs(r_RK2_05),1));
sgtitle('Regione di stabilità RK2, alpha = 1/2');

%% RK2 con alpha = 1 (Heun)
alpha = 1;
A = [0 0; alpha 0];
b = [1-1/(2*alpha); 1/(2*alpha)];

r_RK2_1 = funz_stabilita(Z,A,b);

figure('Name','Regione di stabilità RK2','NumberTitle','off');
subplot(1,2,1)
contour(X,Y,abs(r_RK2_1),0:0.01:1);
xlabel('Re'), ylabel('Im'), axis('equal');
subplot(1,2,2)
surf(X,Y,min(abs(r_RK2_1),1));
sgtitle('Regione di stabilità RK2, alpha = 1');

%% RK4
A = [0 0 0 0; ...
    1/2 0 0 0; ...
    0 1/2 0 0; ...
    0 0 1 0];
b = [1/6; 1/3; 1/3; 1/6];

r_RK4 = funz_stabilita(Z,A,b);

figure('Name','Regione di stabilità RK4','NumberTitle','off');
subplot(1,2,1)
contour(X,Y,abs(r_RK4),0:0.01:1);
xlabel('Re'), ylabel('Im'), axis('equal');
subplot(1,2,2)
surf(X,Y,min(abs(r_RK4),1));
sgtitle('Regione di stabilità RK4');