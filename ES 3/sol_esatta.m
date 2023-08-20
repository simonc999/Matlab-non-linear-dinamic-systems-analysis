function y = sol_esatta(t,mu)

y1 = exp(mu*t + log(1/10));
y2 = (9/10)*exp(-t) + (1/10)*exp(mu*t);

y = [y1;y2]'; 

end