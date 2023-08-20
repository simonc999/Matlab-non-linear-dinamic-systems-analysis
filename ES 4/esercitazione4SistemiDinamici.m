%% Metodi Multistep Lineari MML
clear;
close all;
clc;

% dati

tspan = [0 10];
y0 = [1.5 1];

% il sistema ha un parametro epsilon da variare

epsilon = [1e-1 1e-2 1e-3];

% ma mano che epsilon va verso zero, il sistema diventa più stiff




%% %%%%% 1-->  Risolvere numericamente il sistema dinamico (PVI) %%%%%%%%%%
% CON epsilon = 10^-2 e epsilon = 10^-3
% usando le subroutines Matlab ode113, ode15s, ode45
% con le tolleranze di default

e = epsilon(1);

[t,y] = ode113(@f, tspan, y0, [], e);        % NSTEP= 6258       
%[t,y] = ode45(@f, tspan, y0, [], e);        % NSTEP= 12081
%[t,y] = ode15s(@f, tspan, y0, [], e);      % NSTEP= 81

% RISULTATI


y1 = y(:,1); 
y2 = y(:,2);

%% Soluzione esatta
% SISTEMA 

ye = soluzione_esatta(t,y0,e);


%% Risultati
%riportare per ogni caso il numero dei passi richiesti e l'errore relativo
%in norma 2 con la soluzione esatta

npassi = length(t);
err = [norm(ye(:,1)-y1), norm(ye(:,2)-y2)]; %se non metto niente è norma 2
norma_err = norm(err);


%% Grafici animati
% produrre i 2 usuali plot delle soluzioni
% il primo delle due componenti t,y1(t) e t,y2(t) in tempo
% uno della traiettoria nello spazio delle fasi y1,y2
% animare questi due plot in funzione del tempo

figure('Name', 'Plot animato delle soluzioni', 'NumberTitle', 'off');

subplot(1,2,1)
axis([tspan, 0 1.5]);
aline1 = animatedline('Color','m','LineWidth',1.5);
aline2 = animatedline('Color','b','LineWidth',1.5);
grid on;
for k = 1:length(t)
    addpoints(aline1,t(k),y1(k));
    addpoints(aline2,t(k),y2(k));
    drawnow
    xlabel('t'); ylabel('y_1,y_2'); title('Plot delle soluzioni');
    legend('y_1','y_2');
end

subplot(1,2,2)
plot(y1,y2,'g','LineWidth',1.5);
xlabel('y_1'), ylabel('y_2'), title('Traiettoria');
grid on;

figure('Name', 'Plot delle soluzioni', 'NumberTitle', 'off');
subplot(1,2,1)



%% Campo di direzioni
%tracciare il campo di direzioni del sistema dinamico per i tre valori di
%epsilon [1e-1 1e-2 1e-3]

% DISCRETIZZO LA SOLUZIONE CON LA MESHGRID
for i = 1:length(epsilon)

    e=epsilon(i);

    %[t,y] = ode113(@f, tspan, y0, [], e); ode="115";        % NSTEP= 6258
    [t,y] = ode45(@f, tspan, y0, [], e);  ode="45";      % NSTEP= 12081
    %[t,y] = ode15s(@f, tspan, y0, [], e); ode="15s";     % NSTEP= 81

    y1 = y(:,1);
    y2 = y(:,2);

    [Y1,Y2] = meshgrid(0:0.1:1.5, 0:0.1:1.5);
    dY1 = (1/e)*(-Y1+Y2./(1+Y2)) - Y2./(1+Y2)^2;
    dY2 = -Y2;

    figure('Name', 'Campo di direzioni', 'NumberTitle', 'off');
    quiver(Y1,Y2,dY1,dY2);
    hold on
    plot(y1,y2,'g','LineWidth',1.5);
    xlabel('y_1'), ylabel('y_2'), title('Campo di direzioni');
    sgtitle(['Campo direzioni --> epsilon = ',num2str(e), 'con ode', num2str(ode)]);

end
