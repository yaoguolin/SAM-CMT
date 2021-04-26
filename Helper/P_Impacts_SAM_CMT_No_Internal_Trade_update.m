
P_FILE = 'basic_P_SAM2.mat'; 
load([dir 'Inputs' dir_s P_FILE]); 

%%% Generate Data: if year 2015 and 2016 don't have data, keep it the same
%%% with the most recent year's data

Pyield_kgkm = Var_Generate_Data(Pyield_kgkm);
Pinput_kgkm = Var_Generate_Data(Pinput_kgkm);

%       3.1 Phosphorus Calculation

%%% The calculation is based raw data
Psur_kgkm = Pinput_kgkm - Pyield_kgkm;

%%% We only use the data that Psur_kgkm > 0, we assign a 0 when Psur_kgkm < 0
% Psur_kgkm_G0 = Psur_kgkm; % Psur_kgkm_G0 is Psur_kgkm greater than 0

% Psur_kgkm_G0(Psur_kgkm_G0<0) = 0;
% Psur_kg_G0 = Psur_kgkm_G0 .* AreaH_FAO; 
%%% There is no problem so far. Be careful when multiply AreaH_FAO_Agg

%       3.2 Phosphorus aggregation in original settings


[Phos.Pinput.Pinput_kgkm_Agg, Phos.Pinput.Pinput_kgkm_AggCO,Phos.Pinput.Pinput_kgkm_AggGB,...
 Phos.Pinput.Pinput_kg_Agg, Phos.Pinput.Pinput_kg_AggCO,Phos.Pinput.Pinput_kg_AggGB]...
    = ProdAggVar_Sum_update(Pinput_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Phos.Pyield.Pyield_kgkm_Agg, Phos.Pyield.Pyield_kgkm_AggCO,Phos.Pyield.Pyield_kgkm_AggGB,...
 Phos.Pyield.Pyield_kg_Agg, Phos.Pyield.Pyield_kg_AggCO,Phos.Pyield.Pyield_kg_AggGB]...
    = ProdAggVar_Sum_update(Pyield_kgkm,AreaH_FAO,MAPPING,cr_ind);

Phos.Psur.Psur_kgkm_Agg = Phos.Pinput.Pinput_kgkm_Agg - Phos.Pyield.Pyield_kgkm_Agg;
Phos.Psur.Psur_kgkm_Agg(Phos.Psur.Psur_kgkm_Agg<0) = 0;

Phos.Psur.Psur_kg_Agg = Phos.Psur.Psur_kgkm_Agg .* Portf.Area.AreaH_FAO_Agg;
Phos.Psur.Psur_kg_AggCO = squeeze(nansum(Phos.Psur.Psur_kg_Agg,2));
Phos.Psur.Psur_kg_AggGB = nansum(Phos.Psur.Psur_kg_AggCO,1);

Phos.Psur.Psur_kgkm_AggCO = Phos.Psur.Psur_kg_AggCO ./ Portf.Area.AreaH_FAO_AggCO;
Phos.Psur.Psur_kgkm_AggGB = Phos.Psur.Psur_kg_AggGB ./ Portf.Area.AreaH_FAO_AggGB;

%{
[Phos.Psur.Psur_kgkm_Agg, Phos.Psur.Psur_kgkm_AggCO,Phos.Psur.Psur_kgkm_AggGB,...
 Phos.Psur.Psur_kg_Agg, Phos.Psur.Psur_kg_AggCO,Phos.Psur.Psur_kg_AggGB,AA3]...
    = ProdAggVar_Sum_update(Psur_kgkm,AreaH_FAO,MAPPING,cr_ind);
%}

Phos.PUE.PUE_Agg = Phos.Pyield.Pyield_kgkm_Agg ./ Phos.Pinput.Pinput_kgkm_Agg;
Phos.PUE.PUE_AggCO = Phos.Pyield.Pyield_kgkm_AggCO ./ Phos.Pinput.Pinput_kgkm_AggCO;
Phos.PUE.PUE_AggGB = Phos.Pyield.Pyield_kgkm_AggGB ./ Phos.Pinput.Pinput_kgkm_AggGB;


%%% Phosphorus content aggregation
contentN_Agg = Var_Agg_WGT(contentN,Product_FAO,MAPPING); % OK so far
contentN_Agg = contentN_Agg(:,cr_ind,:);

%       3.3 Phosphorus aggregation with the experiment
[Phos.Pinput.Pinput_kgkm_Exp,Phos.Pinput.Pinput_kgkm_ExpCO,Phos.Pinput.Pinput_kgkm_ExpGB,...
 Phos.Pinput.Pinput_kg_Exp, Phos.Pinput.Pinput_kg_ExpCO,Phos.Pinput.Pinput_kg_ExpGB]...
    = ProdAggVar_SumExp_update(Phos.Pinput.Pinput_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Phos.Pyield.Pyield_kgkm_Exp,Phos.Pyield.Pyield_kgkm_ExpCO,Phos.Pyield.Pyield_kgkm_ExpGB,...
 Phos.Pyield.Pyield_kg_Exp, Phos.Pyield.Pyield_kg_ExpCO,Phos.Pyield.Pyield_kg_ExpGB]...
    = ProdAggVar_SumExp_update(Phos.Pyield.Pyield_kgkm_Agg,harvst_port,yr_base,cr_ind);

Phos.Psur.Psur_kgkm_Exp = Phos.Pinput.Pinput_kgkm_Exp - Phos.Pyield.Pyield_kgkm_Exp;
Phos.Psur.Psur_kgkm_Exp(Phos.Psur.Psur_kgkm_Exp<0) = 0;

Phos.Psur.Psur_kg_Exp = Phos.Psur.Psur_kgkm_Exp .* Portf.Area.harvst_port;
Phos.Psur.Psur_kg_ExpCO = squeeze(nansum(Phos.Psur.Psur_kg_Exp,2));
Phos.Psur.Psur_kg_ExpGB = nansum(Phos.Psur.Psur_kg_ExpCO,1);

Phos.Psur.Psur_kgkm_ExpCO = Phos.Psur.Psur_kg_ExpCO ./ Portf.Area.harvst_portco;
Phos.Psur.Psur_kgkm_ExpGB = Phos.Psur.Psur_kg_ExpGB ./ Portf.Area.harvst_portgb;

%{
[Psur_kgkm_Exp,Psur_kgkm_ExpCO,Psur_kgkm_ExpGB,...
 Psur_kg_Exp, Psur_kg_ExpCO,Psur_kg_ExpGB]...
    = ProdAggVar_SumExp_update(Phos.Psur.Psur_kgkm_Agg,harvst_port,yr_base,cr_ind);
%}

Phos.PUE.PUE_ExpCO = Phos.Pyield.Pyield_kgkm_ExpCO ./ Phos.Pinput.Pinput_kgkm_ExpCO;
Phos.PUE.PUE_ExpGB = Phos.Pyield.Pyield_kgkm_ExpGB ./ Phos.Pinput.Pinput_kgkm_ExpGB;

%       3.4 Phosphorus impact changes
%%% N input
Phos.Pinput.Pinput_kg_Delta = Phos.Pinput.Pinput_kgkm_Agg(:,:,yr_base) .* Portf.Area.harvst_delta; %*****
Phos.Pinput.Pinput_kg_DeltaCO = nansum(Phos.Pinput.Pinput_kg_Delta,2);%*****
Phos.Pinput.Pinput_kg_DeltaGB =  nansum(Phos.Pinput.Pinput_kg_DeltaCO);%*****

Phos.Pinput.Pinput_kgkm_Delta = Phos.Pinput.Pinput_kgkm_Exp - Phos.Pinput.Pinput_kgkm_Agg(:,:,yr_base); %*****
Phos.Pinput.Pinput_kgkm_DeltaCO = Phos.Pinput.Pinput_kgkm_ExpCO - Phos.Pinput.Pinput_kgkm_AggCO(:,yr_base); %*****
Phos.Pinput.Pinput_kgkm_DeltaGB = Phos.Pinput.Pinput_kgkm_ExpGB - Phos.Pinput.Pinput_kgkm_AggGB(yr_base); %*****

%%% N yield
Phos.Pyield.Pyield_kg_Delta = Phos.Pyield.Pyield_kgkm_Agg(:,:,yr_base) .* Portf.Area.harvst_delta; %*****
Phos.Pyield.Pyield_kg_DeltaCO = nansum(Phos.Pyield.Pyield_kg_Delta,2);%*****
Phos.Pyield.Pyield_kg_DeltaGB =  nansum(Phos.Pyield.Pyield_kg_DeltaCO);%*****

Phos.Pyield.Pyield_kgkm_Delta = Phos.Pyield.Pyield_kgkm_Exp - Phos.Pyield.Pyield_kgkm_Agg(:,:,yr_base); %*****
Phos.Pyield.Pyield_kgkm_DeltaCO = Phos.Pyield.Pyield_kgkm_ExpCO - Phos.Pyield.Pyield_kgkm_AggCO(:,yr_base); %*****
Phos.Pyield.Pyield_kgkm_DeltaGB = Phos.Pyield.Pyield_kgkm_ExpGB - Phos.Pyield.Pyield_kgkm_AggGB(yr_base); %*****

%%% N surplus
Phos.Psur.Psur_kg_Delta = Phos.Psur.Psur_kgkm_Agg(:,:,yr_base) .* Portf.Area.harvst_delta; %*****
Phos.Psur.Psur_kg_DeltaCO = nansum(Phos.Psur.Psur_kg_Delta,2); %*****
Phos.Psur.Psur_kg_DeltaGB = nansum(Phos.Psur.Psur_kg_DeltaCO); %*****

Phos.Psur.Psur_kgkm_Delta = Phos.Psur.Psur_kgkm_Exp - Phos.Psur.Psur_kgkm_Agg(:,:,yr_base); %*****
Phos.Psur.Psur_kgkm_DeltaCO = Phos.Psur.Psur_kgkm_ExpCO - Phos.Psur.Psur_kgkm_AggCO(:,yr_base); %*****
Phos.Psur.Psur_kgkm_DeltaGB = Phos.Psur.Psur_kgkm_ExpGB - Phos.Psur.Psur_kgkm_AggGB(yr_base); %*****

%%% PUE
Phos.PUE.PUE_DeltaCO = Phos.PUE.PUE_ExpCO - Phos.PUE.PUE_AggCO(:,yr_base); 
Phos.PUE.PUE_DeltaGB = Phos.PUE.PUE_ExpGB - Phos.PUE.PUE_AggGB(yr_base);

%{
%        3.5 Virtual and alternative nitrogen
%%% Generate ImTrdQnt_Agg
ImTrdQnt_Agg_NoInternal = ImTrdQnt_Agg;
trade_port_NoInternal = trade_port;

for cn = 1:1:6
    ImTrdQnt_Agg_NoInternal(:,:,cn,cn) = 0;
    trade_port_NoInternal(:,:,cn,cn) = 0;
end

% Original
[Parea_Vir,Psur_Vir,Pinput_Vir,Parea_Alt,Psur_Alt,Pinput_Alt,contentNTrd_Agg,...
 BiParea_Vir,BiPsur_Vir,BiPinput_Vir,...
 BiParea_Alt,BiPsur_Alt,BiPinput_Alt,...
 Parea_Vir_CO,Psur_Vir_CO,Pinput_Vir_CO, Parea_Alt_CO, Psur_Alt_CO, Pinput_Alt_CO,...
 Parea_Vir_GB,Psur_Vir_GB,Pinput_Vir_GB, Parea_Alt_GB, Psur_Alt_GB, Pinput_Alt_GB] ...
 = Nutr_VirtAlt(contentN_Agg,ImTrdQnt_Agg_NoInternal,Yield_FAO_Agg,Pyield_kgkm_Agg, ...
 Psur_kgkm_Agg, Pinput_kgkm_Agg, uniYrs);

% New
[Parea_Vir_Exp,Psur_Vir_Exp,Pinput_Vir_Exp,Parea_Alt_Exp,Psur_Alt_Exp,Pinput_Alt_Exp,contentNTrd_Exp,...
 BiParea_Vir_Exp,BiPsur_Vir_Exp,BiPinput_Vir_Exp,...
 BiParea_Alt_Exp,BiPsur_Alt_Exp,BiPinput_Alt_Exp,...
 Parea_Vir_ExpCO,Psur_Vir_ExpCO,Pinput_Vir_ExpCO, Parea_Alt_ExpCO, Psur_Alt_ExpCO, Pinput_Alt_ExpCO,...
 Parea_Vir_ExpGB,Psur_Vir_ExpGB,Pinput_Vir_ExpGB, Parea_Alt_ExpGB, Psur_Alt_ExpGB, Pinput_Alt_ExpGB] ...
    = Nutr_VirtAlt(contentN_Agg,trade_port_NoInternal,yield_port,Pyield_kgkm_Agg, ...
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
% Orginal
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

%}

%       3.5 Phosphorus AEZ changes

%%% Disaggregated
% Original
Phos.AEZ.Psur_kg_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;

for az = 1:1:18
    Phos.AEZ.Psur_kg_AEZ_Agg(:,az,:,:) = squeeze(Phos.Psur.Psur_kgkm_Agg(:,:,:)) .* squeeze(Portf.AEZ.AreaH_AEZ_FAO_Agg(:,az,:,:));
end

Phos.AEZ.Psur_kgkm_AEZ_Agg = Phos.AEZ.Psur_kg_AEZ_Agg ./ Portf.AEZ.AreaH_AEZ_FAO_Agg;

Portf.AEZ.harvst_aez_port = Portf.AEZ.harvst_aez_port(:,:,cr_ind);

% New
Phos.AEZ.Psur_kg_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    Phos.AEZ.Psur_kg_AEZ_Exp(:,az,:) = squeeze(Phos.Psur.Psur_kgkm_Agg(:,:,yr_base)) .* squeeze(Portf.AEZ.harvst_aez_port(:,az,:));
end

Phos.AEZ.Psur_kgkm_AEZ_Exp = Phos.AEZ.Psur_kg_AEZ_Exp ./Portf.AEZ.harvst_aez_port;

% Changes
Phos.AEZ.Psur_kg_AEZ_Delta = Phos.AEZ.Psur_kg_AEZ_Exp - Phos.AEZ.Psur_kg_AEZ_Agg(:,:,:,yr_base);

Phos.AEZ.Psur_kgkm_AEZ_Delta = Phos.AEZ.Psur_kgkm_AEZ_Exp - Phos.AEZ.Psur_kgkm_AEZ_Agg(:,:,:,yr_base);

%%% National Level
Phos.AEZ.Psur_kg_AEZ_AggCO = squeeze(nansum(Phos.AEZ.Psur_kg_AEZ_Agg,3));
Phos.AEZ.Psur_kg_AEZ_ExpCO = squeeze(nansum(Phos.AEZ.Psur_kg_AEZ_Exp,3));
Phos.AEZ.Psur_kg_AEZ_DeltaCO = squeeze(nansum(Phos.AEZ.Psur_kg_AEZ_Delta,3));

Phos.AEZ.Psur_kgkm_AEZ_AggCO = Phos.AEZ.Psur_kg_AEZ_AggCO ./Portf.AEZ.AreaH_AEZ_FAO_AggCO; 
Phos.AEZ.Psur_kgkm_AEZ_ExpCO = Phos.AEZ.Psur_kg_AEZ_ExpCO ./Portf.AEZ.harvst_aez_portco;
Phos.AEZ.Psur_kgkm_AEZ_DeltaCO = Phos.AEZ.Psur_kgkm_AEZ_ExpCO - Phos.AEZ.Psur_kgkm_AEZ_AggCO(:,:,yr_base);

%%% Global Level
Phos.AEZ.Psur_kg_AEZ_AggGB = squeeze(nansum(Phos.AEZ.Psur_kg_AEZ_AggCO,1));
Phos.AEZ.Psur_kg_AEZ_ExpGB = squeeze(nansum(Phos.AEZ.Psur_kg_AEZ_ExpCO,1));
Phos.AEZ.Psur_kg_AEZ_DeltaGB = squeeze(nansum(Phos.AEZ.Psur_kg_AEZ_DeltaCO,1));

Phos.AEZ.Psur_kgkm_AEZ_AggGB = Phos.AEZ.Psur_kg_AEZ_AggGB ./Portf.AEZ.AreaH_AEZ_FAO_AggGB;
Phos.AEZ.Psur_kgkm_AEZ_ExpGB = Phos.AEZ.Psur_kg_AEZ_ExpGB ./Portf.AEZ.harvst_aez_portgb;
Phos.AEZ.Psur_kgkm_AEZ_DeltaGB = Phos.AEZ.Psur_kgkm_AEZ_ExpGB - Phos.AEZ.Psur_kgkm_AEZ_AggGB(:,yr_base);

%{
%%% Virtual and Alternative Phosphorus AEZ changes
% Bilateral Virtual: 10 crops * 56 years * 6 importers * 6 exporters
% HARVST_AEZ_PRC: 6 producers (exporters) * 18 AEZs * 10 Crops

HARVST_AEZ_PRC_reshape = permute(HARVST_AEZ_PRC,[3,1,2]); % 10 crops * 6 regions * 18 AEZs 
HARVST_AEZ_PRC_NEWreshape = permute(HARVST_AEZ_PRC_NEW,[3,1,2]);
%%%%%%%%%%%%%%%%%%%Virtual Phosphorus%%%%%%%%%%%%%%%%%%%%%%%
% Original
for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Vir_AEZ(cr_ind,1:yr_dim,1:co_dim,cn,az) = squeeze(BiPsur_Vir(cr_ind,1:yr_dim,1:co_dim,cn)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
        %BiParea_Vir_AEZ(cr_ind,1:yr_dim,1:co_dim,cn,az) = squeeze(BiParea_Vir(cr_ind,1:yr_dim,1:co_dim,cn)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
    end
end
% 10 crops * 56 years * 6 importers * 6 exporters * 18 AEZs

%%% Adding up importing regions for each AEZ in exporter countries
Psur_Vir_AEZ_sumacrsIMP = squeeze(nansum(BiPsur_Vir_AEZ,3)); % 10 crops * 56 years * 6 exporters * 18 AEZs
%Parea_Vir_AEZ_sumacrsIMP = squeeze(nansum(BiParea_Vir_AEZ,3));
Psur_Vir_AEZ_sumacrsIMP = permute(Psur_Vir_AEZ_sumacrsIMP,[3,4,1,2]);
Psur_Vir_AEZ_kgkm_Agg = Psur_Vir_AEZ_sumacrsIMP ./AreaH_AEZ_FAO_Agg;

%%% Calculate virtual nitrogen surplus intensity
% Psur_Vir_AEZ_kgkm = Psur_Vir_AEZ_sumacrsIMP./Parea_Vir_AEZ_sumacrsIMP;
% Psur_Vir_AEZ_kgkm = permute(Psur_Vir_AEZ_kgkm,[3,4,1,2]);

Psur_Vir_AEZ_sumacrsIMPCO = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMP,3));
%Parea_Vir_AEZ_sumacrsIMPCO = squeeze(nansum(Parea_Vir_AEZ_sumacrsIMP,1));
%Psur_Vir_AEZ_kgkmCO = Psur_Vir_AEZ_sumacrsIMPCO./Parea_Vir_AEZ_sumacrsIMPCO;
%Psur_Vir_AEZ_kgkmCO = permute(Psur_Vir_AEZ_kgkmCO,[2,3,1]);
Psur_Vir_AEZ_kgkm_AggCO = Psur_Vir_AEZ_sumacrsIMPCO./AreaH_AEZ_FAO_AggCO;

Psur_Vir_AEZ_sumacrsIMPGB = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMPCO,1));
%Parea_Vir_AEZ_sumacrsIMPGB = squeeze(nansum(Parea_Vir_AEZ_sumacrsIMPCO,2));
%Psur_Vir_AEZ_kgkmGB = Psur_Vir_AEZ_sumacrsIMPGB./Parea_Vir_AEZ_sumacrsIMPGB;
%Psur_Vir_AEZ_kgkmGB = permute(Psur_Vir_AEZ_kgkmGB,[2,1]);
Psur_Vir_AEZ_kgkm_AggGB = Psur_Vir_AEZ_sumacrsIMPGB./AreaH_AEZ_FAO_AggGB;


% New

for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Vir_AEZ_Exp(cr_ind,1:co_dim,cn,az) = squeeze(BiPsur_Vir_Exp(cr_ind,1,1:co_dim,cn)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
        %BiParea_Vir_AEZ_Exp(cr_ind,1:co_dim,cn,az) = squeeze(BiParea_Vir_Exp(cr_ind,1,1:co_dim,cn)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
    end
end
% 10 crops * 6 importers * 6 exporters * 18 AEZs

%%% Adding up importing regions for each AEZ in exporter countries
Psur_Vir_AEZ_sumacrsIMP_Exp = squeeze(nansum(BiPsur_Vir_AEZ_Exp,2)); % 10 crops * 6 exporters * 18 AEZs
%Parea_Vir_AEZ_sumacrsIMP_Exp = squeeze(nansum(BiParea_Vir_AEZ_Exp,2));
Psur_Vir_AEZ_sumacrsIMP_Exp = permute(Psur_Vir_AEZ_sumacrsIMP_Exp,[2,3,1]);

%%% Calculate virtual nitrogen surplus intensity
%Psur_Vir_AEZ_kgkm_Exp = Psur_Vir_AEZ_sumacrsIMP_Exp./Parea_Vir_AEZ_sumacrsIMP_Exp;
%Psur_Vir_AEZ_kgkm_Exp = permute(Psur_Vir_AEZ_kgkm_Exp,[2,3,1]);
Psur_Vir_AEZ_kgkm_Exp = Psur_Vir_AEZ_sumacrsIMP_Exp ./harvst_aez_port;


Psur_Vir_AEZ_sumacrsIMP_ExpCO = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMP_Exp,3));
%Parea_Vir_AEZ_sumacrsIMP_ExpCO = squeeze(nansum(Parea_Vir_AEZ_sumacrsIMP_Exp,1));
%Psur_Vir_AEZ_kgkm_ExpCO = Psur_Vir_AEZ_sumacrsIMP_ExpCO./Parea_Vir_AEZ_sumacrsIMP_ExpCO;
Psur_Vir_AEZ_kgkm_ExpCO = Psur_Vir_AEZ_sumacrsIMP_ExpCO ./ harvst_aez_portco;


Psur_Vir_AEZ_sumacrsIMP_ExpGB = squeeze(nansum(Psur_Vir_AEZ_sumacrsIMP_ExpCO,1));
%Parea_Vir_AEZ_sumacrsIMP_ExpGB = squeeze(nansum(Parea_Vir_AEZ_sumacrsIMP_ExpCO,1));
%Psur_Vir_AEZ_kgkm_ExpGB = Psur_Vir_AEZ_sumacrsIMP_ExpGB./Parea_Vir_AEZ_sumacrsIMP_ExpGB;
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
        %BiParea_Alt_AEZ(cr_ind,1:yr_dim,cn,1:co_dim,az) = squeeze(BiParea_Alt(cr_ind,1:yr_dim,cn,1:co_dim)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
    end
end
% 10 crops * 56 years * 6 importers * 6 exporters * 18 AEZs

%%% Adding up exporting regions for each AEZ in importer countries
Psur_Alt_AEZ_sumacrsExpo = squeeze(nansum(BiPsur_Alt_AEZ,4)); % 10 crops * 56 years * 6 importers * 18 AEZs
%Parea_Alt_AEZ_sumacrsExpo = squeeze(nansum(BiParea_Alt_AEZ,4));
Psur_Alt_AEZ_sumacrsExpo = permute(Psur_Alt_AEZ_sumacrsExpo,[3,4,1,2]);

%%% Calculate virtual nitrogen surplus intensity
%Psur_Alt_AEZ_kgkm = Psur_Alt_AEZ_sumacrsExpo./Parea_Alt_AEZ_sumacrsExpo;
Psur_Alt_AEZ_kgkm_Agg = Psur_Alt_AEZ_sumacrsExpo ./AreaH_AEZ_FAO_Agg;
%Psur_Alt_AEZ_kgkm = permute(Psur_Alt_AEZ_kgkm,[3,4,1,2]);

Psur_Alt_AEZ_sumacrsExpoCO = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpo,3));
%Parea_Alt_AEZ_sumacrsExpoCO = squeeze(nansum(Parea_Alt_AEZ_sumacrsExpo,1));
%Psur_Alt_AEZ_kgkmCO = Psur_Alt_AEZ_sumacrsExpoCO ./Parea_Alt_AEZ_sumacrsExpoCO;
Psur_Alt_AEZ_kgkm_AggCO = Psur_Alt_AEZ_sumacrsExpoCO ./AreaH_AEZ_FAO_AggCO;
%Psur_Alt_AEZ_kgkmCO = permute(Psur_Alt_AEZ_kgkmCO,[2,3,1]);

Psur_Alt_AEZ_sumacrsExpoGB = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpoCO,1));
%Parea_Alt_AEZ_sumacrsExpoGB = squeeze(nansum(Parea_Alt_AEZ_sumacrsExpoCO,2));
Psur_Alt_AEZ_kgkm_AggGB = Psur_Alt_AEZ_sumacrsExpoGB./AreaH_AEZ_FAO_AggGB;
%Psur_Alt_AEZ_kgkmGB = Psur_Alt_AEZ_sumacrsExpoGB./Parea_Alt_AEZ_sumacrsExpoGB;
%Psur_Alt_AEZ_kgkmGB = permute(Psur_Alt_AEZ_kgkmGB,[2,1]);

% New
for cn = 1:1:6
    for az = 1:1:18
        BiPsur_Alt_AEZ_Exp(cr_ind,cn,1:co_dim,az) = squeeze(BiPsur_Alt_Exp(cr_ind,1,cn,1:co_dim)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
        %BiParea_Alt_AEZ_Exp(cr_ind,cn,1:co_dim,az) = squeeze(BiParea_Alt_Exp(cr_ind,1,cn,1:co_dim)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
    end
end
% 10 crops * 6 importers * 6 exporters * 18 AEZs

%%% Adding up exporting regions for each AEZ in importer countries
Psur_Alt_AEZ_sumacrsExpo_Exp = squeeze(nansum(BiPsur_Alt_AEZ_Exp,3)); % 10 crops * 6 importers * 18 AEZs
%Parea_Alt_AEZ_sumacrsExpo_Exp = squeeze(nansum(BiParea_Alt_AEZ_Exp,3));
Psur_Alt_AEZ_sumacrsExpo_Exp = permute(Psur_Alt_AEZ_sumacrsExpo_Exp,[2,3,1]);
%%% Calculate alternative nitrogen surplus intensity
%Psur_Alt_AEZ_kgkm_Exp = Psur_Alt_AEZ_sumacrsExpo_Exp./Parea_Alt_AEZ_sumacrsExpo_Exp;
%Psur_Alt_AEZ_kgkm_Exp = permute(Psur_Alt_AEZ_kgkm_Exp,[2,3,1]);
Psur_Alt_AEZ_kgkm_Exp = Psur_Alt_AEZ_sumacrsExpo_Exp./harvst_aez_port;


Psur_Alt_AEZ_sumacrsExpo_ExpCO = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpo_Exp,3));
%Parea_Alt_AEZ_sumacrsExpo_ExpCO = squeeze(nansum(Parea_Alt_AEZ_sumacrsExpo_Exp,1));
%Psur_Alt_AEZ_kgkm_ExpCO = Psur_Alt_AEZ_sumacrsExpo_ExpCO./Parea_Alt_AEZ_sumacrsExpo_ExpCO;
Psur_Alt_AEZ_kgkm_ExpCO = Psur_Alt_AEZ_sumacrsExpo_ExpCO./harvst_aez_portco;

Psur_Alt_AEZ_sumacrsExpo_ExpGB = squeeze(nansum(Psur_Alt_AEZ_sumacrsExpo_ExpCO,1));
%Parea_Alt_AEZ_sumacrsExpo_ExpGB = squeeze(nansum(Parea_Alt_AEZ_sumacrsExpo_ExpCO,1));
%Psur_Alt_AEZ_kgkm_ExpGB = Psur_Alt_AEZ_sumacrsExpo_ExpGB./Parea_Alt_AEZ_sumacrsExpo_ExpGB;
%Psur_Alt_AEZ_kgkm_ExpGB = permute(Psur_Alt_AEZ_kgkm_ExpGB,[2,1]);
Psur_Alt_AEZ_kgkm_ExpGB = Psur_Alt_AEZ_sumacrsExpo_ExpGB./harvst_aez_portgb;

% Changes
Psur_Alt_AEZ_kgkm_Delta = Psur_Alt_AEZ_kgkm_Exp - squeeze(Psur_Alt_AEZ_kgkm_Agg(:,:,:,yr_base));
Psur_Alt_AEZ_kgkm_DeltaCO = Psur_Alt_AEZ_kgkm_ExpCO - squeeze(Psur_Alt_AEZ_kgkm_AggCO(:,:,yr_base));
Psur_Alt_AEZ_kgkm_DeltaGB = Psur_Alt_AEZ_kgkm_ExpGB - squeeze(Psur_Alt_AEZ_kgkm_AggGB(:,yr_base));
%}
