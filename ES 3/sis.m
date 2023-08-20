function dy = sis(y,mu)

% Equazioni del PVI

    y1 = y(1); y2 = y(2);

    dy1 = mu*y1;
    dy2 = (1+mu)*y1 - y2;

    dy = [dy1; dy2]; % vettore colonna
    
end