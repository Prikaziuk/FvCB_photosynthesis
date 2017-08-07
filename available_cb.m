function available_cb(src, ~, end_range, values_range)
end_range.String = values_range(src.Value:end);
end_range.Value = length(end_range.String);
end