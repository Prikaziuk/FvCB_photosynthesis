function Aj = regeneration(J, Cc, G_x, Rd)
%%% CO2 assimilation limited by regeneration of RUBISCO
%%% == CO2 assimilation limited by rate of electron transport
% J - electron transport rate with given light intencity (I) |  micro mol m-2 s-1
% Cc - chloroplastic CO2 partial pressure, pCO2 | ppm
% G_x - gamma*, CO2 compensation point without dark respiration | ppm
% Rd - dark mitochondrial respiration rate | micro mol m-2 s-1

num = J .* (Cc - G_x);
denom = 4 * Cc + 8 * G_x;
Aj = num / denom - Rd;
end