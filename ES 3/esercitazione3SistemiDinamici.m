%% %%%%%%%%%%%%%%%%%%%%%%%%%%% ES 3.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Metodo RK4 con passo variabile

clear;
close all;
clc;

% dati e condizioni iniziali
y0 = [0.1,1];
mu = -5;
T = 10;
A=[mu 0;(1+mu) -1];


%A=[1 1 ; 1 1];
autovalori = eig(A);
[V,D,W] = eig(A) ;
S=[0,1;1,1];
S_INV=inv(S);
ris= exp([0,0;0,2]);

%% Soluzione esatta

%scelgo un passo
ht = 0.1;
hp = 0.3; %a k = 0.56 la soluzione non è più decrescente

%osservo che c'è una fase di transitorio in cui se il passo è troppo grande
% (es: 0.5) l'errore è grande e serve un passo più piccolo
%nella fase successiva al transitorio si potrebbe usare un passo più grande
%ma non troppo altrimenti la soluzione diverge (max 0.5)
%per h = 0.56 la soluzione non è più monotona decrescente


%% Soluzione approssimata con scelta del passo di integrazione

t = 0:0.01:10;

%regime transitorio per t < 4/|mu| con passo ht = 0.1
%regime permanente per t >= 4/|mu| con passo hp da trovare
t1 = 0:ht:t(find(t == 4/abs(mu))-1); %faccio -1 perchè ho minore stretto
t2 = t(t == 4/abs(mu)):hp:T;

tf = [t1,t2];

h = zeros(1,length(tf));

%mi costruisco il vettore degli h in modo da poterlo usare nel metodo RK4
for i = 1:(length(tf)-1)
    h(i) = tf(i+1) - tf(i);
end

%calcolo soluzione esatta
y = sol_esatta(tf,mu);

%implemento RK4
u = RK4(tf,mu,y0,h);

%% Errori
[er1,er2,Einf,E2,nye,nya] = calcola_errori(y,u);

%grafici
figure('Name','Errori','NumberTitle','off');

subplot(2,2,1)
plot(tf,y(:,1),tf,u(:,1),'--',tf,y(:,2),tf,u(:,2),'--');
legend('ye1','ya1','ye2','ya2');
title('Soluzioni vs tempo'), xlabel('t'), ylabel('Soluz. esatta (ye) e approssimata (ya)');

subplot(2,2,2)
plot(tf,er1,tf,er2);
legend('er1','er2');
title('Errori vs tempo'), xlabel('t'), ylabel('Errori');

subplot(2,2,3)
plot(tf,nye,tf,nya);
legend('nye','nya');
title('Norme vs tempo'), xlabel('t'), ylabel('Norma 2 della soluz. esatta e approssimata');

subplot(2,2,4)
plot(u(:,1),u(:,2),'--',y(:,1),y(:,2));
legend('Orbita approssimata','Orbita esatta');
title('Orbite'), xlabel('ya1,ye1'), ylabel('ya2,ye2');