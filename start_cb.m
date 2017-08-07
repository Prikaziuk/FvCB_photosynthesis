function start_cb(~, ~, I_val, I_st, I_end, I_choice, ...
                        T_val, T_st, T_end, T_choice, ...
                        CO2_val, CO2_st, CO2_end, CO2_choice, ...
                        O2_val, O2_st, O2_end, O2_choice, ...
                        V_cmax_val, V_cmax_st, V_cmax_end, V_cmax_choice, ...
                        rm_val, Kc_val, Ko_val, ...
                        G_x_val, calculate_G_x, ...
                        Rd_val, Jmax_val, Tp_val, ...
                        out_filename, not_new_figure, f)
                    
%% ranges
PAR = parse_range(I_val, I_st, I_end, I_choice);
T = parse_range(T_val, T_st, T_end, T_choice);
CO2 = parse_range(CO2_val, CO2_st, CO2_end, CO2_choice);
O2 = parse_range(O2_val, O2_st, O2_end, O2_choice);
Vcmax = parse_range(V_cmax_val, V_cmax_st, V_cmax_end, V_cmax_choice);

%% values from edit boxes
rm = parse_edit(rm_val);
Kc = parse_edit(Kc_val);
Ko = parse_edit(Ko_val);
G_x = parse_edit(G_x_val);
calculate_G_x = logical(calculate_G_x.Value);
Rd = parse_edit(Rd_val);
Jmax = parse_edit(Jmax_val);
Tp = parse_edit(Tp_val);

%% run model
out = model('PAR', PAR, 'T', T, 'CO2', CO2, 'O2', O2, 'Vcmax', Vcmax, ...
            'rm', rm, 'Kc', Kc, 'Ko', Ko, ...
            'G_x', G_x, 'calculate_G_x', calculate_G_x, ...
            'Rd', Rd, 'Jmax', Jmax, 'Tp', Tp);
        
%% write output to mat-file
save(out_filename.String, 'out')
% writetable(struct2table(out), 'station.xlsx') % awful one row table with > 100 rows

%% plot output
f2 = figure(2);
f2.Name = 'Output';

% choosing X axis: one where range is ticked
x_ax = findobj(f, 'Tag', 'range');
x = find(flip([x_ax.Value])); % flip because PAR - last, Vcmax - first (older to newer in order of declaration)

y_ax = findobj(f, 'Tag', 'y axis');
y_num = find([y_ax.Value]);
y = y_ax(y_num).String;

if not_new_figure.Value
    hold on
else
    hold off
end

to_plot = struct2table(out);
if strcmp(y, sprintf('\x0393\x002A'))
    y = 'G_x';
end

X = to_plot{:, x};
Y = to_plot{:, {y}};

plot(X,Y)

if length(Y) == 1
    text(X(50), Y, sprintf(['It seems that Farquhar model\n', ...
        'does not consider this dependency:\nY = %1.1f (const)'], Y), ...
        'HorizontalAlignment', 'center', 'FontSize', 15)
else
    legend('show')
end

units = to_plot{:, {'units'}};
X_units = units{x};
X_lab = to_plot.Properties.VariableNames{x};
if strcmp(X_lab, 'CO2')
    X_lab = sprintf('CO_{2}');
elseif strcmp(X_lab, 'O2')
    X_lab = sprintf('O_{2}');
end

xlabel(strcat(X_lab, {', '}, X_units))


y_units_num = find(strcmp(y, fieldnames(to_plot)));
Y_units = units{y_units_num};

if strcmp(y, 'G_x')
    y = sprintf('\x0393\x002A');
end
ylabel(strcat(y, {', '}, Y_units))


end


function param =  parse_range(value, start_r, end_r, choice)
switch choice.Value
    case 0
        param = str2double(value.String);
    case 1
        start_r = str2double(start_r.String{start_r.Value});
        end_r = str2double(end_r.String{end_r.Value});
        param = linspace(start_r, end_r);
end
end

function param = parse_edit(value)
param = str2double(value.String);
end