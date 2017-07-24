function ra = rll(Pa,Cb)

%% Datos directos

global MH2 Ei



area= 70; %m

kag = 0.03; 

H = 0.937; 

k = 1.8*10^3;

Vsangre = 0.107e-3; %m^-3

Vpulmon = 6.5e-3; %m^3


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


