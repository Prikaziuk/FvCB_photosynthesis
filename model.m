function out = model(varargin)

p = input_parser;

%% check non valid name of input parameter
par_names = strings;
for par=p.Parameters
    par_names = par_names + "'" + par{:} + "' ";
end

if ~isempty(varargin)
    for v=varargin
        if (ischar(v{:}) || isstring(v{:})) && ~any(strcmp(v{:}, p.Parameters))
            error(['`%1$s` is not a valid parameter name\n'...
                'See `help` or use these in any order:\n%2$s'], v{:}, par_names)
        end
    end
end

%% getting parsed arguments
parse(p, varargin{:});

% %% only one argument can be an array, others are floats
% one_array_found = false;
% cel = struct2cell(p.Results);
% for i=1:length(cel)
%     if length(cel{i}) > 1
%         if one_array_found
%             error(['Only one parameter can be an array, the rest should be '...
%                 'simple numbers (arrays of length == 1)\n' ...
%                 'By default array is `I` in range from 0 to 1500'], cel{i})
%         end
%         one_array_found = true;
%     end
% end


PAR = p.Results.PAR;
T = p.Results.T;
CO2 = p.Results.CO2; % g_leaf * CO2ppm; 0.13 : % 0.7*26.6
O2 = p.Results.O2; % mbar
Vc_max_25 = p.Results.Vcmax;

rm = p.Results.rm; % assuming no negative values

Kc_25 = p.Results.Kc;
Ko_25 = p.Results.Ko;
G_x_25 = p.Results.G_x;
if p.Results.calculate_G_x
    Vo_max_25 = 0.25 * Vc_max_25; % only to calculate gamma*
    RUBISCO_specificity = (Vc_max_25 * Ko_25) ./ (Vo_max_25 * Kc_25); % Sc_o
    G_x_25 = 0.5 * O2 ./ RUBISCO_specificity;
end
    
% May be taken as persentage from Vcmax(25)
Rd_25 =  p.Results.Rd; % 0.01-0.02 * Vcmax
J_max_25 = p.Results.Jmax; % 1.5-2 * Vcmax

Tp_25 = p.Results.Tp;

%% mesophyll resistance conductance = gm = 1 / rm; | m2 s bar mol-1
if sum(rm == 0) || isempty(rm) % do you really need isempty?
    % ppm CO2 intercellular (Ci) == ppm CO2 chloroplastic (Cc)
    Cc = 0.7 * CO2; % constant from Silvia
else % Ci ~= Cc
    Ci = 0.7 * CO2;
end

%% Activation energies, kJ / mol
Ekc = 59.36;
Eko = 35.94;
Eg = 23.4;
Evc = 58.52;
% Evo = 58.52;
Er = 66.4;
Ej = 37;

% for Jmax additional
H = 220;
S = 710;

Ep = 47.1;

%% Temperature corrections
Kc = arrhenius(Kc_25, Ekc, T);
Ko = arrhenius(Ko_25, Eko, T);
G_x = arrhenius(G_x_25, Eg, T);
Vcmax = arrhenius(Vc_max_25, Evc, T);
% Vomax = arrhenius(Vo_max_25, Evo, T);
Rd = arrhenius(Rd_25, Er, T);
Jmax = arrhenius(J_max_25, Ej, T);

% for Jmax additional
Jmax = Jmax .* Jmax_coefficient(H, S, T);

Tp = arrhenius(Tp_25, Ep, T);

%% Ap
Ap = 3 * Tp - Rd;

%% Ac and Aj
J = electron_transport(PAR, Jmax);
if sum(rm == 0) || isempty(rm)
    Ac = carboxylation(Vcmax, Cc, G_x, Kc, O2, Ko, Rd);
    Aj = regeneration(J, Cc, G_x, Rd);
else
    Ac = solve_equation(-((Ci + Kc .* (1-O2 ./ Ko)) ./ rm + Vcmax - Rd), ...
        (Vcmax .* (Ci - G_x) - Rd .* (Ci + Kc .* (1-O2 ./ Ko))) ./ rm);
    Aj = solve_equation(-((Ci + 2 * G_x) ./ rm + J / 4 - Rd), ...
        ((Ci - G_x) .* J / 4 - Rd .* (Ci + 2 * G_x)) ./ rm);
end

%% All values to output
out.PAR = PAR;
out.T = T;
out.CO2 = CO2;
out.O2 = O2;
out.Vcmax = Vcmax;
out.rm = rm;
out.Kc = Kc;
out.Ko = Ko;
out.G_x = G_x;
out.Rd = Rd;
out.Jmax = Jmax;
out.Tp = Tp;

out.A = min(min(Ac, Aj), Ap) - Rd;

out.Ac = Ac;
out.Aj = Aj;
out.Ap = Ap;

%% add units
u_PAR = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');
u_T = sprintf('\x00B0\x0043');
u_CO2 = sprintf('ppm | \x03BC bar');
u_CO2(8)= [];
u_O2 = 'mbar';
u_Vcmax = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');
u_rm = sprintf('m\x00B2 s bar mol\x207B\x00B9');
u_Kc = sprintf('\x03BC bar');
u_Kc(2)= [];
u_Ko = 'mbar';
u_G_x = sprintf('\x03BC bar');
u_G_x(2)= [];
u_Rd = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');
u_Jmax = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');
u_Tp = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');

u_A = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');

u_Ac = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');
u_Aj = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');
u_Ap = sprintf('\x03BCmol m\x207B\x00B2 s\x207B\x00B9');

out.units = {u_PAR, u_T, u_CO2, u_O2, u_Vcmax, u_rm, u_Kc, u_Ko, u_G_x,...
             u_Rd, u_Jmax, u_Tp, u_A, u_Ac, u_Aj, u_Ap};

%plot(I, min(Ac, Aj), 'DisplayName', sprintf('rm = %1.1f', rm))
end