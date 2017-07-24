
function dtdX=fsimulacion(X,t)
global R1 R2 R3 Pao n_O2 Vpulmon


ra = -Pao*(1-X) / (R1 + R2 + R3);

dtdX = -n_O2/Vpulmon/ ra;