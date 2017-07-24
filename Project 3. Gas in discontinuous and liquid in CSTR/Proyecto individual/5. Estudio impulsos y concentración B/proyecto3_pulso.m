clc
clear all
close all

%% Datos directos

global  Pao  A Vestandar  w H Pa Dbl Cb Dal kag Vsangre area k kal 



Pa = 0.137; %%% 0.21 en el mejor de los casos  0.137

Pao = Pa;

area= 70; %m

kag = 0.03; 

H = 0.937; 

k = 1.8*10^3;

Vsangre = 0.107e-3; %m^-3

%% PULSO DEL PULMÓN

A = 3*10^-3; %m^3

Vestandar = 7 *10^-3; %m^3

freq = 0.25; % respiraciones/s

w = 2*pi*freq; %rad/s



%%

Cb = 2.25 ; %mol/m^3 de hemoglobina

Dal = 7.1e-10; 

interf = 5e-7; 

Dbl = 8.3e-12;

%% Datos calculados





kal = Dal/interf ; % difusivad de a en el liquido dividido por la interfase



%% llada ode45

[t Xa] = ode45(@frespiracion_pulso,[0 60],0);

figure(1)

plot(t,Xa);

ra = -Pao*(1-Xa) / (R1 + R2 + R3);

figure(2)

plot(t,ra)
