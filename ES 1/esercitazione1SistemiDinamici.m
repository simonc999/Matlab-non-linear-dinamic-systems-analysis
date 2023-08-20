close 
clear
clc

%% 1) dinamiche periodiche 

% Simulare il seguente sistema dinamico sull’intervallo [0, 20] mediante
% la function Matlab ode15s (v. help ode15s o la reference page linkata al 
% fondo dell help page o la documentazione 
% https://it.mathworks.com/help/matlab/ref/ode15s.html):

% LE SOLUZIONI DI QUESTI SISTEMI POSSONO ESSERE VISULIZZATI DAI PLOT DELLE
% DUE VARIABILI DI STATO NEL TEMPO O DAL GRAFICO DELLE FASI (Y2 VS Y1) CHE
% IN QUESTO CASO AVENDO DUE DIMENSIONI SARA' UNA TRAIETTORIA NEL PIANO (SE
% FOSSERO 3 SARA' NELLO SPAZIO)

y0 = [3 -3] ;

T = [0 20];

%con µ = 1 e µ = 0.5.

mu = 1;
mu1 = 0.5;

[T,Y] = ode15s(@(t,y) sis1(t,y,mu),T,y0);

[T_1,Y_1] = ode15s(@(t,y) sis1(t,y,mu1),T,y0);

% Si visualizzi, in una figura composta da 2 × 2 pannelli, 
% l evoluzione di


% MODULO
r = sqrt(Y(:,1).^2+Y(:,2).^2);
r1 = sqrt(Y_1(:,1).^2+Y_1(:,2).^2);


figure('Name','Dinamiche periodiche','NumberTitle','off')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% mu = 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,1)                      % ORBITA DI Y1 E Y2 MU = 1
plot(T,Y)
title('y1 e y2 vs t MU = 1');
xlabel('t');
legend('y1','y2');


subplot(3,2,3)                      % EVOLUZIONE DI R MU = 1
plot(T,r);
title('r vs t MU = 1');
xlabel('t');


subplot(3,2,5)                      % Y1 (x) E Y2 (y) MU = 1
plot(Y(:,1),Y(:,2));
title('y1 vs y2 MU = 1');
ylabel('y2');
xlabel('y1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% mu = 0.5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,2)                      % ORBITA DI Y1 E Y2 MU = 0.5
plot(T_1,Y_1)
title('y1 e y2 vs t MU = 0.5');
xlabel('t');
legend('y1','y2');


subplot(3,2,4)                      % EVOLUZIONE DI R MU = 0.5
plot(T_1,r1);
title('r vs t MU = 0.5');
xlabel('t');


subplot(3,2,6)                      % Y1 (x) E Y2 (y) MU = 0.5
plot(Y_1(:,1),Y_1(:,2));
title('y1 vs y2 MU = 0.5');
ylabel('y2');
xlabel('y1');

% COME LO LEGGO?
% NEL PRIMO HO CORDINATE NEL TEMPO A T=0 Y1 è A -3 E Y2 A 3
% NELL'ORBITA VEDO CHE SONO A -3 E 3 DI COORDINATE
% QUINDI POI OSCILLERANNO IN TONDO

% TRAIETTORIA= ORBITA: PLOTTO Y2 E Y1 UNA IN FUNZIONE DELL'ALTRA (IL TEMPO
% DIVENTA UN PARAMETRO CHE FISSO)

%% 2)  Dinamiche quasi-periodiche. 

clc
clear

% in questo es il sistema è rappresentato da funzioni istantanee che non
% dipendono dalle funzioni degli altri parametri, quindi non ,i serve ode


% Si visualizzi sull intervallo [0,100] e [0,300] l’evoluzione delle 
% funzioni con la relativa orbita {u2(t) contro u1(t)} nell intervallo 
% [0,100]. 

% u1 e u2 sembrano periodiche indipendentemente dal parametro a,
% se invece vedo il grafico dell'orbita, vedo che in realtà non passano
% esattamente dagli stessi punti: il raggio si accorcia, istante per
% istante la traiettoria si sposta.

% nb. se a = radice(2) è giusto che venga molto uguale al grafico iniziale

t100=(0:0.01:100); 
t300=(0:0.01:300); 

a1 = pi/3.1;
a2 = sqrt(2); 


u_100 = exp(-t100)+sin(t100)+cos(sqrt(2)*t100);
u_300 = exp(-t300)+sin(t300)+cos(sqrt(2)*t300);

u1_100 = exp(-t100)+sin(t100);
u1_300 = exp(-t300)+sin(t300);

u2_100_a1 = exp(-t100)+cos(a1*t100);
u2_300_a1 = exp(-t300)+cos(a1*t300);

u2_100_a2 = exp(-t100)+cos(a2*t100);
u2_300_a2 = exp(-t300)+cos(a2*t300);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% curve in t %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Dinamiche quasi-periodiche nel tempo','NumberTitle','off')

subplot(4,2,1)                      % PLOT U in t [0 100]
plot(t100,u_100);
title('u vs t');
subtitle('u(t) - t100')
xlabel('t [0 100]');
ylabel('u');

subplot(4,2,3)                      % PLOT U1 in t [0 100]
plot(t100,u1_100);
title('u1 vs t');
subtitle('u1(t) - t100')
xlabel('t [0 100]');
ylabel('u1');

subplot(4,2,5)                      % PLOT U2 a = pi/3.1 in t [0 100] 
plot(t100,u2_100_a1);
subtitle('u2(t) - t100 - a1')
title('u2 vs t a = pi/3.1');
xlabel('t [0 100]');
ylabel('u2');

subplot(4,2,7)                      % PLOT U2 a = sqrt(2) in t [0 100] 
plot(t100,u2_100_a2,'r');
title('u2 vs t a = sqrt(2)');
subtitle('u2(t) - t100 - a2')
xlabel('t [0 100]');
ylabel('u2');



% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %
subplot(4,2,2)                      % PLOT U in t [0 300]
plot(t300,u_300);
title('u vs t');
subtitle('u(t) - t300')
xlabel('t [0 300]');
ylabel('u');

subplot(4,2,4)                      % PLOT U1 in t [0 300]
plot(t300,u1_300);
title('u1 vs t');
subtitle('u1(t) - t300')
xlabel('t [0 300]');
ylabel('u1');

subplot(4,2,6)                      % PLOT U2 a = pi/3.1 in t [0 300]
plot(t300,u2_300_a1);
title('u2_1 vs t a = pi/3.1');
subtitle('u2(t) - t300 - a1')
xlabel('t [0 300]');
ylabel('u2_1');

subplot(4,2,8)                      % PLOT U2 a = sqrt(2) in t [0 300]
plot(t300,u2_300_a2,'r');
title('u2 vs t a = sqrt(2)');
subtitle('u2(t) - t300 - a2')
xlabel('t [0 300]');
ylabel('u2');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%% u1 vs u2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Dinamiche quasi-periodiche u1 vs u2','NumberTitle','off')

subplot(2,2,1)                      % PLOT U1 vs U2 a = pi/3.1 t [0 100]
comet(u1_100,u2_100_a1);
title('u1 vs u2');
subtitle('t100 a = pi/3.1')
xlabel('u1');
ylabel('u2');

subplot(2,2,2)                      % PLOT U1 vs U2 a = sqrt(2) t [0 100]
comet(u1_100,u2_100_a2);
title('u1 vs u2 a = sqrt(2)');
subtitle('t100 a = rad(2)')
xlabel('u1');
ylabel('u2');


subplot(2,2,3)                      % PLOT U1 vs U2 a = pi/3.1 t [0 300]
comet(u1_300,u2_300_a1);
subtitle('t300 a = pi/3.1')
title('u1 vs u2');
xlabel('u1');
ylabel('u2');

subplot(2,2,4)                      % PLOT U1 vs U2 a = sqrt(2) t [0 300]
comet(u1_300,u2_300_a2);
title('u1 vs u2 a = sqrt(2)');
subtitle('t300 a = rad(2)')
xlabel('u1');
ylabel('u2');



%% 3) Dinamiche caotiche: sistema di Lorenz. 


clc
clear

% Si simuli e visualizzi, in una figura con 1 × 4 pannelli, 
% l’evoluzione di y1(t),y2(t),y3(t),r(t) 
% soluzioni del sistema di Lorenz nell intervallo [0,300].
% Si visualizzi l’orbita nello spazio tridimensionale.

y0 = [0 10 0] ;

T = [0 300];
sigma = 10;
R = 28;
b = 8/3;

[T,Y] = ode15s(@(t,y) sis2(t,y,sigma,R,b),T,y0);

r = sqrt(Y(:,1).^2+Y(:,2).^2);

% %%%%%%%%%%%%%%%%%%%%%%%% PLOT NEL TEMPO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Dinamiche caotiche:y1,y2,y3 vs t','NumberTitle','off')
subplot(1,4,1)
plot(T,Y(:,1))
title('y1 vs t');
xlabel('t');

subplot(1,4,2)
plot(T,Y(:,2))
title('y2 vs t');
xlabel('t');

subplot(1,4,3)
plot(T,Y(:,3))
title('y3 vs t');
xlabel('t');

subplot(1,4,4)
plot(T,r);
title('r vs t');
xlabel('t');

% %%%%%%%%%%%%%%%%%%%%%%%% ORBITA SPAZIO 3D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Dinamiche caotiche:sistema di Lorenz','NumberTitle','off')

plot3(Y(:,1),Y(:,2),Y(:,3));
title('orbita di Lorenz');
xlabel('y1(t)')
ylabel('y2(t)')
zlabel('y3(t)')

%% 4) Moto di un corpo in orbita attorno ad un altro corpo

p = 0.25; % rho
alpha = pi/4;
y0 = [1-p 0 0 alpha*sqrt((1+p)/(1-p))] ;% con µ = 1 e µ = 0.5.

T = [0 100];

T2 = [0 200];

T3 = [0 300];

[T,Y] = ode15s(@(t,y) sis3(t,y,alpha),T,y0);

[T2,Y2] = ode15s(@(t,y) sis3(t,y,alpha),T2,y0);

[T3,Y3] = ode15s(@(t,y) sis3(t,y,alpha),T3,y0);



r = sqrt(Y(:,1).^2+Y(:,2).^2);
r2 = sqrt(Y2(:,1).^2+Y2(:,2).^2);

r3 = sqrt(Y3(:,1).^2+Y3(:,2).^2);


figure('Name','Moto di un corpo in orbita attorno ad un altro corpo','NumberTitle','off')
subplot(3,3,1)
plot(T,Y(:,[1 2]))
title('y1 e y2 vs t100');
xlabel('t');
legend('y1','y2');

subplot(3,3,4)
plot(T,r);
title('r vs t100');
xlabel('t');

subplot(3,3,7)
plot(Y(:,2),Y(:,1));
title('orbita t100');
ylabel('y2');
xlabel('y1');



subplot(3,3,2)
plot(T2,Y2(:,[1 2]))
title('y1 e y2 vs t200');
xlabel('t');
legend('y1','y2');

subplot(3,3,5)
plot(T2,r2);
title('r vs t200');
xlabel('t');

subplot(3,3,8)
plot(Y2(:,2),Y2(:,1));
title('orbita t200');
ylabel('y2');
xlabel('y1');



subplot(3,3,3)
plot(T3,Y3(:,[1 2]))
title('y1 e y2 vs t300');
xlabel('t');
legend('y1','y2');

subplot(3,3,6)
plot(T3,r3);
title('r vs t300');
xlabel('t');

subplot(3,3,9)
plot(Y3(:,2),Y3(:,1));
title('orbita t300');
ylabel('y2');
xlabel('y1');


% faccio il test modificando le tolleranze


 OPT=odeset('RelTol', 1e-29, 'AbsTol', 1e-29);

T4 = [0 300];

[T4,Y4] = ode15s(@(t,y) sis3(t,y,alpha),T4,y0,OPT);

r4 = sqrt(Y4(:,1).^2+Y4(:,2).^2);

figure('Name','Moto di un corpo in orbita attorno ad un altro corpo CORRETTO CON TOLLERANZE','NumberTitle','off')
subplot(3,1,1)
plot(T4,Y4(:,[1 2]))
title('y1 e y2 vs t300');
xlabel('t');
legend('y1','y2');

subplot(3,1,2)
plot(T4,r4);
title('r vs t300');
xlabel('t');

subplot(3,1,3)
plot(Y4(:,2),Y4(:,1));
title('orbita t300');
ylabel('y2');
xlabel('y1');
