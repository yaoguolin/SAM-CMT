% Compare the two secnario's results

result_dir = [dir dir_s 'Application' dir_s 'Graphs09182018' dir_s];

%% New Figures 07192019



CN_Label =  {"Global","USA","EU27","BRAZIL","CHINA","SoAmer","OTHER"};
CR_Label = ["Paddy Rice", "Wheat","Sorghum", "Oth CoarseGrain","Soybeans",...
            "Palm Fruit","Rapeseed","Oth Oilseeds","Sugar Crop","OthAgri"];
 
        
[stackHarvstA,stackHarvestA_tot] = ...
fstackData(portf2.HARVST_Delta.*100,portf2.HARVST_DeltaCO.*100,portf.HARVST_Delta.*100,portf.HARVST_DeltaCO.*100);

y_label = 'Harvested Area Changes (ha)';
%tlt('Harvested Area')
plotBarStackGroups_Decomp_Extreme_nolegend(stackHarvstA,stackHarvestA_tot, CN_Label, CR_Label,...
    'Harvested Area Changes(ha)','(ha)','Harvested Area')


[stackNsur,stackNsur_tot] = ...
fstackData(Nitr2.Nsur.Nsur_kg_Delta./1000000000,Nitr2.Nsur.Nsur_kg_DeltaCO./1000000000,...
Nitr.Nsur.Nsur_kg_Delta./1000000000,Nitr.Nsur.Nsur_kg_DeltaCO./1000000000);

plotBarStackGroups_Decomp_Extreme_nolegend(stackNsur,stackNsur_tot, CN_Label, CR_Label,...
    'Nitrogen Surplus Changes (Tg N)','(Tg N)',...
    'Nitrogen Surplus')

[stackPsur,stackPsur_tot] = ...
fstackData(Phos2.Psur.Psur_kg_Delta./1000000000,Phos2.Psur.Psur_kg_DeltaCO./1000000000,...
Phos.Psur.Psur_kg_Delta./1000000000,Phos.Psur.Psur_kg_DeltaCO./1000000000);

plotBarStackGroups_Decomp_Extreme_nolegend(stackPsur,stackPsur_tot, CN_Label, CR_Label,...
    'Phosphorus Surplus Changes (Tg P)','(Tg P)',...
    'Phosphorus Surplus')


[stackBWdep,stackBWdep_tot] = ...
fstackData(Wat2.Blue.BlueW_L_Delta,Wat2.Blue.BlueW_L_DeltaCO,...
Wat.Blue.BlueW_L_Delta,Wat.Blue.BlueW_L_DeltaCO);

plotBarStackGroups_Decomp_Extreme_nolegend(stackBWdep,stackBWdep_tot, CN_Label, CR_Label,...
    'Blue Water Use Changes (L)','(L)',...
    'Blue Water Use')

%% Order Change 10242019
CN_Label =  {"Global","CHINA","USA","BRAZIL","SoAmer","EU27","OTHER"};
portf.HARVST_Delta_order = f_CNReorder(portf.HARVST_Delta);
portf.HARVST_DeltaCO_order = f_CNReorder(portf.HARVST_DeltaCO);
Nitr.Nsur.Nsur_kg_Delta_order = f_CNReorder(Nitr.Nsur.Nsur_kg_Delta);
Nitr.Nsur.Nsur_kg_DeltaCO_order = f_CNReorder(Nitr.Nsur.Nsur_kg_DeltaCO);
Phos.Psur.Psur_kg_Delta_order = f_CNReorder(Phos.Psur.Psur_kg_Delta);
Phos.Psur.Psur_kg_DeltaCO_order = f_CNReorder(Phos.Psur.Psur_kg_DeltaCO);
Wat.Blue.BlueW_L_Delta_order = f_CNReorder(Wat.Blue.BlueW_L_Delta);
Wat.Blue.BlueW_L_DeltaCO_order = f_CNReorder(Wat.Blue.BlueW_L_DeltaCO);


%%% 05/23/2019
%%% modification on 07/20/2020
% harvsted area percentage change standard deviations in original order
% HARVST_pchange_std = [0.008627919 0.002842137 0.1403026 0.1403026 0.0223222 0.00258823];
HARVST_pchange_std = [0.015 0.006 0.193 0.002 0.030 0.003];
AreaH_FAO_AggCO = squeeze(nansum(AreaH_FAO_Agg, 2));
AreaH_FAO_std = AreaH_FAO_Agg(:, 54) .* transpose(HARVST_pchange_std) ./100;
AreaH_FAO_std_order = f_CNReorder(AreaH_FAO_std);
err_global = nansum(AreaH_FAO_Agg(:,54)) * 0.01 ./ 100;
AreaH_FAO_std_order_global = nan(1+co_dim,1);
AreaH_FAO_std_order_global(1,1) = err_global;
AreaH_FAO_std_order_global(2: 1+co_dim,1) = AreaH_FAO_std_order;

Nsur_std = AreaH_FAO_std .* Nitr.Nsur.Nsur_kgkm_AggCO(:,54);
Nsur_std_order = f_CNReorder(Nsur_std);
Nsur_err_global = Nitr.Nsur.Nsur_kgkm_AggGB(:,54) .* err_global;
Nsur_std_order_global = nan(1+co_dim,1);
Nsur_std_order_global(1,1) = Nsur_err_global;
Nsur_std_order_global(2: 1+co_dim,1) = Nsur_std_order;

Psur_std = AreaH_FAO_std .* Phos.Psur.Psur_kgkm_AggCO(:,54);
Psur_std_order = f_CNReorder(Psur_std);
Psur_err_global = Phos.Psur.Psur_kgkm_AggGB(:,54) .* err_global;
Psur_std_order_global = nan(1+co_dim,1);
Psur_std_order_global(1,1) = Psur_err_global;
Psur_std_order_global(2: 1+co_dim,1) = Psur_std_order;

BlueW_std = AreaH_FAO_std .* Wat.Blue.BlueW_AggCO(:,54);
BlueW_std_order = f_CNReorder(BlueW_std);
BlueW_err_global = Wat.Blue.BlueW_AggGB(:,54) .* err_global;
BlueW_std_order_global = nan(1+co_dim,1);
BlueW_std_order_global(1,1) = BlueW_err_global;
BlueW_std_order_global(2: 1+co_dim,1) = BlueW_std_order;

figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(2,2,[0.1 0.05],[.15 .05],[.05 .01]); 
axes(ha(1));
tlt = 'Harvested Area';
y_label = 'Harvested Area Changes (ha)';
h1 = RESULTS_decomp_graph07202020_errorbar(portf.HARVST_Delta_order.*100,portf.HARVST_DeltaCO_order.*100, AreaH_FAO_std_order_global .* 100 .* 3, tlt,y_label,CN_Label,CR_Label);

xlim([0.3,7.7])

axes(ha(2));
tlt = 'Nitrogen Surplus';
y_label = 'Nitrogen Surplus Changes (Tg)';
h2 = RESULTS_decomp_graph07202020_errorbar(Nitr.Nsur.Nsur_kg_Delta_order./1000000000,Nitr.Nsur.Nsur_kg_DeltaCO_order./1000000000,Nsur_std_order_global./1000000000 .* 3, tlt,y_label,CN_Label,CR_Label);
xlim([0.3,7.7])

axes(ha(3));
tlt = 'Phosphorus Surplus';
y_label = 'Phosphorus Surplus Changes (Tg)';
h3 = RESULTS_decomp_graph07202020_errorbar(Phos.Psur.Psur_kg_Delta_order./1000000000,Phos.Psur.Psur_kg_DeltaCO_order./1000000000,Psur_std_order_global./1000000000 .* 3, tlt,y_label,CN_Label,CR_Label);
xlim([0.3,7.7])

axes(ha(4));
tlt = 'Irrigation Water Use';
y_label = 'Irrigation Water Use Changes (L)';
h4 = RESULTS_decomp_graph07202020_errorbar(Wat.Blue.BlueW_L_Delta_order,Wat.Blue.BlueW_L_DeltaCO_order,BlueW_std_order_global .*3, tlt,y_label,CN_Label,CR_Label);
xlim([0.3,7.7])

CRLABEL = horzcat(CR_Label, "Total" , 'Error Bar-3STD');
leg1 = legend(h4,CRLABEL);
newPosition = [0.35 0.05 0.3 0.04]
%[left bottom width height]
%set(leg1,'Position', newPosition,);
set(leg1,'Position', newPosition,'Orientation','horizontal', 'FontSize', 12)

%%

portf2.HARVST_Delta_order = f_CNReorder(portf2.HARVST_Delta);
portf2.HARVST_DeltaCO_order = f_CNReorder(portf2.HARVST_DeltaCO);
Nitr2.Nsur.Nsur_kg_Delta_order = f_CNReorder(Nitr2.Nsur.Nsur_kg_Delta);
Nitr2.Nsur.Nsur_kg_DeltaCO_order = f_CNReorder(Nitr2.Nsur.Nsur_kg_DeltaCO);
Phos2.Psur.Psur_kg_Delta_order = f_CNReorder(Phos2.Psur.Psur_kg_Delta);
Phos2.Psur.Psur_kg_DeltaCO_order = f_CNReorder(Phos2.Psur.Psur_kg_DeltaCO);
Wat2.Blue.BlueW_L_Delta_order = f_CNReorder(Wat2.Blue.BlueW_L_Delta);
Wat2.Blue.BlueW_L_DeltaCO_order = f_CNReorder(Wat2.Blue.BlueW_L_DeltaCO);




CR_Label = ["Paddy Rice", "Wheat","Sorghum", "Oth CoarseGrain","Soybeans",...
            "Palm Fruit","Rapeseed","Oth Oilseeds","Sugar Crop","OthAgri"];
 
        
[stackHarvstA,stackHarvestA_tot] = ...
fstackData(portf2.HARVST_Delta_order.*100,portf2.HARVST_DeltaCO_order.*100,portf.HARVST_Delta_order.*100,portf.HARVST_DeltaCO_order.*100);

y_label = 'Harvested area changes (ha)';
%tlt('Harvested Area')
plotBarStackGroups_Decomp_Extreme_nolegend(stackHarvstA,stackHarvestA_tot, CN_Label, CR_Label,...
    'Harvested area changes(ha)','(ha)','a. Harvested area')


[stackNsur,stackNsur_tot] = ...
fstackData(Nitr2.Nsur.Nsur_kg_Delta_order./1000000000,Nitr2.Nsur.Nsur_kg_DeltaCO_order./1000000000,...
Nitr.Nsur.Nsur_kg_Delta_order./1000000000,Nitr.Nsur.Nsur_kg_DeltaCO_order./1000000000);

plotBarStackGroups_Decomp_Extreme_nolegend(stackNsur,stackNsur_tot, CN_Label, CR_Label,...
    'Nitrogen surplus changes (Tg)','(Tg)',...
    'b. Nitrogen surplus')

[stackPsur,stackPsur_tot] = ...
fstackData(Phos2.Psur.Psur_kg_Delta_order./1000000000,Phos2.Psur.Psur_kg_DeltaCO_order./1000000000,...
Phos.Psur.Psur_kg_Delta_order./1000000000,Phos.Psur.Psur_kg_DeltaCO_order./1000000000);

plotBarStackGroups_Decomp_Extreme_nolegend(stackPsur,stackPsur_tot, CN_Label, CR_Label,...
    'Phosphorus surplus changes (Tg)','(Tg)',...
    'c. Phosphorus surplus')


[stackBWdep,stackBWdep_tot] = ...
fstackData(Wat2.Blue.BlueW_L_Delta_order,Wat2.Blue.BlueW_L_DeltaCO_order,...
Wat.Blue.BlueW_L_Delta_order,Wat.Blue.BlueW_L_DeltaCO_order);

plotBarStackGroups_Decomp_Extreme_nolegend(stackBWdep,stackBWdep_tot, CN_Label, CR_Label,...
    'Irrigation water use changes (L)','(L)',...
    'd. Irrigation Water Use')








%% Synergy trade off analysis 07192019


%%%% Calculate the percentage changes of one indicator and draw a bar
%%%% chart
Nsur_PC2(1,1) = -percent_changes(Nitr2.Nsur.Nsur_kg_AggGB(:,yr_base),Nitr2.Nsur.Nsur_kg_DeltaGB);
Nsur_PC2(2:7) = -percent_changes(Nitr2.Nsur.Nsur_kg_AggCO(:,yr_base),Nitr2.Nsur.Nsur_kg_DeltaCO);

NsurI_PC2(1,1) = -percent_changes(Nitr2.Nsur.Nsur_kgkm_AggGB(:,yr_base),Nitr2.Nsur.Nsur_kgkm_DeltaGB);
NsurI_PC2(2:7) = -percent_changes(Nitr2.Nsur.Nsur_kgkm_AggCO(:,yr_base),Nitr2.Nsur.Nsur_kgkm_DeltaCO);

NUE_PC2(1,1) = percent_changes(Nitr2.NUE.NUE_AggGB(:,yr_base),Nitr2.NUE.NUE_DeltaGB);
NUE_PC2(2:7) = percent_changes(Nitr2.NUE.NUE_AggCO(:,yr_base),Nitr2.NUE.NUE_DeltaCO);

Psur_PC2(1,1) = -percent_changes(Phos2.Psur.Psur_kg_AggGB(:,yr_base),Phos2.Psur.Psur_kg_DeltaGB);
Psur_PC2(2:7) = -percent_changes(Phos2.Psur.Psur_kg_AggCO(:,yr_base),Phos2.Psur.Psur_kg_DeltaCO);

PsurI_PC2(1,1) = -percent_changes(Phos2.Psur.Psur_kgkm_AggGB(:,yr_base),Phos2.Psur.Psur_kgkm_DeltaGB);
PsurI_PC2(2:7) = -percent_changes(Phos2.Psur.Psur_kgkm_AggCO(:,yr_base),Phos2.Psur.Psur_kgkm_DeltaCO);

PUE_PC2(1,1) = percent_changes(Phos2.PUE.PUE_AggGB(:,yr_base),Phos2.PUE.PUE_DeltaGB);
PUE_PC2(2:7) = percent_changes(Phos2.PUE.PUE_AggCO(:,yr_base),Phos2.PUE.PUE_DeltaCO);

BWater_PC2(1,1) = -percent_changes(Wat2.Blue.BlueW_L_AggGB(:,yr_base),Wat2.Blue.BlueW_L_DeltaGB);
BWater_PC2(2:7) = -percent_changes(Wat2.Blue.BlueW_L_AggCO(:,yr_base),Wat2.Blue.BlueW_L_DeltaCO);

Wat2.Blue.BlueW_DeltaCO = Wat2.Blue.BlueW_ExpCO - Wat2.Blue.BlueW_AggCO(:,yr_base);
Wat2.Blue.BlueW_DeltaGB = Wat2.Blue.BlueW_ExpGB - Wat2.Blue.BlueW_AggGB(:,yr_base);

BWaterI_PC2(1,1) = -percent_changes(Wat2.Blue.BlueW_AggGB(:,yr_base),Wat2.Blue.BlueW_DeltaGB);
BWaterI_PC2(2:7) = -percent_changes(Wat2.Blue.BlueW_AggCO(:,yr_base),Wat2.Blue.BlueW_DeltaCO);

BWUE_PC2(1,1) = percent_changes(Wat2.BWUE.BWUE_AggGB(:,yr_base),Wat2.BWUE.BWUE_DeltaGB);
BWUE_PC2(2:7) = percent_changes(Wat2.BWUE.BWUE_AggCO(:,yr_base),Wat2.BWUE.BWUE_DeltaCO);


Nsur_PC(1,1) = -percent_changes(Nitr.Nsur.Nsur_kg_AggGB(:,yr_base),Nitr.Nsur.Nsur_kg_DeltaGB);
Nsur_PC(2:7,1) = -percent_changes(Nitr.Nsur.Nsur_kg_AggCO(:,yr_base),Nitr.Nsur.Nsur_kg_DeltaCO);

NsurI_PC(1,1) = -percent_changes(Nitr.Nsur.Nsur_kgkm_AggGB(:,yr_base),Nitr.Nsur.Nsur_kgkm_DeltaGB);
NsurI_PC(2:7,1) = -percent_changes(Nitr.Nsur.Nsur_kgkm_AggCO(:,yr_base),Nitr.Nsur.Nsur_kgkm_DeltaCO);

NUE_PC(1,1) = percent_changes(Nitr.NUE.NUE_AggGB(:,yr_base),Nitr.NUE.NUE_DeltaGB);
NUE_PC(2:7,1) = percent_changes(Nitr.NUE.NUE_AggCO(:,yr_base),Nitr.NUE.NUE_DeltaCO);

Psur_PC(1,1) = -percent_changes(Phos.Psur.Psur_kg_AggGB(:,yr_base),Phos.Psur.Psur_kg_DeltaGB);
Psur_PC(2:7,1) = -percent_changes(Phos.Psur.Psur_kg_AggCO(:,yr_base),Phos.Psur.Psur_kg_DeltaCO);

PsurI_PC(1,1) = -percent_changes(Phos.Psur.Psur_kgkm_AggGB(:,yr_base),Phos.Psur.Psur_kgkm_DeltaGB);
PsurI_PC(2:7,1) = -percent_changes(Phos.Psur.Psur_kgkm_AggCO(:,yr_base),Phos.Psur.Psur_kgkm_DeltaCO);

PUE_PC(1,1) = percent_changes(Phos.PUE.PUE_AggGB(:,yr_base),Phos.PUE.PUE_DeltaGB);
PUE_PC(2:7,1) = percent_changes(Phos.PUE.PUE_AggCO(:,yr_base),Phos.PUE.PUE_DeltaCO);

BWater_PC(1,1) = -percent_changes(Wat.Blue.BlueW_L_AggGB(:,yr_base),Wat.Blue.BlueW_L_DeltaGB);
BWater_PC(2:7,1) = -percent_changes(Wat.Blue.BlueW_L_AggCO(:,yr_base),Wat.Blue.BlueW_L_DeltaCO);

Wat.Blue.BlueW_DeltaCO = Wat.Blue.BlueW_ExpCO - Wat.Blue.BlueW_AggCO(:,yr_base);
Wat.Blue.BlueW_DeltaGB = Wat.Blue.BlueW_ExpGB - Wat.Blue.BlueW_AggGB(:,yr_base);

BWaterI_PC(1,1) = -percent_changes(Wat.Blue.BlueW_AggGB(:,yr_base),Wat.Blue.BlueW_DeltaGB);
BWaterI_PC(2:7,1) = -percent_changes(Wat.Blue.BlueW_AggCO(:,yr_base),Wat.Blue.BlueW_DeltaCO);

BWUE_PC(1,1) = percent_changes(Wat.BWUE.BWUE_AggGB(:,yr_base),Wat.BWUE.BWUE_DeltaGB);
BWUE_PC(2:7,1) = percent_changes(Wat.BWUE.BWUE_AggCO(:,yr_base),Wat.BWUE.BWUE_DeltaCO);


stacked_inds2 = [Nsur_PC2,NsurI_PC2,NUE_PC2,Psur_PC2,PsurI_PC2,PUE_PC2,BWater_PC2,...
    BWaterI_PC2,BWUE_PC2];

stacked_inds = [Nsur_PC,NsurI_PC,NUE_PC,Psur_PC,PsurI_PC,PUE_PC,BWater_PC,...
    BWaterI_PC,BWUE_PC];


stacked_inds_t = transpose(stacked_inds);

stacked_inds_t_pos = stacked_inds_t;
stacked_inds_t_pos(stacked_inds_t_pos<0) = 0;


stacked_inds_t_neg = stacked_inds_t;
stacked_inds_t_neg(stacked_inds_t_pos>0) = 0;

%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins 
%%% Paralell bar graph
figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(7,1,[0.02 0],[.15 .05],[.05 .01]) 

x = 1:9;
for i = 1:1:7
axes(ha(i));
bp(i) = bar(x,stacked_inds_t_pos(:,i),'FaceColor',[0.4660    0.6740    0.1880],'EdgeColor',[0.4660    0.6740    0.1880]);
hold on;
bn(i) = bar(x,stacked_inds_t_neg(:,i),'FaceColor',[0.6350    0.0780    0.1840],'EdgeColor',[   0.6350    0.0780    0.1840]);
    if i<7
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'FontSize',11)
    else
        set(gca,'FontSize',11)
        set(gca,'xticklabel',{"-Nsur","-Nsur Intensity","NUE","-Psur","-Psur Intensity","PUE","-BlueW","-BlueW Intensity","BWUE"},'FontSize',11)
    end
xlim([0.4,9.6])
%label_inds = ["Nsur","Psur","WaterDepletion","NUE","PUE","Crop Revenue","Self-sufficiency Rate"];
%legend(label_inds);
%xticklabels(CN_Label1);
set(gca,'box','off')

ylabel(CN_Label(i),'FontSize',12)

end
h = [bp(1),bn(1)];


hlabel = {"Sustainable Changes","Unsustainable Changes"};
hleg = legend(h,hlabel);
newPosition = [0.37 0.05 0.3 0.04];
%[left bottom width height]
%set(leg1,'Position', newPosition,);
set(hleg,'Position', newPosition,'Orientation','horizontal', 'FontSize', 12)






%% Original Figures
%% Harvested Area
[stackHarvstA,stackHarvestA_tot] = ...
fstackData(portf2.HARVST_Delta.*100,portf2.HARVST_DeltaCO.*100,portf.HARVST_Delta.*100,portf.HARVST_DeltaCO.*100);

CN_Label =  {"Global","USA","EU27","BRAZIL","CHINA","SoAmer","OTHER"};
CR_Label = ["Paddy Rice", "Wheat","Sorghum", "Corn","Soybeans",...
            "Palm Fruit","Rapeseed","Oth Oilseeds","Sugar Crop","OthAgri"];
        
plotBarStackGroups_Decomp_Extreme(stackHarvstA,stackHarvestA_tot, CN_Label, CR_Label,...
    'Harvested Area Changes by Region and Crop(ha)','(ha)',...
    'Harvested Area Changes (ha) - Decomposition by Region and Crop Type',result_dir,...
    'Harvested Area Changes (ha) - Decomposition by Region and Crop Type')



%% Nitrogen Surplus
[stackNsur,stackNsur_tot] = ...
fstackData(Nitr2.Nsur.Nsur_kg_Delta./1000000000,Nitr2.Nsur.Nsur_kg_DeltaCO./1000000000,...
Nitr.Nsur.Nsur_kg_Delta./1000000000,Nitr.Nsur.Nsur_kg_DeltaCO./1000000000);

plotBarStackGroups_Decomp_Extreme(stackNsur,stackNsur_tot, CN_Label, CR_Label,...
    'Nitrogen Surplus Changes by Region and Crop Type (Tg N)','(Tg N)',...
    'Nitrogen Surplus Changes (Tg N) - Decomposition by Region and Crop Type',result_dir,...
    'Nitrogen Surplus Changes (Tg N) - Decomposition by Region and Crop Type')

%%% Nitrogen suplus soybean only and intensity changes
lgd2 = {"Intensity Changes","Base Year","25% Soybean Tariffs"};

[Nitrogen_Dep_Global,Nitrogen_Tot_Global,Nitrogen_Dep_Pos,Nitrogen_Dep_Neg,...
 NitrogenIns_DeltaCO,NitrogenInt_New_Tot,NitrogenInt_Org_Tot] = fData_plotBarStack_Decomp_intensity(Nitr.Nsur.Nsur_kg_Delta,Nitr.Nsur.Nsur_kg_DeltaCO,...
    Nitr.Nsur.Nsur_kgkm_AggCO(:,yr_base),Nitr.Nsur.Nsur_kgkm_AggGB(yr_base),...
    Nitr.Nsur.Nsur_kgkm_ExpCO,Nitr.Nsur.Nsur_kgkm_ExpGB);

[Phos_Dep_Global,Phos_Tot_Global,Phos_Dep_Pos,Phos_Dep_Neg,...
 PhosIns_DeltaCO,PhosInt_New_Tot,PhosInt_Org_Tot] = fData_plotBarStack_Decomp_intensity(Phos.Psur.Psur_kg_Delta,Phos.Psur.Psur_kg_DeltaCO,...
    Phos.Psur.Psur_kgkm_AggCO(:,yr_base),Phos.Psur.Psur_kgkm_AggGB(yr_base),...
    Phos.Psur.Psur_kgkm_ExpCO,Phos.Psur.Psur_kgkm_ExpGB);

Nutr_Dep_Global{1} = Nitrogen_Dep_Global;
Nutr_Dep_Global{2} = Phos_Dep_Global;
Nutr_Tot_Global{1} = Nitrogen_Tot_Global;
Nutr_Tot_Global{2} = Phos_Tot_Global;
Nutr_Dep_Pos{1} = Nitrogen_Dep_Pos;
Nutr_Dep_Pos{2} = Phos_Dep_Pos;
Nutr_Dep_Neg{1} = Nitrogen_Dep_Neg;
Nutr_Dep_Neg{2} = Phos_Dep_Neg;
NutrIns_DeltaCO{1} = NitrogenIns_DeltaCO;
NutrIns_DeltaCO{2} = PhosIns_DeltaCO;
NutrInt_New_Tot{1} = NitrogenInt_New_Tot;
NutrInt_New_Tot{2} = PhosInt_New_Tot;
NutrInt_Org_Tot{1} = NitrogenInt_Org_Tot;
NutrInt_Org_Tot{2} = PhosInt_Org_Tot;

clear y_label
y_label(1) = "Nitrogen Surplus Changes (kg N)";
y_label(2) = "Phosphorus Surplus Changes (kg P)";

clear y_label_left
y_label_left(1) = "Nitrogen Surplus Intensity Changes (kg N/km^2)";
y_label_left(2) = "Phosphorus Surplus Intensity Changes(kg N/km^2)";

clear y_label_right
y_label_right(1) = "Nitrogen Surplus Intensity Levels (kg N/km^2)";
y_label_right(2) = "Phosphorus Surplus Intensity Levels (kg N/km^2)";

clear tlt_left
tlt_left(1) = "Nitrogen Surplus Changes";
tlt_left(2) = "Phosphorus Surplus Changes";

clear tlt_right
tlt_right(1) = "Nitrogen Surplus Intensity";
tlt_right(2) = "Phosphorus Surplus Intensity";
filename = "Nutrient_Pollution";

plotBarStack_Decomp_intensity(2,co_dim,cr_dim-1,Nutr_Dep_Global,Nutr_Tot_Global,Nutr_Dep_Pos,Nutr_Dep_Neg,...
 NutrIns_DeltaCO,NutrInt_New_Tot,NutrInt_Org_Tot,...
    CN_Label,CR_Label,y_label,y_label_left,y_label_right,...
    tlt_left,tlt_right,lgd2,result_dir,filename);

%% Water
lgd2 = {"Usage Rate Changes","Base Year","25% Soybean Tariffs"};

[GWater_Dep_Global,GWater_Tot_Global,GWater_Dep_Pos,GWater_Dep_Neg,...
 GWaterIns_DeltaCO,GWaterInt_New_Tot,GWaterInt_Org_Tot] = fData_plotBarStack_Decomp_intensity(Wat.h2oDeplete.h2oDeplete_L_Delta,Wat.h2oDeplete.h2oDeplete_L_DeltaCO,...
    Wat.h2oDeplete.h2oDeplete_AggCO(:,yr_base),Wat.h2oDeplete.h2oDeplete_AggGB(yr_base),...
    Wat.h2oDeplete.h2oDeplete_ExpCO,Wat.h2oDeplete.h2oDeplete_ExpGB);

[BWater_Dep_Global,BWater_Tot_Global,BWater_Dep_Pos,BWater_Dep_Neg,...
 BWaterIns_DeltaCO,BWaterInt_New_Tot,BWaterInt_Org_Tot] = fData_plotBarStack_Decomp_intensity(Wat.Blue.BlueW_L_Delta,Wat.Blue.BlueW_L_DeltaCO,...
    Wat.Blue.BlueW_AggCO(:,yr_base),Wat.Blue.BlueW_AggGB(yr_base),...
    Wat.Blue.BlueW_ExpCO,Wat.Blue.BlueW_ExpGB);

Wat_Dep_Global{1} = GWater_Dep_Global;
Wat_Dep_Global{2} = BWater_Dep_Global;
Wat_Tot_Global{1} = GWater_Tot_Global;
Wat_Tot_Global{2} = BWater_Tot_Global;
Wat_Dep_Pos{1} = GWater_Dep_Pos;
Wat_Dep_Pos{2} = BWater_Dep_Pos;
Wat_Dep_Neg{1} = GWater_Dep_Neg;
Wat_Dep_Neg{2} = BWater_Dep_Neg;
WatIns_DeltaCO{1} = GWaterIns_DeltaCO;
WatIns_DeltaCO{2} = BWaterIns_DeltaCO;
WatInt_New_Tot{1} = GWaterInt_New_Tot;
WatInt_New_Tot{2} = BWaterInt_New_Tot;
WatInt_Org_Tot{1} = GWaterInt_Org_Tot;
WatInt_Org_Tot{2} = BWaterInt_Org_Tot;

clear y_label
y_label(1) = "Ground Water Depletion Changes (L)";
y_label(2) = "Blue Water Usage Changes (L)";

clear y_label_left
y_label_left(1) = "Ground Water Intensity Changes (kg N/km^2)";
y_label_left(2) = "Blue Water Intensity Changes(kg N/km^2)";

clear y_label_right
y_label_right(1) = "Ground Water Intensity Levels (kg N/km^2)";
y_label_right(2) = "Blue Water Intensity Levels (kg N/km^2)";

clear tlt_left
tlt_left(1) = "Ground Water Changes";
tlt_left(2) = "Blue Water Changes";

clear tlt_right
tlt_right(1) = "Ground Water Intensity";
tlt_right(2) = "Blue Water Intensity";
filename = "Water Usage";

plotBarStack_Decomp_intensity(2,co_dim,cr_dim-1,Wat_Dep_Global,Wat_Tot_Global,Wat_Dep_Pos,Wat_Dep_Neg,...
 WatIns_DeltaCO,WatInt_New_Tot,WatInt_Org_Tot,...
    CN_Label,CR_Label,y_label,y_label_left,y_label_right,...
    tlt_left,tlt_right,lgd2,result_dir,filename);

%% N2O Emissions
%%% 1% of Nitrogen Inputs
clear y_label
clear y_label_left
clear y_label_right
clear tlt_left
clear tlt_right

y_label(1) = "N_2O Emission Changes (kg)";

y_label_left(1) = "N_2O Emission Changes (kg)";

y_label_right(1) = "N_2O Emission Intensity Levels (kg/km^2)";

tlt_left(1) = "N_2O Emission Changes";

tlt_right(1) = "N_2O Emission Intensity";

filename = "N2O Emissions";

lgd2 = {"N_2O Emission Changes","Base Year","25% Soybean Tariffs"};

[N2O_Dep_Global,N2O_Tot_Global,N2O_Dep_Pos,N2O_Dep_Neg,...
 N2OIns_DeltaCO,N2OInt_New_Tot,N2OInt_Org_Tot] = fData_plotBarStack_Decomp_intensity(Nitr.Ninput.Ninput_kg_Delta*0.01,Nitr.Ninput.Ninput_kg_DeltaCO*0.01,...
    Nitr.Ninput.Ninput_kg_AggCO(:,yr_base)*0.01,Nitr.Ninput.Ninput_kg_AggGB(yr_base)*0.01,...
    Nitr.Ninput.Ninput_kg_ExpCO*0.01,Nitr.Ninput.Ninput_kg_ExpGB*0.01);

N2O_Dep_Global1{1} = N2O_Dep_Global;
N2O_Tot_Global1{1} = N2O_Tot_Global;
N2O_Dep_Pos1{1} = N2O_Dep_Pos;
N2O_Dep_Neg1{1} = N2O_Dep_Neg;
N2OIns_DeltaCO1{1} = N2OIns_DeltaCO;
N2OInt_New_Tot1{1} = N2OInt_New_Tot;
N2OInt_Org_Tot1{1} = N2OInt_Org_Tot;

plotBarStack_Decomp_intensity(1,co_dim,cr_dim-1,N2O_Dep_Global1,N2O_Tot_Global1,N2O_Dep_Pos1,N2O_Dep_Neg1,...
 N2OIns_DeltaCO1,N2OInt_New_Tot1,N2OInt_Org_Tot1,...
    CN_Label,CR_Label,y_label,y_label_left,y_label_right,...
    tlt_left,tlt_right,lgd2,result_dir,filename);

%% Phosphorus Surplus
[stackPsur,stackPsur_tot] = ...
fstackData(Phos2.Psur.Psur_kg_Delta./1000000000,Phos2.Psur.Psur_kg_DeltaCO./1000000000,...
Phos.Psur.Psur_kg_Delta./1000000000,Phos.Psur.Psur_kg_DeltaCO./1000000000);

plotBarStackGroups_Decomp_Extreme(stackPsur,stackPsur_tot, CN_Label, CR_Label,...
    'Phosphorus Surplus Changes by Region and Crop Type (Tg P)','(Tg P)',...
    'Phosphorus Surplus Changes (Tg P) - Decomposition by Region and Crop Type',result_dir,...
    'Phosphorus Surplus Changes (Tg P) - Decomposition by Region and Crop Type')

%% Water Depletion
[stackWdep,stackWdep_tot] = ...
fstackData(Wat2.h2oDeplete.h2oDeplete_L_Delta,Wat2.h2oDeplete.h2oDeplete_L_DeltaCO,...
Wat.h2oDeplete.h2oDeplete_L_Delta,Wat.h2oDeplete.h2oDeplete_L_DeltaCO);

plotBarStackGroups_Decomp(stackWdep,stackWdep_tot, CN_Label, CR_Label,...
    'Ground Water Depletion Changes by Region and Crop Type (L)','(L)',...
    'Ground Water Depletion Changes (L) - Decomposition by Region and Crop Type',result_dir,...
    'Ground Water Depletion Changes (L) - Decomposition by Region and Crop Type')

%% Economic Damage Cost


[stackTBAL,stackTBAL_tot] = ...
fstackData(trade_bal_delta(:,CR_IND),trade_bal_deltaco,EDCost_Delta1,EDCost_DeltaCO1);

plotBarStackGroups_Decomp_TRBAL(stackTBAL,stackTBAL_tot, CN_Label, CR_Label,...
    'Trade Balance vs. Nitrogen Economic Damage Cost (US$)','(US$)',...
    'Trade Balance/EDC - Decomposition by Region and Crop Type',result_dir,...
    'Trade Balance and EDC - Decomposition by Region and Crop Type')

%% Blue Water Usage
[stackBWdep,stackBWdep_tot] = ...
fstackData(Wat2.Blue.BlueW_L_Delta,Wat2.Blue.BlueW_L_DeltaCO,...
Wat.Blue.BlueW_L_Delta,Wat.Blue.BlueW_L_DeltaCO);

plotBarStackGroups_Decomp(stackBWdep,stackBWdep_tot, CN_Label, CR_Label,...
    'Water Usage Changes by Region and Crop Type (L)','(L)',...
    'Water Usage Changes (L) - Decomposition by Region and Crop Type',result_dir,...
    'Water Usage Changes (L) - Decomposition by Region and Crop Type')

%% Crop Revenue
[stackCRev,stackCRev_tot] = ...
fstackData(Econ.Ag.Ag_Rev_Delta,Econ.Ag.Ag_Rev_DeltaCO,...
Econ2.Ag.Ag_Rev_Delta,Econ2.Ag.Ag_Rev_DeltaCO);

plotBarStackGroups_Decomp(stackCRev,stackCRev_tot, CN_Label, CR_Label,...
    'Crop Revenue Changes (US$)','(US$)',...
    'Crop Revenue Changes (US$) - Decomposition by Region and Crop Type',result_dir,...
    'Crop Revenue Changes (US$) - Decomposition by Region and Crop Type')

%% Caloric Supply
[stackCalP,stackCalP_tot] = ...
fstackData(Nutri.Calor.CalorProd_Delta,Nutri.Calor.CalorProd_DeltaCO,...
Nutri2.Calor.CalorProd_Delta,Nutri2.Calor.CalorProd_DeltaCO);

plotBarStackGroups_Decomp(stackCalP,stackCalP_tot, CN_Label, CR_Label,...
    'Caloric Production Changes (kcal)','(kcal)',...
    'Caloric Production Changes (kcal) - Decomposition by Region and Crop Type',result_dir,...
    'Caloric Production Changes (kcal) - Decomposition by Region and Crop Type')

[stackCalC,stackCalC_tot] = ...
fstackData(Nutri.Calor.CalorPNIm_Delta,Nutri.Calor.CalorPNIm_DeltaCO,...
Nutri2.Calor.CalorPNIm_Delta,Nutri2.Calor.CalorPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackCalC,stackCalC_tot, CN_Label, CR_Label,...
    'Caloric Consumption Changes(kcal)','(kcal)',...
    'Caloric Consumption Changes from primary crops(kcal) - Decomposition by Region and Crop Type',result_dir,...
    'Caloric Production Changes from primary crops (kcal) - Decomposition by Region and Crop Type')

%% Protein Supply
[stackProtP,stackProtP_tot] = ...
fstackData(Nutri.Prot.ProtProd_Delta,Nutri.Prot.ProtProd_DeltaCO,...
Nutri2.Prot.ProtProd_Delta,Nutri2.Prot.ProtProd_DeltaCO);

plotBarStackGroups_Decomp(stackProtP,stackProtP_tot, CN_Label, CR_Label,...
    'Protein Production Changes (g)','(g)',...
    'Protein Production Changes (g) - Decomposition by Region and Crop Type',result_dir,...
    'Protein Production Changes (g) - Decomposition by Region and Crop Type')

[stackProtC,stackProtC_tot] = ...
fstackData(Nutri.Prot.ProtPNIm_Delta,Nutri.Prot.ProtPNIm_DeltaCO,...
Nutri2.Prot.ProtPNIm_Delta,Nutri2.Prot.ProtPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackProtC,stackProtC_tot, CN_Label, CR_Label,...
    'Protein Consumption Changes(kcal)','(kcal)',...
    'Protein Consumption Changes from primary crops(kcal) - Decomposition by Region and Crop Type',result_dir,...
    'Protein Production Changes from primary crops (kcal) - Decomposition by Region and Crop Type')

%% Fat Supply

[stackFatP,stackFatP_tot] = ...
fstackData(Nutri.Fat.FatProd_Delta,Nutri.Fat.FatProd_DeltaCO,...
Nutri2.Fat.FatProd_Delta,Nutri2.Fat.FatProd_DeltaCO);

plotBarStackGroups_Decomp(stackFatP,stackFatP_tot, CN_Label, CR_Label,...
    'Fat Production Changes (g)','(g)',...
    'Fat Production Changes (g) - Decomposition by Region and Crop Type',result_dir,...
    'Fat Production Changes (g) - Decomposition by Region and Crop Type')

[stackFatC,stackFatC_tot] = ...
fstackData(Nutri.Fat.FatPNIm_Delta,Nutri.Fat.FatPNIm_DeltaCO,...
Nutri2.Fat.FatPNIm_Delta,Nutri2.Fat.FatPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackFatC,stackFatC_tot, CN_Label, CR_Label,...
    'Fat Consumption Changes(g)','(g)',...
    'Fat Consumption Changes from primary crops(g) - Decomposition by Region and Crop Type',result_dir,...
    'Fat Production Changes from primary crops (g) - Decomposition by Region and Crop Type')

%% Calcium
[stackCaP,stackCaP_tot] = ...
fstackData(Nutri.Calc.CalcProd_Delta,Nutri.Calc.CalcProd_DeltaCO,...
Nutri2.Calc.CalcProd_Delta,Nutri2.Calc.CalcProd_DeltaCO);

plotBarStackGroups_Decomp(stackCaP,stackCaP_tot, CN_Label, CR_Label,...
    'Calcium Production Changes (mg)','(mg)',...
    'Calcium Production Changes (mg) - Decomposition by Region and Crop Type',result_dir,...
    'Calcium Production Changes (mg) - Decomposition by Region and Crop Type')

[stackCaC,stackCaC_tot] = ...
fstackData(Nutri.Calc.CalcPNIm_Delta,Nutri.Calc.CalcPNIm_DeltaCO,...
Nutri2.Calc.CalcPNIm_Delta,Nutri2.Calc.CalcPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackCaC,stackCaC_tot, CN_Label, CR_Label,...
    'Calcium Consumption Changes(mg)','(mg)',...
    'Calcium Consumption Changes from primary crops(mg) - Decomposition by Region and Crop Type',result_dir,...
    'Calcium Production Changes from primary crops (mg) - Decomposition by Region and Crop Type')

%% Carb
[stackCarbP,stackCarbP_tot] = ...
fstackData(Nutri.Carb.CarbProd_Delta,Nutri.Carb.CarbProd_DeltaCO,...
Nutri2.Carb.CarbProd_Delta,Nutri2.Carb.CarbProd_DeltaCO);

plotBarStackGroups_Decomp(stackCarbP,stackCarbP_tot, CN_Label, CR_Label,...
    'Carb Production Changes (g)','(g)',...
    'Carb Production Changes (g) - Decomposition by Region and Crop Type',result_dir,...
    'Carb Production Changes (g) - Decomposition by Region and Crop Type')

[stackCarbC,stackCarbC_tot] = ...
fstackData(Nutri.Carb.CarbPNIm_Delta,Nutri.Carb.CarbPNIm_DeltaCO,...
Nutri2.Carb.CarbPNIm_Delta,Nutri2.Carb.CarbPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackCarbC,stackCarbC_tot, CN_Label, CR_Label,...
    'Carb Consumption Changes(g)','(g)',...
    'Carb Consumption Changes from primary crops(g) - Decomposition by Region and Crop Type',result_dir,...
    'Carb Production Changes from primary crops (g) - Decomposition by Region and Crop Type')

%% Iron supply
[stackFeP,stackFeP_tot] = ...
fstackData(Nutri.Fe.FeProd_Delta,Nutri.Fe.FeProd_DeltaCO,...
Nutri2.Fe.FeProd_Delta,Nutri2.Fe.FeProd_DeltaCO);

plotBarStackGroups_Decomp(stackFeP,stackFeP_tot, CN_Label, CR_Label,...
    'Iron Production Changes (mg)','(mg)',...
    'Iron Production Changes (mg) - Decomposition by Region and Crop Type',result_dir,...
    'Iron Production Changes (mg) - Decomposition by Region and Crop Type')

[stackFeC,stackFeC_tot] = ...
fstackData(Nutri.Fe.FePNIm_Delta,Nutri.Fe.FePNIm_DeltaCO,...
Nutri2.Fe.FePNIm_Delta,Nutri2.Fe.FePNIm_DeltaCO);

plotBarStackGroups_Decomp(stackFeC,stackFeC_tot, CN_Label, CR_Label,...
    'Iron Consumption Changes(mg)','(mg)',...
    'Iron Consumption Changes from primary crops(mg) - Decomposition by Region and Crop Type',result_dir,...
    'Iron Production Changes from primary crops (mg) - Decomposition by Region and Crop Type')

%% Fiber Supply
[stackFiberP,stackFiberP_tot] = ...
fstackData(Nutri.Fiber.FiberProd_Delta,Nutri.Fiber.FiberProd_DeltaCO,...
Nutri2.Fiber.FiberProd_Delta,Nutri2.Fiber.FiberProd_DeltaCO);

plotBarStackGroups_Decomp(stackFiberP,stackFiberP_tot, CN_Label, CR_Label,...
    'Fiber Production Changes (g)','(g)',...
    'Fiber Production Changes (g) - Decomposition by Region and Crop Type',result_dir,...
    'Fiber Production Changes (g) - Decomposition by Region and Crop Type')

[stackFiberC,stackFiberC_tot] = ...
fstackData(Nutri.Fiber.FiberPNIm_Delta,Nutri.Fiber.FiberPNIm_DeltaCO,...
Nutri2.Fiber.FiberPNIm_Delta,Nutri2.Fiber.FiberPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackFiberC,stackFiberC_tot, CN_Label, CR_Label,...
    'Fiber Consumption Changes(g)','(g)',...
    'Fiber Consumption Changes from primary crops(g) - Decomposition by Region and Crop Type',result_dir,...
    'Fiber Production Changes from primary crops (g) - Decomposition by Region and Crop Type')

%% Folate Supply
[stackFolP,stackFolP_tot] = ...
fstackData(Nutri.Fol.FolProd_Delta,Nutri.Fol.FolProd_DeltaCO,...
Nutri2.Fol.FolProd_Delta,Nutri2.Fol.FolProd_DeltaCO);

plotBarStackGroups_Decomp(stackFolP,stackFolP_tot, CN_Label, CR_Label,...
    'Folate Production Changes (mcg)','(mcg)',...
    'Folate Production Changes (mcg) - Decomposition by Region and Crop Type',result_dir,...
    'Folate Production Changes (mcg) - Decomposition by Region and Crop Type')

[stackFolC,stackFolC_tot] = ...
fstackData(Nutri.Fol.FolPNIm_Delta,Nutri.Fol.FolPNIm_DeltaCO,...
Nutri2.Fol.FolPNIm_Delta,Nutri2.Fol.FolPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackFolC,stackFolC_tot, CN_Label, CR_Label,...
    'Folate Consumption Changes (mcg)','(mcg)',...
    'Folate Consumption Changes (mcg) - Decomposition by Region and Crop Type',result_dir,...
    'Folate Consumption Changes (mcg) - Decomposition by Region and Crop Type')
%% Potassium (K) Supply
[stackKP,stackKP_tot] = ...
fstackData(Nutri.K.KProd_Delta,Nutri.K.KProd_DeltaCO,...
Nutri2.K.KProd_Delta,Nutri2.K.KProd_DeltaCO);

plotBarStackGroups_Decomp(stackKP,stackKP_tot, CN_Label, CR_Label,...
    'Potassium Production Changes (mg)','(mcg)',...
    'Potassium Production Changes (mg) - Decomposition by Region and Crop Type',result_dir,...
    'Potassium Production Changes (mg) - Decomposition by Region and Crop Type')

[stackKC,stackKC_tot] = ...
fstackData(Nutri.K.KPNIm_Delta,Nutri.K.KPNIm_DeltaCO,...
Nutri2.K.KPNIm_Delta,Nutri2.K.KPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackKC,stackKC_tot, CN_Label, CR_Label,...
    'Potassium Consumption Changes (mg)','(mg)',...
    'Potassium Consumption Changes (mg) - Decomposition by Region and Crop Type',result_dir,...
    'Potassium Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Magnesium (Mg) Supply
[stackMgP,stackMgP_tot] = ...
fstackData(Nutri.Mg.MgProd_Delta,Nutri.Mg.MgProd_DeltaCO,...
Nutri2.Mg.MgProd_Delta,Nutri2.Mg.MgProd_DeltaCO);

plotBarStackGroups_Decomp(stackMgP,stackMgP_tot, CN_Label, CR_Label,...
    ' Magnesium Production Changes (mg)','(mg)',...
    ' Magnesium Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Magnesium Production Changes (mg) - Decomposition by Region and Crop Type')

[stackMgC,stackMgC_tot] = ...
fstackData(Nutri.Mg.MgPNIm_Delta,Nutri.Mg.MgPNIm_DeltaCO,...
Nutri2.Mg.MgPNIm_Delta,Nutri2.Mg.MgPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackMgC,stackMgC_tot, CN_Label, CR_Label,...
    ' Magnesium Consumption Changes (mg)','(mg)',...
    ' Magnesium Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Magnesium Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Sodium (Na) Supply
[stackNaP,stackNaP_tot] = ...
fstackData(Nutri.Na.NaProd_Delta,Nutri.Na.NaProd_DeltaCO,...
Nutri2.Na.NaProd_Delta,Nutri2.Na.NaProd_DeltaCO);

plotBarStackGroups_Decomp(stackNaP,stackNaP_tot, CN_Label, CR_Label,...
    'Sodium Production Changes (mg)','(mg)',...
    'Sodium Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    'Sodium Production Changes (mg) - Decomposition by Region and Crop Type')

[stackNaC,stackNaC_tot] = ...
fstackData(Nutri.Na.NaPNIm_Delta,Nutri.Na.NaPNIm_DeltaCO,...
Nutri2.Na.NaPNIm_Delta,Nutri2.Na.NaPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackNaC,stackNaC_tot, CN_Label, CR_Label,...
    'Sodium Consumption Changes (mg)','(mg)',...
    'Sodium Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    'Sodium Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Niacin Supply
[stackNiacP,stackNiacP_tot] = ...
fstackData(Nutri.Niac.NiacProd_Delta,Nutri.Niac.NiacProd_DeltaCO,...
Nutri2.Niac.NiacProd_Delta,Nutri2.Niac.NiacProd_DeltaCO);

plotBarStackGroups_Decomp(stackNiacP,stackNiacP_tot, CN_Label, CR_Label,...
    ' Niacin Production Changes (mg)','(mg)',...
    ' Niacin Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Niacin Production Changes (mg) - Decomposition by Region and Crop Type')

[stackNiacC,stackNiacC_tot] = ...
fstackData(Nutri.Niac.NiacPNIm_Delta,Nutri.Niac.NiacPNIm_DeltaCO,...
Nutri2.Niac.NiacPNIm_Delta,Nutri2.Niac.NiacPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackNiacC,stackNiacC_tot, CN_Label, CR_Label,...
    ' Niacin Consumption Changes (mg)','(mg)',...
    ' Niacin Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Niacin Consumption Changes (mg) - Decomposition by Region and Crop Type')


%% Riboflavin Supply
[stackRiboP,stackRiboP_tot] = ...
fstackData(Nutri.Ribo.RiboProd_Delta,Nutri.Ribo.RiboProd_DeltaCO,...
Nutri2.Ribo.RiboProd_Delta,Nutri2.Ribo.RiboProd_DeltaCO);

plotBarStackGroups_Decomp(stackRiboP,stackRiboP_tot, CN_Label, CR_Label,...
    ' Riboflavin Production Changes (mg)','(mg)',...
    ' Riboflavin Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Riboflavin Production Changes (mg) - Decomposition by Region and Crop Type')

[stackRiboC,stackRiboC_tot] = ...
fstackData(Nutri.Ribo.RiboPNIm_Delta,Nutri.Ribo.RiboPNIm_DeltaCO,...
Nutri2.Ribo.RiboPNIm_Delta,Nutri2.Ribo.RiboPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackRiboC,stackRiboC_tot, CN_Label, CR_Label,...
    ' Riboflavin Consumption Changes (mg)','(mg)',...
    ' Riboflavin Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Riboflavin Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Sugar Supply
[stackSugarP,stackSugarP_tot] = ...
fstackData(Nutri.Sugar.SugarProd_Delta,Nutri.Sugar.SugarProd_DeltaCO,...
Nutri2.Sugar.SugarProd_Delta,Nutri2.Sugar.SugarProd_DeltaCO);

plotBarStackGroups_Decomp(stackSugarP,stackSugarP_tot, CN_Label, CR_Label,...
    ' Sugar Production Changes (mg)','(mg)',...
    ' Sugar Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Sugar Production Changes (mg) - Decomposition by Region and Crop Type')

[stackSugarC,stackSugarC_tot] = ...
fstackData(Nutri.Sugar.SugarPNIm_Delta,Nutri.Sugar.SugarPNIm_DeltaCO,...
Nutri2.Sugar.SugarPNIm_Delta,Nutri2.Sugar.SugarPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackSugarC,stackSugarC_tot, CN_Label, CR_Label,...
    ' Sugar Consumption Changes (mg)','(mg)',...
    ' Sugar Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Sugar Consumption Changes (mg) - Decomposition by Region and Crop Type')
%% Thiamin
[stackThiaP,stackThiaP_tot] = ...
fstackData(Nutri.Thia.ThiaProd_Delta,Nutri.Thia.ThiaProd_DeltaCO,...
Nutri2.Thia.ThiaProd_Delta,Nutri2.Thia.ThiaProd_DeltaCO);

plotBarStackGroups_Decomp(stackThiaP,stackThiaP_tot, CN_Label, CR_Label,...
    ' Thiamin Production Changes (mg)','(mg)',...
    ' Thiamin Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Thiamin Production Changes (mg) - Decomposition by Region and Crop Type')

[stackThiaC,stackThiaC_tot] = ...
fstackData(Nutri.Thia.ThiaPNIm_Delta,Nutri.Thia.ThiaPNIm_DeltaCO,...
Nutri2.Thia.ThiaPNIm_Delta,Nutri2.Thia.ThiaPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackThiaC,stackThiaC_tot, CN_Label, CR_Label,...
    ' Thiamin Consumption Changes (mg)','(mg)',...
    ' Thiamin Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Thiamin Consumption Changes (mg) - Decomposition by Region and Crop Type')


%% Vitamin A Supply
[stackVAP,stackVAP_tot] = ...
fstackData(Nutri.VA.VAProd_Delta,Nutri.VA.VAProd_DeltaCO,...
Nutri2.VA.VAProd_Delta,Nutri2.VA.VAProd_DeltaCO);

plotBarStackGroups_Decomp(stackVAP,stackVAP_tot, CN_Label, CR_Label,...
    ' VA Production Changes (mg)','(mg)',...
    ' VA Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VA Production Changes (mg) - Decomposition by Region and Crop Type')

[stackVAC,stackVAC_tot] = ...
fstackData(Nutri.VA.VAPNIm_Delta,Nutri.VA.VAPNIm_DeltaCO,...
Nutri2.VA.VAPNIm_Delta,Nutri2.VA.VAPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackVAC,stackVAC_tot, CN_Label, CR_Label,...
    ' VA Consumption Changes (mg)','(mg)',...
    ' VA Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VA Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Vitamin B12 Supply
[stackVB12P,stackVB12P_tot] = ...
fstackData(Nutri.VB12.VB12Prod_Delta,Nutri.VB12.VB12Prod_DeltaCO,...
Nutri2.VB12.VB12Prod_Delta,Nutri2.VB12.VB12Prod_DeltaCO);

plotBarStackGroups_Decomp(stackVB12P,stackVB12P_tot, CN_Label, CR_Label,...
    ' VB12 Production Changes (mcg)','(mcg)',...
    ' VB12 Production Changes (mcg) - Decomposition by Region and Crop Type', result_dir,...
    ' VB12 Production Changes (mcg) - Decomposition by Region and Crop Type')

[stackVB12C,stackVB12C_tot] = ...
fstackData(Nutri.VB12.VB12PNIm_Delta,Nutri.VB12.VB12PNIm_DeltaCO,...
Nutri2.VB12.VB12PNIm_Delta,Nutri2.VB12.VB12PNIm_DeltaCO);

plotBarStackGroups_Decomp(stackVB12C,stackVB12C_tot, CN_Label, CR_Label,...
    ' VB12 Consumption Changes (mg)','(mg)',...
    ' VB12 Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VB12 Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Vitamin B6 Supply
[stackVB6P,stackVB6P_tot] = ...
fstackData(Nutri.VB6.VB6Prod_Delta,Nutri.VB6.VB6Prod_DeltaCO,...
Nutri2.VB6.VB6Prod_Delta,Nutri2.VB6.VB6Prod_DeltaCO);

plotBarStackGroups_Decomp(stackVB6P,stackVB6P_tot, CN_Label, CR_Label,...
    ' VB6 Production Changes (mg)','(mg)',...
    ' VB6 Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VB6 Production Changes (mg) - Decomposition by Region and Crop Type')

[stackVB6C,stackVB6C_tot] = ...
fstackData(Nutri.VB6.VB6PNIm_Delta,Nutri.VB6.VB6PNIm_DeltaCO,...
Nutri2.VB6.VB6PNIm_Delta,Nutri2.VB6.VB6PNIm_DeltaCO);

plotBarStackGroups_Decomp(stackVB6C,stackVB6C_tot, CN_Label, CR_Label,...
    ' VB6 Consumption Changes (mg)','(mg)',...
    ' VB6 Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VB6 Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Vitamin C
[stackVCP,stackVCP_tot] = ...
fstackData(Nutri.VC.VCProd_Delta,Nutri.VC.VCProd_DeltaCO,...
Nutri2.VC.VCProd_Delta,Nutri2.VC.VCProd_DeltaCO);

plotBarStackGroups_Decomp(stackVCP,stackVCP_tot, CN_Label, CR_Label,...
    ' VC Production Changes (mg)','(mg)',...
    ' VC Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VC Production Changes (mg) - Decomposition by Region and Crop Type')

[stackVCC,stackVCC_tot] = ...
fstackData(Nutri.VC.VCPNIm_Delta,Nutri.VC.VCPNIm_DeltaCO,...
Nutri2.VC.VCPNIm_Delta,Nutri2.VC.VCPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackVCC,stackVCC_tot, CN_Label, CR_Label,...
    ' VC Consumption Changes (mg)','(mg)',...
    ' VC Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VC Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Vitamin D
[stackVDP,stackVDP_tot] = ...
fstackData(Nutri.VD.VDProd_Delta,Nutri.VD.VDProd_DeltaCO,...
Nutri2.VD.VDProd_Delta,Nutri2.VD.VDProd_DeltaCO);

plotBarStackGroups_Decomp(stackVDP,stackVDP_tot, CN_Label, CR_Label,...
    ' VD Production Changes (mg)','(mg)',...
    ' VD Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VD Production Changes (mg) - Decomposition by Region and Crop Type')

[stackVDC,stackVDC_tot] = ...
fstackData(Nutri.VD.VDPNIm_Delta,Nutri.VD.VDPNIm_DeltaCO,...
Nutri2.VD.VDPNIm_Delta,Nutri2.VD.VDPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackVDC,stackVDC_tot, CN_Label, CR_Label,...
    ' VD Consumption Changes (mg)','(mg)',...
    ' VD Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VD Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Vitamin E
[stackVEP,stackVEP_tot] = ...
fstackData(Nutri.VE.VEProd_Delta,Nutri.VE.VEProd_DeltaCO,...
Nutri2.VE.VEProd_Delta,Nutri2.VE.VEProd_DeltaCO);

plotBarStackGroups_Decomp(stackVEP,stackVEP_tot, CN_Label, CR_Label,...
    ' VE Production Changes (mg)','(mg)',...
    ' VE Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VE Production Changes (mg) - Decomposition by Region and Crop Type')

[stackVEC,stackVEC_tot] = ...
fstackData(Nutri.VE.VEPNIm_Delta,Nutri.VE.VEPNIm_DeltaCO,...
Nutri2.VE.VEPNIm_Delta,Nutri2.VE.VEPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackVEC,stackVEC_tot, CN_Label, CR_Label,...
    ' VE Consumption Changes (mg)','(mg)',...
    ' VE Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' VE Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Zinc
[stackZnP,stackZnP_tot] = ...
fstackData(Nutri.Zn.ZnProd_Delta,Nutri.Zn.ZnProd_DeltaCO,...
Nutri2.Zn.ZnProd_Delta,Nutri2.Zn.ZnProd_DeltaCO);

plotBarStackGroups_Decomp(stackZnP,stackZnP_tot, CN_Label, CR_Label,...
    ' Zinc Production Changes (mg)','(mg)',...
    ' Zinc Production Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Zinc Production Changes (mg) - Decomposition by Region and Crop Type')

[stackZnC,stackZnC_tot] = ...
fstackData(Nutri.Zn.ZnPNIm_Delta,Nutri.Zn.ZnPNIm_DeltaCO,...
Nutri2.Zn.ZnPNIm_Delta,Nutri2.Zn.ZnPNIm_DeltaCO);

plotBarStackGroups_Decomp(stackZnC,stackZnC_tot, CN_Label, CR_Label,...
    ' Zinc Consumption Changes (mg)','(mg)',...
    ' Zinc Consumption Changes (mg) - Decomposition by Region and Crop Type', result_dir,...
    ' Zinc Consumption Changes (mg) - Decomposition by Region and Crop Type')

%% Virtual Nitrogen
%%% Decomposition by crop type
% 1. Area

[stackVirNArea,stackVirNArea_tot] = ...
fstackData(Nitr2.Vir.Narea_Vir_Delta.*100,Nitr2.Vir.Narea_Vir_DeltaCO.*100,...
Nitr.Vir.Narea_Vir_Delta.*100,Nitr.Vir.Narea_Vir_DeltaCO.*100);

plotBarStackGroups_Decomp(stackVirNArea,stackVirNArea_tot, CN_Label, CR_Label,...
    'Virtual Area Changes by Region and Crop(ha)','(ha)',...
    'Virtual Area Changes (ha) - Decomposition by Region and Crop Type',result_dir,...
    'Virtual Area Changes (ha) - Decomposition by Region and Crop Type')

%%% Decomposition by trade partnership

[stackVirNAreaPart,stackVirNAreaPart_tot] = ...
fstackData(Nitr2.Vir.BiNarea_Vir_DeltaCR.*100,Nitr2.Vir.Narea_Vir_DeltaCO.*100,...
Nitr.Vir.BiNarea_Vir_DeltaCR.*100,Nitr.Vir.Narea_Vir_DeltaCO.*100);

LGD =  ["USA","EU27","BRAZIL","CHINA","SoAmer","OTHER"];
plotBarStackGroups_Decomp(stackVirNAreaPart,stackVirNAreaPart_tot, CN_Label, LGD,...
    'Virtual Area Changes by Region and Export Partners(ha)','(ha)',...
    'Virtual Area Changes (ha) - Decomposition by Region and Export Partners',result_dir,...
    'Virtual Area Changes (ha) - Decomposition by Region and Export Partners')

% 2. Nitrogen Surplus

[stackVirNsur,stackVirNsur_tot] = ...
fstackData(Nitr2.Vir.Nsur_Vir_Delta./1000000000,Nitr2.Vir.Nsur_Vir_DeltaCO./1000000000,...
Nitr.Vir.Nsur_Vir_Delta./1000000000,Nitr.Vir.Nsur_Vir_DeltaCO./1000000000);

plotBarStackGroups_Decomp(stackVirNsur,stackVirNsur_tot, CN_Label, CR_Label,...
    'Virtual Nitrogen Surplus Changes by Region and Crop(Tg N)','(Tg N)',...
    'Virtual Nitrogen Surplus Changes (Tg N) - Decomposition by Region and Crop Type',result_dir,...
    'Virtual Nitrogen Surplus Changes (Tg N) - Decomposition by Region and Crop Type')

%%% Decomposition by trade partnership

[stackVirNsurPart,stackVirNsurPart_tot] = ...
fstackData(Nitr2.Vir.BiNsur_Vir_DeltaCR./1000000000,Nitr2.Vir.Nsur_Vir_DeltaCO./1000000000,...
Nitr.Vir.BiNsur_Vir_DeltaCR./1000000000,Nitr.Vir.Nsur_Vir_DeltaCO./1000000000);

LGD =  ["USA","EU27","BRAZIL","CHINA","SoAmer","OTHER"];
plotBarStackGroups_Decomp(stackVirNsurPart,stackVirNsurPart_tot, CN_Label, LGD,...
    'Virtual Nitrogen Changes by Region and Export Partners(Tg N)','(Tg N)',...
    'Virtual Nitrogen Changes (Tg N) - Decomposition by Region and Export Partners',result_dir,...
    'Virtual Nitrogen Changes (Tg N) - Decomposition by Region and Export Partners')

%% Nutrition Supply Combined
%%% Nutrition Supply Changes
NutriNames = fieldnames(Nutri);
NutriNames = string(NutriNames);
NutriProd_DeltaCO(1:co_dim,1:length(NutriNames)) = nan;
Nutri2Prod_DeltaCO(1:co_dim,1:length(NutriNames)) = nan;

NutriProd_AggCO(1:co_dim,1:length(NutriNames),1:56) = nan;
Nutri2Prod_AggCO(1:co_dim,1:length(NutriNames),1:56) = nan;

NutriProd_ExpCO(1:co_dim,1:length(NutriNames)) = nan;
Nutri2Prod_ExpCO(1:co_dim,1:length(NutriNames)) = nan;

%%% Ratio nan
    NutriProd_Ratio_AggCO(1:co_dim,1:length(NutriNames),1:56) = nan;
    NutriPNIm_Ratio_AggCO(1:co_dim,1:length(NutriNames),1:56) = nan; 
    
    NutriProd_Ratio_ExpCO(1:co_dim,1:length(NutriNames)) = nan;
    NutriPNIm_Ratio_ExpCO(1:co_dim,1:length(NutriNames)) = nan;
    
    
    Nutri2Prod_Ratio_AggCO(1:co_dim,1:length(NutriNames),1:56) = nan;
    Nutri2PNIm_Ratio_AggCO(1:co_dim,1:length(NutriNames),1:56) = nan; 
    
    Nutri2Prod_Ratio_ExpCO(1:co_dim,1:length(NutriNames)) = nan;
    Nutri2PNIm_Ratio_ExpCO(1:co_dim,1:length(NutriNames)) = nan;

    Nutri2Cont_Agg(1:co_dim,1:length(NutriNames),1:10,1:56) = nan;
    
for i = 1:length(NutriNames)
    NutriProdNames(i) = strcat(NutriNames(i),"Prod_DeltaCO");
    NutriProdNames_Org(i) = strcat(NutriNames(i),"Prod_AggCO");
    NutriProdNames_Exp(i) = strcat(NutriNames(i),"Prod_ExpCO");
    
    NutriProdRNames_Org(i) = strcat(NutriNames(i),"Prod_PopRatio");
    NutriPNImRNames_Org(i) = strcat(NutriNames(i),"PNIm_PopRatio");
    
    NutriProdRNames_Exp(i) = strcat(NutriNames(i),"Prod_PopRatioExp");
    NutriPNImRNames_Exp(i) = strcat(NutriNames(i),"PNIm_PopRatioExp");
    
    NutriContentNames(i) = strcat(NutriNames(i),"Cont_Agg");

    
    NutriProd_DeltaCO(:,i) = getfield(Nutri.(NutriNames(i)),NutriProdNames(i));
    Nutri2Prod_DeltaCO(:,i) = getfield(Nutri2.(NutriNames(i)),NutriProdNames(i));
    
    NutriProd_AggCO(:,i,:) = getfield(Nutri.(NutriNames(i)),NutriProdNames_Org(i));
    Nutri2Prod_AggCO(:,i,:) = getfield(Nutri2.(NutriNames(i)),NutriProdNames_Org(i));
    
    NutriProd_ExpCO(:,i) = getfield(Nutri.(NutriNames(i)),NutriProdNames_Exp(i));
    Nutri2Prod_ExpCO(:,i) = getfield(Nutri2.(NutriNames(i)),NutriProdNames_Exp(i));
 %%% Ratio %%%   
    NutriProd_Ratio_AggCO(:,i,:) = getfield(Nutri.(NutriNames(i)),NutriProdRNames_Org(i));
    NutriPNIm_Ratio_AggCO(:,i,:) = getfield(Nutri.(NutriNames(i)),NutriPNImRNames_Org(i)); 
    
    NutriProd_Ratio_ExpCO(:,i) = getfield(Nutri.(NutriNames(i)),NutriProdRNames_Exp(i));
    NutriPNIm_Ratio_ExpCO(:,i) = getfield(Nutri.(NutriNames(i)),NutriPNImRNames_Exp(i));
    
    
    Nutri2Prod_Ratio_AggCO(:,i,:) = getfield(Nutri2.(NutriNames(i)),NutriProdRNames_Org(i));
    Nutri2PNIm_Ratio_AggCO(:,i,:) = getfield(Nutri2.(NutriNames(i)),NutriPNImRNames_Org(i)); 
    
    Nutri2Prod_Ratio_ExpCO(:,i) = getfield(Nutri2.(NutriNames(i)),NutriProdRNames_Exp(i));
    Nutri2PNIm_Ratio_ExpCO(:,i) = getfield(Nutri2.(NutriNames(i)),NutriPNImRNames_Exp(i));
    
    Nutri2Cont_Agg(:,i,:,:) = getfield(Nutri2.(NutriNames(i)),NutriContentNames(i));
end
%% Nutrition Production Data
Nutri2Prod_Ratio_Comb(:,:,1) = Nutri2Prod_Ratio_AggCO(:,:,yr_base);
Nutri2Prod_Ratio_Comb(:,:,2) = Nutri2Prod_Ratio_ExpCO(:,:);

Nutri2Prod_Ratio_Comb_Adjust = Nutri2Prod_Ratio_Comb;
Nutri2Prod_Ratio_Comb_Adjust(Nutri2Prod_Ratio_Comb_Adjust>5) = 5;

Nutri2Prod_Ratio_Diff = (Nutri2Prod_Ratio_Comb(:,:,2) ./ Nutri2Prod_Ratio_Comb(:,:,1) - 1).*100;

Nutri2Prod_Ratio_Diff_G1P = Nutri2Prod_Ratio_Diff;
Nutri2Prod_Ratio_Diff_G1P(Nutri2Prod_Ratio_Comb(:,:,2) <= 1 | Nutri2Prod_Ratio_Diff_G1P <=0) = 0;

Nutri2Prod_Ratio_Diff_G1N = Nutri2Prod_Ratio_Diff;
Nutri2Prod_Ratio_Diff_G1N(Nutri2Prod_Ratio_Comb(:,:,2) <= 1 | Nutri2Prod_Ratio_Diff_G1N > 0) = 0;

Nutri2Prod_Ratio_Diff_L1P = Nutri2Prod_Ratio_Diff;
Nutri2Prod_Ratio_Diff_L1P(Nutri2Prod_Ratio_Comb(:,:,2) > 1 | Nutri2Prod_Ratio_Diff_L1P <=0) = 0;

Nutri2Prod_Ratio_Diff_L1N = Nutri2Prod_Ratio_Diff;
Nutri2Prod_Ratio_Diff_L1N(Nutri2Prod_Ratio_Comb(:,:,2) > 1 | Nutri2Prod_Ratio_Diff_L1N > 0) = 0;

Nutri2PNIm_Ratio_Comb(:,:,1) = Nutri2PNIm_Ratio_AggCO(:,:,yr_base);
Nutri2PNIm_Ratio_Comb(:,:,2) = Nutri2PNIm_Ratio_ExpCO(:,:);



%% Nutrition Production Figure
figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(6,1,[0.01 0.05],[.1 .05],[.04 .2]) 
for co = 1:co_dim
    axes(ha(co));
    G1P = bar(squeeze(Nutri2Prod_Ratio_Diff_G1P(co,:)),'EdgeColor','None','FaceColor',[0 0.4470 0.7410]);
    hold on
    G1N = bar(squeeze(Nutri2Prod_Ratio_Diff_G1N(co,:)),'EdgeColor','None','FaceColor',[0.8500 0.3250 0.0980]);
    hold on
    L1P = bar(squeeze(Nutri2Prod_Ratio_Diff_L1P(co,:)),'EdgeColor','None','FaceColor',[0.4660 0.6740 0.1880]);
    hold on
    L1N = bar(squeeze(Nutri2Prod_Ratio_Diff_L1N(co,:)),'EdgeColor','None','FaceColor',[0.6350 0.0780 0.1840;])
    hold off
    yl(co,:) = get(gca,'ylim');
    box off;
    ylabel(CN_Label(co+1))
    %{
    if co ==6
        yTick = get(gca,'ytick');
        set(gca,'xticklabel',[])
        xTick = get(gca,'xtick');
        for k = 1:length(NutriNames)
            text(xTick(k),-40000-0.05*(25000+40000),NutriNames(k),'HorizontalAlignment','center')
        end
    end
    %}
    set(gca,'XTick',[])
    set(gca,'xticklabel',[])
end  
%set(ha(5:6),'XTickLabel',Crop_Label);    


set(gca,'XTick',[1:22])
set(gca,'XTickLabel',NutriNames)
%set(ha,'YTickLabel','')
hL = legend([G1P,G1N,L1P,L1N],{"Positive changes with updated ratio greater than 1",...
    "Negative changes with updated ratio greater than 1",...
    "Postive changes with updated ratio less than 1",...
    "Negative changes with updated ratio less than 1"})

% Programatically move the Legend
newPosition = [0.9 0.849 0.01 0.1];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

text(0,2.5,'% changes')

%ylim(ha,min(yl(:,1)),max(yl(:,1)));
%set(ha,'ylim',[-10 10])

%% Nutrition Consumption
Nutri2PNIm_Ratio_Comb(:,:,1) = Nutri2PNIm_Ratio_AggCO(:,:,yr_base);
Nutri2PNIm_Ratio_Comb(:,:,2) = Nutri2PNIm_Ratio_ExpCO(:,:);

Nutri2PNIm_Ratio_Comb_Adjust = Nutri2PNIm_Ratio_Comb;
Nutri2PNIm_Ratio_Comb_Adjust(Nutri2PNIm_Ratio_Comb_Adjust>5) = 5;

Nutri2PNIm_Ratio_Diff = (Nutri2PNIm_Ratio_Comb(:,:,2) ./ Nutri2PNIm_Ratio_Comb(:,:,1) - 1).*100;

Nutri2PNIm_Ratio_Diff_G1P = Nutri2PNIm_Ratio_Diff;
Nutri2PNIm_Ratio_Diff_G1P(Nutri2PNIm_Ratio_Comb(:,:,2) <= 1 | Nutri2PNIm_Ratio_Diff_G1P <=0) = 0;

Nutri2PNIm_Ratio_Diff_G1N = Nutri2PNIm_Ratio_Diff;
Nutri2PNIm_Ratio_Diff_G1N(Nutri2PNIm_Ratio_Comb(:,:,2) <= 1 | Nutri2PNIm_Ratio_Diff_G1N > 0) = 0;

Nutri2PNIm_Ratio_Diff_L1P = Nutri2PNIm_Ratio_Diff;
Nutri2PNIm_Ratio_Diff_L1P(Nutri2PNIm_Ratio_Comb(:,:,2) > 1 | Nutri2PNIm_Ratio_Diff_L1P <=0) = 0;

Nutri2PNIm_Ratio_Diff_L1N = Nutri2PNIm_Ratio_Diff;
Nutri2PNIm_Ratio_Diff_L1N(Nutri2PNIm_Ratio_Comb(:,:,2) > 1 | Nutri2PNIm_Ratio_Diff_L1N > 0) = 0;

%% Consumption figure
figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(6,1,[0.01 0.05],[.1 .05],[.04 .2]) 
for co = 1:co_dim
    axes(ha(co));
    G1P = bar(squeeze(Nutri2PNIm_Ratio_Diff_G1P(co,:)),'EdgeColor','None','FaceColor',[0 0.4470 0.7410]);
    hold on
    G1N = bar(squeeze(Nutri2PNIm_Ratio_Diff_G1N(co,:)),'EdgeColor','None','FaceColor',[0.8500 0.3250 0.0980]);
    hold on
    L1P = bar(squeeze(Nutri2PNIm_Ratio_Diff_L1P(co,:)),'EdgeColor','None','FaceColor',[0.4660 0.6740 0.1880]);
    hold on
    L1N = bar(squeeze(Nutri2PNIm_Ratio_Diff_L1N(co,:)),'EdgeColor','None','FaceColor',[0.6350 0.0780 0.1840;])
    hold off
    yl(co,:) = get(gca,'ylim');
    box off;
    ylabel(CN_Label(co+1))
    %{
    if co ==6
        yTick = get(gca,'ytick');
        set(gca,'xticklabel',[])
        xTick = get(gca,'xtick');
        for k = 1:length(NutriNames)
            text(xTick(k),-40000-0.05*(25000+40000),NutriNames(k),'HorizontalAlignment','center')
        end
    end
    %}
    set(gca,'XTick',[])
    set(gca,'xticklabel',[])
end  
%set(ha(5:6),'XTickLabel',Crop_Label);    


set(gca,'XTick',[1:22])
set(gca,'XTickLabel',NutriNames)
%set(ha,'YTickLabel','')
hL = legend([G1P,G1N,L1P,L1N],{"Positive changes with updated ratio greater than 1",...
    "Negative changes with updated ratio greater than 1",...
    "Postive changes with updated ratio less than 1",...
    "Negative changes with updated ratio less than 1"})

newPosition = [0.9 0.849 0.01 0.1];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

text(0,60,'% changes')


Nsur_PC = -percent_changes(Nitr2.Nsur.Nsur_kg_AggCO(:,yr_base),Nitr2.Nsur.Nsur_kg_DeltaCO);
NUE_PC = percent_changes(Nitr2.NUE.NUE_AggCO(:,yr_base),Nitr2.NUE.NUE_DeltaCO);
Psur_PC = -percent_changes(Phos2.Psur.Psur_kg_AggCO(:,yr_base),Phos2.Psur.Psur_kg_DeltaCO);
PUE_PC = percent_changes(Phos2.PUE.PUE_AggCO(:,yr_base),Phos2.PUE.PUE_DeltaCO);
h2oDep_PC = -percent_changes(Wat2.h2oDeplete.h2oDeplete_AggCO(:,yr_base),Wat2.h2oDeplete.h2oDeplete_DeltaCO);
CrRev_PC = percent_changes(Econ2.Ag.Ag_Rev_AggCO(:,yr_base),Econ2.Ag.Ag_Rev_DeltaCO);
TopS2_PC = -percent_changes(Soc2.TopS.Area_Top2(:,yr_base),Soc2.TopS.Area_Top2_DeltaCO);
SSR_PC = percent_changes(Soc2.SSR.SSR_N_AggCO(:,yr_base),Soc2.SSR.SSR_N_ExpCO);

NutrPDiv_PC = Nutri2Prod_Ratio_Diff_L1P + Nutri2Prod_Ratio_Diff_L1N;
NutrPDiv_PC(NutrPDiv_PC==0) = nan;
NutrPDiv_PC = nanmean(NutrPDiv_PC,2);

NutrCDiv_PC = Nutri2PNIm_Ratio_Diff_L1P + Nutri2PNIm_Ratio_Diff_L1N;
NutrCDiv_PC(NutrCDiv_PC ==0) = nan;
NutrCDiv_PC = nanmean(NutrCDiv_PC,2);

stacked_inds = [Nsur_PC,Psur_PC,h2oDep_PC,NUE_PC,PUE_PC,CrRev_PC,...
   TopS2_PC,NutrPDiv_PC,NutrCDiv_PC];

stacked_inds_trans = transpose(stacked_inds);
