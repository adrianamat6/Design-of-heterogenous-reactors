


function dconv=fproyecto1iso(L,conv)
global cte Ca0   

T=250+273;
k=0.01;
Ca=Ca0*((1-conv)/(1+2*conv)); %no tenemos en cuenta la T aquí (adiabático)
ra=-k*Ca^2;


dconv=-cte*ra;