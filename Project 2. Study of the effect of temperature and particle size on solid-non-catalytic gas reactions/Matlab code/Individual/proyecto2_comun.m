clear all 
close all
clc
%COMBINACIÓN DE RESISTENCIAS DURANTE LA REDUCCIÓN DE PARTÍCULAS ESFÉRICAS%

global Ca dmolb R kg De k b

%% datos
R=2.5*10^-3;
T=1000+273;
Dp=2*R;
Xa=0.2;
P=3; %atm
db=4600; %densidad kg/m3

PMb=231.5; %peso molecular kg/kmol

Do=3*10^-6; % a 700ºC

De=Do*(T/(700+273))^(1.5);%m2/s

b=1/4;

u=0.01;

vis=8.4*10^-5;

%% datos calculados
Pa=Xa*P;

Ca=Pa/(0.082*T); %mol/L o kmol/m3 %esto sale de PV=NRT

dmolb=db/PMb; %densidad molar

k=1930*exp(-100000/(8.31*T));

Dengas=P*2.02/0.082/T; %g/L

Re=u*Dengas*Dp/vis;

Sc=vis/(Dengas*De);

jd=0.725/(Re^0.41-0.15);

Sh=Sc^(1/3)*jd*Re;

kg=Sh*De/Dp; %m/s  en este caso dan el dato pero lo normal es calcularlo en f(turbulencia)

%% ode diseño
[r,t]=ode45(@fproyecto2_comun,[R 0],0);
% como trabajamos en diseño, la independiente es el radio y la dependiente t
% en simulación sería al contrario
figure(1)
tau=t(end) %min
plot(r,t)
ylabel('\tau (min)')
xlabel('R (m)')
title('Variación de \tau con R')

R1=r.^2/(R.^2*kg); %siendo kg el coeficiente de transf de mat asociado a la dif_ext
R2=(R-r).*r/(R*De); 
R3=1/k;
Rt=R1+R2+R3;

figure(2)
plot(t/3600,[R1./Rt,R2./Rt,R3./Rt])
legend('R1/Rt (difusión externa)','R2/Rt (difusión interna)','R3/Rt (reacción química)')
%% ode simulación
% tau=4.6281e+04;
% 
% [t,r]=ode45(@ffproyecto2_comun,[0,tau*2],R);
% 
% figure(3)
% plot(t,r)
% xlabel('\tau (min)')
% ylabel('R (m)')
% title('Variación de R con \tau')

