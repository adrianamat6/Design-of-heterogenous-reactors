%fproyecto1ciso

function dconv=fproyecto1iso(L,conv)
global cte Ca0 k0 ER T0 IH Cp a kc De Leq dcat 

T=T0-IH/Cp*conv;
Ca=Ca0*((1-conv)/(1+2*conv));%
k=0.01;

ml=Leq*((3*k*dcat*Ca)/(2*De))^0.5; %multiplicamos por dcat por unidades: ud/m^3 
efc=tanh(ml)/ml;
raquimica=-k*Ca^2;
ra=efc*raquimica %consideramos en este caso la difusión interna


dconv=-cte*ra;