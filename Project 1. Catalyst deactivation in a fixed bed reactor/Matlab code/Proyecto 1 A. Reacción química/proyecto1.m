clear all; 
close all;
clc
global cte Ca0 k0 ER T0 IH Cp

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
cte=dcat*(1-plecho)/(Ca0*vel);
ER=log(k500/k250);
ER=ER/(1/(500+273)-1/(250+273));
k0=k250/exp(-ER/(250+500));
IH=-1500;
Cp=15;

[L,conv]=ode45(@fproyecto1,[0 Lf],0)

Ca=Ca0*((1-conv)./(1+2*conv));
Cb=Ca0*conv./(1+2*conv);
Cc=Ca0*2*conv./(1+2*conv);
T=T0-IH/Cp*conv
k=k0.*exp(-ER/T);
ra_adiabatico=-k.*Ca'.^2;
figure(1)
plot(L,Ca,L,Cb,L,Cc) % A disminuye (puesto que es reactivo) y B y C aumentan (ya que son productos de la reacción)
                     %Fijate que la C es igual que B pero aumentado el
                     %doble. Esto es debido a la reaccion: A-->B+2C
xlabel('L (m)')
ylabel('C adiabático (mol/m^3)')
legend('A', 'B', 'C')
grid on

figure(2)
plot(L,conv)
xlabel('L (m)')
ylabel('Conversión adiabático')
grid on

%me invento el diametro
D=1;
S=pi*D^2/4;
Qvo=vel*S;
Qv=(1+2*conv)*Qvo
figure(3)
plot(L,Qv) %se obtiene la misma forma que con la gráfica de la conversión
xlabel('L (m)')
ylabel('Qv adiabatico (m^3/s)')
grid on

figure(4)
plot(L,T) %ocurre lo mismo con la T. La forma de la curva es la misma que la de la conversión  y el Qv. 
          %Esto es debido a que ambas cosas son proporcionales a la conversión. 
xlabel('L (m)')
ylabel('T adiabatico (K)')
grid on

[L_iso, conv_iso]=ode45(@fproyecto1iso,[0 Lf],0)
figure(5)
plot(L_iso,conv_iso)
xlabel('L (m)')
ylabel('conversión isoterma')
grid on
Ca_iso=Ca0*((1-conv_iso)./(1+2*conv_iso));
Cb_iso=Ca0*conv_iso./(1+2*conv_iso);
Cc_iso=Ca0*2*conv_iso./(1+2*conv_iso);
ra_isotermo=-0.01.*Ca_iso.^2;

figure(6)
plot(L_iso,Ca_iso,L_iso,Cb_iso,L_iso,Cc_iso)
xlabel('L (m)')
ylabel('C isotermas (mol/m^3')
grid on

Qvo=vel*S;
Qv_iso=(1+2*conv_iso)*Qvo;
figure(7)
plot(L_iso,Qv_iso); %se obtiene la misma forma que con la gráfica de la conversión
xlabel('L (m)')
ylabel('Qv isotermo (m^3/s)')
grid on


%%Comparando adiabatico e isotermo
figure(8)
subplot(2,2,1)
plot(L,conv)
grid on
xlabel('L (m)')
ylabel('conversión adiabático')
subplot(2,2,2)
plot(L_iso,conv_iso)
xlabel('L (m)')
ylabel('conversión isotermo')
grid on

figure(9)
plot(L,conv,L_iso,conv_iso)
xlabel('L (m)')
ylabel('conversión ')
legend('Adiabático','Isotermo')
grid on

figure(10)
subplot(2,2,1)
plot(L,Qv)
grid on
xlabel('L (m)')
ylabel('Qv adiabático')

subplot(2,2,2)
plot(L_iso,Qv_iso)
grid on
xlabel('L (m)')
ylabel('Qv adiabático')


figure(11)
subplot(2,2,1)
plot(L,Ca,L,Cb,L,Cc)
grid on
xlabel('L (m)')
ylabel('C (mol/m^3) adiabático')
legend('A','B','C')

subplot(2,2,2)
plot(L_iso,Ca_iso,L_iso,Cb_iso,L_iso,Cc_iso)
grid on
xlabel('L (m)')
ylabel('C (mol/m^3) isotermo')
legend('A','B','C')

