clear all; 
close all;
clc
global cte Ca0 k0 ER T0 IH Cp a kc

%%Datos%%
P=5; %atm
T0=250; %ºC
Lf=0.1; %m
vel=2; %m/s
plecho=0.3;
dcat=2000; %kg/m3
k=0.01;
k250=0.01;
k500=2;
PM=78;
visc=2.75e-5;
dp=0.01; %diametro particula
D=5e-8; %%m^2/s (difusividad)

densgas=P*PM/(0.082*T0);
velreal=vel*plecho;
Sc=visc/(densgas*D);
Re=(dp*densgas*velreal)/visc;
jd=0.725/(Re^0.41-0.15);
Sh=jd*Sc*(1/3)*Re;
kc=D*Sh/dp;
a=3/(dp*dcat/2);


%%Datos calculados%%
T0=250+273; %K
Ca0=P/(0.082*T0);%mol/L = kmol/m3    %de la ec. gases ideales PV=nRT; n/V=P/R/T
Ca0=Ca0*1000;
cte=dcat*(1-plecho)/(Ca0*vel);
ER=log(k500/k250);
ER=-ER/(1/(500+273)-1/(250+273));
k0=k250/exp(-ER/(250+500));
IH=-1500;
Cp=15;

[L,conv]=ode45(@fproyecto1b,[0 Lf],0)

Ca=Ca0*((1-conv)./(1+2*conv));
Cb=Ca0*conv./(1+2*conv);
Cc=Ca0*2*conv./(1+2*conv);
T=T0-IH/Cp*conv
ra=-a*kc*Ca;

plot(L,Ca,L,Cb,L,Cc)

figure(1)
plot(L,conv)
xlabel('L (m)')
ylabel('conversión difusión externa')


[L_iso,conv_iso]=ode45(@fproyecto1biso,[0 Lf],0)

Ca_iso=Ca0*((1-conv_iso)./(1+2*conv_iso));
Cb=Ca0*conv_iso./(1+2*conv_iso);
Cc=Ca0*2*conv_iso./(1+2*conv_iso);
T=T0-IH/Cp*conv_iso
ra=-a*kc*Ca_iso;

