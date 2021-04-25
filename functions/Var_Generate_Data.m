function [var_out] = Var_Generate_Data(var_name)
% This function create data for year 2015 and 2016 if the variable 2015 and
% 2016 has no data (equal to the most recently available data)
dim = size(var_name);
co_dim = dim(1);
cr_dim = dim(2);
yr_dim = dim(3);
var_out(1:co_dim,1:cr_dim,1:yr_dim) = var_name(1:co_dim,1:cr_dim,1:yr_dim);
for co=1:1:co_dim
    for cr = 1:1:cr_dim
        for y = 50:1:yr_dim
            if isnan(var_name(co,cr,y))==1
                var_out(co,cr,y) = var_out(co,cr,y-1);
            else var_out(co,cr,y) = var_out(co,cr,y);
            end
        end
    end

end

end

