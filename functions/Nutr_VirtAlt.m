function [area_vir,sur_vir,input_vir, area_alt, sur_alt, input_alt,trade_nutr_content,...
          biarea_vir,binutr_surplus_vir,binutr_input_vir,...
          biarea_alt,binutr_surplus_alt,binutr_input_alt,...
          area_vir_co,sur_vir_co,input_vir_co, area_alt_co, sur_alt_co, input_alt_co,...
          area_vir_gb,sur_vir_gb,input_vir_gb, area_alt_gb, sur_alt_gb, input_alt_gb]...
          = Nutr_VirtAlt(nutr_content,bitrade_var,yield, nutr_yield, nutr_surplus, nutr_input,baseyr)
          
% nutr_content: nutrient content
% bitrade_var: bilateral trade var netImTrdQnt
% yield:Yield_FAO
% nutr_yield: nutrition yield
% nutr_surplus: nutrition surplus
% nutr_input: nutrition input

%%% find zero nutrient content
nutr_content_sum = nansum(nansum(nutr_content,1),3);
cr_dim = length(nutr_content_sum);
co_dim = size(nutr_yield);
co_dim = co_dim(1);

uniYrs = 1961:1:2016;
yr_base = find(uniYrs == baseyr);
yr_dim = length(yr_base);

Nu_zero = find(nutr_content_sum==0);
Nu_other = setdiff([1:cr_dim],Nu_zero);

if yr_dim == 1
    yield_reshape = permute(yield,[2,1]);
    yield_reshape = reshape(yield,cr_dim,yr_dim,co_dim);
else
    yield_reshape = permute(yield,[2 3 1]);
end

%%% changing the order of dimensions
nutr_yield_reshape = permute(nutr_yield,[2 3 1]);
nutr_surplus_reshape = permute(nutr_surplus,[2 3 1]);
nutr_input_reshape = permute(nutr_input,[2 3 1]);
nutr_content_reshape = permute(nutr_content,[2 3 1]);

%%% Virtual
for ex = 1:1:co_dim
    for cr = 1:1:cr_dim     
        trade_nutr_content(cr,1:yr_dim,ex,:) = bitrade_var(cr,1:yr_dim,ex,:).*nutr_content_reshape(cr,yr_base,ex);
    end
end

biarea_vir(1:cr_dim,1:yr_dim,1:co_dim,1:co_dim) = nan;
binutr_surplus_vir(1:cr_dim,1:yr_dim,1:co_dim,1:co_dim) = nan;
binutr_input_vir(1:cr_dim,1:yr_dim,1:co_dim,1:co_dim) = nan;

for ex = 1:1:co_dim
    biarea_vir(Nu_other,1:yr_dim,1:co_dim,ex) = trade_nutr_content(Nu_other,1:yr_dim,1:co_dim,ex)./nutr_yield_reshape(Nu_other,yr_base,ex);

    if yr_dim == 1
    biarea_vir(Nu_zero,1:yr_dim,1:co_dim,ex) = trade_nutr_content(Nu_zero,1:yr_dim,1:co_dim,ex)./yield_reshape(Nu_zero,length(yr_base),ex);
    else
    biarea_vir(Nu_zero,1:yr_dim,1:co_dim,ex) = trade_nutr_content(Nu_zero,1:yr_dim,1:co_dim,ex)./yield_reshape(Nu_zero,yr_base,ex);
    end

    %%% Calculate virtual nitrogen surplus
    binutr_surplus_vir(:,1:yr_dim,:,ex)= biarea_vir(:,1:yr_dim,:,ex).*nutr_surplus_reshape(:,yr_base,ex);
    %%% Clculate virtual nitrogen input
    binutr_input_vir(:,1:yr_dim,:,ex)= biarea_vir(:,1:yr_dim,:,ex).*nutr_input_reshape(:,yr_base,ex);

end

area_vir = nansum(biarea_vir,4);
area_vir = permute(area_vir,[3 1 2]);

sur_vir = nansum(binutr_surplus_vir,4);
sur_vir = permute(sur_vir,[3 1 2]);

input_vir = nansum(binutr_input_vir,4);
input_vir = permute(input_vir,[3 1 2]);

% Regional
area_vir_co = nansum(area_vir,2);
sur_vir_co = nansum(sur_vir,2);
input_vir_co = nansum(input_vir,2);

% Global
area_vir_gb = nansum(area_vir_co,1);
sur_vir_gb = nansum(sur_vir_co,1);
input_vir_gb = nansum(input_vir_co,1);

%%% Alternative
for im = 1:1:co_dim
    biarea_alt(Nu_other,1:yr_dim,im,:) = trade_nutr_content(Nu_other,1:yr_dim,im,1:co_dim)./nutr_yield_reshape(Nu_other,yr_base,im);
    
    if yr_dim ==1
    biarea_alt(Nu_zero,1:yr_dim,im,:) = trade_nutr_content(Nu_zero,1:yr_dim,im,1:co_dim)./yield_reshape(Nu_zero,length(yr_base),im);
    else
    biarea_alt(Nu_zero,1:yr_dim,im,:) = trade_nutr_content(Nu_zero,1:yr_dim,im,1:co_dim)./yield_reshape(Nu_zero,yr_base,im);
    end
    
    %%% Calculate virtual nitrogen surplus
    binutr_surplus_alt(:,1:yr_dim,im,:)= biarea_alt(:,1:yr_dim,im,:).* nutr_surplus_reshape(:,yr_base,im);

    %%% Clculate virtual nitrogen input
    binutr_input_alt(:,1:yr_dim,im,:)= biarea_alt(:,1:yr_dim,im,:).* nutr_input_reshape(:,yr_base,im);

end
 
area_alt = nansum(biarea_alt,4);
area_alt = permute(area_alt,[3 1 2]);

sur_alt = nansum(binutr_surplus_alt,4);
sur_alt = permute(sur_alt,[3 1 2]);

input_alt = nansum(binutr_input_alt,4);
input_alt = permute(input_alt,[3 1 2]);

% Regional
area_alt_co = nansum(area_alt,2);
sur_alt_co = nansum(area_alt,2);
input_alt_co = nansum(input_alt,2);

% Global
area_alt_gb = nansum(area_alt_co,1);
sur_alt_gb = nansum(area_alt_co,1);
input_alt_gb = nansum(input_alt_co,1);

end



