function [var_kg_agggb,var_wgt_agggb,var_kgkm_agggb] = Var_Agg_WGTGB(var_name,var_wgt)


%%% var_name: country * crop* year

% This function is used to generate country level or global level analyses
% sum_dim = 2 when generating national level analyses
% sum_dim = 1 when generating global level analyses

dim = size(var_name);


var_cell = {var_name,var_wgt};
var_out = N_NanPairs(var_cell);

var_name1 = var_out{1};
var_wgt1 = var_out{2};

var_kg_agggb = squeeze(nansum(var_name1 .* var_wgt1,1)); % Numerator
var_wgt_agggb = squeeze(nansum(var_wgt1,1)); % Denominator

var_kgkm_agggb = var_kg_agggb ./ var_wgt_agggb;

end

