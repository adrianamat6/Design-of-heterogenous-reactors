clear all; 
close all;
clc
global cte Ca0 k0 ER T0 IH Cp kd a

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
%%Datos calculados%%
T0=250+273; %K
Ca0=P/(0.082*T0);%mol/L = kmol/m3    %de la ec. gases ideales PV=nRT; n/V=P/R/T
Ca0=Ca0*1000;
cte=dcat*vel*(1-plecho)/(Ca0*vel);
ER=log(k500/k250);
ER=ER/(1/(500+273)-1/(250+273));
k0=k250/exp(-ER/(250+500));
IH=-1500;
Cp=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cosas a variar
kd=0.1;

tao_final=0.1; %ir variando el tiempo final

ti=[1*24 2*24 3*24 4*24 5*24 6*24];

a_vector=[];

t_vector=[];

conv_matriz=[];

for i=1:length(ti)
    
a_vector(i)=exp(-kd*ti(i));

a=a_vector(i);
  
span=linspace(0 ,tao_final,100)
[t,conv]=ode45(@fFAgallos,span,0);

t_vector(i,:)=t;

conv_matriz(:,i)=conv;


%convv(i,:)=conv;

end


plot(ti,conv_matriz(end,:))
plot(t,conv_matriz)

T=T0-IH/Cp.*conv
k=k0.*exp(-ER./T)
Ca=Ca0.*((1-conv)./(1+2.*conv)) %no tenemos en cuenta la T aquí (adiabático)

ra=-k.*Ca.^2.*a;
