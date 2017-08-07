function [O2_val, O2_st, O2_end, O2_choice] = O2_gui(f, UP, LEFT, LEFT_SHIFT)
%% variable part
var = sprintf('O\x2082');
O2_range = {'0', '100', '200', '300', '400'};
uni = ' mbar';
init_val = '205';
too_big = 2100;

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
O2_st = uicontrol(f, 'Style', 'popup');
O2_st.String = O2_range;
%I_st.Position % [left (max 488) bottom (max 342) width (default 60) height (also moves up as bottom)]
O2_st.Position(1) = left_2;
O2_st.Position(2) = UP;
O2_st.Visible = 'off';
O2_st.Tag = 'start';
% OR
O2_val = uicontrol(f, 'Style', 'edit');
O2_val.String = init_val;
O2_val.Position(1) = left_2;
O2_val.Position(2) = UP - 1;
O2_val.Callback = {@bg_cb, too_big};
O2_val.Tag = 'val';

%% 3
O2_end = uicontrol(f, 'Style', 'popupmenu');
O2_end.String = O2_range;
O2_end.Position(1) = left_3;
O2_end.Position(2) = UP;
O2_end.Value = length(O2_end.String);
O2_end.Visible = 'off';
O2_end.Tag = 'end';

O2_st.Callback = {@available_cb, O2_end, O2_range}; %% can't define earlier


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
O2_choice = uicontrol(f, 'Style', 'checkbox');
O2_choice.String = 'Range and X axis';
O2_choice.Position(1) = left_choose;
O2_choice.Position(2) = UP;
O2_choice.Position(3) = 120;
O2_choice.Callback = {@visibility_cb, O2_st, O2_end, O2_val, units, left_3, left_4, f};
O2_choice.Tag = 'range';
O2_choice.FontSize = font_units - 1;

end
        