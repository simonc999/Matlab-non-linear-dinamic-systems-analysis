%% Metodi di Runge - Kutta impliciti
clear;
close all;
clc;

set(0,'DefaultLineLineWidth',1.5);

%dato iniziale, tempo finale e numero di passi
y0 = 1;
T = 1;
nsteps = 40;

%iterazioni e tolleranza del metodo di Newton
maxiter = 20; %newton converge velocissimo, non servono tante iterazioni
tol = 1e-10;

%matrice di Butcher
%Eulero Implicito
%B = [1 1; 0 1];
%Trapezi
B = [0 0 0; 1 0.5 0.5; 0 0.5 0.5];

%ricavo le tre sottomatrici a partire da quella di Butcher
c = B(1:end-1,1);
b = B(end, 2:end)';
A = B(1:end-1,2:end);

%discretizzazione del vettore dei tempi
t = linspace(0,T,nsteps);
h = T/(nsteps-1); %oppure h = t(2)-t(1);
nstages = length(c);

[Y, iter] = metodoNewton(t,h,A,b,c,y0,nsteps,nstages,tol,maxiter);

%soluzione esatta
yex = y0*exp(t)+t;

%plot soluzione esatta vs approssimata
figure()
plot(t, Y, 'o-', t, yex, 'r');
xlabel('t'), ylabel('y,u'), title('Soluzione esatta vs approssimata');
legend('Approssimata','Esatta');

%calcolare l'errore globale
err_globale = norm(yex-Y')/norm(yex);

%% Ordine di convergenza
%studiare l'ordine di convergenza del metodo risultante per es. eseguendo dei test dimezzando il passo h
%e riportando per ogni test l'errore globale ed il numero medio delle iterazioni di Newton

h_test = [h h/2 h/4 h/8 h/16 h/32 h/64 h/128]; %dimezzo h o raddoppio nsteps

err_globale_test = zeros(length(h_test),1);
num_medio_iter_test = zeros(length(h_test),1);

for i=1:length(h_test)

    t_test = 0:h_test(i):T;
    nsteps_test = length(t_test);

    [Y_test, it_test] = metodoNewton(t_test,h_test(i),A,b,c,y0,nsteps_test,nstages,tol,maxiter);

    yex = y0*exp(t_test)+t_test;
    num_medio_iter_test(i) = mean(it_test);
    err_globale_test(i) = norm(yex-Y_test')/norm(yex);

end

%verifico la convergenza
rate = zeros(length(err_globale_test)-1,1);
for i = 1:length(err_globale_test)-1
    rate(i) = err_globale_test(i)/err_globale_test(i+1);
end
figure()
plot(rate,'-o'); 
%nei trapezi: dividendo h per due, l'errore si divide per 4 --> convergenza quadratica
title('Studio della convergenza');