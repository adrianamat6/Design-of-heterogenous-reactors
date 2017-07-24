function y = auxproyecto3(E)

global MH2 Ei 

cte = (abs(MH2 * (Ei - E)/(Ei - 1)))^0.5; 

% se ha añadido el comando abs para que la raíz cuadrada no sea negativa.

y = E - cte/tanh(cte);