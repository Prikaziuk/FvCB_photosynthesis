function [CO2_val, CO2_st, CO2_end, CO2_choice] = CO2_gui(f, UP, LEFT, LEFT_SHIFT)
%% variable part
var = sprintf('CO\x2082');
CO2_range = {'0', '300', '600', '900', '1200', '1500'};
%uni = sprintf('\x03BC');
uni = sprintf(' ppm | \x03BC bar');
uni(9)= []; % may be because 03BC and b from bar go together we have to replace space it manually
init_val = '380';
too_big = 10000;

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
CO2_st = uicontrol(f, 'Style', 'popup');
CO2_st.String = CO2_range;
%I_st.Position % [left (max 488) bottom (max 342) width (default 60) height (also moves up as bottom)]
CO2_st.Position(1) = left_2;
CO2_st.Position(2) = UP;
CO2_st.Visible = 'off';
CO2_st.Tag = 'start';
% OR
CO2_val = uicontrol(f, 'Style', 'edit');
CO2_val.String = init_val;
CO2_val.Position(1) = left_2;
CO2_val.Position(2) = UP - 1;
CO2_val.Callback = {@bg_cb, too_big};
CO2_val.Tag = 'val';

%% 3
CO2_end = uicontrol(f, 'Style', 'popupmenu');
CO2_end.String = CO2_range;
CO2_end.Position(1) = left_3;
CO2_end.Position(2) = UP;
CO2_end.Value = length(CO2_end.String);
CO2_end.Visible = 'off';
CO2_end.Tag = 'end';

CO2_st.Callback = {@available_cb, CO2_end, CO2_range}; %% can't define earlier

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
CO2_choice = uicontrol(f, 'Style', 'checkbox');
CO2_choice.String = 'Range and X axis';
CO2_choice.Position(1) = left_choose;
CO2_choice.Position(2) = UP;
CO2_choice.Position(3) = 120;
CO2_choice.Callback = {@visibility_cb, CO2_st, CO2_end, CO2_val, units, left_3, left_4, f};
CO2_choice.Tag = 'range';
CO2_choice.FontSize = font_units - 1;

end
        