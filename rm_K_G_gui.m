function [rm_val, Kc_val, Ko_val, G_x_val, calculate_G_x] = rm_K_G_gui(f, UP, BETWEEN_UP, LEFT, LEFT_SHIFT)
%% control position
font = 10.5;
font_units = 10;
width_units = 100;

left_1 = LEFT;
left_2 = LEFT + LEFT_SHIFT;
left_3 = LEFT + LEFT_SHIFT * 2 + 1;
left_4 = LEFT + LEFT_SHIFT * 3 + 1;

up1 = UP;
up2 = UP - BETWEEN_UP;
up3 = UP - BETWEEN_UP * 2;
up4 = UP - BETWEEN_UP * 3;

%% 1.1
var = 'rm';
uni = sprintf(' m\x00B2 s bar mol\x207B\x00B9');
init_val = '0';

lab = uicontrol(f, 'Style', 'text');
lab.String = var;
lab.Position(1) = left_1;
lab.Position(2) = up1 - 1;
lab.FontSize = font;

%% 1.2
rm_val = uicontrol(f, 'Style', 'edit');
rm_val.String = init_val;
rm_val.Position(1) = left_2;
rm_val.Position(2) = up1 - 1;

%% 1.3
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_3;
units.Position(2) = up1 - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;


%% 2.1
var = 'Kc';
uni = sprintf(' \x03BC bar');
uni(3)= []; % may be because 03BC and b from bar go together we have to replace space it manually
init_val = '404';
too_big = 1000;

lab = uicontrol(f, 'Style', 'text');
lab.String = var;
lab.Position(1) = left_1;
lab.Position(2) = up2 - 1;
lab.FontSize = font;

%% 2.2
Kc_val = uicontrol(f, 'Style', 'edit');
Kc_val.String = init_val;
Kc_val.Position(1) = left_2;
Kc_val.Position(2) = up2 - 1;
Kc_val.Callback = {@bg_cb, too_big};

%% 2.3
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_3;
units.Position(2) = up2 - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;


%% 3.1
var = 'Ko';
uni = ' mbar';
init_val = '248';
too_big = 1000;

lab = uicontrol(f, 'Style', 'text');
lab.String = var;
lab.Position(1) = left_1;
lab.Position(2) = up3 - 1;
lab.FontSize = font;

%% 3.2
Ko_val = uicontrol(f, 'Style', 'edit');
Ko_val.String = init_val;
Ko_val.Position(1) = left_2;
Ko_val.Position(2) = up3 - 1;
Ko_val.Callback = {@bg_cb, too_big};

%% 3.3
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_3;
units.Position(2) = up3 - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;

%% 4.1
var = sprintf('\x0393\x002A');
uni = sprintf(' \x03BC bar');
uni(3)= []; % may be because 03BC and b from bar go together we have to replace space it manually
init_val = '38.6';
too_big = 100;

lab = uicontrol(f, 'Style', 'text');
lab.String = var;
lab.Position(1) = left_1;
lab.Position(2) = up4 - 1;
lab.FontSize = font;

%% 4.2
G_x_val = uicontrol(f, 'Style', 'edit');
G_x_val.String = init_val;
G_x_val.Position(1) = left_2;
G_x_val.Position(2) = up4 - 1;
G_x_val.Callback = {@bg_cb, too_big};

%% 4.3
units = uicontrol(f, 'Style', 'text');
units.String = uni;
units.Position(1) = left_3;
units.Position(2) = up4 - 1;
units.Position(3) = width_units;
units.HorizontalAlignment = 'left';
units.FontSize = font_units;

%% 4.4
width = 200;

calculate_G_x = uicontrol(f, 'Style', 'checkbox');
calculate_G_x.String = sprintf(['Caluclate ', var, ' = 0.5 * O / S(c/o)']);
calculate_G_x.Position(1) = left_4;
calculate_G_x.Position(2) = up4 - 1;
calculate_G_x.Position(3) = width;
calculate_G_x.HorizontalAlignment = 'left';
calculate_G_x.FontSize = font_units;
calculate_G_x.Callback = {@calc_G_x_cb, G_x_val};

%% special Callback to show that values of Kc, Ko and gamma changes depending on rm
rm_val.Callback = {@rm_cb, Kc_val, Ko_val, G_x_val};

end

function rm_cb(src, ~, Kc_val, Ko_val, G_x_val)
inp = (str2double(src.String));
if inp > 0
    Kc_val.BackgroundColor = 'yellow';
    Kc_val.String = '260';
    
    Ko_val.BackgroundColor = 'yellow';
    Ko_val.String = '179';
    
    G_x_val.BackgroundColor = 'yellow';
    G_x_val.String = '37';
elseif inp==0
    Kc_val.BackgroundColor = [.94 .94 .94];
    Kc_val.String = '404';
    
    Ko_val.BackgroundColor = [.94 .94 .94];
    Ko_val.String = '248';
    
    G_x_val.BackgroundColor = [.94 .94 .94];
    G_x_val.String = '38.6';
elseif isnan(inp) || isempty(src.String) || inp < 0
    src.BackgroundColor = 'red';
else
    src.BackgroundColor = [.94 .94 .94];
end
end

function calc_G_x_cb(src, ~, G_x_val)
switch src.Value
    case 1
        G_x_val.Style = 'text';
        G_x_val.String = 'formula';
        G_x_val.Position(2) = G_x_val.Position(2) - 3;
    case 0
        G_x_val.Style = 'edit';
        G_x_val.String = '38.6';
        G_x_val.Position(2) = G_x_val.Position(2) + 3;
end
end
