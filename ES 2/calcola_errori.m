function [er1,er2,Einf,E2,nye,nya] = calcola_errori(y,u)
%Calcolo degli errori richiesti dall'esercitazione

ye1 = y(:,1); ye2 = y(:,2); %vettori soluzione esatta
ya1 = u(:,1); ya2 = u(:,2); %vettori soluzione numerica

er1 = zeros(1,length(u));
er2 = zeros(1,length(u));
Einf = zeros(1,length(u));
E2 = zeros(1,length(u));
nye = zeros(1,length(u));
nya = zeros(1,length(u));

for i = 1:length(u) %lungo come vettore tempi, quindi come u
    er1(i) = abs(ye1(i)-ya1(i));
    er2(i) = abs(ye2(i)-ya2(i));
    Einf(i) = norm((y(i,:)-u(i,:)),inf); % NORMA INFINITO
    E2(i) = norm((y(i,:)-u(i,:)),2);     % NORMA 2
    nye(i) = norm(y(i,:),2);             % NORMA SULLE 2 COMPONENTI
    nya(i) = norm(u(i,:),2);
end

end