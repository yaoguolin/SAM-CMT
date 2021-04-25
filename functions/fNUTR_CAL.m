function   [nutr_prod_aggco_pop_daily, nutrPNIm_aggco_pop_daily,...
            nutr_prod_expco_pop_daily, nutrPNIm_expco_pop_daily,...
            nutr_prod_agg,      nutr_prod_exp,           nutr_prod_delta,   ...
            nutr_prod_aggco,    nutr_prod_expco,         nutr_prod_deltaco,  ... 
            nutrImTrdQnt_agg,   nutrImTrdQnt_exp,        nutrImTrdQnt_delta,...
            nutrExport_agg,     nutrImport_agg,          nutrNetImp_agg,    ...
            nutrPNIm_agg,       nutrExport_exp,          nutrImport_exp,    ...
            nutrNetImp_exp,     nutrPNIm_exp,            nutrExport_delta,  ...
            nutrImport_delta,   nutrNetImp_delta,        nutrPNIm_delta,    ...
            nutrExport_aggco,   nutrImport_aggco,        nutrNetImp_aggco,  ...
            nutrPNIm_aggco,     nutrExport_expco,        nutrImport_expco,  ...
            nutrNetImp_expco,   nutrPNIm_expco,          nutrExport_deltaco,...
            nutrImport_deltaco, nutrNetImp_deltaco,      nutrPNIm_deltaco,...
            nutr_cont_agg]...
    = fNUTR_CAL(nutr_cont,prod_fao,prod_fao_agg,ImTrdQnt, pop, prod_port,trade_port,cr_ind,cr_dim,co_dim,mapp,yr_base,yr_trd)

%%% This script is designed for all nutrition supply calculation.
pop_agg = Var_Agg_SIMPLE2d(pop,mapp);

[nutr_prod,nutr_cap] = NutrProd(nutr_cont,prod_fao,pop);

%%% Nutrition supply by aggregated regions and crops
nutr_prod_agg = Var_Agg_SIMPLE(nutr_prod,mapp);


nutr_prod_agg = nutr_prod_agg(:,cr_ind,:);


%%% Nutrition content after aggregation
nutr_cont_agg = nutr_prod_agg./prod_fao_agg; % 6*10*56???


[nutr_prod_exp,nutr_cap_exp] = NutrProd2dim(nutr_cont_agg,prod_port,pop,yr_base);


%%% Nutrition supply changes by crop and by country
nutr_prod_delta = nutr_prod_exp - nutr_prod_agg(:,:,yr_base);


%%% Nutrition Supply by country (Original)
nutr_prod_aggco = squeeze(nansum(nutr_prod_agg,2)); %6*56

nutr_prod_aggco_pop_daily = nutr_prod_aggco ./ pop_agg ./365;

%%% Nutrition Supply by country (New)
nutr_prod_expco = squeeze(nansum(nutr_prod_exp,2));

nutr_prod_expco_pop_daily = nutr_prod_expco ./ pop_agg(:,yr_base) ./365;

%%% Nutrition supply by country (changes)
nutr_prod_deltaco = nutr_prod_expco - nutr_prod_aggco(:,yr_base);


%%% Nutrition trade changes
%%% ImTrdQnt (bilateral trade quantities)
ImTrdQnt_SAM(1:170,1:56,1:218,1:218) = nan;
ImTrdQnt_SAM(:,yr_trd,:,:) = ImTrdQnt;

nutrImTrdQnt_SAM = ImTrdQnt_SAM .* nutr_cont;


%%% Bilateral trade nutrition changes (original)
nutrImTrdQnt_agg= Var_Agg_TRD(nutrImTrdQnt_SAM,mapp);


nutrImTrdQnt_agg = nutrImTrdQnt_agg(cr_ind,:,:,:);


%%% Bilateral trade nutrition changes (new)
trade_port_reshape = permute(trade_port,[3,4,1,2]);
nutrImTrdQnt_exp(1:cr_dim,1,1:co_dim,1:co_dim) = nan;


for cr = 1:1:cr_dim
    nutrImTrdQnt_exp(cr,1,1:co_dim,1:co_dim) = trade_port_reshape(1:co_dim,1:co_dim,cr).*nutr_cont_agg(1:co_dim,cr,yr_base);
end

%%% Bilateral trade nutrition changes (changes)
nutrImTrdQnt_delta = nutrImTrdQnt_exp - nutrImTrdQnt_agg(:,yr_base,:,:);


%%% Changes in total exports and imports (original)
% Exports
nutrExport_agg = permute(squeeze(nansum(nutrImTrdQnt_agg,3)),[3,1,2]);


% Imports
nutrImport_agg = permute(squeeze(nansum(nutrImTrdQnt_agg,4)),[3,1,2]);


% Net imports
nutrNetImp_agg = nutrImport_agg - nutrExport_agg;



% Production + Net Imports
nutrPNIm_agg = nutr_prod_agg + nutrNetImp_agg;


%%% Changes in total exports and imports (new)
% Exports
nutrExport_exp = permute(squeeze(nansum(nutrImTrdQnt_exp,3)),[2,1]);


% Imports
nutrImport_exp = permute(squeeze(nansum(nutrImTrdQnt_exp,4)),[2,1]);


% Net Imports
nutrNetImp_exp = nutrImport_exp - nutrExport_exp;


% Production + Net Imports
nutrPNIm_exp = nutr_prod_exp + nutrNetImp_exp;


%%% Changes in total exports and imports (changes)
% Exports
nutrExport_delta = nutrExport_exp - nutrExport_agg(:,:,yr_base);


% Imports
nutrImport_delta = nutrImport_exp - nutrImport_agg(:,:,yr_base);


% Net Imports
nutrNetImp_delta = nutrNetImp_exp - nutrNetImp_agg(:,:,yr_base);


% Production + Net Imports
nutrPNIm_delta = nutrPNIm_exp - nutrPNIm_agg(:,:,yr_base);


%%%%%%%%%%%%%%%% Changes in total exports and imports by country

%%% Changes in total exports and imports (original)
% Exports
nutrExport_aggco = squeeze(nansum(nutrExport_agg,2));


% Imports
nutrImport_aggco = squeeze(nansum(nutrImport_agg,2));


% Net imports
nutrNetImp_aggco = nutrImport_aggco - nutrExport_aggco;


% Production + Net Imports
nutrPNIm_aggco = nutr_prod_aggco + nutrNetImp_aggco;

nutrPNIm_aggco_pop_daily = nutrPNIm_aggco ./pop_agg ./365;


%%% Changes in total exports and imports (new)
% Exports
nutrExport_expco = squeeze(nansum(nutrExport_exp,2));


% Imports
nutrImport_expco = squeeze(nansum(nutrImport_exp,2));



% Net Imports
nutrNetImp_expco = nutrImport_expco - nutrExport_expco;


% Production + Net Imports
nutrPNIm_expco = nutr_prod_expco + nutrNetImp_expco;

nutrPNIm_expco_pop_daily = nutrPNIm_expco ./pop_agg(:,yr_base) ./365;


%%% Changes in total exports and imports (changes)
% Exports
nutrExport_deltaco = nutrExport_expco - nutrExport_aggco(:,yr_base);


% Imports
nutrImport_deltaco = nutrImport_expco - nutrImport_aggco(:,yr_base);


% Net Imports
nutrNetImp_deltaco = nutrNetImp_expco - nutrNetImp_aggco(:,yr_base);


% Production + Net Imports
nutrPNIm_deltaco = nutrPNIm_expco - nutrPNIm_aggco(:,yr_base);




end

