function [AGG_VAR_WGT] = Var_Agg_WGTCR(var_name,var_wgt,mapp)
% var_name: variables that we need to aggregate 218*170*56
% var_wgt: weighted variables

%%% var_name: 170*218*56
%%% mapp include:
%%% crp_map: an ordered array with correct mapping of the new crop
%%% aggregation
%%% co_map: an ordered array with correct mapping of the new country
%%% aggregation
%%% crp_array: a set of crops with desired orders
%%% co_array: a set of countries 

cr_map = mapp{1,1};
co_map = mapp{1,2};
cr_array = mapp{1,3};
co_array = mapp{1,4};

%%% cr_dim: new crop dimension
%%% co_dim: new country dimension

co_dim = length(co_array);
cr_dim = length(cr_array);



%%% When var_name = nan, var_wgt shouldn't be included in the next
%%% calculation.
%{
var_wgt_indx = ~isnan(var_name);
var_wgt_indx = var_wgt_indx.*1;

var_wgt_indx(var_wgt_indx==0) = nan;
var_wgt_temp = var_wgt .* var_wgt_indx;

var_product= var_name .* var_wgt_temp;

var_wgt_agg = Var_Agg_SIMPLE(var_wgt_temp,mapp);
%}

var_cell = {var_name,var_wgt};
var_out = N_NanPairs(var_cell);

var_name1 = var_out{1};
var_wgt1 = var_out{2};

var_wgt_agg = Var_Agg_SIMPLECR(var_wgt1,mapp);
var_prod = var_name1 .* var_wgt1;


    for j = 1:1:cr_dim
        indcr{j} = find(cr_map == cr_array(j));
        AGG_VAR_PROD(:,j,:) = nansum(var_prod(:,indcr{j},:),2);
    end


AGG_VAR_WGT = AGG_VAR_PROD ./var_wgt_agg;
%AGG_VAR_WGT(AGG_VAR_WGT==0)=nan;

end
