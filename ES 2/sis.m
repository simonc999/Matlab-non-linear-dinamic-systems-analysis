
% restituisce vettore colonna

function dy = sis(y,mu)
%Equazioni del PVI
    y1 = y(1); y2 = y(2);

    dy1 = mu*y1 + y2 - (y1+y2)*(y1^2+y2^2);
    dy2 = -y1 + mu*y2 - (y2-y1)*(y1^2+y2^2);

    dy = [dy1; dy2]; %vettore colonna
end