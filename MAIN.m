function MAIN
f = figure(1);
delete(f.Children)
f.Name = 'Model';

% https://nl.mathworks.com/help/matlab/ref/uicontrol-properties.html

%gamma = sprintf('\x393*');
% https://unicode-table.com/en/#basic-latin
%% positioning of ui objects
UP = 380; % should decrease from ui to ui by BETWEEN_UP
BETWEEN_UP = 29; % multiply each time
LEFT = 20; % the same in one column
LEFT_SHIFT = 60;

%% 'From' 'To'
from = uicontrol(f, 'Style', 'text');
from.String = 'From';
from.Position(1) = LEFT + LEFT_SHIFT;
from.Position(2) = UP + 20;
from.HorizontalAlignment = 'left';

to = uicontrol(f, 'Style', 'text');
to.String = 'To';
to.Position(1) = LEFT + LEFT_SHIFT * 2;
to.Position(2) = UP + 20;
to.HorizontalAlignment = 'left';

%% Parameters ranges
[I_val, I_st, I_end, I_choice] = I_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[T_val, T_st, T_end, T_choice] = T_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[CO2_val, CO2_st, CO2_end, CO2_choice] = CO2_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[O2_val, O2_st, O2_end, O2_choice] = O2_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[V_cmax_val, V_cmax_st, V_cmax_end, V_cmax_choice] = Vcmax_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[rm_val, Kc_val, Ko_val, G_x_val, calculate_G_x] = rm_K_G_gui(f, UP, BETWEEN_UP, LEFT, LEFT_SHIFT);
y_gui(f, UP, BETWEEN_UP, LEFT_SHIFT);

UP = UP - BETWEEN_UP * 4; % how to make it better?
[Rd_val] = Rd_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[Jmax_val] = Jmax_gui(f, UP, LEFT, LEFT_SHIFT);

UP = UP - BETWEEN_UP;
[Tp_val] = Tp_gui(f, UP, LEFT, LEFT_SHIFT);
filename = filename_gui(f, UP, LEFT, LEFT_SHIFT);

%% hold on 'checkbox'
hold = uicontrol(f, 'Style', 'checkbox');
% hold.String = sprintf('Hold \n on \n  plots');
hold.Position(1) = LEFT_SHIFT * 8 + 4;
hold.Position(3) = 15;
hold.Position(4) = 30;
hold_t = uicontrol(f, 'Style', 'text');
hold_t.String = sprintf('Hold on\nplots');
hold_t.Position(1) = LEFT_SHIFT * 8 + 18;
hold_t.Position(3) = 50;
hold_t.Position(4) = 30;
hold_t.FontSize = 9;

%% evaluate final value of parameters, run model and plot
START = uicontrol(f, 'Style', 'pushbutton');
START.String = 'Start simulation';
START.Position(1) = START.Position(1) + 60;
START.Position(3) = 400;
START.Position(4) = 30;
START.FontSize = 14;
START.Callback = {@start_cb, I_val, I_st, I_end, I_choice ...
                             T_val, T_st, T_end, T_choice, ...
                             CO2_val, CO2_st, CO2_end, CO2_choice, ...
                             O2_val, O2_st, O2_end, O2_choice, ...
                             V_cmax_val, V_cmax_st, V_cmax_end, V_cmax_choice, ...
                             rm_val, Kc_val, Ko_val, ...
                             G_x_val, calculate_G_x, ...
                             Rd_val, Jmax_val, Tp_val, ...
                             filename, hold, f};

%% restore to defaults (simply rerun the programme)
def = uicontrol(f, 'Style', 'togglebutton');
def.String = 'Default';
def.Position(4) = START.Position(4);
def.Callback = {@(~,~) MAIN};
def.FontSize = 9;

end
