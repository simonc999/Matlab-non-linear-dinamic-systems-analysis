%% R-K 2

clear all 
clc

mu=1;
h=0.005;
t=[0:h:20];
y0=[1 -3];
a=0.5;
u(1,:)=y0;

for i=1:(length(t)-1)
    K1=fun(t(i), u(i,:),mu);
    K2=fun(t(i)+a*h, u(i,:)+a*h*K1',mu);
    u(i+1,:)=u(i,:)+h*((1-(1/(2*a)))*K1'+(1/(2*a))*K2');
end


% soluzione esatta
r0=sqrt(y0(1)^2+y0(2)^2);

r=(sqrt(mu)*r0)./(sqrt(r0^2+(mu-r0^2)*exp(-2*mu.*t)));

teta0=atan(y0(2)./y0(1));

phi=r0^2+(mu-r0^2)*exp(-2*mu.*t);

teta=teta0-t+mu*(t+(log(phi)-log(mu))/(2*mu));

s1 = r.*cos(teta);
s2 = r.*sin(teta);
s=[s1',s2'];


er=abs(s-u);

ern=zeros(length(t),2);
ern2=zeros(length(t),2);

for i=1:length(t)   
    
    ernt(i)= norm((er(i,:)),Inf)';
    
    ern2t(i)= norm(er(i,:),2)';
    
    n2_u(i)=norm(u(i,:),2);

    n2_y(i)=norm(s(i,:),2);

    
end

%% subplot 

figure(1)
subplot(2,2,1)
plot(t,s1,t,s2,t,u(:,1),t,u(:,2))
title({'Confronto tra soluzione esatta e simulata'})
legend({'s1','s2','u1','u2'})

subplot(2,2,2)
plot(t,er(:,1),t,er(:,2),t,ernt',t,ern2t')
title({'Confronto tra errori'})
legend({'err s1','err s2','norm inf','norm 2'})

subplot(2,2,3)
plot(t,n2_u,t,n2_y)
title({'Grafico norme sulle due componenti'})
legend({'norma2 u','norma2 s'})

subplot(2,2,4)
plot(s(:,1),s(:,2),u(:,1),u(:,2))
title({'Orbite y esatta e y approssimata'})
legend({'y esatta','y approssimata'})

%% quinto punto      
clear all
clc
a=0.5;
mu=1;

h=[0.1  0.05 0.025 0.0125 0.00625 0.003125 0.0015625 ];
y0=[1 -3];

for j=1:length(h)
        
        t=[0:h(j):20];
        
        uh(1,:)=y0;

        for i=1:(length(t)-1)
            K1=fun(t(i), uh(i,:),mu);
            K2=fun(t(i)+a*h(j), uh(i,:)+a*h(j)*K1',mu);
            uh(i+1,:)=uh(i,:)+h(j)*((1-(1/(2*a)))*K1'+(1/(2*a))*K2');
        end


        % soluzione esatta
        r0=sqrt(y0(1)^2+y0(2)^2);

        r=(sqrt(mu)*r0)./(sqrt(r0^2+(mu-r0^2)*exp(-2*mu.*t)));

        teta0=atan(y0(2)./y0(1));

        phi=r0^2+(mu-r0^2)*exp(-2*mu.*t);

        teta=teta0-t+mu*(t+(log(phi)-log(mu))/(2*mu));

        s1 = r.*cos(teta);
        s2 = r.*sin(teta);
        s=[s1',s2'];

        E2_2=norm(s-uh);
        nye=norm(s,2);
        err_H(j)=norm(E2_2,2)/norm(nye,2);
        err_max1(j)=max(abs(s(:,1)-uh(:,1)));
        err_max2(j)=max(abs(s(:,2)-uh(:,2)));

end

figure(2)
loglog(h,err_H,'o--',h,h,h,h.^2, h,h.^4);
hold on
loglog(h,err_max1)
hold on
loglog(h,err_max2)