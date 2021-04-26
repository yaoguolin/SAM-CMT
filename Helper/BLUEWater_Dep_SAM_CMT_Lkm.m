
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
BlueW_Agg = Var_Agg_WGT(BlueW_Lm,AreaH_FAO,MAPPING);
%BlueW_Agg(BlueW_Agg==0) = nan;
BlueW_Agg = BlueW_Agg(:,cr_ind,:);

BlueW_L_Agg = BlueW_Agg.*AreaH_FAO_Agg;
BlueW_L_AggCO =squeeze(nansum(BlueW_L_Agg,2));

%%% Blue water intensity by country
BlueW_AggCO = BlueW_L_AggCO ./ AreaH_FAO_AggCO;

%%%% Global
BlueW_L_AggGB = nansum(BlueW_L_AggCO,1);

%%% Blue water intensity globally before shocks
%BlueW_AggGB = BlueW_L_AggGB ./ Product_FAO_AggGB;
BlueW_AggGB = BlueW_L_AggGB ./ AreaH_FAO_AggGB;

% New
BlueW_L_Exp = BlueW_Agg(:,:,yr_base).*harvst_port;
BlueW_L_ExpCO = reshape(nansum(BlueW_L_Exp,2),co_dim,length(yr_base));

%%%% Global
BlueW_L_ExpGB =nansum(BlueW_L_ExpCO,1);

%%% Blue water intensity by country after shocks
BlueW_ExpCO = BlueW_L_ExpCO ./ harvst_portco;

%%% Blue water intensity globally after shocks
BlueW_ExpGB = BlueW_L_ExpGB ./ harvst_portgb;

% Changes
BlueW_L_Delta = BlueW_Agg(:,:,yr_base).* harvst_delta;
BlueW_L_DeltaCO = squeeze(nansum(BlueW_L_Delta,2));
BlueW_L_DeltaGB = squeeze(nansum(BlueW_L_DeltaCO));

BlueW_DeltaCO = BlueW_ExpCO - BlueW_AggCO(:,yr_base);
BlueW_DeltaGB = BlueW_ExpGB - BlueW_AggGB(yr_base);

%%%% Water Use Efficiency
% Original
BWUE_Agg = Product_FAO_Agg ./BlueW_L_Agg;
BWUE_N_Agg = Nyield_kg_Agg ./BlueW_L_Agg;

BWUE_AggCO = Product_FAO_AggCO./ BlueW_L_AggCO;
BWUE_N_AggCO = Nyield_kg_AggCO./BlueW_L_AggCO;

BWUE_AggGB = nansum(Product_FAO_AggCO,1)./ nansum(BlueW_L_AggCO,1);
BWUE_N_AggGB = nansum(Nyield_kg_AggCO,1)./nansum(BlueW_L_AggCO,1);

% New
BWUE_Exp = prod_port./ BlueW_L_Exp;
BWUE_N_Exp = Nyield_kg_Exp ./BlueW_L_Exp;

BWUE_ExpCO = prod_portco./ BlueW_L_ExpCO;
BWUE_N_ExpCO = Nyield_kg_ExpCO ./BlueW_L_ExpCO;

BWUE_ExpGB = nansum(prod_portco,1)./ nansum(BlueW_L_ExpCO,1);
BWUE_N_ExpGB = nansum(Nyield_kg_ExpCO,1) ./ nansum(BlueW_L_ExpCO,1);

% Changes
BWUE_Delta = BWUE_Exp - BWUE_Agg(:,:,yr_base);
BWUE_N_Delta = BWUE_N_Exp - BWUE_N_Agg(:,:,yr_base);

BWUE_DeltaCO = BWUE_ExpCO - BWUE_AggCO(:,yr_base);
BWUE_N_DeltaCO = BWUE_N_ExpCO - BWUE_N_AggCO(:,yr_base);

BWUE_DeltaGB = BWUE_ExpGB - BWUE_AggGB(yr_base);
BWUE_N_DeltaGB = BWUE_N_ExpGB - BWUE_N_AggGB(yr_base);

%%% AEZ water
%       Groundwater AEZ changes

%%% Disaggregated
% Original
BlueW_L_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;
for az = 1:1:18
    BlueW_L_AEZ_Agg(:,az,:,:) = BlueW_Agg(:,:,:) .* squeeze(AreaH_AEZ_FAO_Agg(:,az,:,:));
end

BlueW_Lkm_AEZ_Agg = BlueW_L_AEZ_Agg ./ AreaH_AEZ_FAO_Agg;


% New
BlueW_L_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    BlueW_L_AEZ_Exp(:,az,:) = squeeze(BlueW_Agg(:,:,yr_base)) .* squeeze(harvst_aez_port(:,az,:));
end

BlueW_Lkm_AEZ_Exp = BlueW_L_AEZ_Exp ./harvst_aez_port;

% Changes
BlueW_L_AEZ_Delta = BlueW_L_AEZ_Exp - BlueW_L_AEZ_Agg(:,:,:,yr_base);

BlueW_Lkm_AEZ_Delta = BlueW_Lkm_AEZ_Exp - BlueW_Lkm_AEZ_Agg(:,:,:,yr_base);

%%% National Level
BlueW_L_AEZ_AggCO = squeeze(nansum(BlueW_L_AEZ_Agg,3));
BlueW_L_AEZ_ExpCO = squeeze(nansum(BlueW_L_AEZ_Exp,3));
BlueW_L_AEZ_DeltaCO = squeeze(nansum(BlueW_L_AEZ_Delta,3));

BlueW_Lkm_AEZ_AggCO = BlueW_L_AEZ_AggCO ./AreaH_AEZ_FAO_AggCO; 
BlueW_Lkm_AEZ_ExpCO = BlueW_L_AEZ_ExpCO ./harvst_aez_portco;
BlueW_Lkm_AEZ_DeltaCO = BlueW_Lkm_AEZ_ExpCO - BlueW_Lkm_AEZ_AggCO(:,:,yr_base);

%%% Global Level
BlueW_L_AEZ_AggGB = squeeze(nansum(BlueW_L_AEZ_AggCO,1));
BlueW_L_AEZ_ExpGB = squeeze(nansum(BlueW_L_AEZ_ExpCO,1));
BlueW_L_AEZ_DeltaGB = squeeze(nansum(BlueW_L_AEZ_DeltaCO,1));

BlueW_Lkm_AEZ_AggGB = BlueW_L_AEZ_AggGB ./AreaH_AEZ_FAO_AggGB;
BlueW_Lkm_AEZ_ExpGB = BlueW_L_AEZ_ExpGB ./harvst_aez_portgb;
BlueW_Lkm_AEZ_DeltaGB = BlueW_Lkm_AEZ_ExpGB - BlueW_Lkm_AEZ_AggGB(:,yr_base);

