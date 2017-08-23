function [Ay, rmy, Kcy, Koy, G_xy, Rdy, Jmaxy, Tpy] = y_gui(f, UP, BETWEEN_UP, LEFT_SHIFT)
%% variables
left_as_hold = LEFT_SHIFT * 8 + 4;
font = 10;

%%

text = uicontrol(f, 'Style', 'text');
text.String = 'Y axis';
text.Position(1) = left_as_hold;
text.Position(2) = UP + BETWEEN_UP * 6 - 10;
text.HorizontalAlignment = 'left';
text.FontSize = font;

Ay = uicontrol(f, 'Style', 'checkbox');
Ay.String = 'A';
Ay.Position(1) = left_as_hold;
Ay.Position(2) = UP + BETWEEN_UP * 5;
Ay.Value = Ay.Max;
Ay.FontSize = font;
Ay.Tag = 'y axis';

T = uicontrol(f, 'Style', 'checkbox');
T.String = 'T';
T.Position(1) = left_as_hold;
T.Position(2) = UP + BETWEEN_UP * 4;
T.FontSize = font;
T.Tag = 'y axis';

CO2 = uicontrol(f, 'Style', 'checkbox');
CO2.String = sprintf('CO\x2082');
CO2.Position(1) = left_as_hold;
CO2.Position(2) = UP + BETWEEN_UP * 3;
CO2.FontSize = font;
CO2.Tag = 'y axis';

Jmax = uicontrol(f, 'Style', 'checkbox');
Jmax.String = 'Jmax';
Jmax.Position(1) = left_as_hold;
Jmax.Position(2) = UP + BETWEEN_UP * 2;
Jmax.FontSize = font;
Jmax.Tag = 'y axis';

Vcmax = uicontrol(f, 'Style', 'checkbox');
Vcmax.String = 'Vcmax';
Vcmax.Position(1) = left_as_hold;
Vcmax.Position(2) = UP + BETWEEN_UP;
Vcmax.FontSize = font;
Vcmax.Tag = 'y axis';

rmy = uicontrol(f, 'Style', 'checkbox');
rmy.String = 'rm';
rmy.Position(1) = left_as_hold;
rmy.Position(2) = UP;
rmy.FontSize = font;
rmy.Tag = 'y axis';

Kcy = uicontrol(f, 'Style', 'checkbox');
Kcy.String = 'Kc';
Kcy.Position(1) = left_as_hold;
Kcy.Position(2) = UP - BETWEEN_UP;
Kcy.FontSize = font;
Kcy.Tag = 'y axis';

Koy = uicontrol(f, 'Style', 'checkbox');
Koy.String = 'Ko';
Koy.Position(1) = left_as_hold;
Koy.Position(2) = UP - BETWEEN_UP * 2;
Koy.FontSize = font;
Koy.Tag = 'y axis';

G_xy = uicontrol(f, 'Style', 'checkbox');
G_xy.String = sprintf('\x0393\x002A');
G_xy.Position(1) = left_as_hold;
G_xy.Position(2) = UP - BETWEEN_UP * 3;
G_xy.FontSize = font;
G_xy.Tag = 'y axis';

Rdy = uicontrol(f, 'Style', 'checkbox');
Rdy.String = 'Rd';
Rdy.Position(1) = left_as_hold;
Rdy.Position(2) = UP - BETWEEN_UP * 4;
Rdy.FontSize = font;
Rdy.Tag = 'y axis';

Jmaxy = uicontrol(f, 'Style', 'checkbox');
Jmaxy.String = sprintf('O\x2082');
Jmaxy.Position(1) = left_as_hold;
Jmaxy.Position(2) = UP - BETWEEN_UP * 5;
Jmaxy.FontSize = font;
Jmaxy.Tag = 'y axis';

Tpy = uicontrol(f, 'Style', 'checkbox');
Tpy.String = 'Tp';
Tpy.Position(1) = left_as_hold;
Tpy.Position(2) = UP - BETWEEN_UP * 6;
Tpy.FontSize = font;
Tpy.Tag = 'y axis';

Ay.Callback = {@inactivate_y f};
T.Callback = {@inactivate_y f};
CO2.Callback = {@inactivate_y f};
Jmax.Callback = {@inactivate_y f};
Vcmax.Callback = {@inactivate_y f};
rmy.Callback = {@inactivate_y f};
Kcy.Callback = {@inactivate_y f};
Koy.Callback = {@inactivate_y f};
G_xy.Callback = {@inactivate_y f};
Rdy.Callback = {@inactivate_y f};
Jmaxy.Callback = {@inactivate_y f};
Tpy.Callback = {@inactivate_y f};


end

function inactivate_y(src, ~, f)
y = findobj(f, 'Tag', 'y axis');
for i=1:length(y)
    y(i).Value = 0;
end
src.Value = 1;
end
