function bg_cb(src, ~, too_big)
inp = (str2double(src.String));
if inp >= too_big
    src.BackgroundColor = 'yellow'; 
elseif isnan(inp) || isempty(src.String) || inp < 0
    src.BackgroundColor = 'red';
else
    src.BackgroundColor = [.94 .94 .94];
end
end