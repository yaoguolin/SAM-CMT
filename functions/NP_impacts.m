function    [Nuinput_kg_Exp,     Nuinput_kg_Agg,      Nuinput_kg_Delta,...
            Nuyield_kg_Exp,      Nuyield_kg_Agg,      Nuyield_kg_Delta,...
            Nusur_kg_Exp,        Nusur_kg_Agg,        Nusur_kg_Delta,...
            Nuinput_kg_ExpCO,	 Nuinput_kg_AggCO,    Nuinput_kg_DeltaCO,...
            Nuyield_kg_ExpCO,	 Nuyield_kg_AggCO,    Nuyield_kg_DeltaCO,...
            Nusur_kg_ExpCO,      Nusur_kg_AggCO,      Nusur_kg_DeltaCO,...
            Nuinput_kgkm_ExpCO,	 Nuinput_kgkm_AggCO,  Nuinput_kgkm_DeltaCO,...
            Nuyield_kgkm_ExpCO,	 Nuyield_kgkm_AggCO,  Nuyield_kgkm_DeltaCO,...
            Nusur_kgkm_ExpCO,    Nusur_kgkm_AggCO,    Nusur_kgkm_DeltaCO,...
            NuUE_ExpCO,          NuUE_AggCO,          NuUE_Delta,...           
            Nuarea_Vir_Exp,      Nuarea_Vir,          Nuarea_Vir_Delta,...
            Nuinput_Vir_Exp,     Nuinput_Vir,         Nuinput_Vir_Delta,...
            Nusur_Vir_Exp,       Nusur_Vir,           Nusur_Vir_Delta,...
            Nuarea_Alt_Exp,      Nuarea_Alt,          Nuarea_Alt_Delta,...
            Nuinput_Alt_Exp,     Nuinput_Alt,         Nuinput_Alt_Delta,...
            Nusur_Alt_Exp,       Nusur_Alt,           Nusur_Alt_Delta]...
            = NP_impacts(nutrient,original_port,new_port,co_dim,cr_dim,yr_dim,yr_base,dir,dir_s)
%   This function assess the nitrogen or phorsphorous impacts
FAO_FILE = 'basic_FAO_SAM.mat';
load([dir 'Inputs' dir_s FAO_FILE]);

    if nutrient = 'N'
        load([dir 'Inputs' dir_s 'basic_N_SAM.mat']);
        Nufer_kgkm = Nfer_kgkm;
        Numan_kgkm = Nman_kgkm;
        Nufix_kgkm = Nman_kgkm;
        Nudep_kgkm = Ndep_kgkm;
        Nuyield_kgkm = Nyield_kgkm;
    elseif nutrient = 'P')
        load([dir 'Inputs' dir_s 'basic_P_SAM.mat']);
        Nufer_kgkm = Pfer_kgkm;
        Numan_kgkm = Pman_kgkm;
        Nufix_kgkm = zeros(1:218,1:170,1:56);
        Nudep_kgkm = zeros(1:218,1:170,1:56);
        Nuyield_kgkm = Pyield_kgkm;
    end
    
    
%       2.1 Nitrogen/Phosphorous aggregation
Nufer_kgkm_Agg = Var_Agg_WGT(Nufer_kgkm,AreaH_FAO,MAPPING);
Numan_kgkm_Agg = Var_Agg_WGT(Numan_kgkm,AreaH_FAO,MAPPING);
Nufix_kgkm_Agg = Var_Agg_WGT(Nufix_kgkm,AreaH_FAO,MAPPING);
Nudep_kgkm_Agg = Var_Agg_WGT(Nudep_kgkm,AreaH_FAO,MAPPING);
Nuyield_kgkm_Agg = Var_Agg_WGT(Nuyield_kgkm,AreaH_FAO,MAPPING);


%%% Nitrogen/Phosphorous content aggregation
contentNu_Agg = Var_Agg_WGT(contentNu,Product_FAO,MAPPING);

% 3. Impact assessments
%      3.1 Nitrogen/Phosphorous
Nuinput_kgkm_Agg =  Nufer_kgkm_Agg + Numan_kgkm_Agg + Nufix_kgkm_Agg + Nudep_kgkm_Agg;
Nusur_kgkm_Agg = Nuinput_kgkm_Agg - Nuyield_kgkm_Agg;

%%% Nutrients usages
Nufer_kg_Agg= Nufer_kgkm_Agg.*AreaH_FAO_Agg;
Numan_kg_Agg = Numan_kgkm_Agg.*AreaH_FAO_Agg;
Nufix_kg_Agg = Nufix_kgkm_Agg.*AreaH_FAO_Agg;
Nudep_kg_Agg = Nudep_kgkm_Agg.*AreaH_FAO_Agg;
Nuyield_kg_Agg = Nuyield_kgkm_Agg.*AreaH_FAO_Agg;

Nuinput_kg_Agg =  Nufer_kg_Agg + Numan_kg_Agg + Nufix_kg_Agg + Nudep_kg_Agg;
Nusur_kg_Agg = Nuinput_kg_Agg - Nuyield_kg_Agg;


Nufer_kg_Exp = Nufer_kgkm_Agg(:,:,yr_base).*harvst_port;
Numan_kg_Exp = Numan_kgkm_Agg(:,:,yr_base).*harvst_port;
Nufix_kg_Exp = Nufix_kgkm_Agg(:,:,yr_base).*harvst_port;
Nudep_kg_Exp = Nudep_kgkm_Agg(:,:,yr_base).*harvst_port;
Nuyield_kg_Exp = Nuyield_kgkm_Agg(:,:,yr_base).*harvst_port;

Nuinput_kg_Exp =  Nufer_kg_Exp + Numan_kg_Exp + Nufix_kg_Exp + Nudep_kg_Exp;
Nusur_kg_Exp = Nuinput_kg_Exp - Nuyield_kg_Exp;

Nuinput_kg_Delta = Nuinput_kg_Exp - Nuinput_kg_Agg(:,:,yr_base);
Nuyield_kg_Delta = Nuyield_kg_Exp - Nuyield_kg_Agg(:,:,yr_base);
Nusur_kg_Delta = Nusur_kg_Exp - Nusur_kg_Agg(:,:,yr_base);

%%% Nitrogen/Phosphorous Use Efficiency
% Original
Nuinput_kg_AggCO = nansum(Nuinput_kg_Agg,2);
Nuyield_kg_AggCO = nansum(Nuyield_kg_Agg,2);
Nusur_kg_AggCO = Nuinput_kg_AggCO - Nuyield_kg_AggCO;

Nuinput_kgkm_AggCO = Nuinput_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Nuyield_kgkm_AggCO = Nuyield_kg_AggCO./nansum(AreaH_FAO_Agg,2);
Nusur_kgkm_AggCO = Nuinput_kgkm_AggCO - Nuyield_kgkm_AggCO;
NuUE_AggCO = Nuyield_kgkm_AggCO ./Nuinput_kgkm_AggCO;

% New
Nuinput_kg_ExpCO = nansum(Nuinput_kg_Exp,2);
Nuyield_kg_ExpCO = nansum(Nuyield_kg_Exp,2);
Nusur_kg_ExpCO = Nuinput_kg_ExpCO - Nuyield_kg_ExpCO;

Nuinput_kgkm_ExpCO = nansum(Nuinput_kg_Exp,2)./nansum(harvst_port,2);
Nuyield_kgkm_ExpCO = nansum(Nuyield_kg_Exp,2)./nansum(harvst_port,2);
Nusur_kgkm_ExpCO = Nuinput_kgkm_ExpCO - Nuyield_kgkm_ExpCO;
NuUE_ExpCO = Nuyield_kgkm_ExpCO ./Nuinput_kgkm_ExpCO;

% Changes
Nuinput_kg_DeltaCO = Nuinput_kg_ExpCO - Nuinput_kg_AggCO(:,:,yr_base);
Nuyield_kg_DeltaCO = Nuyield_kg_ExpCO - Nuyield_kg_AggCO(:,:,yr_base);
Nusur_kg_DeltaCO = Nusur_kg_ExpCO - Nusur_kg_AggCO(:,:,yr_base);

Nuinput_kgkm_DeltaCO = Nuinput_kgkm_ExpCO - Nuinput_kgkm_AggCO(:,:,yr_base);
Nuyield_kgkm_DeltaCO = Nuyield_kgkm_ExpCO - Nuyield_kgkm_AggCO(:,:,yr_base);
Nusur_kgkm_DeltaCO = Nusur_kgkm_ExpCO - Nusur_kgkm_AggCO(:,:,yr_base);

NUE_Delta = NuUE_ExpCO - NuUE_AggCO(:,:,yr_base);


%%% Virtual and alternative N/P
% Original
[Nuarea_Vir,Nusur_Vir,Nuinput_Vir,Nuarea_Alt,Nusur_Alt,Nuinput_Alt,contentNuTrd_Agg] ...
    = Nutr_VirtAlt(contentNu_Agg,ImTrdQnt_Agg,Yield_FAO_Agg,Nuyield_kgkm_Agg, ...
    Nusur_kgkm_Agg, Nuinput_kgkm_Agg, 1961:2016);

% New
[Nuarea_Vir_Exp,Nusur_Vir_Exp,Nuinput_Vir_Exp,Nuarea_Alt_Exp,Nusur_Alt_Exp,...
    Nuinput_Alt_Exp,contentNuTrd_Exp] ...
    = Nutr_VirtAlt(contentNu_Agg,trade_port,yield_port,Nuyield_kgkm_Agg, ...
    Nusur_kgkm_Agg, Nuinput_kgkm_Agg,2011);

% Changes

Nuarea_Vir_Delta = Nuarea_Vir_Exp - Nuarea_Vir(:,:,yr_base);
Nusur_Vir_Delta = Nusur_Vir_Exp - Nusur_Vir(:,:,yr_base);
Nuinput_Vir_Delta = Nuinput_Vir_Exp - Nuinput_Vir(:,:,yr_base);

Nuarea_Alt_Delta = Nuarea_Alt_Exp - Nuarea_Alt(:,:,yr_base);
Nusur_Alt_Delta = Nusur_Alt_Exp - Nusur_Alt(:,:,yr_base);
Nuinput_Alt_Delta = Nuinput_Alt_Exp - Nuinput_Alt(:,:,yr_base);

end

