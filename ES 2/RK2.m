function u = RK2(t,mu,y0,alpha,h)
    %Funzione che implementa il metodo RK2
    
    u = zeros(length(t),2);
    K1 = zeros(length(t),2);
    K2 = zeros(length(t),2);
    u(1,:) = y0;
    
    for n = 1:(length(t)-1)
        K1(n,:) = sis(u(n,:),mu);
        K2(n,:) = sis(u(n,:) + alpha*h*K1(n,:),mu);
        u(n+1,:) = u(n,:) + h*((1-(1/(2*alpha)))*K1(n,:) + (1/(2*alpha))*K2(n,:));
    end

end