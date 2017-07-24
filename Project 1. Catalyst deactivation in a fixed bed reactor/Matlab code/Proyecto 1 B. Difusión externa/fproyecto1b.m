
function dconv=fproyecto1(L,conv)
global cte Ca0 k0 ER T0 IH Cp a kc

T=T0-IH/Cp*conv;
k=k0*exp(-ER/T);
Ca=Ca0*((1-conv)/(1+2*conv))%


ra=-a*kc*Ca;


dconv=-cte*ra;