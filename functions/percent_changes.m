function [perChvar] = percent_changes(var_orig,var_delta)
%%% Calculate percentage changes
perChvar = (var_delta./var_orig) .*100;

end

