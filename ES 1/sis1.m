function dy=sis1(~,y,mu)
dy = zeros(2,1);
%mu=1;
dy(1)=mu*y(1)-y(2)-y(1).*(y(1).^2+3/2*y(2).^2);
dy(2)=y(1)+mu*y(2)-y(2).*(y(1).^2+1/2*y(2).^2);