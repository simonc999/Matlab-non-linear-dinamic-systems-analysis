function [ dy ] = sis3( t,y,alfa)



R=(1/((alfa)^2))*(y(1).^2+y(2).^2).^(1.5);

dy = zeros(4,1);

dy(1) = y(3);
dy(2) =y(4);
dy(3)=-y(1)./R;
dy(4)=-y(2)./R;
end