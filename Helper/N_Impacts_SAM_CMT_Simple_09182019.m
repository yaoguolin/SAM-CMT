
N_FILE = 'basic_N_SAM.mat'; 
load([dir 'Inputs' dir_s N_FILE]); 

%%% Generate Data: if year 2015 and 2016 don't have data, keep it the same
%%% with the most recent year's data
Nitrog.Nfer_kgkm = Var_Generate_Data(Nfer_kgkm);
Nitrog.Nman_kgkm = Var_Generate_Data(Nman_kgkm);
Nitrog.Nyield_kgkm = Var_Generate_Data(Nyield_kgkm);
Nitrog.Ndep_kgkm = Var_Generate_Data(Ndep_kgkm);

%       3.1 Nitrogen Calculation

%%% The calculation is based raw data
N_comb = nan(218,170,56,4);
N_comb(:,:,:,1) = Nfer_kgkm;
N_comb(:,:,:,2) = Nman_kgkm;
N_comb(:,:,:,3) = Nfix_kgkm;
N_comb(:,:,:,4) = Ndep_kgkm;

Nitrog.Ninput_kgkm =  squeeze(nansum(N_comb,4));
Nitrog.Nsur_kgkm = Ninput_kgkm - Nyield_kgkm;

%%% We only use the data that Nsur_kgkm > 0, we assign a 0 when Nsur_kgkm < 0
% Nsur_kgkm_G0 = Nsur_kgkm; % Nsur_kgkm_G0 is Nsur_kgkm greater than 0

% Nsur_kgkm_G0(Nsur_kgkm_G0<0) = 0;
% Nsur_kg_G0 = Nsur_kgkm_G0 .* AreaH_FAO; 
%%% There is no problem so far. Be careful when multiply AreaH_FAO_Agg

%       3.2 Nitrogen aggregation in original settings
[Nitrog.Ninput_kgkm_Agg, Nitrog.Ninput_kgkm_AggCO,Nitrog.Ninput_kgkm_AggGB,...
 Nitrog.Ninput_kg_Agg, Nitrog.Ninput_kg_AggCO,Nitrog.Ninput_kg_AggGB]...
    = ProdAggVar_Sum09182019(Ninput_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Nitrog.Nyield_kgkm_Agg, Nitrog.Nyield_kgkm_AggCO,Nitrog.Nyield_kgkm_AggGB,...
 Nitrog.Nyield_kg_Agg, Nitrog.Nyield_kg_AggCO,Nitrog.Nyield_kg_AggGB]...
    = ProdAggVar_Sum09182019(Nyield_kgkm,AreaH_FAO,MAPPING,cr_ind);

Nitrog.Nsur_kgkm_Agg = Nitrog.Ninput_kgkm_Agg - Nitrog.Nyield_kgkm_Agg;
Nitrog.Nsur_kgkm_AggCO = Nitrog.Ninput_kgkm_AggCO - Nitrog.Nyield_kgkm_AggCO;
Nitrog.Nsur_kgkm_AggGB = Nitrog.Ninput_kgkm_AggGB - Nitrog.Nyield_kg_AggGB;

Nitrog.Nsur_kg_Agg = Nitrog.Ninput_kg_Agg - Nitrog.Nyield_kg_Agg;
Nitrog.Nsur_kg_AggCO = Nitrog.Ninput_kg_AggCO - Nitrog.Nyield_kg_AggCO;
Nitrog.Nsur_kg_AggGB = Nitrog.Ninput_kg_AggGB - Nitrog.Nyield_kg_AggGB;

Nitrog.NUE_Agg = Nitrog.Nyield_kgkm_Agg ./ Nitrog.Ninput_kgkm_Agg;
Nitrog.NUE_AggCO = Nitrog.Nyield_kgkm_AggCO ./ Nitrog.Ninput_kgkm_AggCO;
Nitrog.NUE_AggGB = Nitrog.Nyield_kgkm_AggGB ./ Nitrog.Ninput_kgkm_AggGB;


%%% Nitrogen content aggregation
contentN_Agg = Var_Agg_WGT(contentN,Product_FAO,MAPPING); % OK so far
contentN_Agg = contentN_Agg(:,cr_ind,:);

%       3.3 Nitrogen aggregation with the experiment
[Nitrog.Ninput_kgkm_Exp,Nitrog.Ninput_kgkm_ExpCO,Nitrog.Ninput_kgkm_ExpGB,...
 Nitrog.Ninput_kg_Exp, Nitrog.Ninput_kg_ExpCO,Nitrog.Ninput_kg_ExpGB]...
    = ProdAggVar_SumExp(Nitrog.Ninput_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Nitrog.Nyield_kgkm_Exp,Nitrog.Nyield_kgkm_ExpCO,Nitrog.Nyield_kgkm_ExpGB,...
 Nitrog.Nyield_kg_Exp, Nitrog.Nyield_kg_ExpCO,Nitrog.Nyield_kg_ExpGB]...
    = ProdAggVar_SumExp(Nitrog.Nyield_kgkm_Agg,harvst_port,yr_base,cr_ind);

Nitrog.Nsur_kgkm_Exp = Nitrog.Ninput_kgkm_Exp - Nitrog.Nyield_kgkm_Exp;
Nitrog.Nsur_kgkm_ExpCO = Nitrog.Ninput_kgkm_ExpCO - Nitrog.Nyield_kgkm_ExpCO;
Nitrog.Nsur_kgkm_ExpGB = Nitrog.Ninput_kgkm_ExpGB - Nitrog.Nyield_kgkm_ExpGB;


Nitrog.NUE_Exp = Nitrog.Nyield_kgkm_Exp ./ Nitrog.Ninput_kgkm_Exp;
Nitrog.NUE_ExpCO = Nitrog.Nyield_kgkm_ExpCO ./ Nitrog.Ninput_kgkm_ExpCO;
Nitrog.NUE_ExpGB = Nitrog.Nyield_kgkm_ExpGB ./ Nitrog.Ninput_kgkm_ExpGB;


%       3.4 Nitrogen impact changes
%%% N input
Nitrog.Ninput_kg_Delta = Nitrog.Ninput_kgkm_Agg(:,:,yr_base) .* Area.harvst_delta; %*****
Nitrog.Ninput_kg_DeltaCO = nansum(Nitrog.Ninput_kg_Delta,2);%*****
Nitrog.Ninput_kg_DeltaGB =  nansum(Nitrog.Ninput_kg_DeltaCO);%*****

Nitrog.Ninput_kgkm_Delta = Nitrog.Ninput_kgkm_Exp - Nitrog.Ninput_kgkm_Agg(:,:,yr_base); %*****
Nitrog.Ninput_kgkm_DeltaCO = Nitrog.Ninput_kgkm_ExpCO - Nitrog.Ninput_kgkm_AggCO(:,yr_base); %*****
Nitrog.Ninput_kgkm_DeltaGB = Nitrog.Ninput_kgkm_ExpGB - Nitrog.Ninput_kgkm_AggGB(yr_base); %*****

%%% N yield
Nitrog.Nyield_kg_Delta = Nitrog.Nyield_kgkm_Agg(:,:,yr_base) .* Area.harvst_delta; %*****
Nitrog.Nyield_kg_DeltaCO = nansum(Nitrog.Nyield_kg_Delta,2);%*****
Nitrog.Nyield_kg_DeltaGB =  nansum(Nitrog.Nyield_kg_DeltaCO);%*****

Nitrog.Nyield_kgkm_Delta = Nitrog.Nyield_kgkm_Exp - Nitrog.Nyield_kgkm_Agg(:,:,yr_base); %*****
Nitrog.Nyield_kgkm_DeltaCO = Nitrog.Nyield_kgkm_ExpCO - Nitrog.Nyield_kgkm_AggCO(:,yr_base); %*****
Nitrog.Nyield_kgkm_DeltaGB = Nitrog.Nyield_kgkm_ExpGB - Nitrog.Nyield_kgkm_AggGB(yr_base); %*****

%%% N surplus
Nitrog.Nsur_kg_Delta = Nitrog.Nsur_kgkm_Agg(:,:,yr_base) .* Area.harvst_delta; %*****
Nitrog.Nsur_kg_DeltaCO = nansum(Nitrog.Nsur_kg_Delta,2); %*****
Nitrog.Nsur_kg_DeltaGB = nansum(Nitrog.Nsur_kg_DeltaCO); %*****

Nitrog.Nsur_kgkm_Delta = Nitrog.Nsur_kgkm_Exp - Nitrog.Nsur_kgkm_Agg(:,:,yr_base); %*****
Nitrog.Nsur_kgkm_DeltaCO = Nitrog.Nsur_kgkm_ExpCO - Nitrog.Nsur_kgkm_AggCO(:,yr_base); %*****
Nitrog.Nsur_kgkm_DeltaGB = Nitrog.Nsur_kgkm_ExpGB - Nitrog.Nsur_kgkm_AggGB(yr_base); %*****

%%% NUE
Nitrog.NUE_DeltaCO = Nitrog.NUE_ExpCO - Nitrog.NUE_AggCO(:,yr_base); 
Nitrog.NUE_DeltaGB = Nitrog.NUE_ExpGB - Nitrog.NUE_AggGB(yr_base);


