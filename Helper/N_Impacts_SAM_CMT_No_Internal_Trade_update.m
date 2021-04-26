
N_FILE = 'basic_N_SAM.mat'; 
load([dir 'Inputs' dir_s N_FILE]); 

%%% Generate Data: if year 2015 and 2016 don't have data, keep it the same
%%% with the most recent year's data
Nfer_kgkm = Var_Generate_Data(Nfer_kgkm);
Nman_kgkm = Var_Generate_Data(Nman_kgkm);
Nyield_kgkm = Var_Generate_Data(Nyield_kgkm);
Ndep_kgkm = Var_Generate_Data(Ndep_kgkm);

%       3.1 Nitrogen Calculation

%%% The calculation is based raw data
Ninput_kgkm =  Nfer_kgkm + Nman_kgkm + Nfix_kgkm + Ndep_kgkm;
Nsur_kgkm = Ninput_kgkm - Nyield_kgkm;

%%% We only use the data that Nsur_kgkm > 0, we assign a 0 when Nsur_kgkm < 0
% Nsur_kgkm_G0 = Nsur_kgkm; % Nsur_kgkm_G0 is Nsur_kgkm greater than 0

% Nsur_kgkm_G0(Nsur_kgkm_G0<0) = 0;
% Nsur_kg_G0 = Nsur_kgkm_G0 .* AreaH_FAO; 
%%% There is no problem so far. Be careful when multiply AreaH_FAO_Agg

%       3.2 Nitrogen aggregation in original settings


[Nitr.Ninput.Ninput_kgkm_Agg, Nitr.Ninput.Ninput_kgkm_AggCO,Nitr.Ninput.Ninput_kgkm_AggGB,...
 Nitr.Ninput.Ninput_kg_Agg, Nitr.Ninput.Ninput_kg_AggCO,Nitr.Ninput.Ninput_kg_AggGB]...
    = ProdAggVar_Sum_update(Ninput_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Nitr.Nyield.Nyield_kgkm_Agg, Nitr.Nyield.Nyield_kgkm_AggCO,Nitr.Nyield.Nyield_kgkm_AggGB,...
 Nitr.Nyield.Nyield_kg_Agg, Nitr.Nyield.Nyield_kg_AggCO,Nitr.Nyield.Nyield_kg_AggGB]...
    = ProdAggVar_Sum_update(Nyield_kgkm,AreaH_FAO,MAPPING,cr_ind);

Nitr.Nsur.Nsur_kgkm_Agg = Nitr.Ninput.Ninput_kgkm_Agg - Nitr.Nyield.Nyield_kgkm_Agg;
Nitr.Nsur.Nsur_kgkm_Agg(Nitr.Nsur.Nsur_kgkm_Agg<0) = 0;

Nitr.Nsur.Nsur_kg_Agg = Nitr.Nsur.Nsur_kgkm_Agg .* Portf.Area.AreaH_FAO_Agg;
Nitr.Nsur.Nsur_kg_AggCO = squeeze(nansum(Nitr.Nsur.Nsur_kg_Agg,2));
Nitr.Nsur.Nsur_kg_AggGB = nansum(Nitr.Nsur.Nsur_kg_AggCO,1);

Nitr.Nsur.Nsur_kgkm_AggCO = Nitr.Nsur.Nsur_kg_AggCO ./ Portf.Area.AreaH_FAO_AggCO;
Nitr.Nsur.Nsur_kgkm_AggGB = Nitr.Nsur.Nsur_kg_AggGB ./ Portf.Area.AreaH_FAO_AggGB;

%{
[Nitr.Nsur.Nsur_kgkm_Agg, Nitr.Nsur.Nsur_kgkm_AggCO,Nitr.Nsur.Nsur_kgkm_AggGB,...
 Nitr.Nsur.Nsur_kg_Agg, Nitr.Nsur.Nsur_kg_AggCO,Nitr.Nsur.Nsur_kg_AggGB,AA3]...
    = ProdAggVar_Sum_update(Nsur_kgkm,AreaH_FAO,MAPPING,cr_ind);
%}

Nitr.NUE.NUE_Agg = Nitr.Nyield.Nyield_kgkm_Agg ./ Nitr.Ninput.Ninput_kgkm_Agg;
Nitr.NUE.NUE_AggCO = Nitr.Nyield.Nyield_kgkm_AggCO ./ Nitr.Ninput.Ninput_kgkm_AggCO;
Nitr.NUE.NUE_AggGB = Nitr.Nyield.Nyield_kgkm_AggGB ./ Nitr.Ninput.Ninput_kgkm_AggGB;


%%% Nitrogen content aggregation
contentN_Agg = Var_Agg_WGT(contentN,Product_FAO,MAPPING); % OK so far
contentN_Agg = contentN_Agg(:,cr_ind,:);

%       3.3 Nitrogen aggregation with the experiment
[Nitr.Ninput.Ninput_kgkm_Exp,Nitr.Ninput.Ninput_kgkm_ExpCO,Nitr.Ninput.Ninput_kgkm_ExpGB,...
 Nitr.Ninput.Ninput_kg_Exp, Nitr.Ninput.Ninput_kg_ExpCO,Nitr.Ninput.Ninput_kg_ExpGB]...
    = ProdAggVar_SumExp_update(Nitr.Ninput.Ninput_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Nitr.Nyield.Nyield_kgkm_Exp,Nitr.Nyield.Nyield_kgkm_ExpCO,Nitr.Nyield.Nyield_kgkm_ExpGB,...
 Nitr.Nyield.Nyield_kg_Exp, Nitr.Nyield.Nyield_kg_ExpCO,Nitr.Nyield.Nyield_kg_ExpGB]...
    = ProdAggVar_SumExp_update(Nitr.Nyield.Nyield_kgkm_Agg,harvst_port,yr_base,cr_ind);

Nitr.Nsur.Nsur_kgkm_Exp = Nitr.Ninput.Ninput_kgkm_Exp - Nitr.Nyield.Nyield_kgkm_Exp;
Nitr.Nsur.Nsur_kgkm_Exp(Nitr.Nsur.Nsur_kgkm_Exp<0) = 0;

Nitr.Nsur.Nsur_kg_Exp = Nitr.Nsur.Nsur_kgkm_Exp .* Portf.Area.harvst_port;
Nitr.Nsur.Nsur_kg_ExpCO = squeeze(nansum(Nitr.Nsur.Nsur_kg_Exp,2));
Nitr.Nsur.Nsur_kg_ExpGB = nansum(Nitr.Nsur.Nsur_kg_ExpCO,1);

Nitr.Nsur.Nsur_kgkm_ExpCO = Nitr.Nsur.Nsur_kg_ExpCO ./ Portf.Area.harvst_portco;
Nitr.Nsur.Nsur_kgkm_ExpGB = Nitr.Nsur.Nsur_kg_ExpGB ./ Portf.Area.harvst_portgb;

%{
[Nsur_kgkm_Exp,Nsur_kgkm_ExpCO,Nsur_kgkm_ExpGB,...
 Nsur_kg_Exp, Nsur_kg_ExpCO,Nsur_kg_ExpGB]...
    = ProdAggVar_SumExp_update(Nitr.Nsur.Nsur_kgkm_Agg,harvst_port,yr_base,cr_ind);
%}

Nitr.NUE.NUE_ExpCO = Nitr.Nyield.Nyield_kgkm_ExpCO ./ Nitr.Ninput.Ninput_kgkm_ExpCO;
Nitr.NUE.NUE_ExpGB = Nitr.Nyield.Nyield_kgkm_ExpGB ./ Nitr.Ninput.Ninput_kgkm_ExpGB;

%       3.4 Nitrogen impact changes
%%% N input
Nitr.Ninput.Ninput_kg_Delta = Nitr.Ninput.Ninput_kgkm_Agg(:,:,yr_base) .* Portf.Area.harvst_delta; %*****
Nitr.Ninput.Ninput_kg_DeltaCO = nansum(Nitr.Ninput.Ninput_kg_Delta,2);%*****
Nitr.Ninput.Ninput_kg_DeltaGB =  nansum(Nitr.Ninput.Ninput_kg_DeltaCO);%*****

Nitr.Ninput.Ninput_kgkm_Delta = Nitr.Ninput.Ninput_kgkm_Exp - Nitr.Ninput.Ninput_kgkm_Agg(:,:,yr_base); %*****
Nitr.Ninput.Ninput_kgkm_DeltaCO = Nitr.Ninput.Ninput_kgkm_ExpCO - Nitr.Ninput.Ninput_kgkm_AggCO(:,yr_base); %*****
Nitr.Ninput.Ninput_kgkm_DeltaGB = Nitr.Ninput.Ninput_kgkm_ExpGB - Nitr.Ninput.Ninput_kgkm_AggGB(yr_base); %*****

%%% N yield
Nitr.Nyield.Nyield_kg_Delta = Nitr.Nyield.Nyield_kgkm_Agg(:,:,yr_base) .* Portf.Area.harvst_delta; %*****
Nitr.Nyield.Nyield_kg_DeltaCO = nansum(Nitr.Nyield.Nyield_kg_Delta,2);%*****
Nitr.Nyield.Nyield_kg_DeltaGB =  nansum(Nitr.Nyield.Nyield_kg_DeltaCO);%*****

Nitr.Nyield.Nyield_kgkm_Delta = Nitr.Nyield.Nyield_kgkm_Exp - Nitr.Nyield.Nyield_kgkm_Agg(:,:,yr_base); %*****
Nitr.Nyield.Nyield_kgkm_DeltaCO = Nitr.Nyield.Nyield_kgkm_ExpCO - Nitr.Nyield.Nyield_kgkm_AggCO(:,yr_base); %*****
Nitr.Nyield.Nyield_kgkm_DeltaGB = Nitr.Nyield.Nyield_kgkm_ExpGB - Nitr.Nyield.Nyield_kgkm_AggGB(yr_base); %*****

%%% N surplus
Nitr.Nsur.Nsur_kg_Delta = Nitr.Nsur.Nsur_kgkm_Agg(:,:,yr_base) .* Portf.Area.harvst_delta; %*****
Nitr.Nsur.Nsur_kg_DeltaCO = nansum(Nitr.Nsur.Nsur_kg_Delta,2); %*****
Nitr.Nsur.Nsur_kg_DeltaGB = nansum(Nitr.Nsur.Nsur_kg_DeltaCO); %*****

Nitr.Nsur.Nsur_kgkm_Delta = Nitr.Nsur.Nsur_kgkm_Exp - Nitr.Nsur.Nsur_kgkm_Agg(:,:,yr_base); %*****
Nitr.Nsur.Nsur_kgkm_DeltaCO = Nitr.Nsur.Nsur_kgkm_ExpCO - Nitr.Nsur.Nsur_kgkm_AggCO(:,yr_base); %*****
Nitr.Nsur.Nsur_kgkm_DeltaGB = Nitr.Nsur.Nsur_kgkm_ExpGB - Nitr.Nsur.Nsur_kgkm_AggGB(yr_base); %*****

%%% NUE
Nitr.NUE.NUE_DeltaCO = Nitr.NUE.NUE_ExpCO - Nitr.NUE.NUE_AggCO(:,yr_base); 
Nitr.NUE.NUE_DeltaGB = Nitr.NUE.NUE_ExpGB - Nitr.NUE.NUE_AggGB(yr_base);

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
[Narea_Vir,Nsur_Vir,Ninput_Vir,Narea_Alt,Nsur_Alt,Ninput_Alt,contentNTrd_Agg,...
 BiNarea_Vir,BiNsur_Vir,BiNinput_Vir,...
 BiNarea_Alt,BiNsur_Alt,BiNinput_Alt,...
 Narea_Vir_CO,Nsur_Vir_CO,Ninput_Vir_CO, Narea_Alt_CO, Nsur_Alt_CO, Ninput_Alt_CO,...
 Narea_Vir_GB,Nsur_Vir_GB,Ninput_Vir_GB, Narea_Alt_GB, Nsur_Alt_GB, Ninput_Alt_GB] ...
 = Nutr_VirtAlt(contentN_Agg,ImTrdQnt_Agg_NoInternal,Yield_FAO_Agg,Nyield_kgkm_Agg, ...
 Nsur_kgkm_Agg, Ninput_kgkm_Agg, uniYrs);

% New
[Narea_Vir_Exp,Nsur_Vir_Exp,Ninput_Vir_Exp,Narea_Alt_Exp,Nsur_Alt_Exp,Ninput_Alt_Exp,contentNTrd_Exp,...
 BiNarea_Vir_Exp,BiNsur_Vir_Exp,BiNinput_Vir_Exp,...
 BiNarea_Alt_Exp,BiNsur_Alt_Exp,BiNinput_Alt_Exp,...
 Narea_Vir_ExpCO,Nsur_Vir_ExpCO,Ninput_Vir_ExpCO, Narea_Alt_ExpCO, Nsur_Alt_ExpCO, Ninput_Alt_ExpCO,...
 Narea_Vir_ExpGB,Nsur_Vir_ExpGB,Ninput_Vir_ExpGB, Narea_Alt_ExpGB, Nsur_Alt_ExpGB, Ninput_Alt_ExpGB] ...
    = Nutr_VirtAlt(contentN_Agg,trade_port_NoInternal,yield_port,Nyield_kgkm_Agg, ...
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

%}

%       3.5 Nitrogen AEZ changes

%%% Disaggregated
% Original
Nitr.AEZ.Nsur_kg_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;

for az = 1:1:18
    Nitr.AEZ.Nsur_kg_AEZ_Agg(:,az,:,:) = squeeze(Nitr.Nsur.Nsur_kgkm_Agg(:,:,:)) .* squeeze(Portf.AEZ.AreaH_AEZ_FAO_Agg(:,az,:,:));
end

Nitr.AEZ.Nsur_kgkm_AEZ_Agg = Nitr.AEZ.Nsur_kg_AEZ_Agg ./ Portf.AEZ.AreaH_AEZ_FAO_Agg;

Portf.AEZ.harvst_aez_port = Portf.AEZ.harvst_aez_port(:,:,cr_ind);

% New
Nitr.AEZ.Nsur_kg_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    Nitr.AEZ.Nsur_kg_AEZ_Exp(:,az,:) = squeeze(Nitr.Nsur.Nsur_kgkm_Agg(:,:,yr_base)) .* squeeze(Portf.AEZ.harvst_aez_port(:,az,:));
end

Nitr.AEZ.Nsur_kgkm_AEZ_Exp = Nitr.AEZ.Nsur_kg_AEZ_Exp ./Portf.AEZ.harvst_aez_port;

% Changes
Nitr.AEZ.Nsur_kg_AEZ_Delta = Nitr.AEZ.Nsur_kg_AEZ_Exp - Nitr.AEZ.Nsur_kg_AEZ_Agg(:,:,:,yr_base);

Nitr.AEZ.Nsur_kgkm_AEZ_Delta = Nitr.AEZ.Nsur_kgkm_AEZ_Exp - Nitr.AEZ.Nsur_kgkm_AEZ_Agg(:,:,:,yr_base);

%%% National Level
Nitr.AEZ.Nsur_kg_AEZ_AggCO = squeeze(nansum(Nitr.AEZ.Nsur_kg_AEZ_Agg,3));
Nitr.AEZ.Nsur_kg_AEZ_ExpCO = squeeze(nansum(Nitr.AEZ.Nsur_kg_AEZ_Exp,3));
Nitr.AEZ.Nsur_kg_AEZ_DeltaCO = squeeze(nansum(Nitr.AEZ.Nsur_kg_AEZ_Delta,3));

Nitr.AEZ.Nsur_kgkm_AEZ_AggCO = Nitr.AEZ.Nsur_kg_AEZ_AggCO ./Portf.AEZ.AreaH_AEZ_FAO_AggCO; 
Nitr.AEZ.Nsur_kgkm_AEZ_ExpCO = Nitr.AEZ.Nsur_kg_AEZ_ExpCO ./Portf.AEZ.harvst_aez_portco;
Nitr.AEZ.Nsur_kgkm_AEZ_DeltaCO = Nitr.AEZ.Nsur_kgkm_AEZ_ExpCO - Nitr.AEZ.Nsur_kgkm_AEZ_AggCO(:,:,yr_base);

%%% Global Level
Nitr.AEZ.Nsur_kg_AEZ_AggGB = squeeze(nansum(Nitr.AEZ.Nsur_kg_AEZ_AggCO,1));
Nitr.AEZ.Nsur_kg_AEZ_ExpGB = squeeze(nansum(Nitr.AEZ.Nsur_kg_AEZ_ExpCO,1));
Nitr.AEZ.Nsur_kg_AEZ_DeltaGB = squeeze(nansum(Nitr.AEZ.Nsur_kg_AEZ_DeltaCO,1));

Nitr.AEZ.Nsur_kgkm_AEZ_AggGB = Nitr.AEZ.Nsur_kg_AEZ_AggGB ./Portf.AEZ.AreaH_AEZ_FAO_AggGB;
Nitr.AEZ.Nsur_kgkm_AEZ_ExpGB = Nitr.AEZ.Nsur_kg_AEZ_ExpGB ./Portf.AEZ.harvst_aez_portgb;
Nitr.AEZ.Nsur_kgkm_AEZ_DeltaGB = Nitr.AEZ.Nsur_kgkm_AEZ_ExpGB - Nitr.AEZ.Nsur_kgkm_AEZ_AggGB(:,yr_base);

%{
%%% Virtual and Alternative Nitrogen AEZ changes
% Bilateral Virtual: 10 crops * 56 years * 6 importers * 6 exporters
% HARVST_AEZ_PRC: 6 producers (exporters) * 18 AEZs * 10 Crops

HARVST_AEZ_PRC_reshape = permute(HARVST_AEZ_PRC,[3,1,2]); % 10 crops * 6 regions * 18 AEZs 
HARVST_AEZ_PRC_NEWreshape = permute(HARVST_AEZ_PRC_NEW,[3,1,2]);
%%%%%%%%%%%%%%%%%%%Virtual Nitrogen%%%%%%%%%%%%%%%%%%%%%%%
% Original
for cn = 1:1:6
    for az = 1:1:18
        BiNsur_Vir_AEZ(cr_ind,1:yr_dim,1:co_dim,cn,az) = squeeze(BiNsur_Vir(cr_ind,1:yr_dim,1:co_dim,cn)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
        %BiNarea_Vir_AEZ(cr_ind,1:yr_dim,1:co_dim,cn,az) = squeeze(BiNarea_Vir(cr_ind,1:yr_dim,1:co_dim,cn)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
    end
end
% 10 crops * 56 years * 6 importers * 6 exporters * 18 AEZs

%%% Adding up importing regions for each AEZ in exporter countries
Nsur_Vir_AEZ_sumacrsIMP = squeeze(nansum(BiNsur_Vir_AEZ,3)); % 10 crops * 56 years * 6 exporters * 18 AEZs
%Narea_Vir_AEZ_sumacrsIMP = squeeze(nansum(BiNarea_Vir_AEZ,3));
Nsur_Vir_AEZ_sumacrsIMP = permute(Nsur_Vir_AEZ_sumacrsIMP,[3,4,1,2]);
Nsur_Vir_AEZ_kgkm_Agg = Nsur_Vir_AEZ_sumacrsIMP ./AreaH_AEZ_FAO_Agg;

%%% Calculate virtual nitrogen surplus intensity
% Nsur_Vir_AEZ_kgkm = Nsur_Vir_AEZ_sumacrsIMP./Narea_Vir_AEZ_sumacrsIMP;
% Nsur_Vir_AEZ_kgkm = permute(Nsur_Vir_AEZ_kgkm,[3,4,1,2]);

Nsur_Vir_AEZ_sumacrsIMPCO = squeeze(nansum(Nsur_Vir_AEZ_sumacrsIMP,3));
%Narea_Vir_AEZ_sumacrsIMPCO = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMP,1));
%Nsur_Vir_AEZ_kgkmCO = Nsur_Vir_AEZ_sumacrsIMPCO./Narea_Vir_AEZ_sumacrsIMPCO;
%Nsur_Vir_AEZ_kgkmCO = permute(Nsur_Vir_AEZ_kgkmCO,[2,3,1]);
Nsur_Vir_AEZ_kgkm_AggCO = Nsur_Vir_AEZ_sumacrsIMPCO./AreaH_AEZ_FAO_AggCO;

Nsur_Vir_AEZ_sumacrsIMPGB = squeeze(nansum(Nsur_Vir_AEZ_sumacrsIMPCO,1));
%Narea_Vir_AEZ_sumacrsIMPGB = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMPCO,2));
%Nsur_Vir_AEZ_kgkmGB = Nsur_Vir_AEZ_sumacrsIMPGB./Narea_Vir_AEZ_sumacrsIMPGB;
%Nsur_Vir_AEZ_kgkmGB = permute(Nsur_Vir_AEZ_kgkmGB,[2,1]);
Nsur_Vir_AEZ_kgkm_AggGB = Nsur_Vir_AEZ_sumacrsIMPGB./AreaH_AEZ_FAO_AggGB;


% New

for cn = 1:1:6
    for az = 1:1:18
        BiNsur_Vir_AEZ_Exp(cr_ind,1:co_dim,cn,az) = squeeze(BiNsur_Vir_Exp(cr_ind,1,1:co_dim,cn)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
        %BiNarea_Vir_AEZ_Exp(cr_ind,1:co_dim,cn,az) = squeeze(BiNarea_Vir_Exp(cr_ind,1,1:co_dim,cn)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
    end
end
% 10 crops * 6 importers * 6 exporters * 18 AEZs

%%% Adding up importing regions for each AEZ in exporter countries
Nsur_Vir_AEZ_sumacrsIMP_Exp = squeeze(nansum(BiNsur_Vir_AEZ_Exp,2)); % 10 crops * 6 exporters * 18 AEZs
%Narea_Vir_AEZ_sumacrsIMP_Exp = squeeze(nansum(BiNarea_Vir_AEZ_Exp,2));
Nsur_Vir_AEZ_sumacrsIMP_Exp = permute(Nsur_Vir_AEZ_sumacrsIMP_Exp,[2,3,1]);

%%% Calculate virtual nitrogen surplus intensity
%Nsur_Vir_AEZ_kgkm_Exp = Nsur_Vir_AEZ_sumacrsIMP_Exp./Narea_Vir_AEZ_sumacrsIMP_Exp;
%Nsur_Vir_AEZ_kgkm_Exp = permute(Nsur_Vir_AEZ_kgkm_Exp,[2,3,1]);
Nsur_Vir_AEZ_kgkm_Exp = Nsur_Vir_AEZ_sumacrsIMP_Exp ./harvst_aez_port;


Nsur_Vir_AEZ_sumacrsIMP_ExpCO = squeeze(nansum(Nsur_Vir_AEZ_sumacrsIMP_Exp,3));
%Narea_Vir_AEZ_sumacrsIMP_ExpCO = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMP_Exp,1));
%Nsur_Vir_AEZ_kgkm_ExpCO = Nsur_Vir_AEZ_sumacrsIMP_ExpCO./Narea_Vir_AEZ_sumacrsIMP_ExpCO;
Nsur_Vir_AEZ_kgkm_ExpCO = Nsur_Vir_AEZ_sumacrsIMP_ExpCO ./ harvst_aez_portco;


Nsur_Vir_AEZ_sumacrsIMP_ExpGB = squeeze(nansum(Nsur_Vir_AEZ_sumacrsIMP_ExpCO,1));
%Narea_Vir_AEZ_sumacrsIMP_ExpGB = squeeze(nansum(Narea_Vir_AEZ_sumacrsIMP_ExpCO,1));
%Nsur_Vir_AEZ_kgkm_ExpGB = Nsur_Vir_AEZ_sumacrsIMP_ExpGB./Narea_Vir_AEZ_sumacrsIMP_ExpGB;
Nsur_Vir_AEZ_kgkm_ExpGB = Nsur_Vir_AEZ_sumacrsIMP_ExpGB ./ harvst_aez_portgb;
%Nsur_Vir_AEZ_kgkm_ExpGB = permute(Nsur_Vir_AEZ_kgkm_ExpGB,[2,1]);

% Changes
Nsur_Vir_AEZ_kgkm_Delta = Nsur_Vir_AEZ_kgkm_Exp - squeeze(Nsur_Vir_AEZ_kgkm_Agg(:,:,:,yr_base));
Nsur_Vir_AEZ_kgkm_DeltaCO = Nsur_Vir_AEZ_kgkm_ExpCO - squeeze(Nsur_Vir_AEZ_kgkm_AggCO(:,:,yr_base));
Nsur_Vir_AEZ_kgkm_DeltaGB = Nsur_Vir_AEZ_kgkm_ExpGB - squeeze(Nsur_Vir_AEZ_kgkm_AggGB(:,yr_base));





%%%%%%%%%%%%%%%%%%%%%%Alternative Nitrogen%%%%%%%%%%%%%%%%%%%%%%%%%%
% Original
for cn = 1:1:6
    for az = 1:1:18
        BiNsur_Alt_AEZ(cr_ind,1:yr_dim,cn,1:co_dim,az) = squeeze(BiNsur_Alt(cr_ind,1:yr_dim,cn,1:co_dim)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
        %BiNarea_Alt_AEZ(cr_ind,1:yr_dim,cn,1:co_dim,az) = squeeze(BiNarea_Alt(cr_ind,1:yr_dim,cn,1:co_dim)).*HARVST_AEZ_PRC_reshape(1:10,cn,az);
    end
end
% 10 crops * 56 years * 6 importers * 6 exporters * 18 AEZs

%%% Adding up exporting regions for each AEZ in importer countries
Nsur_Alt_AEZ_sumacrsExpo = squeeze(nansum(BiNsur_Alt_AEZ,4)); % 10 crops * 56 years * 6 importers * 18 AEZs
%Narea_Alt_AEZ_sumacrsExpo = squeeze(nansum(BiNarea_Alt_AEZ,4));
Nsur_Alt_AEZ_sumacrsExpo = permute(Nsur_Alt_AEZ_sumacrsExpo,[3,4,1,2]);

%%% Calculate virtual nitrogen surplus intensity
%Nsur_Alt_AEZ_kgkm = Nsur_Alt_AEZ_sumacrsExpo./Narea_Alt_AEZ_sumacrsExpo;
Nsur_Alt_AEZ_kgkm_Agg = Nsur_Alt_AEZ_sumacrsExpo ./AreaH_AEZ_FAO_Agg;
%Nsur_Alt_AEZ_kgkm = permute(Nsur_Alt_AEZ_kgkm,[3,4,1,2]);

Nsur_Alt_AEZ_sumacrsExpoCO = squeeze(nansum(Nsur_Alt_AEZ_sumacrsExpo,3));
%Narea_Alt_AEZ_sumacrsExpoCO = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpo,1));
%Nsur_Alt_AEZ_kgkmCO = Nsur_Alt_AEZ_sumacrsExpoCO ./Narea_Alt_AEZ_sumacrsExpoCO;
Nsur_Alt_AEZ_kgkm_AggCO = Nsur_Alt_AEZ_sumacrsExpoCO ./AreaH_AEZ_FAO_AggCO;
%Nsur_Alt_AEZ_kgkmCO = permute(Nsur_Alt_AEZ_kgkmCO,[2,3,1]);

Nsur_Alt_AEZ_sumacrsExpoGB = squeeze(nansum(Nsur_Alt_AEZ_sumacrsExpoCO,1));
%Narea_Alt_AEZ_sumacrsExpoGB = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpoCO,2));
Nsur_Alt_AEZ_kgkm_AggGB = Nsur_Alt_AEZ_sumacrsExpoGB./AreaH_AEZ_FAO_AggGB;
%Nsur_Alt_AEZ_kgkmGB = Nsur_Alt_AEZ_sumacrsExpoGB./Narea_Alt_AEZ_sumacrsExpoGB;
%Nsur_Alt_AEZ_kgkmGB = permute(Nsur_Alt_AEZ_kgkmGB,[2,1]);

% New
for cn = 1:1:6
    for az = 1:1:18
        BiNsur_Alt_AEZ_Exp(cr_ind,cn,1:co_dim,az) = squeeze(BiNsur_Alt_Exp(cr_ind,1,cn,1:co_dim)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
        %BiNarea_Alt_AEZ_Exp(cr_ind,cn,1:co_dim,az) = squeeze(BiNarea_Alt_Exp(cr_ind,1,cn,1:co_dim)).*HARVST_AEZ_PRC_NEWreshape(1:10,cn,az);
    end
end
% 10 crops * 6 importers * 6 exporters * 18 AEZs

%%% Adding up exporting regions for each AEZ in importer countries
Nsur_Alt_AEZ_sumacrsExpo_Exp = squeeze(nansum(BiNsur_Alt_AEZ_Exp,3)); % 10 crops * 6 importers * 18 AEZs
%Narea_Alt_AEZ_sumacrsExpo_Exp = squeeze(nansum(BiNarea_Alt_AEZ_Exp,3));
Nsur_Alt_AEZ_sumacrsExpo_Exp = permute(Nsur_Alt_AEZ_sumacrsExpo_Exp,[2,3,1]);
%%% Calculate alternative nitrogen surplus intensity
%Nsur_Alt_AEZ_kgkm_Exp = Nsur_Alt_AEZ_sumacrsExpo_Exp./Narea_Alt_AEZ_sumacrsExpo_Exp;
%Nsur_Alt_AEZ_kgkm_Exp = permute(Nsur_Alt_AEZ_kgkm_Exp,[2,3,1]);
Nsur_Alt_AEZ_kgkm_Exp = Nsur_Alt_AEZ_sumacrsExpo_Exp./harvst_aez_port;


Nsur_Alt_AEZ_sumacrsExpo_ExpCO = squeeze(nansum(Nsur_Alt_AEZ_sumacrsExpo_Exp,3));
%Narea_Alt_AEZ_sumacrsExpo_ExpCO = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpo_Exp,1));
%Nsur_Alt_AEZ_kgkm_ExpCO = Nsur_Alt_AEZ_sumacrsExpo_ExpCO./Narea_Alt_AEZ_sumacrsExpo_ExpCO;
Nsur_Alt_AEZ_kgkm_ExpCO = Nsur_Alt_AEZ_sumacrsExpo_ExpCO./harvst_aez_portco;

Nsur_Alt_AEZ_sumacrsExpo_ExpGB = squeeze(nansum(Nsur_Alt_AEZ_sumacrsExpo_ExpCO,1));
%Narea_Alt_AEZ_sumacrsExpo_ExpGB = squeeze(nansum(Narea_Alt_AEZ_sumacrsExpo_ExpCO,1));
%Nsur_Alt_AEZ_kgkm_ExpGB = Nsur_Alt_AEZ_sumacrsExpo_ExpGB./Narea_Alt_AEZ_sumacrsExpo_ExpGB;
%Nsur_Alt_AEZ_kgkm_ExpGB = permute(Nsur_Alt_AEZ_kgkm_ExpGB,[2,1]);
Nsur_Alt_AEZ_kgkm_ExpGB = Nsur_Alt_AEZ_sumacrsExpo_ExpGB./harvst_aez_portgb;

% Changes
Nsur_Alt_AEZ_kgkm_Delta = Nsur_Alt_AEZ_kgkm_Exp - squeeze(Nsur_Alt_AEZ_kgkm_Agg(:,:,:,yr_base));
Nsur_Alt_AEZ_kgkm_DeltaCO = Nsur_Alt_AEZ_kgkm_ExpCO - squeeze(Nsur_Alt_AEZ_kgkm_AggCO(:,:,yr_base));
Nsur_Alt_AEZ_kgkm_DeltaGB = Nsur_Alt_AEZ_kgkm_ExpGB - squeeze(Nsur_Alt_AEZ_kgkm_AggGB(:,yr_base));
%}

% Damage Cost
Nitr.Econ.DC_US_min = 0.03 * 2.3 + 0.73 * 8.4 + 0.12 * 15.7 + 0.12 * 1.1;
Nitr.Econ.DC_US_max = 0.03 * 30.3 + 0.73 * 57.2 + 0.12 * 67.4 + 0.12 * 50.6;
Nitr.Econ.DC_US_avg = 0.03 * 8.2 + 0.73 * 39.4 + 0.12 * 24.6 + 0.12 * 13.7;

Nitr.Econ.DC_CN_min = 0.03 * 0.3 + 0.73 * 1.0 + 0.12 * 1.8 + 0.12 * 0.1;
Nitr.Econ.DC_CN_max = 0.03 * 3.5 + 0.73 * 6.6 + 0.12 * 7.7 + 0.12 * 5.8;
Nitr.Econ.DC_CN_avg = 0.03 * 1.0 + 0.73 * 4.5 + 0.12 * 2.8 + 0.12 * 1.6;

US_ind = find(co_array == "USA");
Nitr.Econ.Nsur_DC_US_min = Nitr.Nsur.Nsur_kg_AggCO(US_ind,:).* Nitr.Econ.DC_US_min;
Nitr.Econ.Nsur_DC_US_max = Nitr.Nsur.Nsur_kg_AggCO(US_ind,:).* Nitr.Econ.DC_US_max;
Nitr.Econ.Nsur_DC_US_avg = Nitr.Nsur.Nsur_kg_AggCO(US_ind,:).* Nitr.Econ.DC_US_avg;

CN_ind = find(co_array == "CHINA");
Nitr.Econ.Nsur_DC_CN_min = Nitr.Nsur.Nsur_kg_AggCO(CN_ind,:).* Nitr.Econ.DC_CN_min;
Nitr.Econ.Nsur_DC_CN_max = Nitr.Nsur.Nsur_kg_AggCO(CN_ind,:).* Nitr.Econ.DC_CN_max;
Nitr.Econ.Nsur_DC_CN_avg = Nitr.Nsur.Nsur_kg_AggCO(CN_ind,:).* Nitr.Econ.DC_CN_avg;

Nitr.Econ.Nsur_DC_US_min_Exp = Nitr.Nsur.Nsur_kg_ExpCO(US_ind,1).* Nitr.Econ.DC_US_min;
Nitr.Econ.Nsur_DC_US_max_Exp = Nitr.Nsur.Nsur_kg_ExpCO(US_ind,1).* Nitr.Econ.DC_US_max;
Nitr.Econ.Nsur_DC_US_avg_Exp = Nitr.Nsur.Nsur_kg_ExpCO(US_ind,1).* Nitr.Econ.DC_US_avg;

Nitr.Econ.Nsur_DC_CN_min_Exp = Nitr.Nsur.Nsur_kg_ExpCO(CN_ind,1).* Nitr.Econ.DC_CN_min;
Nitr.Econ.Nsur_DC_CN_max_Exp = Nitr.Nsur.Nsur_kg_ExpCO(CN_ind,1).* Nitr.Econ.DC_CN_max;
Nitr.Econ.Nsur_DC_CN_avg_Exp = Nitr.Nsur.Nsur_kg_ExpCO(CN_ind,1).* Nitr.Econ.DC_CN_avg;

Nitr.Econ.Nsur_DC_US_min_Delta = Nitr.Nsur.Nsur_kg_DeltaCO(US_ind,1).* Nitr.Econ.DC_US_min;
Nitr.Econ.Nsur_DC_US_max_Delta = Nitr.Nsur.Nsur_kg_DeltaCO(US_ind,1).* Nitr.Econ.DC_US_max;
Nitr.Econ.Nsur_DC_US_avg_Delta = Nitr.Nsur.Nsur_kg_DeltaCO(US_ind,1).* Nitr.Econ.DC_US_avg;

Nitr.Econ.Nsur_DC_CN_min_Delta = Nitr.Nsur.Nsur_kg_DeltaCO(CN_ind,1).* Nitr.Econ.DC_CN_min;
Nitr.Econ.Nsur_DC_CN_max_Delta = Nitr.Nsur.Nsur_kg_DeltaCO(CN_ind,1).* Nitr.Econ.DC_CN_max;
Nitr.Econ.Nsur_DC_CN_avg_Delta = Nitr.Nsur.Nsur_kg_DeltaCO(CN_ind,1).* Nitr.Econ.DC_CN_avg;

