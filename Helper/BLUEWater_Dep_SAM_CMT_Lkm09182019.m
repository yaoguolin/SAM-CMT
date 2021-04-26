
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

BLUE.BlueW_Lkm = WF_Blue_m3ton_56 .* Product_FAO ./ AreaH_FAO;

%%% Blue water intensity by country and crop type
BLUE.BlueW_Agg = Var_Agg_WGT(BLUE.BlueW_Lkm,AreaH_FAO,MAPPING);
%BlueW_Agg(BlueW_Agg==0) = nan;
BLUE.BlueW_Agg = BLUE.BlueW_Agg(:,cr_ind,:);

BLUE.BlueW_L_Agg = BLUE.BlueW_Agg.*Area.AreaH_FAO_Agg;
BLUE.BlueW_L_AggCO =squeeze(nansum(BLUE.BlueW_L_Agg,2));

%%% Blue water intensity by country
BLUE.BlueW_AggCO = BLUE.BlueW_L_AggCO ./ Area.AreaH_FAO_AggCO;

%%%% Global
BLUE.BlueW_L_AggGB = nansum(BLUE.BlueW_L_AggCO,1);

%%% Blue water intensity globally before shocks
%BlueW_AggGB = BlueW_L_AggGB ./ Product_FAO_AggGB;
BLUE.BlueW_AggGB = BLUE.BlueW_L_AggGB ./ Area.AreaH_FAO_AggGB;

% New
BLUE.BlueW_L_Exp = BLUE.BlueW_Agg(:,:,yr_base).*harvst_port;
BLUE.BlueW_L_ExpCO = squeeze(nansum(BLUE.BlueW_L_Exp,2));

%%%% Global
BLUE.BlueW_L_ExpGB =nansum(BLUE.BlueW_L_ExpCO,1);

%%% Blue water intensity by country after shocks
BLUE.BlueW_ExpCO = BLUE.BlueW_L_ExpCO ./ Area.harvst_portco;

%%% Blue water intensity globally after shocks
BLUE.BlueW_ExpGB = BLUE.BlueW_L_ExpGB ./ Area.harvst_portgb;

% Changes
BLUE.BlueW_L_Delta = BLUE.BlueW_Agg(:,:,yr_base).* Area.harvst_delta;
BLUE.BlueW_L_DeltaCO = squeeze(nansum(BLUE.BlueW_L_Delta,2));
BLUE.BlueW_L_DeltaGB = squeeze(nansum(BLUE.BlueW_L_DeltaCO));

BLUE.BlueW_DeltaCO = BLUE.BlueW_ExpCO - BLUE.BlueW_AggCO(:,yr_base);
BLUE.BlueW_DeltaGB = BLUE.BlueW_ExpGB - BLUE.BlueW_AggGB(yr_base);

%%%% Water Use Efficiency
% Original
BLUE.BWUE_Agg = Area.Product_FAO_Agg ./BLUE.BlueW_L_Agg;
BLUE.BWUE_N_Agg = Nitrog.Nyield_kg_Agg ./BLUE.BlueW_L_Agg;

BLUE.BWUE_AggCO = Area.Product_FAO_AggCO./ BLUE.BlueW_L_AggCO;
BLUE.BWUE_N_AggCO = Nitrog.Nyield_kg_AggCO./BLUE.BlueW_L_AggCO;

BLUE.BWUE_AggGB = nansum(Area.Product_FAO_AggCO,1)./ nansum(BLUE.BlueW_L_AggCO,1);
BLUE.BWUE_N_AggGB = nansum(Nitrog.Nyield_kg_AggCO,1)./nansum(BLUE.BlueW_L_AggCO,1);

% New
BLUE.BWUE_Exp = prod_port./ BLUE.BlueW_L_Exp;
BLUE.BWUE_N_Exp = Nitrog.Nyield_kg_Exp ./BLUE.BlueW_L_Exp;

BLUE.BWUE_ExpCO = Area.prod_portco./ BLUE.BlueW_L_ExpCO;
BLUE.BWUE_N_ExpCO = Nitrog.Nyield_kg_ExpCO ./BLUE.BlueW_L_ExpCO;

BLUE.BWUE_ExpGB = nansum(Area.prod_portco,1)./ nansum(BLUE.BlueW_L_ExpCO,1);
BLUE.BWUE_N_ExpGB = nansum(Nitrog.Nyield_kg_ExpCO,1) ./ nansum(BLUE.BlueW_L_ExpCO,1);

% Changes
BLUE.BWUE_Delta = BLUE.BWUE_Exp - BLUE.BWUE_Agg(:,:,yr_base);
BLUE.BWUE_N_Delta = BLUE.BWUE_N_Exp - BLUE.BWUE_N_Agg(:,:,yr_base);

BLUE.BWUE_DeltaCO = BLUE.BWUE_ExpCO - BLUE.BWUE_AggCO(:,yr_base);
BLUE.BWUE_N_DeltaCO = BLUE.BWUE_N_ExpCO - BLUE.BWUE_N_AggCO(:,yr_base);

BLUE.BWUE_DeltaGB = BLUE.BWUE_ExpGB - BLUE.BWUE_AggGB(yr_base);
BLUE.BWUE_N_DeltaGB = BLUE.BWUE_N_ExpGB - BLUE.BWUE_N_AggGB(yr_base);


