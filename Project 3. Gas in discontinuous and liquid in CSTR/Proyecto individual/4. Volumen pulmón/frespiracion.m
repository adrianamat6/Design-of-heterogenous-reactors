function dXdt=frespiracion(X,t)
global R1 R2 R3 Pao n_O2 Vpulmon


ra = -Pao*(1-X) / (R1 + R2 + R3);

dXdt = - n_O2 /ra / Vpulmon ;






