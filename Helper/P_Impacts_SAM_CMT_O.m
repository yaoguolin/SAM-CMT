
P_FILE = 'basic_P_SAM.mat'; 
load([dir 'Inputs' dir_s P_FILE]); 

Pfer_kgkm = Var_Generate_Data(Pfer_kgkm);
Pman_kgkm = Var_Generate_Data(Pman_kgkm);
Pyield_kgkm = Var_Generate_Data(Pyield_kgkm);
Peros_kgkm = Var_Generate_Data(Peros_kgkm);

Pfer_kgkm_Agg = Var_Agg_WGT(Pfer_kgkm,AreaH_FAO,MAPPING);
Pman_kgkm_Agg = Var_Agg_WGT(Pman_kgkm,AreaH_FAO,MAPPING);
Pyield_kgkm_Agg = Var_Agg_WGT(Pyield_kgkm,AreaH_FAO,MAPPING);
Peros_kgkm_Agg = Var_Agg_WGT(Peros_kgkm,AreaH_FAO,MAPPING);

%%% Nitrogen/Phosphorous content aggregation
contentP_Agg = Var_Agg_WGT(contentP,Product_FAO,MAPPING);

% 3. Impact assessments
%      3.1 Nitrogen/Phosphorous
Pinput_kgkm_Agg =  Pfer_kgkm_Agg + Pman_kgkm_Agg;
Psur_kgkm_Agg = Pinput_kgkm_Agg - Pyield_kgkm_Agg;
Pres_kgkm_Agg = Psur_kgkm_Agg - Peros_kgkm_Agg;

%%% Nutrients usages
Pfer_kg_Agg= Pfer_kgkm_Agg.*AreaH_FAO_Agg;
Pman_kg_Agg = Pman_kgkm_Agg.*AreaH_FAO_Agg;
Pyield_kg_Agg = Pyield_kgkm_Agg.*AreaH_FAO_Agg;
Peros_kg_Agg = Peros_kgkm_Agg .*AreaH_FAO_Agg;

Pinput_kg_Agg =  Pfer_kg_Agg + Pman_kg_Agg;
Psur_kg_Agg = Pinput_kg_Agg - Pyield_kg_Agg;
Pres_kg_Agg = Psur_kg_Agg - Peros_kg_Agg;

Pfer_kg_Exp = Pfer_kgkm_Agg(:,:,yr_base).*harvst_port;
Pman_kg_Exp = Pman_kgkm_Agg(:,:,yr_base).*harvst_port;
Pyield_kg_Exp = Pyield_kgkm_Agg(:,:,yr_base).*harvst_port;
Peros_kg_Exp = Peros_kgkm_Agg(:,:,yr_base).*harvst_port;

Pinput_kg_Exp =  Pfer_kg_Exp + Pman_kg_Exp;
Psur_kg_Exp = Pinput_kg_Exp - Pyield_kg_Exp;
Pres_kg_Exp = Psur_kg_Exp - Peros_kg_Exp;

Pinput_kg_Delta = Pinput_kg_Exp - Pinput_kg_Agg(:,:,yr_base);
Pyield_kg_Delta = Pyield_kg_Exp - Pyield_kg_Agg(:,:,yr_base);
Psur_kg_Delta = Psur_kg_Exp - Psur_kg_Agg(:,:,yr_base);
Pres_kg_Delta = Pres_kg_Exp - Pres_kg_Agg(:,:,yr_base);

%%% Nitrogen/Phosphorous Use Efficiency
% Original
%%%%% Regional
Pinput_kg_AggCO = nansum(Pinput_kg_Agg,2);
Pyield_kg_AggCO = nansum(Pyield_kg_Agg,2);
Peros_kg_AggCO = nansum(Peros_kg_Agg,2);
Psur_kg_AggCO = Pinput_kg_AggCO - Pyield_kg_AggCO;
Pres_kg_AggCO = Psur_kg_AggCO - Peros_kg_AggCO;

%%%%% Global
Pinput_kg_AggGB = nansum(Pinput_kg_AggCO,1);
Pyield_kg_AggGB = nansum(Pyield_kg_AggCO,1);
Peros_kg_AggGB = nansum(Peros_kg_AggCO,1);
Psur_kg_AggGB = Pinput_kg_AggGB - Pyield_kg_AggGB;
Pres_kg_AggGB = Psur_kg_AggGB - Peros_kg_AggGB;

%%%%% Regional
Pinput_kgkm_AggCO = Pinput_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Pyield_kgkm_AggCO = Pyield_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Peros_kgkm_AggCO = Peros_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Psur_kgkm_AggCO = Pinput_kgkm_AggCO - Pyield_kgkm_AggCO;
Pres_kgkm_AggCO = Psur_kgkm_AggCO - Peros_kgkm_AggCO;
PUE_AggCO = Pyield_kgkm_AggCO ./Pinput_kgkm_AggCO;

%%%%% Global
Pinput_kgkm_AggGB = Pinput_kg_AggGB./nansum(nansum(AreaH_FAO_Agg,2),1);
Pyield_kgkm_AggGB = Pyield_kg_AggGB./nansum(nansum(AreaH_FAO_Agg,2),1);
Peros_kgkm_AggGB = Peros_kg_AggGB./nansum(nansum(AreaH_FAO_Agg,2),1);
Psur_kgkm_AggGB = Pinput_kgkm_AggGB - Pyield_kgkm_AggGB;
Pres_kgkm_AggGB = Psur_kgkm_AggGB - Peros_kgkm_AggGB;
PUE_AggGB = Pyield_kgkm_AggGB ./Pinput_kgkm_AggGB;

% New
%%%%% Regional
Pinput_kg_ExpCO = nansum(Pinput_kg_Exp,2);
Pyield_kg_ExpCO = nansum(Pyield_kg_Exp,2);
Peros_kg_ExpCO = nansum(Peros_kg_Exp,2);
Psur_kg_ExpCO = Pinput_kg_ExpCO - Pyield_kg_ExpCO;
Pres_kg_ExpCO = Psur_kg_ExpCO - Peros_kg_ExpCO;

%%%%% Global
Pinput_kg_ExpGB = nansum(Pinput_kg_ExpCO,1);
Pyield_kg_ExpGB = nansum(Pyield_kg_ExpCO,1);
Peros_kg_ExpGB = nansum(Peros_kg_ExpCO,1);
Psur_kg_ExpGB = Pinput_kg_ExpGB - Pyield_kg_ExpGB;
Pres_kg_ExpGB = Psur_kg_ExpGB - Peros_kg_ExpGB;

%%%%% Regional
Pinput_kgkm_ExpCO = nansum(Pinput_kg_Exp,2)./nansum(harvst_port,2);
Pyield_kgkm_ExpCO = nansum(Pyield_kg_Exp,2)./nansum(harvst_port,2);
Peros_kgkm_ExpCO = nansum(Peros_kg_Exp,2)./nansum(harvst_port,2);
Psur_kgkm_ExpCO = Pinput_kgkm_ExpCO - Pyield_kgkm_ExpCO;
Pres_kgkm_ExpCO = Psur_kgkm_ExpCO - Peros_kgkm_ExpCO;
PUE_ExpCO = Pyield_kgkm_ExpCO ./Pinput_kgkm_ExpCO;

%%%%% Global
Pinput_kgkm_ExpGB = Pinput_kg_ExpGB./nansum(nansum(harvst_port,2),1);
Pyield_kgkm_ExpGB = Pyield_kg_ExpGB./nansum(nansum(harvst_port,2),1);
Peros_kgkm_ExpGB = Peros_kg_ExpGB./nansum(nansum(harvst_port,2),1);
Psur_kgkm_ExpGB = Pinput_kgkm_ExpGB-Pyield_kgkm_ExpGB;
Pres_kgkm_ExpGB = Psur_kgkm_ExpGB - Peros_kgkm_ExpGB;
PUE_ExpGB = Pyield_kgkm_ExpGB ./Pinput_kgkm_ExpGB;

% Changes
%%%%% Regional
Pinput_kg_DeltaCO = Pinput_kg_ExpCO - Pinput_kg_AggCO(:,:,yr_base);
Pyield_kg_DeltaCO = Pyield_kg_ExpCO - Pyield_kg_AggCO(:,:,yr_base);
Psur_kg_DeltaCO = Psur_kg_ExpCO - Psur_kg_AggCO(:,:,yr_base);
Pres_kg_DeltaCO = Pres_kg_ExpCO - Pres_kg_AggCO(:,:,yr_base);

Pinput_kgkm_DeltaCO = Pinput_kgkm_ExpCO - Pinput_kgkm_AggCO(:,:,yr_base);
Pyield_kgkm_DeltaCO = Pyield_kgkm_ExpCO - Pyield_kgkm_AggCO(:,:,yr_base);
Psur_kgkm_DeltaCO = Psur_kgkm_ExpCO - Psur_kgkm_AggCO(:,:,yr_base);
Pres_kgkm_DeltaCO = Pres_kgkm_ExpCO - Pres_kgkm_AggCO(:,:,yr_base);

PUE_Delta = PUE_ExpCO - PUE_AggCO(:,:,yr_base);

%%%%% Global
Pinput_kg_DeltaGB = Pinput_kg_ExpGB - Pinput_kg_AggGB(yr_base);
Pyield_kg_DeltaGB = Pyield_kg_ExpGB - Pyield_kg_AggGB(yr_base);
Psur_kg_DeltaGB = Psur_kg_ExpGB - Psur_kg_AggGB(yr_base);
Pres_kg_DeltaGB = Pres_kg_ExpGB - Pres_kg_AggGB(yr_base);

Pinput_kgkm_DeltaGB = Pinput_kgkm_ExpGB - Pinput_kgkm_AggGB(yr_base);
Pyield_kgkm_DeltaGB = Pyield_kgkm_ExpGB - Pyield_kgkm_AggGB(yr_base);
Psur_kgkm_DeltaGB = Psur_kgkm_ExpGB - Psur_kgkm_AggGB(yr_base);
Pres_kgkm_DeltaGB = Pres_kgkm_ExpGB - Pres_kgkm_AggGB(yr_base);

PUE_DeltaGB = PUE_ExpGB - PUE_AggGB(yr_base);

%%% Virtual and alternative N/P
% Original
[Parea_Vir,Psur_Vir,Pinput_Vir,Parea_Alt,Psur_Alt,Pinput_Alt,contentPTrd_Agg,...
 BiParea_Vir,BiPsur_Vir,BiPinput_Vir,...
 BiParea_Alt,BiPsur_Alt,BiPinput_Alt,...
 Parea_Vir_CO,Psur_Vir_CO,Pinput_Vir_CO, Parea_Alt_CO, Psur_Alt_CO, Pinput_Alt_CO,...
 Parea_Vir_GB,Psur_Vir_GB,Pinput_Vir_GB, Parea_Alt_GB, Psur_Alt_GB, Pinput_Alt_GB] ...
    = Nutr_VirtAlt(contentP_Agg,ImTrdQnt_Agg,Yield_FAO_Agg,Pyield_kgkm_Agg, ...
    Psur_kgkm_Agg, Pinput_kgkm_Agg, 1961:2016);

% New
[Parea_Vir_Exp,Psur_Vir_Exp,Pinput_Vir_Exp,Parea_Alt_Exp,Psur_Alt_Exp,...
 Pinput_Alt_Exp,contentPTrd_Exp,...
 BiParea_Vir_Exp,BiPsur_Vir_Exp,BiPinput_Vir_Exp,...
 BiParea_Alt_Exp,BiPsur_Alt_Exp,BiPinput_Alt_Exp,...
 Parea_Vir_ExpCO,Psur_Vir_ExpCO,Pinput_Vir_ExpCO, Parea_Alt_ExpCO, Psur_Alt_ExpCO, Pinput_Alt_ExpCO,...
 Parea_Vir_ExpGB,Psur_Vir_ExpGB,Pinput_Vir_ExpGB, Parea_Alt_ExpGB, Psur_Alt_ExpGB, Pinput_Alt_ExpGB] ...
    = Nutr_VirtAlt(contentP_Agg,trade_port,yield_port,Pyield_kgkm_Agg, ...
    Psur_kgkm_Agg, Pinput_kgkm_Agg,2011);

% Changes

Parea_Vir_Delta = Parea_Vir_Exp - Parea_Vir(:,:,yr_base);
Psur_Vir_Delta = Psur_Vir_Exp - Psur_Vir(:,:,yr_base);
Pinput_Vir_Delta = Pinput_Vir_Exp - Pinput_Vir(:,:,yr_base);

Parea_Alt_Delta = Parea_Alt_Exp - Parea_Alt(:,:,yr_base);
Psur_Alt_Delta = Psur_Alt_Exp - Psur_Alt(:,:,yr_base);
Pinput_Alt_Delta = Pinput_Alt_Exp - Pinput_Alt(:,:,yr_base);

%%%%% Regional
Parea_Vir_DeltaCO = Parea_Vir_ExpCO - Parea_Vir_CO(:,yr_base);
Psur_Vir_DeltaCO = Psur_Vir_ExpCO - Psur_Vir_CO(:,yr_base);
Pinput_Vir_DeltaCO = Pinput_Vir_ExpCO - Pinput_Vir_CO(:,yr_base);


Parea_Alt_DeltaCO = Parea_Alt_ExpCO - Parea_Alt_CO(:,yr_base);
Psur_Alt_DeltaCO = Psur_Alt_ExpCO - Psur_Alt_CO(:,yr_base);
Pinput_Alt_DeltaCO = Pinput_Alt_ExpCO - Pinput_Alt_CO(:,yr_base);

%%%%% Global
Parea_Vir_DeltaGB = Parea_Vir_ExpGB - Parea_Vir_GB(yr_base);
Psur_Vir_DeltaGB = Psur_Vir_ExpGB - Psur_Vir_GB(yr_base);
Pinput_Vir_DeltaGB = Pinput_Vir_ExpGB - Pinput_Vir_GB(yr_base);


Parea_Alt_DeltaGB = Parea_Alt_ExpGB - Parea_Alt_GB(yr_base);
Psur_Alt_DeltaGB = Psur_Alt_ExpGB - Psur_Alt_GB(yr_base);
Pinput_Alt_DeltaGB = Pinput_Alt_ExpGB - Pinput_Alt_GB(yr_base);

%%%% Changes based on importing and exporting partners
BiParea_Vir_CR = reshape(nansum(BiParea_Vir,1),length(uniYrs),co_dim,co_dim);
BiPsur_Vir_CR = reshape(nansum(BiPsur_Vir,1),length(uniYrs),co_dim,co_dim);
BiPinput_Vir_CR = reshape(nansum(BiPsur_Vir,1),length(uniYrs),co_dim,co_dim);

BiParea_Alt_CR = reshape(nansum(BiParea_Alt,1),length(uniYrs),co_dim,co_dim);
BiPsur_Alt_CR = reshape(nansum(BiPsur_Alt,1),length(uniYrs),co_dim,co_dim);
BiPinput_Alt_CR = reshape(nansum(BiPsur_Alt,1),length(uniYrs),co_dim,co_dim);

BiParea_Vir_CR = permute(BiParea_Vir_CR,[2,3,1]);
BiPsur_Vir_CR = permute(BiPsur_Vir_CR,[2,3,1]);
BiPinput_Vir_CR = permute(BiPinput_Vir_CR,[2,3,1]);

BiParea_Alt_CR = permute(BiParea_Alt_CR,[2,3,1]);
BiPsur_Alt_CR = permute(BiPsur_Alt_CR,[2,3,1]);
BiPinput_Alt_CR = permute(BiPinput_Alt_CR,[2,3,1]);

%New
BiParea_Vir_ExpCR = reshape(nansum(BiParea_Vir_Exp,1),length(yr_base),co_dim,co_dim);
BiPsur_Vir_ExpCR = reshape(nansum(BiPsur_Vir_Exp,1),length(yr_base),co_dim,co_dim);
BiPinput_Vir_ExpCR = reshape(nansum(BiPsur_Vir_Exp,1),length(yr_base),co_dim,co_dim);

BiParea_Alt_ExpCR = reshape(nansum(BiParea_Alt_Exp,1),length(yr_base),co_dim,co_dim);
BiPsur_Alt_ExpCR = reshape(nansum(BiPsur_Alt_Exp,1),length(yr_base),co_dim,co_dim);
BiPinput_Alt_ExpCR = reshape(nansum(BiPsur_Alt_Exp,1),length(yr_base),co_dim,co_dim);

BiParea_Vir_ExpCR = permute(BiParea_Vir_ExpCR,[2,3,1]);
BiPsur_Vir_ExpCR = permute(BiPsur_Vir_ExpCR,[2,3,1]);
BiPinput_Vir_ExpCR = permute(BiPinput_Vir_ExpCR,[2,3,1]);

BiParea_Alt_ExpCR = permute(BiParea_Alt_ExpCR,[2,3,1]);
BiPsur_Alt_ExpCR = permute(BiPsur_Alt_ExpCR,[2,3,1]);
BiPinput_Alt_ExpCR = permute(BiPinput_Alt_ExpCR,[2,3,1]);

%%% Changes

BiParea_Vir_DeltaCR = BiParea_Vir_ExpCR - BiParea_Vir_CR(:,:,yr_base);
BiPsur_Vir_DeltaCR = BiPsur_Vir_ExpCR - BiPsur_Vir_CR(:,:,yr_base);
BiPinput_Vir_DeltaCR = BiPinput_Vir_ExpCR - BiPinput_Vir_CR(:,:,yr_base);

BiParea_Alt_DeltaCR = BiParea_Alt_ExpCR - BiParea_Alt_CR(:,:,yr_base);
BiPsur_Alt_DeltaCR = BiPsur_Alt_ExpCR - BiPsur_Alt_CR(:,:,yr_base);
BiPinput_Alt_DeltaCR = BiPinput_Alt_ExpCR - BiPinput_Alt_CR(:,:,yr_base);
