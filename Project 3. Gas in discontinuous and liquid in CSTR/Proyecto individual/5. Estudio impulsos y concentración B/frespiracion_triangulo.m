
function dXdt=frespiracion_triangulo(t,X)
global  Pao n_O2  A Vestandar  w H Pa Dbl Cb Dal kag Vsangre area k kal MH2 Ei freq

%% triangulo, Volumen Pulmón

% ampl=6;
% 
% 
% msubida= 1/freq *4/9;
% mbajada= 1/freq *5/9;
% 
% if mbajada==0
%     Vpulmon=mod(t*(ampl/msubida),ampl);
% else
%     t_1= 0:0.001:msubida;
%     t_2= 0:0.001:mbajada;
%    helper= unique(mod(t_1*(ampl/msubida),ampl));
%    helper2= ampl-unique(mod(t_2*(ampl/mbajada),ampl));
%    signal= [helper, helper2];
%    signal2= repmat(signal,1,ceil(numel(t)/numel(signal)));
%    Vpulmon= signal2(1:numel(t)) + 1/freq;
% end
% Vpulmon

T = 1/freq;
t1 = T *4/9;
t2 = T * 5/9;
Vmax = 10*10^-3;
Vmin = 4*10^-3;

m1 = (Vmax-Vmin)/t1;
m2 = (Vmin-Vmax)/(T-t1);


tpulso=mod(t,T);
if tpulso <= t1
Vpulmon = m1.*tpulso + Vmin;  
else  %// x > 0.3
Vpulmon = m2.*(tpulso -t1) + Vmax ;
end
t

%%

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

ra

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

Tasa_consumo = (Consumo_fuerte/AH)/3600; %moles/s

Conc_O2=0.21/(0.082*(37+273));

n_O2=Conc_O2*Vpulmon*10^3;

t=n_O2/(-ra*Vpulmon);
%%



ra = -Pao*(1-X) / (R1 + R2 + R3);

dXdt = - ra/n_O2*Vpulmon;

