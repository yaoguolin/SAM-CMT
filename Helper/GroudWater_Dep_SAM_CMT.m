%%% Aggregate h2oDeplete_3d_gf to desired mapping
% Original
%[h2oDeplete_3d_gf1,Product_FAO1] = Non_NAN_PAIRS(h2oDeplete_3d_gf,Product_FAO);
%Product_FAO_C = Yield_FAO .* AreaH_FAO;
%Product_FAO_C_Agg = Var_Agg_SIMPLE(Product_FAO_C,MAPPING);
%Product_FAO_C_AggCO = reshape(nansum(Product_FAO_C_Agg,2),co_dim,length(uniYrs));

h2oDeplete_3d_gf_Agg = Var_Agg_WGT(h2oDeplete_3d_gf,Product_FAO,MAPPING);
h2oDeplete_3d_gf_Agg(h2oDeplete_3d_gf_Agg==0) = nan;
h2oDeplete_3d_gf_Agg = h2oDeplete_3d_gf_Agg(:,cr_ind,:);
h2oDeplete_3d_L_Agg = h2oDeplete_3d_gf_Agg.*Product_FAO_Agg;
h2oDeplete_L_AggCO =squeeze(nansum(h2oDeplete_3d_L_Agg,2));

%%% Ground water intensity by country
h2oDeplete_AggCO = h2oDeplete_L_AggCO ./ Product_FAO_AggCO;

%%%% Global
h2oDeplete_L_AggGB = nansum(h2oDeplete_AggCO,1);

%%% Blue water intensity globally before shocks
h2oDeplete_AggGB = h2oDeplete_L_AggGB ./ Product_FAO_AggGB;

% New
h2oDeplete_3d_L_Exp = h2oDeplete_3d_gf_Agg(:,:,yr_base).*prod_port;
h2oDeplete_L_ExpCO = reshape(nansum(h2oDeplete_3d_L_Exp,2),co_dim,length(yr_base));

%%%% Global
h2oDeplete_L_ExpGB =nansum(h2oDeplete_L_ExpCO,1);

%%% Ground water intensity by country after shocks
h2oDeplete_ExpCO = h2oDeplete_L_ExpCO ./ prod_portco;

%%% Blue water intensity globally after shocks
h2oDeplete_ExpGB = h2oDeplete_L_ExpGB ./ prod_portgb;

% Changes
h2oDeplete_L_Delta = h2oDeplete_3d_gf_Agg(:,:,yr_base).* prod_delta;
h2oDeplete_L_DeltaCO = squeeze(nansum(h2oDeplete_L_Delta,2));
h2oDeplete_L_DeltaGB = squeeze(nansum(h2oDeplete_L_DeltaCO));

%%%% Water Use Efficiency
% Original
WUE_Agg = Product_FAO_Agg ./h2oDeplete_3d_L_Agg;
WUE_N_Agg = Nyield_kg_Agg ./h2oDeplete_3d_L_Agg;

WUE_AggCO = Product_FAO_AggCO./ h2oDeplete_AggCO;
WUE_N_AggCO = Nyield_kg_AggCO./h2oDeplete_AggCO;

WUE_AggGB = nansum(Product_FAO_AggCO,1)./ nansum(h2oDeplete_AggCO,1);
WUE_N_AggGB = nansum(Nyield_kg_AggCO,1)./nansum(h2oDeplete_AggCO,1);

% New
WUE_Exp = prod_port./ h2oDeplete_3d_L_Exp;
WUE_N_Exp = Nyield_kg_Exp ./h2oDeplete_3d_L_Exp;

WUE_ExpCO = prod_portco./ h2oDeplete_ExpCO;
WUE_N_ExpCO = Nyield_kg_ExpCO ./h2oDeplete_ExpCO;

WUE_ExpGB = nansum(prod_portco,1)./ nansum(h2oDeplete_ExpCO,1);
WUE_N_ExpGB = nansum(Nyield_kg_ExpCO,1) ./ nansum(h2oDeplete_ExpCO,1);

% Changes
WUE_Delta = WUE_Exp - WUE_Agg(:,:,yr_base);
WUE_N_Delta = WUE_N_Exp - WUE_N_Agg(:,:,yr_base);

WUE_DeltaCO = WUE_ExpCO - WUE_AggCO(:,yr_base);
WUE_N_DeltaCO = WUE_N_ExpCO - WUE_N_AggCO(:,yr_base);

WUE_DeltaGB = WUE_ExpGB - WUE_AggGB(yr_base);
WUE_N_DeltaGB = WUE_N_ExpGB - WUE_N_AggGB(yr_base);

%%% AEZ water
%       Groundwater AEZ changes

%%% Disaggregated
% Original
h2oDeplete_L_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;
for az = 1:1:18
    h2oDeplete_L_AEZ_Agg(:,az,:,:) = squeeze(h2oDeplete_3d_gf_Agg(:,:,:)) .* squeeze(Prod_AEZ_FAO_Agg(:,az,:,:));
end

% New
h2oDeplete_L_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    h2oDeplete_L_AEZ_Exp(:,az,:) = squeeze(h2oDeplete_3d_gf_Agg(:,:,yr_base)) .* squeeze(prod_aez_port(:,az,:));
end

% Changes
h2oDeplete_L_AEZ_Delta = h2oDeplete_L_AEZ_Exp - h2oDeplete_L_AEZ_Agg(:,:,:,yr_base);

%%% National Level
h2oDeplete_L_AEZ_AggCO = squeeze(nansum(h2oDeplete_L_AEZ_Agg,3));
h2oDeplete_L_AEZ_ExpCO = squeeze(nansum(h2oDeplete_L_AEZ_Exp,3));
h2oDeplete_L_AEZ_DeltaCO = squeeze(nansum(h2oDeplete_L_AEZ_Delta,3));

%%% Global Level
h2oDeplete_L_AEZ_AggGB = squeeze(nansum(h2oDeplete_L_AEZ_AggCO,1));
h2oDeplete_L_AEZ_ExpGB = squeeze(nansum(h2oDeplete_L_AEZ_ExpCO,1));
h2oDeplete_L_AEZ_DeltaGB = squeeze(nansum(h2oDeplete_L_AEZ_DeltaCO,1));