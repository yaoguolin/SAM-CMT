
P_FILE = 'basic_P_SAM2.mat'; 
load([dir 'Inputs' dir_s P_FILE]); 

%%% Generate Data: if year 2015 and 2016 don't have data, keep it the same
%%% with the most recent year's data
Phosp.Pinput_kgkm = Var_Generate_Data(Pinput_kgkm);
Phosp.Pyield_kgkm = Var_Generate_Data(Pyield_kgkm);


%       3.1 Phospen Calculation


Phosp.Psur_kgkm = Pinput_kgkm - Pyield_kgkm;

%%% We only use the data that Psur_kgkm > 0, we assign a 0 when Psur_kgkm < 0
% Psur_kgkm_G0 = Psur_kgkm; % Psur_kgkm_G0 is Psur_kgkm greater than 0

% Psur_kgkm_G0(Psur_kgkm_G0<0) = 0;
% Psur_kg_G0 = Psur_kgkm_G0 .* AreaH_FAO; 
%%% There is no problem so far. Be careful when multiply AreaH_FAO_Agg

%       3.2 Phospen aggregation in original settings
[Phosp.Pinput_kgkm_Agg, Phosp.Pinput_kgkm_AggCO,Phosp.Pinput_kgkm_AggGB,...
 Phosp.Pinput_kg_Agg, Phosp.Pinput_kg_AggCO,Phosp.Pinput_kg_AggGB]...
    = ProdAggVar_Sum09182019(Pinput_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Phosp.Pyield_kgkm_Agg, Phosp.Pyield_kgkm_AggCO,Phosp.Pyield_kgkm_AggGB,...
 Phosp.Pyield_kg_Agg, Phosp.Pyield_kg_AggCO,Phosp.Pyield_kg_AggGB]...
    = ProdAggVar_Sum09182019(Pyield_kgkm,AreaH_FAO,MAPPING,cr_ind);

Phosp.Psur_kgkm_Agg = Phosp.Pinput_kgkm_Agg - Phosp.Pyield_kgkm_Agg;
Phosp.Psur_kgkm_Agg(Phosp.Psur_kgkm_Agg<0) = 0;
Phosp.Psur_kgkm_AggCO = Phosp.Pinput_kgkm_AggCO - Phosp.Pyield_kgkm_AggCO;
Phosp.Psur_kgkm_AggGB = Phosp.Pinput_kgkm_AggGB - Phosp.Pyield_kgkm_AggGB;

Phosp.Psur_kg_Agg = Phosp.Pinput_kg_Agg - Phosp.Pyield_kg_Agg;
Phosp.Psur_kg_AggCO = Phosp.Pinput_kg_AggCO - Phosp.Pyield_kg_AggCO;
Phosp.Psur_kg_AggGB = Phosp.Pinput_kg_AggGB - Phosp.Pyield_kg_AggGB;

Phosp.PUE_Agg = Phosp.Pyield_kgkm_Agg ./ Phosp.Pinput_kgkm_Agg;
Phosp.PUE_AggCO = Phosp.Pyield_kgkm_AggCO ./ Phosp.Pinput_kgkm_AggCO;
Phosp.PUE_AggGB = Phosp.Pyield_kgkm_AggGB ./ Phosp.Pinput_kgkm_AggGB;


%%% Phospen content aggregation
contentP_Agg = Var_Agg_WGT(contentP,Product_FAO,MAPPING); % OK so far
contentP_Agg = contentP_Agg(:,cr_ind,:);

%       3.3 Phospen aggregation with the experiment
[Phosp.Pinput_kgkm_Exp,Phosp.Pinput_kgkm_ExpCO,Phosp.Pinput_kgkm_ExpGB,...
 Phosp.Pinput_kg_Exp, Phosp.Pinput_kg_ExpCO,Phosp.Pinput_kg_ExpGB]...
    = ProdAggVar_SumExp(Phosp.Pinput_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Phosp.Pyield_kgkm_Exp,Phosp.Pyield_kgkm_ExpCO,Phosp.Pyield_kgkm_ExpGB,...
 Phosp.Pyield_kg_Exp, Phosp.Pyield_kg_ExpCO,Phosp.Pyield_kg_ExpGB]...
    = ProdAggVar_SumExp(Phosp.Pyield_kgkm_Agg,harvst_port,yr_base,cr_ind);

Phosp.Psur_kgkm_Exp = Phosp.Pinput_kgkm_Exp - Phosp.Pyield_kgkm_Exp;
Phosp.Psur_kgkm_ExpCO = Phosp.Pinput_kgkm_ExpCO - Phosp.Pyield_kgkm_ExpCO;
Phosp.Psur_kgkm_ExpGB = Phosp.Pinput_kgkm_ExpGB - Phosp.Pyield_kgkm_ExpGB;


Phosp.PUE_Exp = Phosp.Pyield_kgkm_Exp ./ Phosp.Pinput_kgkm_Exp;
Phosp.PUE_ExpCO = Phosp.Pyield_kgkm_ExpCO ./ Phosp.Pinput_kgkm_ExpCO;
Phosp.PUE_ExpGB = Phosp.Pyield_kgkm_ExpGB ./ Phosp.Pinput_kgkm_ExpGB;


%       3.4 Phospen impact changes
%%% P input
Phosp.Pinput_kg_Delta = Phosp.Pinput_kgkm_Agg(:,:,yr_base) .* Area.harvst_delta; %*****
Phosp.Pinput_kg_DeltaCO = nansum(Phosp.Pinput_kg_Delta,2);%*****
Phosp.Pinput_kg_DeltaGB =  nansum(Phosp.Pinput_kg_DeltaCO);%*****

Phosp.Pinput_kgkm_Delta = Phosp.Pinput_kgkm_Exp - Phosp.Pinput_kgkm_Agg(:,:,yr_base); %*****
Phosp.Pinput_kgkm_DeltaCO = Phosp.Pinput_kgkm_ExpCO - Phosp.Pinput_kgkm_AggCO(:,yr_base); %*****
Phosp.Pinput_kgkm_DeltaGB = Phosp.Pinput_kgkm_ExpGB - Phosp.Pinput_kgkm_AggGB(yr_base); %*****

%%% P yield
Phosp.Pyield_kg_Delta = Phosp.Pyield_kgkm_Agg(:,:,yr_base) .* Area.harvst_delta; %*****
Phosp.Pyield_kg_DeltaCO = nansum(Phosp.Pyield_kg_Delta,2);%*****
Phosp.Pyield_kg_DeltaGB =  nansum(Phosp.Pyield_kg_DeltaCO);%*****

Phosp.Pyield_kgkm_Delta = Phosp.Pyield_kgkm_Exp - Phosp.Pyield_kgkm_Agg(:,:,yr_base); %*****
Phosp.Pyield_kgkm_DeltaCO = Phosp.Pyield_kgkm_ExpCO - Phosp.Pyield_kgkm_AggCO(:,yr_base); %*****
Phosp.Pyield_kgkm_DeltaGB = Phosp.Pyield_kgkm_ExpGB - Phosp.Pyield_kgkm_AggGB(yr_base); %*****

%%% P surplus
Phosp.Psur_kg_Delta = Phosp.Psur_kgkm_Agg(:,:,yr_base) .* Area.harvst_delta; %*****
Phosp.Psur_kg_DeltaCO = nansum(Phosp.Psur_kg_Delta,2); %*****
Phosp.Psur_kg_DeltaGB = nansum(Phosp.Psur_kg_DeltaCO); %*****

Phosp.Psur_kgkm_Delta = Phosp.Psur_kgkm_Exp - Phosp.Psur_kgkm_Agg(:,:,yr_base); %*****
Phosp.Psur_kgkm_DeltaCO = Phosp.Psur_kgkm_ExpCO - Phosp.Psur_kgkm_AggCO(:,yr_base); %*****
Phosp.Psur_kgkm_DeltaGB = Phosp.Psur_kgkm_ExpGB - Phosp.Psur_kgkm_AggGB(yr_base); %*****

%%% PUE
Phosp.PUE_DeltaCO = Phosp.PUE_ExpCO - Phosp.PUE_AggCO(:,yr_base); 
Phosp.PUE_DeltaGB = Phosp.PUE_ExpGB - Phosp.PUE_AggGB(yr_base);


