function [var_kgkm_agg, var_kgkm_aggco,var_kgkm_agggb,var_kg_agg, var_kg_aggco,var_kg_agggb] = ProdAggVar_Sum(var_name,var_wgt,mapp,cr_ind)

% This function is used to generate country level or global level analyses

var_cell = {var_name,var_wgt};
var_out = N_NanPairs(var_cell);

var_name1 = var_out{1};
var_wgt1 = var_out{2};

var_wgt_agg = Var_Agg_SIMPLE(var_wgt1,mapp);
var_kgkm_agg = Var_Agg_WGT(var_name1,var_wgt1,mapp);

var_wgt_agg = var_wgt_agg(:,cr_ind,:);
var_kgkm_agg = var_kgkm_agg(:,cr_ind,:);

var_kgkm_agg(var_kgkm_agg<0)=0;

var_kg_agg = var_kgkm_agg .* var_wgt_agg;



[var_kg_aggco,var_wgt_aggco,var_kgkm_aggco] = Var_Agg_WGTCO(var_kgkm_agg,var_wgt_agg);

[var_kg_agggb,var_wgt_agggb,var_kgkm_agggb]= Var_Agg_WGTGB(var_kgkm_aggco,var_wgt_aggco);


end

