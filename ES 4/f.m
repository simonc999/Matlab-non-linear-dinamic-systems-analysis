function dy = f(t,y,e)
%Equazioni del PVI

dy1 = (1/e)*(-y(1)+y(2)/(1+y(2))) - y(2)/(1+y(2))^2;
dy2 = -y(2);

dy = [dy1; dy2];

end