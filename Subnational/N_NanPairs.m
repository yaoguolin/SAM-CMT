function [out_varcell] = N_NanPairs(varcell)
% 
% find overlaped non-nan pairs for all variable input in varcell
% varcell is a variable cell containing as many as variables as you want

v_len = length(varcell);
check_var = cellfun(@nisnan,varcell,'UniformOutput',false);
product_var = ones(size(varcell{1}));

for i = 1:1:v_len
    product_var = product_var .* check_var{i};
end

for i = 1:1:v_len
    out_varcell{i} = product_var .* varcell{i};
end

end

