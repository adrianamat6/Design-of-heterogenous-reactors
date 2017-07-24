clear all 
close all
clc
%COMBINACI�N DE RESISTENCIAS DURANTE LA REDUCCI�N DE PART�CULAS ESF�RICAS%

global Ca dmolb R kg De k b

%% datos
R=5e-3;
T=500; %�C
Xa=0.2;
P=3; %atm
db=4600; %densidad kg/m3
PMb=231.5; %peso molecular kg/kmol
kg=7e-4; %m/s  en este caso dan el dato pero lo normal es calcularlo en f(turbulencia)
De=3e-6; %m2/s
b=1/4;
%% datos calculados
T=T+273; %K
Pa=Xa*P;
Ca=Pa/(0.082*T); %mol/L o kmol/m3 %esto sale de PV=NRT
dmolb=db/PMb; %densidad molar
k=1930*exp(-100000/(8.31*T));
%% ode dise�o
[r,t]=ode45(@fproyecto2_comun,[R 0],0);
% como trabajamos en dise�o, la independiente es el radio y la dependiente t
% en simulaci�n ser�a al contrario

figure(1)
tau=t(end) %min
plot(r,t)
ylabel('\tau (s)')
xlabel('R (m)')
title('Variaci�n de \tau con R')

R1=r.^2/(R.^2*kg); %siendo kg el coeficiente de transf de mat asociado a la dif_ext
R2=(R-r).*r/(R*De); 
R3=1/k;
Rt=R1+R2+R3;

figure(2)
plot(t/3600,[R1./Rt,R2./Rt,R3./Rt])
%% ode simulaci�n
% tau=4.6281e+04;
% 
% [t,r]=ode45(@ffproyecto2_comun,[0,tau*2],R);
% 
% figure(3)
% plot(t,r)
% xlabel('\tau (min)')
% ylabel('R (m)')
% title('Variaci�n de R con \tau')

