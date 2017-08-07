function J = electron_transport(I, Jmax)
%% I ~ absorptance
f = 0.15; % correction of spectral quality: leaf absorbtance 0.85
I2 = I * (1-f) / 2; % effective light shared by 2 PS

%% J ~ I
theta = 0.7; % empirical curvature factor 

num = I2 + Jmax - sqrt((I2 + Jmax) .^ 2 - 4 * theta .* I2 .* Jmax);
denom = 2 * theta;

J = num / denom;
end

