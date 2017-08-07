function [V_cmax_val, V_cmax_st, V_cmax_end, V_cmax_choice] = Vcmax_gui(f, UP, LEFT, LEFT_SHIFT)
%% variable part
var = 'Vcmax';
% var = sprintf('Vc \x2098 \x2093');
V_cmax_range = {'0', '40', '60', '80', '100', '120'};
uni = sprintf(' \x03BCmol m\x207B\x00B2 s\x207B\x00B9');
init_val = '80';
too_big = 150;

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
V_cmax_st = uicontrol(f, 'Style', 'popup');
V_cmax_st.String = V_cmax_range;
%I_st.Position % [left (max 488) bottom (max 342) width (default 60) height (also moves up as bottom)]
V_cmax_st.Position(1) = left_2;
V_cmax_st.Position(2) = UP;
V_cmax_st.Visible = 'off';
V_cmax_st.Tag = 'start';
% OR
V_cmax_val = uicontrol(f, 'Style', 'edit');
V_cmax_val.String = init_val;
V_cmax_val.Position(1) = left_2;
V_cmax_val.Position(2) = UP - 1;
V_cmax_val.Callback = {@bg_cb, too_big};
V_cmax_val.Tag = 'val';

%% 3
V_cmax_end = uicontrol(f, 'Style', 'popupmenu');
V_cmax_end.String = V_cmax_range;
V_cmax_end.Position(1) = left_3;
V_cmax_end.Position(2) = UP;
V_cmax_end.Value = length(V_cmax_end.String);
V_cmax_end.Visible = 'off';
V_cmax_end.Tag = 'end';

V_cmax_st.Callback = {@available_cb, V_cmax_end, V_cmax_range}; %% can't define earlier

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
V_cmax_choice = uicontrol(f, 'Style', 'checkbox');
V_cmax_choice.String = 'Range and X axis';
V_cmax_choice.Position(1) = left_choose;
V_cmax_choice.Position(2) = UP;
V_cmax_choice.Position(3) = 120;
V_cmax_choice.Callback = {@visibility_cb, V_cmax_st, V_cmax_end, V_cmax_val, units, left_3, left_4, f};
V_cmax_choice.Tag = 'range';
V_cmax_choice.FontSize = font_units - 1;
end
        
