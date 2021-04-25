function [SSR,SSR_max,SSR_min] = SSR_cal(trade_var,prod_var)
% initial trade variables and production variables

dim = size(prod_var);
co_dim = dim(1);
cr_dim = dim(2);

    if length(dim)>2;
        yr_length = dim(3);
    else
        yr_length = 1;
    end

imp_var = nansum(trade_var,4);
exp_var = squeeze(nansum(trade_var,3));

imp_var = permute(imp_var,[3,1,2]);
exp_var = permute(exp_var,[3,1,2]);

imp_var_co = reshape(nansum(imp_var,2),co_dim,yr_length);
exp_var_co = reshape(nansum(exp_var,2),co_dim,yr_length);

prod_var_co = reshape(nansum(prod_var,2),co_dim,yr_length);


SSR = (prod_var_co .*100)./(prod_var_co + imp_var_co - exp_var_co);
SSR_max = nanmax(nanmax(SSR));
SSR_min = nanmin(nanmin(SSR));

end

