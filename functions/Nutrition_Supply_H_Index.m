%%% Nutrition supply
[CalorProd,Calor_Cap] = NutrProd(CalorCont,Product_FAO,pop_SAM);
[ProtProd,Prot_Cap] = NutrProd(ProtCont,Product_FAO,pop_SAM);
[FatProd,Fat_Cap] = NutrProd(FatCont,Product_FAO,pop_SAM);

%%% Nutrition supply by aggregated regions and crops
CalorProd_Agg = Var_Agg_SIMPLE(CalorProd,MAPPING);
ProtProd_Agg = Var_Agg_SIMPLE(ProtProd,MAPPING);
FatProd_Agg = Var_Agg_SIMPLE(FatProd,MAPPING);

CalorProd_Agg = CalorProd_Agg(:,cr_ind,:);
ProtProd_Agg = ProtProd_Agg(:,cr_ind,:);
FatProd_Agg = FatProd_Agg(:,cr_ind,:);

%%% Nutrition content after aggregation
CalorCont_Agg = CalorProd_Agg./Product_FAO_Agg; % 6*10*56
ProtCont_Agg = ProtProd_Agg./Product_FAO_Agg; % 6*10*56
FatCont_Agg = FatProd_Agg./Product_FAO_Agg; % 6*10*56

[CalorProd_Exp,Calor_Cap_Exp] = NutrProd2dim(CalorCont_Agg,prod_port,pop_SAM,yr_base);
[ProtProd_Exp,Prot_Cap_Exp] = NutrProd2dim(ProtCont_Agg,prod_port,pop_SAM,yr_base);
[FatProd_Exp,Fat_Cap_Exp] = NutrProd2dim(FatCont_Agg,prod_port,pop_SAM,yr_base);

%%% Nutrition supply changes by crop and by country
CalorProd_Delta = CalorProd_Exp - CalorProd_Agg(:,:,yr_base);
ProtProd_Delta = ProtProd_Exp - ProtProd_Agg(:,:,yr_base);
FatProd_Delta = FatProd_Exp - FatProd_Agg(:,:,yr_base);

%%% Nutrition Supply by country (Original)
CalorProd_AggCO = squeeze(nansum(CalorProd_Agg,2)); %6*56
ProtProd_AggCO = squeeze(nansum(ProtProd_Agg,2)); %6*56
FatProd_AggCO = squeeze(nansum(FatProd_Agg,2)); %6*56

%%% Nutrition Supply by country (New)
CalorProd_ExpCO = squeeze(nansum(CalorProd_Exp,2));
ProtProd_ExpCO = squeeze(nansum(ProtProd_Exp,2));
FatProd_ExpCO = squeeze(nansum(FatProd_Exp,2));

%%% Nutrition supply by country (changes)
CalorProd_DeltaCO = CalorProd_ExpCO - CalorProd_AggCO(:,yr_base);
ProtProd_DeltaCO = ProtProd_ExpCO - ProtProd_AggCO(:,yr_base);
FatProd_DeltaCO = FatProd_ExpCO - FatProd_AggCO(:,yr_base);

%%% Nutrition trade changes
%%% ImTrdQnt (bilateral trade quantities)
ImTrdQnt_SAM(1:170,1:56,1:218,1:218) = nan;
ImTrdQnt_SAM(:,yr_trd,:,:) = ImTrdQnt;

CalorImTrdQnt_SAM = ImTrdQnt_SAM .* CalorCont;
ProtImTrdQnt_SAM = ImTrdQnt_SAM .* ProtCont;
FatImTrdQnt_SAM = ImTrdQnt_SAM .* FatCont;

%%% Bilateral trade nutrition changes (original)
CalorImTrdQnt_Agg= Var_Agg_TRD(CalorImTrdQnt_SAM,MAPPING);
ProtImTrdQnt_Agg= Var_Agg_TRD(ProtImTrdQnt_SAM,MAPPING);
FatImTrdQnt_Agg= Var_Agg_TRD(FatImTrdQnt_SAM,MAPPING);

CalorImTrdQnt_Agg = CalorImTrdQnt_Agg(cr_ind,:,:,:);
ProtImTrdQnt_Agg = ProtImTrdQnt_Agg(cr_ind,:,:,:);
FatImTrdQnt_Agg = FatImTrdQnt_Agg(cr_ind,:,:,:);



%%% Bilateral trade nutrition changes (new)
trade_port_reshape = permute(trade_port,[3,4,1,2]);
CalorImTrdQnt_Exp(1:cr_dim,1,1:co_dim,1:co_dim) = nan;
ProtImTrdQnt_Exp(1:cr_dim,1,1:co_dim,1:co_dim) = nan;
FatImTrdQnt_Exp(1:cr_dim,1,1:co_dim,1:co_dim) = nan;

for cr = 1:1:cr_dim
    CalorImTrdQnt_Exp(cr,1,1:co_dim,1:co_dim) = trade_port_reshape(1:co_dim,1:co_dim,cr).*CalorCont_Agg(1:co_dim,cr,yr_base);
    ProtImTrdQnt_Exp(cr,1,1:co_dim,1:co_dim) = trade_port_reshape(1:co_dim,1:co_dim,cr).*ProtCont_Agg(1:co_dim,cr,yr_base);
    FatImTrdQnt_Exp(cr,1,1:co_dim,1:co_dim) = trade_port_reshape(1:co_dim,1:co_dim,cr).*FatCont_Agg(1:co_dim,cr,yr_base);
end

%%% Bilateral trade nutrition changes (changes)
CalorImTrdQnt_Delta = CalorImTrdQnt_Exp - CalorImTrdQnt_Agg(:,yr_base,:,:);
ProtImTrdQnt_Delta = ProtImTrdQnt_Exp - ProtImTrdQnt_Agg(:,yr_base,:,:);
FatImTrdQnt_Delta = FatImTrdQnt_Exp - FatImTrdQnt_Agg(:,yr_base,:,:);

%%% Changes in total exports and imports (original)
% Exports
CalorExport_Agg = permute(squeeze(nansum(CalorImTrdQnt_Agg,3)),[3,1,2]);
ProtExport_Agg = permute(squeeze(nansum(ProtImTrdQnt_Agg,3)),[3,1,2]);
FatExport_Agg = permute(squeeze(nansum(FatImTrdQnt_Agg,3)),[3,1,2]);

% Imports
CalorImport_Agg = permute(squeeze(nansum(CalorImTrdQnt_Agg,4)),[3,1,2]);
ProtImport_Agg = permute(squeeze(nansum(ProtImTrdQnt_Agg,4)),[3,1,2]);
FatImport_Agg = permute(squeeze(nansum(FatImTrdQnt_Agg,4)),[3,1,2]);

% Net imports
CalorNetImp_Agg = CalorImport_Agg - CalorExport_Agg;
ProtNetImp_Agg = ProtImport_Agg - ProtExport_Agg;
FatNetImp_Agg = FatImport_Agg - FatExport_Agg;

% Production + Net Imports
CalorPNIm_Agg = CalorProd_Agg + CalorNetImp_Agg;
ProtPNIm_Agg = ProtProd_Agg + ProtNetImp_Agg;
FatPNIm_Agg = FatProd_Agg + FatNetImp_Agg;

%%% Changes in total exports and imports (new)
% Exports
CalorExport_Exp = permute(squeeze(nansum(CalorImTrdQnt_Exp,3)),[2,1]);
ProtExport_Exp = permute(squeeze(nansum(ProtImTrdQnt_Exp,3)),[2,1]);
FatExport_Exp = permute(squeeze(nansum(FatImTrdQnt_Exp,3)),[2,1]);

% Imports
CalorImport_Exp = permute(squeeze(nansum(CalorImTrdQnt_Exp,4)),[2,1]);
ProtImport_Exp = permute(squeeze(nansum(ProtImTrdQnt_Exp,4)),[2,1]);
FatImport_Exp = permute(squeeze(nansum(FatImTrdQnt_Exp,4)),[2,1]);

% Net Imports
CalorNetImp_Exp = CalorImport_Exp - CalorExport_Exp;
ProtNetImp_Exp = ProtImport_Exp - ProtExport_Exp;
FatNetImp_Exp = FatImport_Exp - FatExport_Exp;

% Production + Net Imports
CalorPNIm_Exp = CalorProd_Exp + CalorNetImp_Exp;
ProtPNIm_Exp = ProtProd_Exp + ProtNetImp_Exp;
FatPNIm_Exp = FatProd_Exp + FatNetImp_Exp;

%%% Changes in total exports and imports (changes)
% Exports
CalorExport_Delta = CalorExport_Exp - CalorExport_Agg(:,:,yr_base);
ProtExport_Delta = ProtExport_Exp - ProtExport_Agg(:,:,yr_base);
FatExport_Delta = FatExport_Exp - FatExport_Agg(:,:,yr_base);

% Imports
CalorImport_Delta = CalorImport_Exp - CalorImport_Agg(:,:,yr_base);
ProtImport_Delta = ProtImport_Exp - ProtImport_Agg(:,:,yr_base);
FatImport_Delta = FatExport_Exp - FatExport_Agg(:,:,yr_base);

% Net Imports
CalorNetImp_Delta = CalorNetImp_Exp - CalorNetImp_Agg(:,:,yr_base);
ProtNetImp_Delta = ProtNetImp_Exp - ProtNetImp_Agg(:,:,yr_base);
FatNetImp_Delta = FatNetImp_Exp - FatNetImp_Agg(:,:,yr_base);

% Production + Net Imports
CalorPNIm_Delta = CalorPNIm_Exp - CalorPNIm_Agg(:,:,yr_base);
ProtPNIm_Delta = ProtPNIm_Exp - ProtPNIm_Agg(:,:,yr_base);
FatPNIm_Delta = FatPNIm_Exp - FatPNIm_Agg(:,:,yr_base);

%%%%%%%%%%%%%%%% Changes in total exports and imports by country

%%% Changes in total exports and imports (original)
% Exports
CalorExport_AggCO = squeeze(nansum(CalorExport_Agg,2));
ProtExport_AggCO = squeeze(nansum(ProtExport_Agg,2));
FatExport_AggCO = squeeze(nansum(FatExport_Agg,2));

% Imports
CalorImport_AggCO = squeeze(nansum(CalorImport_Agg,2));
ProtImport_AggCO = squeeze(nansum(ProtImport_Agg,2));
FatImport_AggCO = squeeze(nansum(FatImport_Agg,2));

% Net imports
CalorNetImp_AggCO = CalorImport_AggCO - CalorExport_AggCO;
ProtNetImp_AggCO = ProtImport_AggCO - ProtExport_AggCO;
FatNetImp_AggCO = FatImport_AggCO - FatExport_AggCO;

% Production + Net Imports
CalorPNIm_AggCO = CalorProd_AggCO + CalorNetImp_AggCO;
ProtPNIm_AggCO = ProtProd_AggCO + ProtNetImp_AggCO;
FatPNIm_AggCO = FatProd_AggCO + FatNetImp_AggCO;

%%% Changes in total exports and imports (new)
% Exports
CalorExport_ExpCO = squeeze(nansum(CalorExport_Exp,2));
ProtExport_ExpCO = squeeze(nansum(ProtExport_Exp,2));
FatExport_ExpCO = squeeze(nansum(FatExport_Exp,2));

% Imports
CalorImport_ExpCO = squeeze(nansum(CalorImport_Exp,2));
ProtImport_ExpCO = squeeze(nansum(ProtImport_Exp,2));
FatImport_ExpCO = squeeze(nansum(FatImport_Exp,2));

% Net Imports
CalorNetImp_ExpCO = CalorImport_ExpCO - CalorExport_ExpCO;
ProtNetImp_ExpCO = ProtImport_ExpCO - ProtExport_ExpCO;
FatNetImp_ExpCO = FatImport_ExpCO - FatExport_ExpCO;

% Production + Net Imports
CalorPNIm_ExpCO = CalorProd_ExpCO + CalorNetImp_ExpCO;
ProtPNIm_ExpCO = ProtProd_ExpCO + ProtNetImp_ExpCO;
FatPNIm_ExpCO = FatProd_ExpCO + FatNetImp_ExpCO;

%%% Changes in total exports and imports (changes)
% Exports
CalorExport_DeltaCO = CalorExport_ExpCO - CalorExport_AggCO(:,yr_base);
ProtExport_DeltaCO = ProtExport_ExpCO - ProtExport_AggCO(:,yr_base);
FatExport_DeltaCO = FatExport_ExpCO - FatExport_AggCO(:,yr_base);

% Imports
CalorImport_DeltaCO = CalorImport_ExpCO - CalorImport_AggCO(:,yr_base);
ProtImport_DeltaCO = ProtImport_ExpCO - ProtImport_AggCO(:,yr_base);
FatImport_DeltaCO = FatExport_ExpCO - FatExport_AggCO(:,yr_base);

% Net Imports
CalorNetImp_DeltaCO = CalorNetImp_ExpCO - CalorNetImp_AggCO(:,yr_base);
ProtNetImp_DeltaCO = ProtNetImp_ExpCO - ProtNetImp_AggCO(:,yr_base);
FatNetImp_DeltaCO = FatNetImp_ExpCO - FatNetImp_AggCO(:,yr_base);

% Production + Net Imports
CalorPNIm_DeltaCO = CalorPNIm_ExpCO - CalorPNIm_AggCO(:,yr_base);
ProtPNIm_DeltaCO = ProtPNIm_ExpCO - ProtPNIm_AggCO(:,yr_base);
FatPNIm_DeltaCO = FatPNIm_ExpCO - FatPNIm_AggCO(:,yr_base);

%{

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%H index Calculation%%%%%%%%%%%%%%%%%%%

%%%% Production ONLY Aggregate by Country, not by Crops
MAPPING_CN = MAPPING;
MAPPING_CN{1,1} = string(FAOSTA[NutrProd,Nutr_Cap] = NutrProd(NutrCont,CropProd,pop)T_CrName_FAO);
MAPPING_CN{1,3} = string(FAOSTAT_CrName_FAO);

Product_FAO_CN = Var_Agg_SIMPLE(Product_FAO,MAPPING_CN);
pop_CN = Var_Agg_SIMPLE(pop_SAM,MAPPING_CN);
for i=1:1:co_dim
    ind{i} = find(co_map == co_array(i));
    pop_CN(i,:) = nansum(pop_SAM(ind{i},:),1);
end

%%% Calculate H_index (original)
[Calor_H_index_CN] = f_H_index_nutr(CalorCont,Product_FAO_CN,pop_CN,yr_no);
[Prot_H_index_CN] = f_H_index_nutr(ProtCont,Product_FAO_CN,pop_CN,yr_no);
[Fat_H_index_CN] = f_H_index_nutr(FatCont,Product_FAO_CN,pop_CN,yr_no);

 %%% Calculate H_index (new)
 %  Crop production from 11 back to 170
 %      Calculate % changes
 Product_FAO_Perc = prod_port ./ Product_FAO_Agg(:,:,yr_base) - 1;
 Product_FAO_Intp(1:co_dim,1:170) = nan; %interpolation
 for cr = 1:1:170
     crind= find(CR_ARY == CR_MAP(cr));
     Product_FAO_Intp(:,cr) = Product_FAO_CN(:,cr,yr_base).* (1 + Product_FAO_Perc(:,crind));    
 end

[Calor_H_index_Exp] = f_H_index_nutr(CalorCont,Product_FAO_Intp,pop_CN,1);
[Prot_H_index_Exp] = f_H_index_nutr(ProtCont,Product_FAO_Intp,pop_CN,1);
[Fat_H_index_Exp] = f_H_index_nutr(FatCont,Product_FAO_Intp,pop_CN,1);
 
%%% Calculate H_index (changes)
Calor_H_index_Delta = Calor_H_index_Exp - Calor_H_index_CN(:,yr_base);
Prot_H_index_Delta = Prot_H_index_Exp - Calor_H_index_CN(:,yr_base);
Fat_H_index_Delta = Fat_H_index_Exp - Fat_H_index_CN(:,yr_base);
%}


