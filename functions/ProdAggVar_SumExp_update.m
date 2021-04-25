function [var_kgkm_exp,var_kgkm_expco,var_kgkm_expgb,var_kg_exp, var_kg_expco,var_kg_expgb] = ProdAggVar_SumExp_update(var_kgkm_agg,var_wgt,yr_base,cr_ind)

% This function is used to generate country level or global level analyses

%var_cell = {var_kgkm_agg(:,:,yr_base),var_wgt};
%var_out = N_NanPairs(var_cell);

var_kgkm_exp = var_kgkm_agg(:,cr_ind,yr_base);
var_wgt = var_wgt(:,cr_ind);
%var_kgkm_exp = var_out{1};
%var_wgt1 = var_out{2};

%var_kgkm_exp = var_kgkm_exp(:,cr_ind);
%var_wgt1 = var_wgt1(:,cr_ind);

var_kg_exp = var_kgkm_exp .* var_wgt;

var_kg_expco = squeeze(nansum(var_kg_exp,2));
var_kg_expgb = nansum(var_kg_expco,1);

var_wgt_co = squeeze(nansum(var_wgt,2));
var_wgt_gb = nansum(var_wgt_co,1);

var_kgkm_expco = var_kg_expco ./ var_wgt_co;
var_kgkm_expgb = var_kg_expgb ./ var_wgt_gb;

end

