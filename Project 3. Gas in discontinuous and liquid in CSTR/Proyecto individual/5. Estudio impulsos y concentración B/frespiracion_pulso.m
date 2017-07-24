
function dXdt=frespiracion_pulso(t,X)
global  Pao n_O2  A Vestandar  w H Pa Dbl Cb Dal kag Vsangre area k kal MH2 Ei

Vpulmon = A * sin(w*t) + Vestandar; %m^3

f = Vsangre/Vpulmon;

a = area/Vpulmon;


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

ra

t
%%%%%% Inicialmente Pa = 0.21

% Cantidad consumida por un ser humano 

AH = 213 / 6;

Consumo_des= 100; %Kcal/h

Consumo_fuerte= 700; %Kcal/h

Tasa_consumo = (Consumo_fuerte/AH)/3600; %moles/s

Conc_O2=0.21/(0.082*(37+273));

n_O2=Conc_O2*Vpulmon*10^3;

t=n_O2/(-ra*Vpulmon);
%%



ra = -Pao*(1-X) / (R1 + R2 + R3);

dXdt = -ra*Vpulmon/n_O2;

