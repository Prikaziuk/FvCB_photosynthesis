function p = input_parser
p = inputParser;
p.CaseSensitive = true;

% DEFAULT values
PAR = linspace(0, 1500);
T = 25;
CO2 = 380;
O2 = 205;
Vcmax = 80;

rm = 0;
Kc = 404; % with conductances recommended 260 micro bar
Ko = 248; % with conductances recommended 179  milli bar
G_x = 38.6; % gamma* | with conductances recommended 37  micro bar
calculate_G_x = false; % 0.5 * O / Sc_o

% May be taken as persentage from Vcmax(25)
Rd = 1; % 0.01-0.02 * Vcmax
Jmax = 124.4; % 1.5-2 * Vcmax

Tp = 11.55; % phosphate utilization, Kim & Leith, 2003

addOptional(p, 'PAR', PAR, @isnumeric);
addOptional(p, 'T', T, @isnumeric);
addOptional(p, 'CO2', CO2, @isnumeric);
addOptional(p, 'O2', O2, @isnumeric);
addOptional(p, 'Vcmax', Vcmax, @isnumeric);

addOptional(p, 'rm', rm, @isnumeric);
addOptional(p, 'Kc', Kc, @isnumeric);
addOptional(p, 'Ko', Ko, @isnumeric);
addOptional(p, 'G_x', G_x, @isnumeric);
addOptional(p, 'calculate_G_x', calculate_G_x, @islogical);

addOptional(p, 'Rd', Rd, @isnumeric);
addOptional(p, 'Jmax', Jmax, @isnumeric);
addOptional(p, 'Tp', Tp, @isnumeric);
end