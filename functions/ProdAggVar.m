function [var_prod] = ProdAggVar(var_name,var_wgt,mapp)

%%% The product of Aggregated Variables

var_cell = {var_name,var_wgt};
var_out = N_NanPairs(var_cell);

var_name1 = var_out{1};
var_wgt1 = var_out{2};

var_wgt_agg = Var_Agg_SIMPLE(var_wgt1,mapp);
var_name_agg = Var_Agg_WGT(var_name1,var_wgt1,mapp);

var_prod = var_wgt_agg .* var_name_agg;

end

