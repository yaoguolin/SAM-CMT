
%% BLUE Water
%% Load Files
BLUE_FILE = 'BLUE_water.mat'; 
load([dir 'Inputs' dir_s BLUE_FILE]); 
%%% Aggregate Blue Water to desired mapping
% Original
WF_Blue_m3ton_56(1:218,1:170,1:56) = nan;
WF_Blue_m3ton_56(1:218,1:170,1:54) = WF_Blue_m3ton;  %L/kg
WF_Blue_m3ton_56(1:218,1:170,55) = WF_Blue_m3ton_56(1:218,1:170,54); 
WF_Blue_m3ton_56(1:218,1:170,56) = WF_Blue_m3ton_56(1:218,1:170,54);

BlueW_Lm = WF_Blue_m3ton_56 .* Product_FAO ./ AreaH_FAO;

%%% Blue water intensity by country and crop type
Wat.BLUE.BlueW_Agg = Var_Agg_WGT(BlueW_Lm,AreaH_FAO,MAPPING);
%BlueW_Agg(BlueW_Agg==0) = nan;
Wat.BLUE.BlueW_Agg = Wat.BLUE.BlueW_Agg(:,cr_ind,:);

Wat.BLUE.BlueW_L_Agg = Wat.BLUE.BlueW_Agg.* Portf.Area.AreaH_FAO_Agg;
Wat.BLUE.BlueW_L_AggCO =squeeze(nansum(Wat.BLUE.BlueW_L_Agg,2));

%%% Blue water intensity by country
Wat.BLUE.BlueW_AggCO = Wat.BLUE.BlueW_L_AggCO ./ Portf.Area.AreaH_FAO_AggCO;

%%%% Global
Wat.BLUE.BlueW_L_AggGB = nansum(Wat.BLUE.BlueW_L_AggCO,1);

%%% Blue water intensity globally before shocks
%BlueW_AggGB = BlueW_L_AggGB ./ Product_FAO_AggGB;
Wat.BLUE.BlueW_AggGB = Wat.BLUE.BlueW_L_AggGB ./ Portf.Area.AreaH_FAO_AggGB;

% New
Wat.BLUE.BlueW_L_Exp = Wat.BLUE.BlueW_Agg(:,:,yr_base).* Portf.Area.harvst_port;
Wat.BLUE.BlueW_L_ExpCO = reshape(nansum(Wat.BLUE.BlueW_L_Exp,2),co_dim,length(yr_base));

%%%% Global
Wat.BLUE.BlueW_L_ExpGB =nansum(Wat.BLUE.BlueW_L_ExpCO,1);

%%% Blue water intensity by country after shocks
Wat.BLUE.BlueW_ExpCO = Wat.BLUE.BlueW_L_ExpCO ./ Portf.Area.harvst_portco;

%%% Blue water intensity globally after shocks
Wat.BLUE.BlueW_ExpGB = Wat.BLUE.BlueW_L_ExpGB ./ Portf.Area.harvst_portgb;

% Changes
Wat.BLUE.BlueW_L_Delta = Wat.BLUE.BlueW_Agg(:,:,yr_base).* Portf.Area.harvst_delta;
Wat.BLUE.BlueW_L_DeltaCO = squeeze(nansum(Wat.BLUE.BlueW_L_Delta,2));
Wat.BLUE.BlueW_L_DeltaGB = squeeze(nansum(Wat.BLUE.BlueW_L_DeltaCO));

Wat.BLUE.BlueW_DeltaCO = Wat.BLUE.BlueW_ExpCO - Wat.BLUE.BlueW_AggCO(:,yr_base);
Wat.BLUE.BlueW_DeltaGB = Wat.BLUE.BlueW_ExpGB - Wat.BLUE.BlueW_AggGB(yr_base);

%%%% Water Use Efficiency
% Original
Wat.BWUE.BWUE_Agg = Portf.Prod.Product_FAO_Agg ./Wat.BLUE.BlueW_L_Agg;
Wat.BWUE.BWUE_N_Agg = Nitr.Nyield.Nyield_kg_Agg ./Wat.BLUE.BlueW_L_Agg;

Wat.BWUE.BWUE_AggCO = Portf.Prod.Product_FAO_AggCO./ Wat.BLUE.BlueW_L_AggCO;
Wat.BWUE.BWUE_N_AggCO = Nitr.Nyield.Nyield_kg_AggCO./Wat.BLUE.BlueW_L_AggCO;

Wat.BWUE.BWUE_AggGB = nansum(Portf.Prod.Product_FAO_AggCO,1)./ nansum(Wat.BLUE.BlueW_L_AggCO,1);
Wat.BWUE.BWUE_N_AggGB = nansum(Nitr.Nyield.Nyield_kg_AggCO,1)./nansum(Wat.BLUE.BlueW_L_AggCO,1);

% New
Wat.BWUE.BWUE_Exp = Portf.Prod.prod_port./ Wat.BLUE.BlueW_L_Exp;
Wat.BWUE.BWUE_N_Exp = Nitr.Nyield.Nyield_kg_Exp ./Wat.BLUE.BlueW_L_Exp;

Wat.BWUE.BWUE_ExpCO = Portf.Prod.prod_portco./ Wat.BLUE.BlueW_L_ExpCO;
Wat.BWUE.BWUE_N_ExpCO = Nitr.Nyield.Nyield_kg_ExpCO ./Wat.BLUE.BlueW_L_ExpCO;

Wat.BWUE.BWUE_ExpGB = Portf.Prod.prod_portgb./ Wat.BLUE.BlueW_L_ExpGB;
Wat.BWUE.BWUE_N_ExpGB = Nitr.Nyield.Nyield_kg_ExpGB ./ Wat.BLUE.BlueW_L_ExpCO;

% Changes
Wat.BWUE.BWUE_Delta = Wat.BWUE.BWUE_Exp - Wat.BWUE.BWUE_Agg(:,:,yr_base);
Wat.BWUE.BWUE_N_Delta = Wat.BWUE.BWUE_N_Exp - Wat.BWUE.BWUE_N_Agg(:,:,yr_base);

Wat.BWUE.BWUE_DeltaCO = Wat.BWUE.BWUE_ExpCO - Wat.BWUE.BWUE_AggCO(:,yr_base);
Wat.BWUE.BWUE_N_DeltaCO = Wat.BWUE.BWUE_N_ExpCO - Wat.BWUE.BWUE_N_AggCO(:,yr_base);

Wat.BWUE.BWUE_DeltaGB = Wat.BWUE.BWUE_ExpGB - Wat.BWUE.BWUE_AggGB(yr_base);
Wat.BWUE.BWUE_N_DeltaGB = Wat.BWUE.BWUE_N_ExpGB - Wat.BWUE.BWUE_N_AggGB(yr_base);

%%% AEZ water
%       Groundwater AEZ changes

%%% Disaggregated
% Original
Wat.AEZ.BlueW_L_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;
for az = 1:1:18
    Wat.AEZ.BlueW_L_AEZ_Agg(:,az,:,:) = Wat.BLUE.BlueW_Agg(:,:,:) .* squeeze(Portf.AEZ.AreaH_AEZ_FAO_Agg(:,az,:,:));
end

Wat.AEZ.BlueW_Lkm_AEZ_Agg = Wat.AEZ.BlueW_L_AEZ_Agg ./ Portf.AEZ.AreaH_AEZ_FAO_Agg;


% New
Wat.AEZ.BlueW_L_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    Wat.AEZ.BlueW_L_AEZ_Exp(:,az,:) = squeeze(Wat.BLUE.BlueW_Agg(:,:,yr_base)) .* squeeze(Portf.AEZ.harvst_aez_port(:,az,:));
end

Wat.AEZ.BlueW_Lkm_AEZ_Exp = Wat.AEZ.BlueW_L_AEZ_Exp ./Portf.AEZ.harvst_aez_port;

% Changes
Wat.AEZ.BlueW_L_AEZ_Delta = Wat.AEZ.BlueW_L_AEZ_Exp - Wat.AEZ.BlueW_L_AEZ_Agg(:,:,:,yr_base);

Wat.AEZ.BlueW_Lkm_AEZ_Delta = Wat.AEZ.BlueW_Lkm_AEZ_Exp - Wat.AEZ.BlueW_Lkm_AEZ_Agg(:,:,:,yr_base);

%%% National Level
Wat.AEZ.BlueW_L_AEZ_AggCO = squeeze(nansum(Wat.AEZ.BlueW_L_AEZ_Agg,3));
Wat.AEZ.BlueW_L_AEZ_ExpCO = squeeze(nansum(Wat.AEZ.BlueW_L_AEZ_Exp,3));
Wat.AEZ.BlueW_L_AEZ_DeltaCO = squeeze(nansum(Wat.AEZ.BlueW_L_AEZ_Delta,3));

Wat.AEZ.BlueW_Lkm_AEZ_AggCO = Wat.AEZ.BlueW_L_AEZ_AggCO ./ Portf.AEZ.AreaH_AEZ_FAO_AggCO; 
Wat.AEZ.BlueW_Lkm_AEZ_ExpCO = Wat.AEZ.BlueW_L_AEZ_ExpCO ./ Portf.AEZ.harvst_aez_portco;
Wat.AEZ.BlueW_Lkm_AEZ_DeltaCO = Wat.AEZ.BlueW_Lkm_AEZ_ExpCO - Wat.AEZ.BlueW_Lkm_AEZ_AggCO(:,:,yr_base);

%%% Global Level
Wat.AEZ.BlueW_L_AEZ_AggGB = squeeze(nansum(Wat.AEZ.BlueW_L_AEZ_AggCO,1));
Wat.AEZ.BlueW_L_AEZ_ExpGB = squeeze(nansum(Wat.AEZ.BlueW_L_AEZ_ExpCO,1));
Wat.AEZ.BlueW_L_AEZ_DeltaGB = squeeze(nansum(Wat.AEZ.BlueW_L_AEZ_DeltaCO,1));

Wat.AEZ.BlueW_Lkm_AEZ_AggGB = Wat.AEZ.BlueW_L_AEZ_AggGB ./Portf.AEZ.AreaH_AEZ_FAO_AggGB;
Wat.AEZ.BlueW_Lkm_AEZ_ExpGB = Wat.AEZ.BlueW_L_AEZ_ExpGB ./Portf.AEZ.harvst_aez_portgb;
Wat.AEZ.BlueW_Lkm_AEZ_DeltaGB = Wat.AEZ.BlueW_Lkm_AEZ_ExpGB - Wat.AEZ.BlueW_Lkm_AEZ_AggGB(:,yr_base);

