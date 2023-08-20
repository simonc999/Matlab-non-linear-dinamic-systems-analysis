function [ye] = soluzione_esatta(t,y0,epsilon)

ye1 = (y0(1) - y0(2)/(1+y0(2)))*exp(-t/epsilon) + (y0(2)*exp(-t))./(1+y0(2)*exp(-t));
ye2 = y0(2)*exp(-t);
ye = [ye1, ye2];
end

