function dy=sis2(t,y,sigma,r,b)
dy=zeros(3,1);

dy(1)=sigma*(y(2)-y(1));

dy(2)=r*y(1)-y(2)-y(1).*y(3);

dy(3)=y(1).*y(2)-b*y(3);