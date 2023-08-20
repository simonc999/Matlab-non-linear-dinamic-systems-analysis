function dydt = fun(t,y, mu)
 
    y=y';
    dydt = zeros(2,1);
    dydt(1)= mu*y(1)+y(2)-(y(1)+y(2))*(y(1)^2+y(2)^2);
    dydt(2)= -y(1)+mu*y(2)-(y(2)-y(1))*(y(1)^2+y(2)^2);
    
end 