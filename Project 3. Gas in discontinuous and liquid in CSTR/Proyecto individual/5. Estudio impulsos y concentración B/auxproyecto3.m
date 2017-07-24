function y = auxproyecto3(E)

global MH2 Ei 


cte = (abs(MH2 * (Ei - E)/(Ei - 1)))^0.5; 


% se ha a�adido el comando abs para que la ra�z cuadrada no sea negativa.

% Se obtiene el valor de E sabiendo que la funci�n objetivo y debe valer 0.
y = E - cte/tanh(cte);