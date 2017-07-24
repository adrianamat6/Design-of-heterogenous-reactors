
function dtdX=fsimulacion(X,t)
global R1 R2 R3 Pao n_O2 Vpulmon   k H f kal E Cb a Dal

n= 7.82*10^-4  ;  %    7.82*10^-4     5.4*10^-3

Pa=Pao*(1-X);
Q=n*0.082*(37+273)/Pa;

 D=0.0008378;
 S=pi*(D/2)^2;
 vgas=Q/S;
 dgas=Pa*0.032/8.31/(37+273);

 Re=vgas*dgas*D/(2*10^-5);
 
% R1=Pao*(1-X)/Q;

jd=0.725/(Re^0.41-0.15);

Sc=(2*10^-5)/(dgas*D);
Sh=(Sc^(1/3))*jd*Re;

kag=Sh*Dal/D;


 R1 = 1/(kag * a);

R3 = H/(f*k*Cb);

 R2 = H/(a * kal * E); 

ra = -Pao*(1-X) / (R1 + R2 + R3);

dtdX = -n_O2/Vpulmon/ ra;