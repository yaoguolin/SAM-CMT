function [var_kgkm_exp,var_kgkm_expco,var_kgkm_expgb,var_kg_exp, var_kg_expco,var_kg_expgb] = ProdAggVar_SumExp(var_kgkm_agg,var_wgt,yr_base,cr_ind)

% This function is used to generate country level or global level analyses

var_cell = {var_kgkm_agg(:,:,yr_base),var_wgt};
var_out = N_NanPairs(var_cell);

var_kgkm_exp = var_out{1};
var_wgt1 = var_out{2};

var_kgkm_exp = var_kgkm_exp(:,cr_ind);
var_wgt1 = var_wgt1(:,cr_ind);

var_kg_exp = var_kgkm_exp .* var_wgt1;

[var_kg_expco,var_wgt_expco,var_kgkm_expco] = Var_Agg_WGTCO(var_kgkm_exp,var_wgt1);

[var_kg_expgb,var_wgt_expgb,var_kgkm_expgb]= Var_Agg_WGTGB(var_kgkm_expco,var_wgt_expco);


end

