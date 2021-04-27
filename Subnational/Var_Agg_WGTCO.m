function [var_kg_aggco,var_wgt_aggco,var_kgkm_aggco] = Var_Agg_WGTCO(var_name,var_wgt)

%%% Aggregate all crops by country

%%% var_name: country * year

dim = size(var_name);


var_cell = {var_name,var_wgt};
var_out = N_NanPairs(var_cell);

var_name1 = var_out{1};
var_wgt1 = var_out{2};

var_kg_aggco = squeeze(nansum(var_name1 .* var_wgt1,2)); % Numerator
var_wgt_aggco = squeeze(nansum(var_wgt1,2)); % Denominator

var_kgkm_aggco = var_kg_aggco ./ var_wgt_aggco;

end

