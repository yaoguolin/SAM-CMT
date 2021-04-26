
P_FILE = 'basic_P_SAM2.mat'; 
load([dir 'Inputs' dir_s P_FILE]); 

%%% Generate Data: if year 2015 and 2016 don't have data, keep it the same
%%% with the most recent year's data
% Pfer_kgkm = Var_Generate_Data(Pfer_kgkm);
% Pman_kgkm = Var_Generate_Data(Pman_kgkm);
Pinput_kgkm = Var_Generate_Data(Pinput_kgkm);
Pyield_kgkm = Var_Generate_Data(Pyield_kgkm);
Peros_kgkm = Var_Generate_Data(Peros_kgkm);

%       4.1 Phosphorus Calculation
%%% The calculation is based raw data
% Pinput_kgkm =  Pfer_kgkm + Pman_kgkm;
Psur_kgkm = Pinput_kgkm - Pyield_kgkm;
Pres_kgkm = Psur_kgkm - Peros_kgkm;

%%% We only use the data that Psur_kgkm > 0, we assign a 0 when Psur_kgkm < 0
% Psur_kgkm_G0 = Psur_kgkm; % Psur_kgkm_G0 is Psur_kgkm greater than 0

% Psur_kgkm_G0(Psur_kgkm_G0<0) = 0;
% Psur_kg_G0 = Psur_kgkm_G0 .* AreaH_FAO; 

%       4.2 Nitrogen aggregation in original settings
[Pinput_kgkm_Agg, Pinput_kgkm_AggCO,Pinput_kgkm_AggGB,...
 Pinput_kg_Agg, Pinput_kg_AggCO,Pinput_kg_AggGB,]...
    = ProdAggVar_Sum(Pinput_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Pyield_kgkm_Agg, Pyield_kgkm_AggCO,Pyield_kgkm_AggGB,...
 Pyield_kg_Agg, Pyield_kg_AggCO,Pyield_kg_AggGB,]...
    = ProdAggVar_Sum(Pyield_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Psur_kgkm_Agg, Psur_kgkm_AggCO,Psur_kgkm_AggGB,...
 Psur_kg_Agg, Psur_kg_AggCO,Psur_kg_AggGB,]...
    = ProdAggVar_Sum(Psur_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Pres_kgkm_Agg, Pres_kgkm_AggCO,Pres_kgkm_AggGB,...
 Pres_kg_Agg, Pres_kg_AggCO,Pres_kg_AggGB,]...
    = ProdAggVar_Sum(Pres_kgkm,AreaH_FAO,MAPPING,cr_ind);

PUE_Agg = Pyield_kgkm_Agg ./ Pinput_kgkm_Agg;
PUE_AggCO = Pyield_kgkm_AggCO ./ Pinput_kgkm_AggCO;
PUE_AggGB = Pyield_kgkm_AggGB ./ Pinput_kgkm_AggGB;

%%% Nitrogen/Phosphorous content aggregation
contentP_Agg = Var_Agg_WGT(contentP,Product_FAO,MAPPING);
contentP_Agg = contentP_Agg(:,cr_ind,:);

%       4.3 Phosphorus aggregation with the experiment
[Pinput_kgkm_Exp,Pinput_kgkm_ExpCO,Pinput_kgkm_ExpGB,...
 Pinput_kg_Exp, Pinput_kg_ExpCO,Pinput_kg_ExpGB]...
    = ProdAggVar_SumExp(Pinput_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Pyield_kgkm_Exp,Pyield_kgkm_ExpCO,Pyield_kgkm_ExpGB,...
 Pyield_kg_Exp, Pyield_kg_ExpCO,Pyield_kg_ExpGB]...
    = ProdAggVar_SumExp(Pyield_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Psur_kgkm_Exp,Psur_kgkm_ExpCO,Psur_kgkm_ExpGB,...
 Psur_kg_Exp, Psur_kg_ExpCO,Psur_kg_ExpGB]...
    = ProdAggVar_SumExp(Psur_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Pres_kgkm_Exp,Pres_kgkm_ExpCO,Pres_kgkm_ExpGB,...
 Pres_kg_Exp, Pres_kg_ExpCO,Pres_kg_ExpGB]...
    = ProdAggVar_SumExp(Pres_kgkm_Agg,harvst_port,yr_base,cr_ind);

PUE_ExpCO = Pyield_kgkm_ExpCO ./ Pinput_kgkm_ExpCO;
PUE_ExpGB = Pyield_kgkm_ExpGB ./ Pinput_kgkm_ExpGB;


%       3.4 Phosphorus impact changes
%%% P input
Pinput_kg_Delta = Pinput_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Pinput_kg_DeltaCO = nansum(Pinput_kg_Delta,2);%*****
Pinput_kg_DeltaGB = nansum(Pinput_kg_DeltaCO); %*****

Pinput_kgkm_Delta = Pinput_kgkm_Exp - Pinput_kgkm_Agg(:,:,yr_base); %*****
Pinput_kgkm_DeltaCO = Pinput_kgkm_ExpCO - Pinput_kgkm_AggCO(:,yr_base); %*****
Pinput_kgkm_DeltaGB = Pinput_kgkm_ExpGB - Pinput_kgkm_AggGB(yr_base); %*****

%%% P yield
Pyield_kg_Delta = Pyield_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Pyield_kg_DeltaCO = nansum(Pyield_kg_Delta,2); %*****
Pyield_kg_DeltaGB = nansum(Pyield_kg_DeltaCO); %*****

Pyield_kgkm_Delta = Pyield_kgkm_Exp - Pyield_kgkm_Agg(:,:,yr_base); %*****
Pyield_kgkm_DeltaCO = Pyield_kgkm_ExpCO - Pyield_kgkm_AggCO(:,yr_base); %*****
Pyield_kgkm_DeltaGB = Pyield_kgkm_ExpGB - Pyield_kgkm_AggGB(yr_base); %*****

%%% P surplus
Psur_kg_Delta = Psur_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Psur_kg_DeltaCO = nansum(Psur_kg_Delta,2); %*****
Psur_kg_DeltaGB = nansum(Psur_kg_DeltaCO); %*****

Psur_kgkm_Delta = Psur_kgkm_Exp - Psur_kgkm_Agg(:,:,yr_base); %*****
Psur_kgkm_DeltaCO = Psur_kgkm_ExpCO - Psur_kgkm_AggCO(:,yr_base); %*****
Psur_kgkm_DeltaGB = Psur_kgkm_ExpGB - Psur_kgkm_AggGB(yr_base); %*****

%%% P reserve
Pres_kg_Delta = Pres_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Pres_kg_DeltaCO = nansum(Pres_kg_Delta,2); %*****
Pres_kg_DeltaGB = nansum(Pres_kg_DeltaCO); %*****

Pres_kgkm_Delta = Pres_kgkm_Exp - Pres_kgkm_Agg(:,:,yr_base); %*****
Pres_kgkm_DeltaCO = Pres_kgkm_ExpCO - Pres_kgkm_AggCO(:,yr_base); %*****
Pres_kgkm_DeltaGB = Pres_kgkm_ExpGB - Pres_kgkm_AggGB(yr_base); %*****

%%% PUE
PUE_DeltaCO = PUE_ExpCO - PUE_AggCO(:,yr_base); 
PUE_DeltaGB = PUE_ExpGB - PUE_AggGB(yr_base);


%       3.5 Virtual and alternative Phosphorus
%%% Generate ImTrdQnt_Agg


% Original
[Parea_Vir,Psur_Vir,Pinput_Vir,Parea_Alt,Psur_Alt,Pinput_Alt,contentPTrd_Agg,...
 BiParea_Vir,BiPsur_Vir,BiPinput_Vir,...
 BiParea_Alt,BiPsur_Alt,BiPinput_Alt,...
 Parea_Vir_CO,Psur_Vir_CO,Pinput_Vir_CO, Parea_Alt_CO, Psur_Alt_CO, Pinput_Alt_CO,...
 Parea_Vir_GB,Psur_Vir_GB,Pinput_Vir_GB, Parea_Alt_GB, Psur_Alt_GB, Pinput_Alt_GB] ...
    = Nutr_VirtAlt(contentP_Agg,ImTrdQnt_Agg_NoInternal,Yield_FAO_Agg,Pyield_kgkm_Agg, ...
    Psur_kgkm_Agg, Pinput_kgkm_Agg, uniYrs);

% New
[Parea_Vir_Exp,Psur_Vir_Exp,Pinput_Vir_Exp,Parea_Alt_Exp,Psur_Alt_Exp,...
 Pinput_Alt_Exp,contentPTrd_Exp,...
 BiParea_Vir_Exp,BiPsur_Vir_Exp,BiPinput_Vir_Exp,...
 BiParea_Alt_Exp,BiPsur_Alt_Exp,BiPinput_Alt_Exp,...
 Parea_Vir_ExpCO,Psur_Vir_ExpCO,Pinput_Vir_ExpCO, Parea_Alt_ExpCO, Psur_Alt_ExpCO, Pinput_Alt_ExpCO,...
 Parea_Vir_ExpGB,Psur_Vir_ExpGB,Pinput_Vir_ExpGB, Parea_Alt_ExpGB, Psur_Alt_ExpGB, Pinput_Alt_ExpGB] ...
    = Nutr_VirtAlt(contentP_Agg,trade_port_NoInternal,yield_port,Pyield_kgkm_Agg, ...
    Psur_kgkm_Agg, Pinput_kgkm_Agg,baseyr);

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

%       3.5 Phosphorus AEZ changes

%%% Disaggregated
% Original
Psur_kg_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;
for az = 1:1:18
    Psur_kg_AEZ_Agg(:,az,:,:) = squeeze(Psur_kgkm_Agg(:,:,:)) .* squeeze(AreaH_AEZ_FAO_Agg(:,az,:,:));
end

Psur_kgkm_AEZ_Agg = Psur_kg_AEZ_Agg ./ AreaH_AEZ_FAO_Agg;


% New
Psur_kg_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    Psur_kg_AEZ_Exp(:,az,:) = squeeze(Psur_kgkm_Agg(:,:,yr_base)) .* squeeze(harvst_aez_port(:,az,:));
end

Psur_kgkm_AEZ_Exp = Psur_kg_AEZ_Exp ./harvst_aez_port;

% Changes
Psur_kg_AEZ_Delta = Psur_kg_AEZ_Exp - Psur_kg_AEZ_Agg(:,:,:,yr_base);

Psur_kgkm_AEZ_Delta = Psur_kgkm_AEZ_Exp - Psur_kgkm_AEZ_Agg(:,:,:,yr_base);

%%% National Level
Psur_kg_AEZ_AggCO = squeeze(nansum(Psur_kg_AEZ_Agg,3));
Psur_kg_AEZ_ExpCO = squeeze(nansum(Psur_kg_AEZ_Exp,3));
Psur_kg_AEZ_DeltaCO = squeeze(nansum(Psur_kg_AEZ_Delta,3));

Psur_kgkm_AEZ_AggCO = Psur_kg_AEZ_AggCO ./AreaH_AEZ_FAO_AggCO; 
Psur_kgkm_AEZ_ExpCO = Psur_kg_AEZ_ExpCO ./harvst_aez_portco;
Psur_kgkm_AEZ_DeltaCO = Psur_kgkm_AEZ_ExpCO - Psur_kgkm_AEZ_AggCO(:,:,yr_base);

%%% Global Level
Psur_kg_AEZ_AggGB = squeeze(nansum(Psur_kg_AEZ_AggCO,1));
Psur_kg_AEZ_ExpGB = squeeze(nansum(Psur_kg_AEZ_ExpCO,1));
Psur_kg_AEZ_DeltaGB = squeeze(nansum(Psur_kg_AEZ_DeltaCO,1));

Psur_kgkm_AEZ_AggGB = Psur_kg_AEZ_AggGB ./AreaH_AEZ_FAO_AggGB;
Psur_kgkm_AEZ_ExpGB = Psur_kg_AEZ_ExpGB ./harvst_aez_portgb;
Psur_kgkm_AEZ_DeltaGB = Psur_kgkm_AEZ_ExpGB - Psur_kgkm_AEZ_AggGB(:,yr_base);

%%% Virtual and Alternative Nitrogen AEZ changes
% Bilateral Virtual: 10 crops * 56 years * 6 importers * 6 exporters
% HARVST_AEZ_PRC: 6 producers (exporters) * 18 AEZs * 10 Crops

HARVST_AEZ_PRC_reshape = permute(HARVST_AEZ_PRC,[3,1,2]); % 10 crops * 6 regions * 18 AEZs 
HARVST_AEZ_PRC_NEWreshape = permute(HARVST_AEZ_PRC_NEW,[3,1,2]);
%%%%%%%%%%%%%%%%%%%Virtual Nitrogen%%%%%%%%%%%%%%%%%%%%%%%
% Original
for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Vir_AEZ(cr_ind,1:yr_dim,1:co_dim,cn,az) = squeeze(BiPsur_Vir(cr_ind,1:yr_dim,1:co_dim,cn)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
        %BiNarea_Vir_AEZ(cr_ind,1:yr_dim,1:co_dim,cn,az) = squeeze(BiNarea_Vir(cr_ind,1:yr_dim,1:co_dim,cn)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
    end
end
% 10 crops * 56 years * 6 importers * 6 exporters * 18 AEZs

%%% Adding up importing regions for each AEZ in exporter countries
Psur_Vir_AEZ_sumacrsIMP = squeeze(nansum(BiPsur_Vir_AEZ,3)); % 10 crops * 56 years * 6 exporters * 18 AEZs
%Narea_Vir_AEZ_sumacrsIMP = squeeze(nansum(BiNarea_Vir_AEZ,3));
Psur_Vir_AEZ_sumacrsIMP = permute(Psur_Vir_AEZ_sumacrsIMP,[3,4,1,2]);
Psur_Vir_AEZ_kgkm_Agg = Psur_Vir_AEZ_sumacrsIMP ./AreaH_AEZ_FAO_Agg;

%%% Calculate virtual nitrogen surplus intensity
% Psur_Vir_AEZ_kgkm = Psur_Vir_AEZ_sumacrsIMP./Narea_Vir_AEZ_sumacrsIMP;
% Psur_Vir_AEZ_kgkm = permute(Psur_Vir_AEZ_kgkm,[3,4,1,2]);

Psur_Vir_AEZ_sumacrsIMPCO = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMP,3));
%Narea_Vir_AEZ_sumacrsIMPCO = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMP,1));
%Psur_Vir_AEZ_kgkmCO = Psur_Vir_AEZ_sumacrsIMPCO./Narea_Vir_AEZ_sumacrsIMPCO;
%Psur_Vir_AEZ_kgkmCO = permute(Psur_Vir_AEZ_kgkmCO,[2,3,1]);
Psur_Vir_AEZ_kgkm_AggCO = Psur_Vir_AEZ_sumacrsIMPCO./AreaH_AEZ_FAO_AggCO;

Psur_Vir_AEZ_sumacrsIMPGB = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMPCO,1));
%Narea_Vir_AEZ_sumacrsIMPGB = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMPCO,2));
%Psur_Vir_AEZ_kgkmGB = Psur_Vir_AEZ_sumacrsIMPGB./Narea_Vir_AEZ_sumacrsIMPGB;
%Psur_Vir_AEZ_kgkmGB = permute(Psur_Vir_AEZ_kgkmGB,[2,1]);
Psur_Vir_AEZ_kgkm_AggGB = Psur_Vir_AEZ_sumacrsIMPGB./AreaH_AEZ_FAO_AggGB;


% New

for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Vir_AEZ_Exp(cr_ind,1:co_dim,cn,az) = squeeze(BiPsur_Vir_Exp(cr_ind,1,1:co_dim,cn)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
        %BiNarea_Vir_AEZ_Exp(cr_ind,1:co_dim,cn,az) = squeeze(BiNarea_Vir_Exp(cr_ind,1,1:co_dim,cn)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
    end
end
% 10 crops * 6 importers * 6 exporters * 18 AEZs

%%% Adding up importing regions for each AEZ in exporter countries
Psur_Vir_AEZ_sumacrsIMP_Exp = squeeze(nansum(BiPsur_Vir_AEZ_Exp,2)); % 10 crops * 6 exporters * 18 AEZs
%Narea_Vir_AEZ_sumacrsIMP_Exp = squeeze(nansum(BiNarea_Vir_AEZ_Exp,2));
Psur_Vir_AEZ_sumacrsIMP_Exp = permute(Psur_Vir_AEZ_sumacrsIMP_Exp,[2,3,1]);

%%% Calculate virtual nitrogen surplus intensity
%Psur_Vir_AEZ_kgkm_Exp = Psur_Vir_AEZ_sumacrsIMP_Exp./Narea_Vir_AEZ_sumacrsIMP_Exp;
%Psur_Vir_AEZ_kgkm_Exp = permute(Psur_Vir_AEZ_kgkm_Exp,[2,3,1]);
Psur_Vir_AEZ_kgkm_Exp = Psur_Vir_AEZ_sumacrsIMP_Exp ./harvst_aez_port;


Psur_Vir_AEZ_sumacrsIMP_ExpCO = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMP_Exp,3));
%Narea_Vir_AEZ_sumacrsIMP_ExpCO = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMP_Exp,1));
%Psur_Vir_AEZ_kgkm_ExpCO = Psur_Vir_AEZ_sumacrsIMP_ExpCO./Narea_Vir_AEZ_sumacrsIMP_ExpCO;
Psur_Vir_AEZ_kgkm_ExpCO = Psur_Vir_AEZ_sumacrsIMP_ExpCO ./ harvst_aez_portco;


Psur_Vir_AEZ_sumacrsIMP_ExpGB = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMP_ExpCO,1));
%Narea_Vir_AEZ_sumacrsIMP_ExpGB = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMP_ExpCO,1));
%Psur_Vir_AEZ_kgkm_ExpGB = Psur_Vir_AEZ_sumacrsIMP_ExpGB./Narea_Vir_AEZ_sumacrsIMP_ExpGB;
Psur_Vir_AEZ_kgkm_ExpGB = Psur_Vir_AEZ_sumacrsIMP_ExpGB ./ harvst_aez_portgb;
%Psur_Vir_AEZ_kgkm_ExpGB = permute(Psur_Vir_AEZ_kgkm_ExpGB,[2,1]);

% Changes
Psur_Vir_AEZ_kgkm_Delta = Psur_Vir_AEZ_kgkm_Exp - squeeze(Psur_Vir_AEZ_kgkm_Agg(:,:,:,yr_base));
Psur_Vir_AEZ_kgkm_DeltaCO = Psur_Vir_AEZ_kgkm_ExpCO - squeeze(Psur_Vir_AEZ_kgkm_AggCO(:,:,yr_base));
Psur_Vir_AEZ_kgkm_DeltaGB = Psur_Vir_AEZ_kgkm_ExpGB - squeeze(Psur_Vir_AEZ_kgkm_AggGB(:,yr_base));





%%%%%%%%%%%%%%%%%%%%%%Alternative Phosphorus%%%%%%%%%%%%%%%%%%%%%%%%%%
% Original
for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Alt_AEZ(cr_ind,1:yr_dim,cn,1:co_dim,az) = squeeze(BiPsur_Alt(cr_ind,1:yr_dim,cn,1:co_dim)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
        %BiNarea_Alt_AEZ(cr_ind,1:yr_dim,cn,1:co_dim,az) = squeeze(BiNarea_Alt(cr_ind,1:yr_dim,cn,1:co_dim)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
    end
end
% 10 crops * 56 years * 6 importers * 6 exporters * 18 AEZs

%%% Adding up exporting regions for each AEZ in importer countries
Psur_Alt_AEZ_sumacrsExpo = squeeze(nansum(BiPsur_Alt_AEZ,4)); % 10 crops * 56 years * 6 importers * 18 AEZs
%Narea_Alt_AEZ_sumacrsExpo = squeeze(nansum(BiNarea_Alt_AEZ,4));
Psur_Alt_AEZ_sumacrsExpo = permute(Psur_Alt_AEZ_sumacrsExpo,[3,4,1,2]);

%%% Calculate virtual nitrogen surplus intensity
%Psur_Alt_AEZ_kgkm = Psur_Alt_AEZ_sumacrsExpo./Narea_Alt_AEZ_sumacrsExpo;
Psur_Alt_AEZ_kgkm_Agg = Psur_Alt_AEZ_sumacrsExpo ./AreaH_AEZ_FAO_Agg;
%Psur_Alt_AEZ_kgkm = permute(Psur_Alt_AEZ_kgkm,[3,4,1,2]);

Psur_Alt_AEZ_sumacrsExpoCO = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpo,3));
%Narea_Alt_AEZ_sumacrsExpoCO = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpo,1));
%Psur_Alt_AEZ_kgkmCO = Psur_Alt_AEZ_sumacrsExpoCO ./Narea_Alt_AEZ_sumacrsExpoCO;
Psur_Alt_AEZ_kgkm_AggCO = Psur_Alt_AEZ_sumacrsExpoCO ./AreaH_AEZ_FAO_AggCO;
%Psur_Alt_AEZ_kgkmCO = permute(Psur_Alt_AEZ_kgkmCO,[2,3,1]);

Psur_Alt_AEZ_sumacrsExpoGB = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpoCO,1));
%Narea_Alt_AEZ_sumacrsExpoGB = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpoCO,2));
Psur_Alt_AEZ_kgkm_AggGB = Psur_Alt_AEZ_sumacrsExpoGB./AreaH_AEZ_FAO_AggGB;
%Psur_Alt_AEZ_kgkmGB = Psur_Alt_AEZ_sumacrsExpoGB./Narea_Alt_AEZ_sumacrsExpoGB;
%Psur_Alt_AEZ_kgkmGB = permute(Psur_Alt_AEZ_kgkmGB,[2,1]);

% New
for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Alt_AEZ_Exp(cr_ind,cn,1:co_dim,az) = squeeze(BiPsur_Alt_Exp(cr_ind,1,cn,1:co_dim)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
        %BiNarea_Alt_AEZ_Exp(cr_ind,cn,1:co_dim,az) = squeeze(BiNarea_Alt_Exp(cr_ind,1,cn,1:co_dim)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
    end
end
% 10 crops * 6 importers * 6 exporters * 18 AEZs

%%% Adding up exporting regions for each AEZ in importer countries
Psur_Alt_AEZ_sumacrsExpo_Exp = squeeze(nansum(BiPsur_Alt_AEZ_Exp,3)); % 10 crops * 6 importers * 18 AEZs
%Narea_Alt_AEZ_sumacrsExpo_Exp = squeeze(nansum(BiNarea_Alt_AEZ_Exp,3));
Psur_Alt_AEZ_sumacrsExpo_Exp = permute(Psur_Alt_AEZ_sumacrsExpo_Exp,[2,3,1]);
%%% Calculate alternative nitrogen surplus intensity
%Psur_Alt_AEZ_kgkm_Exp = Psur_Alt_AEZ_sumacrsExpo_Exp./Narea_Alt_AEZ_sumacrsExpo_Exp;
%Psur_Alt_AEZ_kgkm_Exp = permute(Psur_Alt_AEZ_kgkm_Exp,[2,3,1]);
Psur_Alt_AEZ_kgkm_Exp = Psur_Alt_AEZ_sumacrsExpo_Exp./harvst_aez_port;


Psur_Alt_AEZ_sumacrsExpo_ExpCO = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpo_Exp,3));
%Narea_Alt_AEZ_sumacrsExpo_ExpCO = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpo_Exp,1));
%Psur_Alt_AEZ_kgkm_ExpCO = Psur_Alt_AEZ_sumacrsExpo_ExpCO./Narea_Alt_AEZ_sumacrsExpo_ExpCO;
Psur_Alt_AEZ_kgkm_ExpCO = Psur_Alt_AEZ_sumacrsExpo_ExpCO./harvst_aez_portco;

Psur_Alt_AEZ_sumacrsExpo_ExpGB = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpo_ExpCO,1));
%Narea_Alt_AEZ_sumacrsExpo_ExpGB = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpo_ExpCO,1));
%Psur_Alt_AEZ_kgkm_ExpGB = Psur_Alt_AEZ_sumacrsExpo_ExpGB./Narea_Alt_AEZ_sumacrsExpo_ExpGB;
%Psur_Alt_AEZ_kgkm_ExpGB = permute(Psur_Alt_AEZ_kgkm_ExpGB,[2,1]);
Psur_Alt_AEZ_kgkm_ExpGB = Psur_Alt_AEZ_sumacrsExpo_ExpGB./harvst_aez_portgb;

% Changes
Psur_Alt_AEZ_kgkm_Delta = Psur_Alt_AEZ_kgkm_Exp - squeeze(Psur_Alt_AEZ_kgkm_Agg(:,:,:,yr_base));
Psur_Alt_AEZ_kgkm_DeltaCO = Psur_Alt_AEZ_kgkm_ExpCO - squeeze(Psur_Alt_AEZ_kgkm_AggCO(:,:,yr_base));
Psur_Alt_AEZ_kgkm_DeltaGB = Psur_Alt_AEZ_kgkm_ExpGB - squeeze(Psur_Alt_AEZ_kgkm_AggGB(:,yr_base));





