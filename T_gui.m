function [T_val, T_st, T_end, T_choice] = T_gui(f, UP, LEFT, LEFT_SHIFT)
%% variable part
var = 'T';
T_range = {'0', '15', '25', '35', '45'};
uni = sprintf(' \x00B0\x0043');
init_val = '25';
too_big = 40;

%% control position
font = 10.5;
font_units = 10;
width_units = 80;

left_1 = LEFT;
left_2 = LEFT + LEFT_SHIFT;
left_3 = LEFT + LEFT_SHIFT * 2 + 1;
left_4 = LEFT + LEFT_SHIFT * 3 + 5;
left_choose = LEFT + LEFT_SHIFT * 4 + 55;

%% 1
lab = uicontrol(f, 'Style', 'text');
lab.String = var;
lab.Position(1) = left_1;
lab.Position(2) = UP - 1;
lab.FontSize = font;

%% 2
T_st = uicontrol(f, 'Style', 'popup');
T_st.String = T_range;
%I_st.Position % [left (max 488) bottom (max 342) width (default 60) height (also moves up as bottom)]
T_st.Position(1) = left_2;
T_st.Position(2) = UP;
T_st.Visible = 'off';
T_st.Tag = 'start';
% OR
T_val = uicontrol(f, 'Style', 'edit');
T_val.String = init_val;
T_val.Position(1) = left_2;
T_val.Position(2) = UP - 1;
T_val.Callback = {@bg_cb, too_big};
T_val.Tag = 'val';

%% 3
T_end = uicontrol(f, 'Style', 'popupmenu');
T_end.String = T_range;
T_end.Position(1) = left_3;
T_end.Position(2) = UP;
T_end.Value = length(T_end.String);
T_end.Visible = 'off';
T_end.Tag = 'end';

T_st.Callback = {@available_cb, T_end, T_range}; %% can't define earlier
% AND
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_3;
units.Position(2) = UP - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;
units.Tag = 'units';
%% 4

%% choose
T_choice = uicontrol(f, 'Style', 'checkbox');
T_choice.String = 'Range and X axis';
T_choice.Position(1) = left_choose;
T_choice.Position(2) = UP;
T_choice.Position(3) = 120;
T_choice.Callback = {@visibility_cb, T_st, T_end, T_val, units, left_3, left_4, f};
T_choice.Tag = 'range';
T_choice.FontSize = font_units - 1;

end
        