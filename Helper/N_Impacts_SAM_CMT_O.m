
N_FILE = 'basic_N_SAM.mat'; 
load([dir 'Inputs' dir_s N_FILE]); 

Nfer_kgkm = Var_Generate_Data(Nfer_kgkm);
Nman_kgkm = Var_Generate_Data(Nman_kgkm);
Nyield_kgkm = Var_Generate_Data(Nyield_kgkm);
Ndep_kgkm = Var_Generate_Data(Ndep_kgkm);

%       2.1 Nitrogen aggregation
Nfer_kgkm_Agg = Var_Agg_WGT(Nfer_kgkm,AreaH_FAO,MAPPING);
Nman_kgkm_Agg = Var_Agg_WGT(Nman_kgkm,AreaH_FAO,MAPPING);
Nfix_kgkm_Agg = Var_Agg_WGT(Nfix_kgkm,AreaH_FAO,MAPPING);
Ndep_kgkm_Agg = Var_Agg_WGT(Ndep_kgkm,AreaH_FAO,MAPPING);
Nyield_kgkm_Agg = Var_Agg_WGT(Nyield_kgkm,AreaH_FAO,MAPPING);


%%% Nitrogen content aggregation
contentN_Agg = Var_Agg_WGT(contentN,Product_FAO,MAPPING);

% 3. Impact assessments
%      3.1 Nitrogen
Ninput_kgkm_Agg =  Nfer_kgkm_Agg + Nman_kgkm_Agg + Nfix_kgkm_Agg + Ndep_kgkm_Agg;
Nsur_kgkm_Agg = Ninput_kgkm_Agg - Nyield_kgkm_Agg;

%%% Nutrients usages
Nfer_kg_Agg= Nfer_kgkm_Agg.*AreaH_FAO_Agg;
Nman_kg_Agg = Nman_kgkm_Agg.*AreaH_FAO_Agg;
Nfix_kg_Agg = Nfix_kgkm_Agg.*AreaH_FAO_Agg;
Ndep_kg_Agg = Ndep_kgkm_Agg.*AreaH_FAO_Agg;
Nyield_kg_Agg = Nyield_kgkm_Agg.*AreaH_FAO_Agg;

Ninput_kg_Agg =  Nfer_kg_Agg + Nman_kg_Agg + Nfix_kg_Agg + Ndep_kg_Agg;
Nsur_kg_Agg = Ninput_kg_Agg - Nyield_kg_Agg;


Nfer_kg_Exp = Nfer_kgkm_Agg(:,:,yr_base).*harvst_port;
Nman_kg_Exp = Nman_kgkm_Agg(:,:,yr_base).*harvst_port;
Nfix_kg_Exp = Nfix_kgkm_Agg(:,:,yr_base).*harvst_port;
Ndep_kg_Exp = Ndep_kgkm_Agg(:,:,yr_base).*harvst_port;
Nyield_kg_Exp = Nyield_kgkm_Agg(:,:,yr_base).*harvst_port;

Ninput_kg_Exp =  Nfer_kg_Exp + Nman_kg_Exp + Nfix_kg_Exp + Ndep_kg_Exp;
Nsur_kg_Exp = Ninput_kg_Exp - Nyield_kg_Exp;

Ninput_kg_Delta = Ninput_kg_Exp - Ninput_kg_Agg(:,:,yr_base);
Nyield_kg_Delta = Nyield_kg_Exp - Nyield_kg_Agg(:,:,yr_base);
Nsur_kg_Delta = Nsur_kg_Exp - Nsur_kg_Agg(:,:,yr_base);

%%% Nitrogen Use Efficiency
% Original
%%%%% Regional
Ninput_kg_AggCO = nansum(Ninput_kg_Agg,2);
Nyield_kg_AggCO = nansum(Nyield_kg_Agg,2);
Nsur_kg_AggCO = Ninput_kg_AggCO - Nyield_kg_AggCO;

%%%%% Global
Ninput_kg_AggGB = nansum(Ninput_kg_AggCO,1);
Nyield_kg_AggGB = nansum(Nyield_kg_AggCO,1);
Nsur_kg_AggGB = Ninput_kg_AggGB - Nyield_kg_AggGB;

%%%%% Regional
Ninput_kgkm_AggCO = Ninput_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Nyield_kgkm_AggCO = Nyield_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Nsur_kgkm_AggCO = Ninput_kgkm_AggCO - Nyield_kgkm_AggCO;
NUE_AggCO = Nyield_kgkm_AggCO ./Ninput_kgkm_AggCO;

%%%%% Global
Ninput_kgkm_AggGB = Ninput_kg_AggGB./nansum(nansum(AreaH_FAO_Agg,2),1);
Nyield_kgkm_AggGB = Nyield_kg_AggGB./nansum(nansum(AreaH_FAO_Agg,2),1);
Nsur_kgkm_AggGB = Ninput_kgkm_AggGB - Nyield_kgkm_AggGB;
NUE_AggGB = Nyield_kgkm_AggGB ./Ninput_kgkm_AggGB;

% New
%%%%% Regional
Ninput_kg_ExpCO = nansum(Ninput_kg_Exp,2);
Nyield_kg_ExpCO = nansum(Nyield_kg_Exp,2);
Nsur_kg_ExpCO = Ninput_kg_ExpCO - Nyield_kg_ExpCO;

%%%%% Global
Ninput_kg_ExpGB = nansum(Ninput_kg_ExpCO,1);
Nyield_kg_ExpGB = nansum(Nyield_kg_ExpCO,1);
Nsur_kg_ExpGB = Ninput_kg_ExpGB - Nyield_kg_ExpGB;

%%%%% Regional
Ninput_kgkm_ExpCO = Ninput_kg_ExpCO./nansum(harvst_port,2);
Nyield_kgkm_ExpCO = Nyield_kg_ExpCO./nansum(harvst_port,2);
Nsur_kgkm_ExpCO = Ninput_kgkm_ExpCO - Nyield_kgkm_ExpCO;
NUE_ExpCO = Nyield_kgkm_ExpCO ./Ninput_kgkm_ExpCO;

%%%%% Global
Ninput_kgkm_ExpGB = Ninput_kg_ExpGB./nansum(nansum(harvst_port,2),1);
Nyield_kgkm_ExpGB = Nyield_kg_ExpGB./nansum(nansum(harvst_port,2),1);
Nsur_kgkm_ExpGB = Ninput_kgkm_ExpGB - Nyield_kgkm_ExpGB;
NUE_ExpGB = Nyield_kgkm_ExpGB ./Ninput_kgkm_ExpGB;

% Changes
%%%%% Regional
Ninput_kg_DeltaCO = Ninput_kg_ExpCO - Ninput_kg_AggCO(:,:,yr_base);
Nyield_kg_DeltaCO = Nyield_kg_ExpCO - Nyield_kg_AggCO(:,:,yr_base);
Nsur_kg_DeltaCO = Nsur_kg_ExpCO - Nsur_kg_AggCO(:,:,yr_base);

Ninput_kgkm_DeltaCO = Ninput_kgkm_ExpCO - Ninput_kgkm_AggCO(:,:,yr_base);
Nyield_kgkm_DeltaCO = Nyield_kgkm_ExpCO - Nyield_kgkm_AggCO(:,:,yr_base);
Nsur_kgkm_DeltaCO = Nsur_kgkm_ExpCO - Nsur_kgkm_AggCO(:,:,yr_base);

NUE_DeltaCO = NUE_ExpCO - NUE_AggCO(:,:,yr_base);

%%%%% Global
Ninput_kg_DeltaGB = Ninput_kg_ExpGB - Ninput_kg_AggGB(yr_base);
Nyield_kg_DeltaGB = Nyield_kg_ExpGB - Nyield_kg_AggGB(yr_base);
Nsur_kg_DeltaGB = Nsur_kg_ExpGB - Nsur_kg_AggGB(yr_base);

Ninput_kgkm_DeltaGB = Ninput_kgkm_ExpGB - Ninput_kgkm_AggGB(yr_base);
Nyield_kgkm_DeltaGB = Nyield_kgkm_ExpGB - Nyield_kgkm_AggGB(yr_base);
Nsur_kgkm_DeltaGB = Nsur_kgkm_ExpGB - Nsur_kgkm_AggGB(yr_base);

NUE_DeltaGB = NUE_ExpGB - NUE_AggGB(yr_base);

%%% Virtual and alternative nitrogen
% Original
[Narea_Vir,Nsur_Vir,Ninput_Vir,Narea_Alt,Nsur_Alt,Ninput_Alt,contentNTrd_Agg,...
 BiNarea_Vir,BiNsur_Vir,BiNinput_Vir,...
 BiNarea_Alt,BiNsur_Alt,BiNinput_Alt,...
 Narea_Vir_CO,Nsur_Vir_CO,Ninput_Vir_CO, Narea_Alt_CO, Nsur_Alt_CO, Ninput_Alt_CO,...
 Narea_Vir_GB,Nsur_Vir_GB,Ninput_Vir_GB, Narea_Alt_GB, Nsur_Alt_GB, Ninput_Alt_GB] ...
 = Nutr_VirtAlt(contentN_Agg,ImTrdQnt_Agg,Yield_FAO_Agg,Nyield_kgkm_Agg, ...
 Nsur_kgkm_Agg, Ninput_kgkm_Agg, uniYrs);

% New
[Narea_Vir_Exp,Nsur_Vir_Exp,Ninput_Vir_Exp,Narea_Alt_Exp,Nsur_Alt_Exp,Ninput_Alt_Exp,contentNTrd_Exp,...
 BiNarea_Vir_Exp,BiNsur_Vir_Exp,BiNinput_Vir_Exp,...
 BiNarea_Alt_Exp,BiNsur_Alt_Exp,BiNinput_Alt_Exp,...
 Narea_Vir_ExpCO,Nsur_Vir_ExpCO,Ninput_Vir_ExpCO, Narea_Alt_ExpCO, Nsur_Alt_ExpCO, Ninput_Alt_ExpCO,...
 Narea_Vir_ExpGB,Nsur_Vir_ExpGB,Ninput_Vir_ExpGB, Narea_Alt_ExpGB, Nsur_Alt_ExpGB, Ninput_Alt_ExpGB] ...
    = Nutr_VirtAlt(contentN_Agg,trade_port,yield_port,Nyield_kgkm_Agg, ...
    Nsur_kgkm_Agg, Ninput_kgkm_Agg,baseyr);
% Changes


Narea_Vir_Delta = Narea_Vir_Exp - Narea_Vir(:,:,yr_base);
Nsur_Vir_Delta = Nsur_Vir_Exp - Nsur_Vir(:,:,yr_base);
Ninput_Vir_Delta = Ninput_Vir_Exp - Ninput_Vir(:,:,yr_base);

Narea_Alt_Delta = Narea_Alt_Exp - Narea_Alt(:,:,yr_base);
Nsur_Alt_Delta = Nsur_Alt_Exp - Nsur_Alt(:,:,yr_base);
Ninput_Alt_Delta = Ninput_Alt_Exp - Ninput_Alt(:,:,yr_base);

%%%%% Regional
Narea_Vir_DeltaCO = Narea_Vir_ExpCO - Narea_Vir_CO(:,yr_base);
Nsur_Vir_DeltaCO = Nsur_Vir_ExpCO - Nsur_Vir_CO(:,yr_base);
Ninput_Vir_DeltaCO = Ninput_Vir_ExpCO - Ninput_Vir_CO(:,yr_base);


Narea_Alt_DeltaCO = Narea_Alt_ExpCO - Narea_Alt_CO(:,yr_base);
Nsur_Alt_DeltaCO = Nsur_Alt_ExpCO - Nsur_Alt_CO(:,yr_base);
Ninput_Alt_DeltaCO = Ninput_Alt_ExpCO - Ninput_Alt_CO(:,yr_base);

%%%%% Global
Narea_Vir_DeltaGB = Narea_Vir_ExpGB - Narea_Vir_GB(yr_base);
Nsur_Vir_DeltaGB = Nsur_Vir_ExpGB - Nsur_Vir_GB(yr_base);
Ninput_Vir_DeltaGB = Ninput_Vir_ExpGB - Ninput_Vir_GB(yr_base);


Narea_Alt_DeltaGB = Narea_Alt_ExpGB - Narea_Alt_GB(yr_base);
Nsur_Alt_DeltaGB = Nsur_Alt_ExpGB - Nsur_Alt_GB(yr_base);
Ninput_Alt_DeltaGB = Ninput_Alt_ExpGB - Ninput_Alt_GB(yr_base);


%%%% Changes based on importing and exporting partners
% Orginal
BiNarea_Vir_CR = reshape(nansum(BiNarea_Vir,1),length(uniYrs),co_dim,co_dim);
BiNsur_Vir_CR = reshape(nansum(BiNsur_Vir,1),length(uniYrs),co_dim,co_dim);
BiNinput_Vir_CR = reshape(nansum(BiNsur_Vir,1),length(uniYrs),co_dim,co_dim);

BiNarea_Alt_CR = reshape(nansum(BiNarea_Alt,1),length(uniYrs),co_dim,co_dim);
BiNsur_Alt_CR = reshape(nansum(BiNsur_Alt,1),length(uniYrs),co_dim,co_dim);
BiNinput_Alt_CR = reshape(nansum(BiNsur_Alt,1),length(uniYrs),co_dim,co_dim);

BiNarea_Vir_CR = permute(BiNarea_Vir_CR,[2,3,1]);
BiNsur_Vir_CR = permute(BiNsur_Vir_CR,[2,3,1]);
BiNinput_Vir_CR = permute(BiNinput_Vir_CR,[2,3,1]);

BiNarea_Alt_CR = permute(BiNarea_Alt_CR,[2,3,1]);
BiNsur_Alt_CR = permute(BiNsur_Alt_CR,[2,3,1]);
BiNinput_Alt_CR = permute(BiNinput_Alt_CR,[2,3,1]);

%New
BiNarea_Vir_ExpCR = reshape(nansum(BiNarea_Vir_Exp,1),length(yr_base),co_dim,co_dim);
BiNsur_Vir_ExpCR = reshape(nansum(BiNsur_Vir_Exp,1),length(yr_base),co_dim,co_dim);
BiNinput_Vir_ExpCR = reshape(nansum(BiNsur_Vir_Exp,1),length(yr_base),co_dim,co_dim);

BiNarea_Alt_ExpCR = reshape(nansum(BiNarea_Alt_Exp,1),length(yr_base),co_dim,co_dim);
BiNsur_Alt_ExpCR = reshape(nansum(BiNsur_Alt_Exp,1),length(yr_base),co_dim,co_dim);
BiNinput_Alt_ExpCR = reshape(nansum(BiNsur_Alt_Exp,1),length(yr_base),co_dim,co_dim);

BiNarea_Vir_ExpCR = permute(BiNarea_Vir_ExpCR,[2,3,1]);
BiNsur_Vir_ExpCR = permute(BiNsur_Vir_ExpCR,[2,3,1]);
BiNinput_Vir_ExpCR = permute(BiNinput_Vir_ExpCR,[2,3,1]);

BiNarea_Alt_ExpCR = permute(BiNarea_Alt_ExpCR,[2,3,1]);
BiNsur_Alt_ExpCR = permute(BiNsur_Alt_ExpCR,[2,3,1]);
BiNinput_Alt_ExpCR = permute(BiNinput_Alt_ExpCR,[2,3,1]);

%%% Changes

BiNarea_Vir_DeltaCR = BiNarea_Vir_ExpCR - BiNarea_Vir_CR(:,:,yr_base);
BiNsur_Vir_DeltaCR = BiNsur_Vir_ExpCR - BiNsur_Vir_CR(:,:,yr_base);
BiNinput_Vir_DeltaCR = BiNinput_Vir_ExpCR - BiNinput_Vir_CR(:,:,yr_base);

BiNarea_Alt_DeltaCR = BiNarea_Alt_ExpCR - BiNarea_Alt_CR(:,:,yr_base);
BiNsur_Alt_DeltaCR = BiNsur_Alt_ExpCR - BiNsur_Alt_CR(:,:,yr_base);
BiNinput_Alt_DeltaCR = BiNinput_Alt_ExpCR - BiNinput_Alt_CR(:,:,yr_base);

