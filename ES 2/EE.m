function u = EE(t,mu,y0,h)
    %Funzione che implementa Eulero Esplicito
    
    u = zeros(length(t),2);
    K = zeros(length(t),2);
    u(1,:) = y0;
    
    for n = 1:(length(t)-1)
        K(n,:) = sis(u(n,:),mu);
        u(n+1,:) = u(n,:) + h*K(n,:);
    end

end