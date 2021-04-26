
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
[Ninput_kgkm_Agg, Ninput_kgkm_AggCO,Ninput_kgkm_AggGB,...
 Ninput_kg_Agg, Ninput_kg_AggCO,Ninput_kg_AggGB,]...
    = ProdAggVar_Sum(Ninput_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Nyield_kgkm_Agg, Nyield_kgkm_AggCO,Nyield_kgkm_AggGB,...
 Nyield_kg_Agg, Nyield_kg_AggCO,Nyield_kg_AggGB,]...
    = ProdAggVar_Sum(Nyield_kgkm,AreaH_FAO,MAPPING,cr_ind);

[Nsur_kgkm_Agg, Nsur_kgkm_AggCO,Nsur_kgkm_AggGB,...
 Nsur_kg_Agg, Nsur_kg_AggCO,Nsur_kg_AggGB,]...
    = ProdAggVar_Sum(Nsur_kgkm,AreaH_FAO,MAPPING,cr_ind);

NUE_Agg = Nyield_kgkm_Agg ./ Ninput_kgkm_Agg;
NUE_AggCO = Nyield_kgkm_AggCO ./ Ninput_kgkm_AggCO;
NUE_AggGB = Nyield_kgkm_AggGB ./ Ninput_kgkm_AggGB;


%%% Nitrogen content aggregation
contentN_Agg = Var_Agg_WGT(contentN,Product_FAO,MAPPING); % OK so far
contentN_Agg = contentN_Agg(:,cr_ind,:);

%       3.3 Nitrogen aggregation with the experiment
[Ninput_kgkm_Exp,Ninput_kgkm_ExpCO,Ninput_kgkm_ExpGB,...
 Ninput_kg_Exp, Ninput_kg_ExpCO,Ninput_kg_ExpGB]...
    = ProdAggVar_SumExp(Ninput_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Nyield_kgkm_Exp,Nyield_kgkm_ExpCO,Nyield_kgkm_ExpGB,...
 Nyield_kg_Exp, Nyield_kg_ExpCO,Nyield_kg_ExpGB]...
    = ProdAggVar_SumExp(Nyield_kgkm_Agg,harvst_port,yr_base,cr_ind);

[Nsur_kgkm_Exp,Nsur_kgkm_ExpCO,Nsur_kgkm_ExpGB,...
 Nsur_kg_Exp, Nsur_kg_ExpCO,Nsur_kg_ExpGB]...
    = ProdAggVar_SumExp(Nsur_kgkm_Agg,harvst_port,yr_base,cr_ind);

NUE_ExpCO = Nyield_kgkm_ExpCO ./ Ninput_kgkm_ExpCO;
NUE_ExpGB = Nyield_kgkm_ExpGB ./ Ninput_kgkm_ExpGB;

%       3.4 Nitrogen impact changes
%%% N input
Ninput_kg_Delta = Ninput_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Ninput_kg_DeltaCO = nansum(Ninput_kg_Delta,2);%*****
Ninput_kg_DeltaGB =  nansum(Ninput_kg_DeltaCO);%*****

Ninput_kgkm_Delta = Ninput_kgkm_Exp - Ninput_kgkm_Agg(:,:,yr_base); %*****
Ninput_kgkm_DeltaCO = Ninput_kgkm_ExpCO - Ninput_kgkm_AggCO(:,yr_base); %*****
Ninput_kgkm_DeltaGB = Ninput_kgkm_ExpGB - Ninput_kgkm_AggGB(yr_base); %*****

%%% N yield
Nyield_kg_Delta = Nyield_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Nyield_kg_DeltaCO = nansum(Nyield_kg_Delta,2);%*****
Nyield_kg_DeltaGB =  nansum(Nyield_kg_DeltaCO);%*****

Nyield_kgkm_Delta = Nyield_kgkm_Exp - Nyield_kgkm_Agg(:,:,yr_base); %*****
Nyield_kgkm_DeltaCO = Nyield_kgkm_ExpCO - Nyield_kgkm_AggCO(:,yr_base); %*****
Nyield_kgkm_DeltaGB = Nyield_kgkm_ExpGB - Nyield_kgkm_AggGB(yr_base); %*****

%%% N surplus
Nsur_kg_Delta = Nsur_kgkm_Agg(:,:,yr_base) .* harvst_delta; %*****
Nsur_kg_DeltaCO = nansum(Nsur_kg_Delta,2); %*****
Nsur_kg_DeltaGB = nansum(Nsur_kg_DeltaCO); %*****

Nsur_kgkm_Delta = Nsur_kgkm_Exp - Nsur_kgkm_Agg(:,:,yr_base); %*****
Nsur_kgkm_DeltaCO = Nsur_kgkm_ExpCO - Nsur_kgkm_AggCO(:,yr_base); %*****
Nsur_kgkm_DeltaGB = Nsur_kgkm_ExpGB - Nsur_kgkm_AggGB(yr_base); %*****

%%% NUE
NUE_DeltaCO = NUE_ExpCO - NUE_AggCO(:,yr_base); 
NUE_DeltaGB = NUE_ExpGB - NUE_AggGB(yr_base);


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

%       3.5 Nitrogen AEZ changes

%%% Disaggregated
% Original
Nsur_kg_AEZ_Agg(1:co_dim,1:18,cr_dim,1:56) = nan;

for az = 1:1:18
    Nsur_kg_AEZ_Agg(:,az,:,:) = squeeze(Nsur_kgkm_Agg(:,:,:)) .* squeeze(AreaH_AEZ_FAO_Agg(:,az,:,:));
end

Nsur_kgkm_AEZ_Agg = Nsur_kg_AEZ_Agg ./ AreaH_AEZ_FAO_Agg;

% New
Nsur_kg_AEZ_Exp(1:co_dim,1:18,cr_dim) = nan;
for az = 1:1:18
    Nsur_kg_AEZ_Exp(:,az,:) = squeeze(Nsur_kgkm_Agg(:,:,yr_base)) .* squeeze(harvst_aez_port(:,az,:));
end

Nsur_kgkm_AEZ_Exp = Nsur_kg_AEZ_Exp ./harvst_aez_port;

% Changes
Nsur_kg_AEZ_Delta = Nsur_kg_AEZ_Exp - Nsur_kg_AEZ_Agg(:,:,:,yr_base);

Nsur_kgkm_AEZ_Delta = Nsur_kgkm_AEZ_Exp - Nsur_kgkm_AEZ_Agg(:,:,:,yr_base);

%%% National Level
Nsur_kg_AEZ_AggCO = squeeze(nansum(Nsur_kg_AEZ_Agg,3));
Nsur_kg_AEZ_ExpCO = squeeze(nansum(Nsur_kg_AEZ_Exp,3));
Nsur_kg_AEZ_DeltaCO = squeeze(nansum(Nsur_kg_AEZ_Delta,3));

Nsur_kgkm_AEZ_AggCO = Nsur_kg_AEZ_AggCO ./AreaH_AEZ_FAO_AggCO; 
Nsur_kgkm_AEZ_ExpCO = Nsur_kg_AEZ_ExpCO ./harvst_aez_portco;
Nsur_kgkm_AEZ_DeltaCO = Nsur_kgkm_AEZ_ExpCO - Nsur_kgkm_AEZ_AggCO(:,:,yr_base);

%%% Global Level
Nsur_kg_AEZ_AggGB = squeeze(nansum(Nsur_kg_AEZ_AggCO,1));
Nsur_kg_AEZ_ExpGB = squeeze(nansum(Nsur_kg_AEZ_ExpCO,1));
Nsur_kg_AEZ_DeltaGB = squeeze(nansum(Nsur_kg_AEZ_DeltaCO,1));

Nsur_kgkm_AEZ_AggGB = Nsur_kg_AEZ_AggGB ./AreaH_AEZ_FAO_AggGB;
Nsur_kgkm_AEZ_ExpGB = Nsur_kg_AEZ_ExpGB ./harvst_aez_portgb;
Nsur_kgkm_AEZ_DeltaGB = Nsur_kgkm_AEZ_ExpGB - Nsur_kgkm_AEZ_AggGB(:,yr_base);

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

% Damage Cost
DC_US_min = 0.03 * 2.3 + 0.73 * 8.4 + 0.12 * 15.7 + 0.12 * 1.1;
DC_US_max = 0.03 * 30.3 + 0.73 * 57.2 + 0.12 * 67.4 + 0.12 * 50.6;
DC_US_avg = 0.03 * 8.2 + 0.73 * 39.4 + 0.12 * 24.6 + 0.12 * 13.7;

DC_CN_min = 0.03 * 0.3 + 0.73 * 1.0 + 0.12 * 1.8 + 0.12 * 0.1;
DC_CN_max = 0.03 * 3.5 + 0.73 * 6.6 + 0.12 * 7.7 + 0.12 * 5.8;
DC_CN_avg = 0.03 * 1.0 + 0.73 * 4.5 + 0.12 * 2.8 + 0.12 * 1.6;

US_ind = find(co_array == "USA");
Nsur_DC_US_min = Nsur_kg_AggCO(US_ind,:).* DC_US_min;
Nsur_DC_US_max = Nsur_kg_AggCO(US_ind,:).* DC_US_max;
Nsur_DC_US_avg = Nsur_kg_AggCO(US_ind,:).* DC_US_avg;

CN_ind = find(co_array == "CHINA");
Nsur_DC_CN_min = Nsur_kg_AggCO(CN_ind,:).* DC_CN_min;
Nsur_DC_CN_max = Nsur_kg_AggCO(CN_ind,:).* DC_CN_max;
Nsur_DC_CN_avg = Nsur_kg_AggCO(CN_ind,:).* DC_CN_avg;

Nsur_DC_US_min_Exp = Nsur_kg_ExpCO(US_ind,1).* DC_US_min;
Nsur_DC_US_max_Exp = Nsur_kg_ExpCO(US_ind,1).* DC_US_max;
Nsur_DC_US_avg_Exp = Nsur_kg_ExpCO(US_ind,1).* DC_US_avg;

Nsur_DC_CN_min_Exp = Nsur_kg_ExpCO(CN_ind,1).* DC_CN_min;
Nsur_DC_CN_max_Exp = Nsur_kg_ExpCO(CN_ind,1).* DC_CN_max;
Nsur_DC_CN_avg_Exp = Nsur_kg_ExpCO(CN_ind,1).* DC_CN_avg;

Nsur_DC_US_min_Delta = Nsur_kg_DeltaCO(US_ind,1).* DC_US_min;
Nsur_DC_US_max_Delta = Nsur_kg_DeltaCO(US_ind,1).* DC_US_max;
Nsur_DC_US_avg_Delta = Nsur_kg_DeltaCO(US_ind,1).* DC_US_avg;

Nsur_DC_CN_min_Delta = Nsur_kg_DeltaCO(CN_ind,1).* DC_CN_min;
Nsur_DC_CN_max_Delta = Nsur_kg_DeltaCO(CN_ind,1).* DC_CN_max;
Nsur_DC_CN_avg_Delta = Nsur_kg_DeltaCO(CN_ind,1).* DC_CN_avg;

