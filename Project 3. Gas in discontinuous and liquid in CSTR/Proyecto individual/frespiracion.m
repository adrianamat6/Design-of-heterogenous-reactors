
function dXdt=frespiracion(t,X)
global R1 R2 R3 Pao n_O2 Vpulmon


ra = -Pao*(1-X) / (R1 + R2 + R3);

dXdt = - ra/n_O2*Vpulmon;

