function [I_val, I_st, I_end, I_choice] = I_gui(f, UP, LEFT, LEFT_SHIFT)
%% variable part
var = 'PAR';
I_range = {'0', '500', '1000', '1500', '2000'};
uni = sprintf(' \x03BCmol m\x207B\x00B2 s\x207B\x00B9');
init_val = '555';
too_big = 5000;

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
I_st = uicontrol(f, 'Style', 'popup');
I_st.String = I_range;
%I_st.Position % [left (max 488) bottom (max 342) width (default 60) height (also moves up as bottom)]
I_st.Position(1) = left_2;
I_st.Position(2) = UP;
I_st.Visible = 'on';
I_st.Tag = 'start';
% OR
I_val = uicontrol(f, 'Style', 'edit');
I_val.String = init_val;
I_val.Position(1) = left_2;
I_val.Position(2) = UP - 1;
I_val.Callback = {@bg_cb, too_big};
I_val.Visible = 'off';
I_val.Tag = 'val';
%% 3
I_end = uicontrol(f, 'Style', 'popupmenu');
I_end.String = I_range;
I_end.Position(1) = left_3;
I_end.Position(2) = UP;
I_end.Value = length(I_end.String);
I_end.Visible = 'on';
I_end.Tag = 'end';

I_st.Callback = {@available_cb, I_end, I_range}; %% can't define earlier

%% 4
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_4;
units.Position(2) = UP - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;
units.Tag = 'units';
%% choose
I_choice = uicontrol(f, 'Style', 'checkbox');
I_choice.String = 'Range and X axis';
I_choice.Position(1) = left_choose;
I_choice.Position(2) = UP;
I_choice.Position(3) = 120;
I_choice.Value = I_choice.Max;
I_choice.Callback = {@visibility_cb, I_st, I_end, I_val, units, left_3, left_4, f};
I_choice.Tag = 'range';
I_choice.FontSize = font_units - 1;

end
        
