close all
clear
clc
h = 0.04;
run cond_iniziali.m;

% INSERIMENTO DELLA SOLUZIONE ESATTA

y = sol_esatta(t,mu,y0); % D: calcolo soluzione esatta

% 1. IMPLEMENTO METODO
% 2. PASSO AL METODO IL SISTEMA sis.m
% 3. OTTENGO LA SOLUZIONE APPROSSIMATA
% 4. GUARDO DIFFERENZE CON QUELLA ESATTA


%% %%%%%%%%%%%%%%%% METODO 1:EULERO ESPLICITO %%%%%%%%%%%%%%%%%%%%%%%%%

u_EE = EE(t,mu,y0,h_);

[er1_EE,er2_EE,Einf_EE,E2_EE,nye_EE,nya_EE] = calcola_errori(y,u_EE);

%grafici
figure('Name','Eulero-Esplicito','NumberTitle','off');

subplot(2,2,1)
plot(t,y(:,1),t,u_EE(:,1),'--',t,y(:,2),t,u_EE(:,2),'--');
legend('ye1','ya1','ye2','ya2');
title('Soluzioni vs tempo'), xlabel('t'), ylabel('Soluz. esatta (ye) e approssimata (ya)');

subplot(2,2,2)
plot(t,er1_EE,t,er2_EE,t,Einf_EE,t,E2_EE);
legend('er1','er2','Einf','E2');
title('Errori vs tempo'), xlabel('t'), ylabel('Errori');

subplot(2,2,3)
plot(t,nye_EE,t,nya_EE);
legend('nye','nya');
title('Norme vs tempo'), xlabel('t'), ylabel('Norma 2 della soluz. esatta e approssimata');

subplot(2,2,4)
plot(u_EE(:,1),u_EE(:,2),y(:,1),y(:,2));
legend('Orbita approssimata','Orbita esatta');
title('Orbite'), xlabel('ya1,ye1'), ylabel('ya2,ye2');

sgtitle(['Eulero Esplicito h = ',num2str(h_)]);

%% %%%%%%%%%%%%%%%% METODO 2:RUNGE-KUTTA 2 %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% O EULERO IMPLICITO %%%%%%%%%%%%%%%%%%%%%%%%%%%%



u_RK2 = RK2(t,mu,y0,alpha,h_);

[er1_RK2,er2_RK2,Einf_RK2,E2_RK2,nye_RK2,nya_RK2] = calcola_errori(y,u_RK2);

%grafici
figure('Name','RK2','NumberTitle','off');

subplot(2,2,1)
plot(t,y(:,1),t,u_RK2(:,1),'--',t,y(:,2),t,u_RK2(:,2),'--');
legend('ye1','ya1','ye2','ya2');
title('Soluzioni vs tempo'), xlabel('t'), ylabel('Soluz. esatta (ye) e approssimata (ya)');

subplot(2,2,2)
plot(t,er1_RK2,t,er2_RK2,t,Einf_RK2,t,E2_RK2);
legend('er1','er2','Einf','E2');
title('Errori vs tempo'), xlabel('t'), ylabel('Errori');

subplot(2,2,3)
plot(t,nye_RK2,t,nya_RK2);
legend('nye','nya');
title('Norme vs tempo'), xlabel('t'), ylabel('Norma 2 della soluz. esatta e approssimata');

subplot(2,2,4)
plot(u_RK2(:,1),u_RK2(:,2),y(:,1),y(:,2));
legend('Orbita approssimata','Orbita esatta');
title('Orbite'), xlabel('ya1,ye1'), ylabel('ya2,ye2');

sgtitle(['RK2 h = ',num2str(h_),' alpha = ', num2str(alpha)]);

%% %%%%%%%%%%%%%%%% METODO 2:HEUN %%%%%%%%%%%%%%%%%%%%%%%%%

alpha_H = 1; % Heun


u_H = RK2(t,mu,y0,alpha_H,h_);

[er1_H,er2_H,Einf_H,E2_H,nye_H,nya_H] = calcola_errori(y,u_H);

%grafici
figure('Name','RK2','NumberTitle','off');

subplot(2,2,1)
plot(t,y(:,1),t,u_H(:,1),'--',t,y(:,2),t,u_H(:,2),'--');
legend('ye1','ya1','ye2','ya2');
title('Soluzioni vs tempo'), xlabel('t'), ylabel('Soluz. esatta (ye) e approssimata (ya)');

subplot(2,2,2)
plot(t,er1_H,t,er2_H,t,Einf_H,t,E2_H);
legend('er1','er2','Einf','E2');
title('Errori vs tempo'), xlabel('t'), ylabel('Errori');

subplot(2,2,3)
plot(t,nye_H,t,nya_H);
legend('nye','nya');
title('Norme vs tempo'), xlabel('t'), ylabel('Norma 2 della soluz. esatta e approssimata');

subplot(2,2,4)
plot(u_H(:,1),u_H(:,2),y(:,1),y(:,2));
legend('Orbita approssimata','Orbita esatta');
title('Orbite'), xlabel('ya1,ye1'), ylabel('ya2,ye2');

sgtitle(['HEUN h = ',num2str(h_),' alpha = ', num2str(alpha_H)]);


%% Ordine di convergenza dei metodi
clear
clc
h = 0.1;
run cond_iniziali.m
% 1. faccio norma2 nel tempo e la divido per la norma2 della soluzione
%    esatta
%    quindi ottengo uno scalare ad ogni test ad h fissato
%    ad esempio ho 100 punti, ripeto con h sempre più piccolo aumentando il
%    numero di punti
% 2. guardo ordine di convergenza o ad occhio 
%    o uso il metodo grafico plot log-log
%    asse y = errore in funzione di h
%    asse x = h che varia
%    p è la pendenza della retta plottando il log-log


err_EE = zeros(1,length(h));
err_EE_INF=zeros(1,length(h));

err_RK2 = zeros(1,length(h));
err_H = zeros(1,length(h));

err_EE_MAX=zeros(length(h),2);
err_RK2_MAX=zeros(length(h),2);
err_H_MAX=zeros(length(h),2);

for j = 1:length(h)

    %ricalcolo soluzione esatta per ogni passo
    tO = min(t):h(j):max(t);
    y = sol_esatta(tO,mu,y0);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    u = EE(tO,mu,y0,h(j));
    [e1,e2,~,E2,nye,~] = calcola_errori(y,u);

    err_EE(j) = norm(E2,2)/norm(nye,2); % !!!

    err_EE_MAX(j,1)=max(abs(e1));
    err_EE_MAX(j,2)=max(abs(e2));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    u = RK2(tO,mu,y0,alpha,h(j));
    [e1,e2,~,E2,nye,~]  = calcola_errori(y,u);
    err_RK2(j) = norm(E2,2)/norm(nye,2);  % !!!

    err_RK2_MAX(j,1)=max(abs(e1));
    err_RK2_MAX(j,2)=max(abs(e2));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    u = RK2(tO,mu,y0,alpha_H,h(j));
    [e1,e2,~,E2,nye,~]  = calcola_errori(y,u);
    err_H(j) = norm(E2,2)/norm(nye,2);  % !!!
    
    err_H_MAX(j,1)=max(abs(e1));
    err_H_MAX(j,2)=max(abs(e2));
end

%grafici
figure('Name','EE ordine di convergenza','NumberTitle','off');
loglog(h,err_EE,'-*r');
hold on
loglog(h,err_EE_MAX(:,1),'-*b');
hold on
loglog(h,err_EE_MAX(:,2),'-*g');
hold on
loglog(h,h,'--r');
hold on
loglog(h,h.^2,'--b');
hold on
loglog(h,h.^3,'--c');
hold on
loglog(h,h.^4,'--k');
grid on
title('Ordine di convergenza EE'), xlabel('log(h)'), ylabel('log(e)');
legend('Errore','ErroreMAX_y1','ErroreMAX_y2','O(h)', 'O(h^2)','O(h^3)', 'O(h^4)');
sgtitle(['EE h = ',num2str(h(end))]);

figure('Name','RK2 ordine di convergenza','NumberTitle','off');
loglog(h,err_RK2,'-*r');
hold on
loglog(h,err_RK2_MAX(:,1),'-*b');
hold on
loglog(h,err_RK2_MAX(:,2),'-*g');
hold on
loglog(h,h,'--r');
hold on
loglog(h,h.^2,'--b');
hold on
loglog(h,h.^3,'--c');
hold on
loglog(h,h.^4,'--k');
grid on
title(['Ordine di convergenza RK2 alpha = ', num2str(alpha)]), xlabel('log(h)'), ylabel('log(e)');
legend('Errore','ErroreMAX_y1','ErroreMAX_y2','O(h)', 'O(h^2)','O(h^3)', 'O(h^4)');
sgtitle(['RK2 h = ',num2str(h(end))]);

figure('Name','HEUN ordine di convergenza','NumberTitle','off');
loglog(h,err_H,'-*r');
hold on
loglog(h,err_H_MAX(:,1),'-*b');
hold on
loglog(h,err_H_MAX(:,2),'-*g');
hold on
loglog(h,h,'--r');
hold on
loglog(h,h.^2,'--b');
hold on
loglog(h,h.^3,'--c');
hold on
loglog(h,h.^4,'--k');
grid on
title(['Ordine di convergenza HEUN alpha = ', num2str(alpha_H)]), xlabel('log(h)'), ylabel('log(e)');
legend('Errore','ErroreMAX_y1','ErroreMAX_y2','O(h)', 'O(h^2)','O(h^3)', 'O(h^4)');
sgtitle(['HEUN h = ',num2str(h(end))]);

%% %%%%%%%%%%%%%%%%%%%%%%%%% ES 2.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
close all;
clc;
h= 0.1;
run cond_iniziali.m;

%% Implemento la soluzione esatta

y = sol_esatta(t,mu,y0);  % calcolo soluzione esatta


%% RK4

u_RK4 = RK4(t,mu,y0,h_);

[er1_RK4,er2_RK4,Einf_RK4,E2_RK4,nye_RK4,nya_RK4] = calcola_errori(y,u_RK4);

% grafici
figure('Name','RK4','NumberTitle','off');

subplot(2,2,1)
plot(t,y(:,1),t,u_RK4(:,1),'--',t,y(:,2),t,u_RK4(:,2),'--');
legend('ye1','ya1','ye2','ya2');
title('Soluzioni vs tempo'), xlabel('t'), ylabel('Soluz. esatta (ye) e approssimata (ya)');

subplot(2,2,2)
plot(t,er1_RK4,t,er2_RK4,t,Einf_RK4,t,E2_RK4);
legend('er1','er2','Einf','E2');
title('Errori vs tempo'), xlabel('t'), ylabel('Errori');

subplot(2,2,3)
plot(t,nye_RK4,t,nya_RK4);
legend('nye','nya');
title('Norme vs tempo'), xlabel('t'), ylabel('Norma 2 della soluz. esatta e approssimata');

subplot(2,2,4)
plot(u_RK4(:,1),u_RK4(:,2),y(:,1),y(:,2));
legend('Orbita approssimata','Orbita esatta');
title('Orbite'), xlabel('ya1,ye1'), ylabel('ya2,ye2');

sgtitle(['RK4 h = ',num2str(h_)]);


%% Ordine di convergenza

err_RK4 = zeros(1,length(h));
err_RK4_MAX=zeros(length(h),2);
for j = 1:length(h)

    %ricalcolo soluzione esatta per ogni passo
    t = min(tspan):h(j):max(tspan);
    y = sol_esatta(t,mu,y0);

    u = RK4(t,mu,y0,h(j));
    
    [e1,e2,~,E2,nye,~]  = calcola_errori(y,u);
    err_RK4(j) = norm(E2,2)/norm(nye,2);
    
    err_RK4_MAX(j,1)=max(abs(e1));
    err_RK4_MAX(j,2)=max(abs(e2));
end

figure('Name','Ordine di convergenza RK4','NumberTitle','off');
loglog(h,err_RK4,'-*r');
hold on
loglog(h,err_RK4_MAX(:,1),'-*b');
hold on
loglog(h,err_RK4_MAX(:,2),'-*g');
hold on
loglog(h,h,'--r');
hold on
loglog(h,h.^2,'--b');
hold on
loglog(h,h.^3,'--c');
hold on
loglog(h,h.^4,'--k');
grid on
title('Ordine di convergenza RK4'), xlabel('log(h)'), ylabel('log(e)');
legend('Errore','ErroreMAX_y1','ErroreMAX_y2','O(h)', 'O(h^2)','O(h^3)', 'O(h^4)');
sgtitle(['RK4 h = ',num2str(h(end))]);
