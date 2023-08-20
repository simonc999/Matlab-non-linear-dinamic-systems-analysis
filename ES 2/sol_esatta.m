function y = sol_esatta(t,mu,y0)

theta0 = atan(y0(2)/y0(1));
r0 = sqrt(y0(1)^2 + y0(2)^2);

r = (sqrt(mu)*r0)./sqrt(r0^2+(mu-r0^2)*exp(-2*mu*t));
phi = r0^2 + (mu-r0^2)*exp(-2*mu*t);
theta = theta0 - t + mu*(t + (log(phi)-log(mu))/(2*mu));

y1 = r.*cos(theta);
y2 = r.*sin(theta);

y = [y1;y2]'; 

end