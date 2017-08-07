function par_T = arrhenius(par_25, E_activation,  T)
%%% corrects energy depending on temperature
% par_25 - value of parameter at 25 degrees
% E_activation - activation energy | kJ / mol
% T - temperature | Celsius
Q10 = exp(13.6e-3 * E_activation); % from von Caemmerer 2000
par_T = par_25 * (Q10 .^ ((T - 25) / 10));
end