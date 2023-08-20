function u = RK4(t,mu,y0,h)
%Funzione che implementa il metodo RK4, ricordarsi di cambiare il PVI

%verifico se il passo è costante (k è un numero) o variabile (k è un vettore)

u = zeros(length(t),2);
K1 = zeros(length(t),2);
K2 = zeros(length(t),2);
K3 = zeros(length(t),2);
K4 = zeros(length(t),2);
u(1,:) = y0;

if length(h) == 1 %passo costante
    for n = 1:(length(t)-1)
        K1(n,:) = sis(u(n,:),mu);
        K2(n,:) = sis(u(n,:) + (h/2)*K1(n,:),mu);
        K3(n,:) = sis(u(n,:) + (h/2)*K2(n,:),mu);
        K4(n,:) = sis(u(n,:) + h*K3(n,:),mu);
        u(n+1,:) = u(n,:) + (h/3)*(K1(n,:)/2 + K2(n,:) + K3(n,:) + K4(n,:)/2);
    end
else %passo variabile
    for n = 1:(length(t)-1)
        K1(n,:) = sis(u(n,:),mu);
        K2(n,:) = sis(u(n,:) + (h(n)/2)*K1(n,:),mu);
        K3(n,:) = sis(u(n,:) + (h(n)/2)*K2(n,:),mu);
        K4(n,:) = sis(u(n,:) + h(n)*K3(n,:),mu);
        u(n+1,:) = u(n,:) + (h(n)/3)*(K1(n,:)/2 + K2(n,:) + K3(n,:) + K4(n,:)/2);
    end
end

end