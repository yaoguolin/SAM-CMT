function   [Area,Nitrog,Phosp,BLUE,Original,Trade]...
    = SAM_CMT_simplified09182019(harvst_port,prod_port,price_port, trade_port,harvst_aez_port,prod_aez_port,cr_map,co_map,cr_array,co_array,cr_ind,baseyr,dir,dir_s)
%%% harvst_port:Harvested area portfolio after shocks dimensions: country *
%%% crops*year
%%% crp_map: an ordered array with correct mapping of the new crop
%%% aggregation
%%% co_map: an ordered array with correct mapping of the new country
%%% aggregation
%%% crp_array: a set of crops with desired orders
%%% co_array: a set of countries 
%%% cr_dim: new crop dimension
%%% co_dim: new country dimension
%%% baseyr: based year that we need to compare the data with

% 1. Iniate original parameters
%      1.1 Original port
%      1.2 new port
%      1.3 MAPPING
%      1.4 year port

% 2. country and crop aggregation
%      2.1 nitrogen aggregation
%      2.2 phosphorous aggregation

% 3. Impact assessments
%      3.1 Nitrogen
%      3.2 Phosphrous
%      3.3 Land
%      3.4 Water
%      3.5 Other sustainable indicators


% 1. Iniate original parameters
FAO_FILE = 'basic_FAO_SAM.mat'; 
load([dir 'Inputs' dir_s FAO_FILE]);

Original.AreaH_FAO = Var_Generate_Data(AreaH_FAO);
Original.Product_FAO = Var_Generate_Data(Product_FAO);
Original.Price_FAO = Var_Generate_Data(Price_FAO);
Original.Yield_FAO = Var_Generate_Data(Yield_FAO);

%WATER_FILE = 'water_depletion_WUE_SAM_56yr.mat';
%load([dir 'Inputs' dir_s WATER_FILE]);

%NNTR_FILE = 'H_index_Calor_Prot_Fat.mat';
%load([dir 'Inputs' dir_s NNTR_FILE]);

%MINUTR_FILE = 'micronutrition.mat';
%load([dir 'Inputs' dir_s MINUTR_FILE]);

HARVST_AEZ_FILE = 'basic_aez2.mat';
load([dir 'Inputs' dir_s HARVST_AEZ_FILE]);

co_dim = length(co_array);
cr_dim = length(cr_array)-1;

uniYrs = 1961:2016;   
yr_dim = length(uniYrs);
yr_base = find(uniYrs == baseyr);                       
tradeyrs = 1986:1:2016;                                 
tyr_base = find(tradeyrs == baseyr);                     
yr_trd = find(uniYrs>1985 & uniYrs<2017);
yr_no = length(uniYrs);

MAPPING = {cr_map,co_map,cr_array,co_array};


% 2. country and crop aggregation

Area.AreaH_FAO_Agg = Var_Agg_SIMPLE(AreaH_FAO,MAPPING);
Area.Product_FAO_Agg = Var_Agg_SIMPLE(Product_FAO,MAPPING);
Area.Price_FAO_Agg = Var_Agg_WGT(Price_FAO,Product_FAO,MAPPING);
Area.Yield_FAO_Agg = Var_Agg_WGT(Yield_FAO,AreaH_FAO,MAPPING);

Area.harvst_delta = harvst_port - Area.AreaH_FAO_Agg(:,:,yr_base);
Area.harvst_deltaco = nansum(Area.harvst_delta,2);
Area.harvst_deltagb = nansum(Area.harvst_deltaco,1);

Area.prod_delta = prod_port - Area.Product_FAO_Agg(:,:,yr_base);
Area.prod_deltaco = nansum(Area.prod_delta,2);
Area.prod_deltagb = nansum(Area.prod_deltaco,1);

Area.AreaH_FAO_Agg = Area.AreaH_FAO_Agg(:,cr_ind,:);
Area.Product_FAO_Agg = Area.Product_FAO_Agg(:,cr_ind,:);
Area.Price_FAO_Agg = Area.Price_FAO_Agg(:,cr_ind,:);
Area.Yield_FAO_Agg = Area.Yield_FAO_Agg(:,cr_ind,:);

Original.HARVST_AEZ_PRC = HARVST_AEZ_PRC(:,:,cr_ind);

Area.AEZ.AreaH_AEZ_FAO_Agg = AreaH_AEZ_FAO_Agg(:,:,cr_ind,:);
Area.AEZ.Prod_AEZ_FAO_Agg = Prod_AEZ_FAO_Agg(:,:,cr_ind,:);


prod_port = prod_port(:,cr_ind);
harvst_port = harvst_port(:,cr_ind);
price_port = price_port(:,cr_ind);
trade_port = trade_port(cr_ind,:,:,:);

harvst_aez_port = harvst_aez_port(:,:,cr_ind); % 6*18*10
prod_aez_port = prod_aez_port(:,:,cr_ind); % 6*18*10

%%% new harvested area percentage: HARVST_AEZ_PRC_NEW
for az = 1:1:18
    Area.AEZ.HARVST_AEZ_PRC_NEW(:,az,:) = squeeze(harvst_aez_port(:,az,:))./squeeze(nansum(harvst_aez_port,2));
end

Area.AreaH_FAO_AggCO = reshape(nansum(Area.AreaH_FAO_Agg,2),co_dim,length(uniYrs));
Area.Product_FAO_AggCO = reshape(nansum(Area.Product_FAO_Agg,2),co_dim,length(uniYrs));

Area.AEZ.AreaH_AEZ_FAO_AggCO = squeeze(nansum(Area.AEZ.AreaH_AEZ_FAO_Agg,3)); % 6*18*56

Area.AreaH_FAO_AggGB = squeeze(nansum(Area.AreaH_FAO_AggCO,1));
Area.Product_FAO_AggGB = squeeze(nansum(Area.Product_FAO_AggCO,1));

Area.AEZ.AreaH_AEZ_FAO_AggGB = squeeze(nansum(Area.AEZ.AreaH_AEZ_FAO_AggCO,1)); % 18*56

Area.prod_port = prod_port;
Area.harvst_port = harvst_port;

Area.prod_portco = reshape(nansum(prod_port,2),co_dim,length(yr_base));
Area.harvst_portco = reshape(nansum(harvst_port,2),co_dim,length(yr_base));

Area.AEZ.prod_aez_port = prod_aez_port;
Area.AEZ.harvst_aez_port = harvst_aez_port;
Area.AEZ.prod_aez_portco = squeeze(nansum(prod_aez_port,3));
Area.AEZ.harvst_aez_portco = squeeze(nansum(harvst_aez_port,3));

Area.prod_portgb = squeeze(nansum(Area.prod_portco,1));
Area.harvst_portgb = squeeze(nansum(Area.harvst_portco,1));

Area.AEZ.prod_aez_portgb = squeeze(nansum(Area.AEZ.prod_aez_portco,1));
Area.AEZ.harvst_aez_portgb = squeeze(nansum(Area.AEZ.harvst_aez_portco,1));

Area.yield_port = prod_port ./harvst_port;
Area.yield_port(isinf(Area.yield_port))=nan;

Area.harvst_delta = harvst_port - Area.AreaH_FAO_Agg(:,:,yr_base);
Area.harvst_deltaco = nansum(Area.harvst_delta,2);
Area.harvst_deltagb = nansum(Area.harvst_deltaco,1);

Area.prod_delta = prod_port - Area.Product_FAO_Agg(:,:,yr_base);
Area.prod_deltaco = nansum(Area.prod_delta,2);
Area.prod_deltagb = nansum(Area.prod_deltaco,1);

%%% Trade aggregation
Trade.ImTrdQnt_Agg(1:(cr_dim+1),1:56,1:co_dim,1:co_dim) = nan;
%ImTrdVal_Agg(1:cr_dim,1:56,1:co_dim,1:co_dim) = nan;

Trade.ImTrdQnt_Agg(:,yr_trd,:,:) = Var_Agg_TRD(ImTrdQnt,MAPPING);
%ImTrdVal_Agg(:,yr_trd,:,:) = Var_Agg_TRD(ImTrdVal,MAPPING);
Trade.ImTrdQnt_Agg = Trade.ImTrdQnt_Agg(cr_ind,:,:,:);

%      3.1 Nitrogen
N_Impacts_SAM_CMT_Simple_09182019


%      3.2 Phosphrous
P_Impacts_SAM_CMT_Simple_09182019

%      3.3 Land

%      3.4 Water
%%%% Water Depletion

%GroudWater_Dep_SAM_CMT_Lkm
BLUEWater_Dep_SAM_CMT_Lkm09182019


%      3.5 Economic Indicators
% Crop revenue
% Original revenue
%{
Ag_Rev_Agg = Product_FAO_Agg .* Price_FAO_Agg;
Ag_Rev_AggCO = reshape(nansum(Ag_Rev_Agg,2),co_dim,length(uniYrs));

% New
Ag_Rev_Exp = prod_port .* price_port;
Ag_Rev_ExpCO = nansum(Ag_Rev_Exp,2);

% Changes
Ag_Rev_Delta = Ag_Rev_Exp - Ag_Rev_Agg(:,:,yr_base);
Ag_Rev_DeltaCO = Ag_Rev_ExpCO - Ag_Rev_AggCO(:,yr_base);
%      3.6 Social Indicators


% Calculate self-sufficiency ratio
% Original
[SSR_AggCO,SSR_AggCO_max,SSR_AggCO_min] = SSR_cal(ImTrdQnt_Agg,Product_FAO_Agg);

% New
[SSR_ExpCO,SSR_ExpCO_max,SSR_ExpCO_min] = SSR_cal(trade_port,prod_port);

% Changes
SSR_Delta = SSR_ExpCO - SSR_AggCO(:,yr_base);

% Calculate nitrogen based self-sufficiency ratio
% Original
Product_N_Agg = Product_FAO_Agg .* contentN_Agg;
[SSR_N_AggCO,SSR_N_AggCO_max,SSR_N_AggCO_min] = SSR_cal(contentNTrd_Agg,Product_N_Agg);

% New
Product_N_Exp = prod_port .* contentN_Agg(:,:,yr_base);
[SSR_N_ExpCO,SSR_N_ExpCO_max,SSR_N_ExpCO_min] = SSR_cal(contentNTrd_Exp,Product_N_Exp);

SSR_N_Delta = SSR_N_ExpCO - SSR_N_AggCO(:,yr_base);

%%%%%%%%%%%%% Top three harvested area shares

% old
%%%%% Excluding other agricultural sectors
AreaH_FAO_Rank = AreaH_FAO_Agg(:,1:cr_dim-1,:);

%%% Ranking Nutr supply per capita for each country
[Area_Rank,Ind_area] = sort(AreaH_FAO_Rank,2,'descend');

%%% Top 2 area
Area_Top2 = squeeze(nansum(Area_Rank(:,1:2,:),2));
Area_Top3 = squeeze(nansum(Area_Rank(:,1:3,:),2));

Ind_crop = cr_array(Ind_area);
Ind_crop2 = Ind_crop(:,1:2,:);
Ind_crop3 = Ind_crop(:,1:3,:);

% new
harvst_port_rank = harvst_port(:,1:cr_dim-1);
[Area_Rank_Exp,Ind_area_Exp] = sort(harvst_port_rank,2,'descend');

Area_Top2_Exp = squeeze(nansum(Area_Rank_Exp(:,1:2),2));
Area_Top3_Exp = squeeze(nansum(Area_Rank_Exp(:,1:3),2));

Ind_crop_Exp = cr_array(Ind_area_Exp);
Ind_crop2_Exp = Ind_crop_Exp(:,1:2);
Ind_crop3_Exp = Ind_crop_Exp(:,1:3);

Area_Top2_DeltaCO = Area_Top2_Exp - Area_Top2(:,yr_base);
Area_Top3_DeltaCO = Area_Top3_Exp - Area_Top3(:,yr_base);


% Calculate the Nutrition production (Calorie, Protein, Fat)
%Nutrition_Supply_H_Index
MacroMicroNutritrion

%}
end

