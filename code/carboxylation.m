function Ac = carboxylation(Vcmax, Cc, G_x, Kc, O, Ko, Rd)
%%% CO2 assimilation limited by carboxyaltion/oxygenation (RUBISCO) 
%%% mostly depends on CO2 O2 concentrations
% Vcmax - carboxylase rate of Rubisco | micro mol m-2 s-1
% Cc - chloroplastic CO2 partial pressure, pCO2 | ppm
% G_x - gamma*, CO2 compensation point without dark respiration | ppm
% Kc - Rubisco Michaelis constant for carboxylation | micro bar
% O - chloroplastic O2 partial pressure, pCO2 | ppm
% Ko - Rubisco Michaelis constant for oxygenation | micro bar
% Rd - dark mitochondrial respiration rate | micro mol m-2 s-1

num = Vcmax .* (Cc - G_x);
denom = Cc + Kc .* (1 + O ./ Ko);
Ac = num ./ denom - Rd;
end