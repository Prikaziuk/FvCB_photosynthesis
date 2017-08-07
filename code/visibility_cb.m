function visibility_cb(src, ~, start_r, end_r, val, units, LEFT_3, LEFT_4, f)
range = findobj(f, 'Tag', 'range');
start = findobj(f, 'Tag', 'start');
endd = findobj(f, 'Tag', 'end');
value = findobj(f, 'Tag', 'val');
unit = findobj(f, 'Tag', 'units');

for i=1:length(range)
    start(i).Visible = 'off';
    endd(i).Visible = 'off';
    unit(i).Position(1) = LEFT_3;
    value(i).Visible = 'on';
end

switch src.Value
    case 0
        for i=1:length(range)
            range(i).Value = 0;
        end
    case 1
        start_r.Visible = 'on';
        end_r.Visible = 'on';

        units.Position(1) = LEFT_4;
     
        val.Visible = 'off';
        
        for i=1:length(range)
            range(i).Value = 0;
        end
        src.Value = 1;
end

end