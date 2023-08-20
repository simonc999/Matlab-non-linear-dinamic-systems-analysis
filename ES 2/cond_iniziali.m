% SCELGO UN PASSO DI DISCRETIZZAZIONE (PIU' VALORI)
% prendo h=T-t0/n con n = 8000--> h=0.04

h = [h, h/2, h/4, h/8, h/16, h/32, h/64, h/128];
tspan=[0 20];
% 1. Implementare in Matlab i metodi precedenti con passo costante hn = h.

% A   2. Si produca la soluzione numerica del sistema dinamico per µ = 1, 
% B   sull'intervallo [0, 20] e 
% C   con le condizioni iniziali y01 = 1, y02 = −3, 
%   utilizzando il metodo a) ed il metodo b) con α = 1, e con α = 0.5.

h_ = h(8);     % 0: %scelgo uno dei passi (potrei farlo con tutti)


mu = 1;        % A: IMPOSTO MU = 1

t = min(tspan):h_:max(tspan); % B: DISCRETIZZAZIONE TEMPO DATO L'INTERVALLO


y0 = [1 -3];   % C: IMPOSTO I VALORI INIZIALI DEL PVI


%%%%%%%%%%%%%%%%%%%%% RK2 - HEUN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha = 0.5; % RK2

alpha_H = 1; % Heun