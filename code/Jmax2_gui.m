function [Jmax_val, Jmax_st, Jmax_end, Jmax_choice] = Jmax2_gui(f, UP, LEFT, LEFT_SHIFT)
%% variable part
var = 'Jmax';
uni = sprintf(' \x03BCmol m\x207B\x00B2 s\x207B\x00B9');
Jmax_range = {'0', '40', '80', '120', '160', '200', '240', '280'};
init_val = '124.4';
too_big = 300;

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
Jmax_st = uicontrol(f, 'Style', 'popup');
Jmax_st.String = Jmax_range;
%I_st.Position % [left (max 488) bottom (max 342) width (default 60) height (also moves up as bottom)]
Jmax_st.Position(1) = left_2;
Jmax_st.Position(2) = UP;
Jmax_st.Visible = 'off';
Jmax_st.Tag = 'start';
% OR
Jmax_val = uicontrol(f, 'Style', 'edit');
Jmax_val.String = init_val;
Jmax_val.Position(1) = left_2;
Jmax_val.Position(2) = UP - 1;
Jmax_val.Callback = {@bg_cb, too_big};
Jmax_val.Tag = 'val';

%% 3
Jmax_end = uicontrol(f, 'Style', 'popupmenu');
Jmax_end.String = Jmax_range;
Jmax_end.Position(1) = left_3;
Jmax_end.Position(2) = UP;
Jmax_end.Value = length(Jmax_end.String);
Jmax_end.Visible = 'off';
Jmax_end.Tag = 'end';

Jmax_st.Callback = {@available_cb, Jmax_end, Jmax_range}; %% can't define earlier


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
Jmax_choice = uicontrol(f, 'Style', 'checkbox');
Jmax_choice.String = 'Range and X axis';
Jmax_choice.Position(1) = left_choose;
Jmax_choice.Position(2) = UP;
Jmax_choice.Position(3) = 120;
Jmax_choice.Callback = {@visibility_cb, Jmax_st, Jmax_end, Jmax_val, units, left_3, left_4, f};
Jmax_choice.Tag = 'range';
Jmax_choice.FontSize = font_units - 1;

end
        