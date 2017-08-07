function coeff = Jmax_coefficient(H, S, T)
%%% extra coefficient Johnson 1942
% H - curvature parameter of Jmax | kJ mol-1
% S - electron transport temperature response parameter | J K-1 mol-1
% T - temperature | Celsius
R = 8.314e-3; % universal gas consant | kJ mol-1 K-1
S = S * 1e-3; % convertion from J to kJ

num_k = 1 + exp((298 * S - H) / (298 * R));
denom_k = 1 + exp((S * (T + 273) - H) ./ (R * (T + 273)));
coeff = num_k ./ denom_k;
end