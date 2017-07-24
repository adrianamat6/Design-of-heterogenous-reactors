clc
clear all
close all

%% Datos directos

global MH2 Ei R1 R2 R3 Pao n_O2 Vpulmon


Pa = 0.137; %%% 0.21 en el mejor de los casos  0.137

Pao = Pa;

area= 70; %m

kag = 0.03; 

H = 0.937; 

k = 1.8*10^3;

Vsangre = 0.107e-3; %m^-3

Vpulmon = 6.5e-3; %m^3

Cb = 2.25 ; %mol/m^3 de hemoglobina

Dal = 7.1e-10; 

interf = 5e-7; 

Dbl = 8.3e-12;

%% Datos calculados

f = Vsangre/Vpulmon;

a = area/Vpulmon;

kal = Dal/interf ; % difusivad de a en el liquido dividido por la interfase


%% Resolución

Pai = Pa; % suposición

error = Pai; % error mayor que el valor dado

% Cuando se tiene un bucle chequear el principio y el final.

while error > Pai/10000; % o bien absoluto el error

Cai = Pai/H;

Ei = 1 + Dbl * Cb/ (Dal * Cai); 

MH2 = Dal * k * Cb / kal^2;

prueba = (1+ Ei)/2; 

E = fzero(@auxproyecto3, prueba);


R1 = 1/(kag * a);

R3 = H/(f*k*Cb);

R2 = H/(a * kal * E); 


ra = -Pa / (R1 + R2 + R3);

Paic = Pa + ra/(kag * a);

error = (Pai - Paic)^2; % antes del volcado

Pai = Paic; % es lo que quiero que se cumpla

end

%% Esta última vez que se pone es por precaución, es un copia y pega). 

Cai = Pai/H;

Ei = 1 + Dbl * Cb/ (Dal * Cai); 

MH2 = Dal * k * Cb / kal^2;

prueba = (1+ Ei)/2; 

E = fzero(@auxproyecto3, prueba);


R1 = 1/(kag * a);

R3 = H/(f*k*Cb);

R2 = H/(a * kal * E); 


ra = -Pa / (R1 + R2 + R3);

%%%%%% Inicialmente Pa = 0.21

% Cantidad consumida por un ser humano 

AH = 213 / 6;

Consumo_des= 100; %Kcal/h

Consumo_fuerte= 700; %Kcal/h

Tasa_consumo = 6*(Consumo_des/AH)/3600; %moles/s

Conc_O2=Pa/(0.082*(37+273));

n_O2=Conc_O2*Vpulmon*10^3;

t=n_O2/(-ra*Vpulmon)



%% llama al ode simulación

[Xas ts]=ode45(@fsimulacion,[0 1-0.06],0)

figure(3)

plot(ts,Xas)
xlabel('t (s)')
ylabel('Xa')
ras = -Pao*(1-Xas) / (R1 + R2 + R3);

figure(4)
plot(ts,ras)
xlabel('t (s)')
ylabel('ra (mol/(s*m^3))')