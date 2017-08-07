function filename = filename_gui(f, UP, LEFT, LEFT_SHIFT)
%% control position
font = 10.5;
width_lab = 150;
width_filename = 139;

left_4 = LEFT + LEFT_SHIFT * 3.5;
left_5 = LEFT + LEFT_SHIFT * 5 + 20;
% left_6 = LEFT + LEFT_SHIFT * 7;


%% 1.1

lab = uicontrol(f, 'Style', 'text');
lab.String = 'output `.mat` file: ';
lab.Position(1) = left_4;
lab.Position(2) = UP - 1;
lab.Position(3) = width_lab;
lab.FontSize = font;
lab.HorizontalAlignment = 'left';

%% 1.2
filename = uicontrol(f, 'Style', 'edit');
filename.String = 'out';
filename.Position(1) = left_5;
filename.Position(2) = UP - 1;
filename.Position(3) = width_filename;
filename.Callback = {@add_mat};
filename.FontSize = font;

%% 1.3
% extension = uicontrol(f, 'Style', 'text');
% extension.String = '.mat';
% extension.Position(1) = left_6;
% extension.Position(2) = UP - 1;
% extension.HorizontalAlignment = 'left';
% extension.FontSize = font;
end

function add_mat(src, ~)
if (length(src.String) < 4) || ~strcmp(src.String(end-3:end), '.mat')
    src.String = sprintf([src.String, '.mat']);
end
end