clc
clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Datos directos

global MH2 Ei

Pa = 1e4; %Pa

Pa = 1e5*300/1000000; % Pa

% area= 70; %m

kag = 1e-7; 

H = 25000; 

k = 10;

% Vsangre = 0.107e-3; %m^-3
% 
% Vpulmon = 6.5e-3; %m^3

Cb = 500 ; %mol/m^3 de hemoglobina

Dal = 1.8e-9; 

% interf = 5e-7; 

Dbl = 3.06e-9;



f = 0.1;

a = 200;

kal = 1e-4 ; % difusivad de a en el liquido dividido por la interfase


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


ra = -Pa / (R1 + R2 + R3)

Volumen = 0.05/-ra %%% Esto es como mínimo .... Dado el consumo... Es decir para empezar no se puede algo menor que 200 L... Luego la concentración disminuirá a lo largo del sistema... Se necesitará mayor Volumen.
