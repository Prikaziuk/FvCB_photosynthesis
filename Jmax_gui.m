function [Jmax_val] = Jmax_gui(f, UP, LEFT, LEFT_SHIFT)
%% control position
font = 10.5;
font_units = 10;
width_units = 100;

left_1 = LEFT;
left_2 = LEFT + LEFT_SHIFT;
left_3 = LEFT + LEFT_SHIFT * 2 + 1;


%% 1.1
var = 'Jmax';
uni = sprintf(' \x03BCmol m\x207B\x00B2 s\x207B\x00B9');
init_val = '124.4';
too_big = 250;

lab = uicontrol(f, 'Style', 'text');
lab.String = var;
lab.Position(1) = left_1;
lab.Position(2) = UP - 1;
lab.FontSize = font;

%% 1.2
Jmax_val = uicontrol(f, 'Style', 'edit');
Jmax_val.String = init_val;
Jmax_val.Position(1) = left_2;
Jmax_val.Position(2) = UP - 1;
Jmax_val.Callback = {@bg_cb, too_big};

%% 1.3
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_3;
units.Position(2) = UP - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;
end