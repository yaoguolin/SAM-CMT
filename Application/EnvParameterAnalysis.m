seed = 523;
rng(seed)
num_sim = 1000;
% perc = 0.1;

for i = 1:1:5
    perc = i * 0.1;
    % Soybean 10%
    [soyN_kgha_dist{i}, soyP_kgha_dist{i}, soyW_Lha_dist{i}] = f_dist_generator(Nitr.Nsur.Nsur_kgkm_Agg(:,5,54)/100,Phos.Psur.Psur_kgkm_Agg(:,5,54)/100, Wat.Blue.BlueW_Agg(:,5,54)/100, num_sim, perc);

    % Oth_CrGr 10%
    [crgrN_kgha_dist{i}, crgrP_kgha_dist{i}, crgrW_Lha_dist{i}] = f_dist_generator(Nitr.Nsur.Nsur_kgkm_Agg(:,4,54)/100,Phos.Psur.Psur_kgkm_Agg(:,4,54)/100, Wat.Blue.BlueW_Agg(:,4,54)/100, num_sim, perc);

    % OthAgri 10%
    [oagriN_kgha_dist{i}, oagriP_kgha_dist{i}, oagriW_Lha_dist{i}] = f_dist_generator(Nitr.Nsur.Nsur_kgkm_Agg(:,10,54)/100,Phos.Psur.Psur_kgkm_Agg(:,10,54)/100, Wat.Blue.BlueW_Agg(:,10,54)/100, num_sim, perc);

    % wheat 10%
    [wheatN_kgha_dist{i}, wheatP_kgha_dist{i}, wheatW_Lha_dist{i}] = f_dist_generator(Nitr.Nsur.Nsur_kgkm_Agg(:,2,54)/100,Phos.Psur.Psur_kgkm_Agg(:,2,54)/100, Wat.Blue.BlueW_Agg(:,2,54)/100, num_sim, perc);

    % Sugarcrop 10%
    [sugarN_kgha_dist{i}, sugarP_kgha_dist{i}, sugarW_Lha_dist{i}] = f_dist_generator(Nitr.Nsur.Nsur_kgkm_Agg(:,9,54)/100,Phos.Psur.Psur_kgkm_Agg(:,9,54)/100, Wat.Blue.BlueW_Agg(:,9,54)/100, num_sim, perc);

end
% generate a variable with the original values
Nsur_kgha_O = nan(6, 10, num_sim);
Psur_kgha_O = nan(6, 10, num_sim);
BlueW_Lha_O = nan(6, 10, num_sim);
AreaH_ha_O = nan(6, 10, num_sim);
AreaH_ha_Delta_O = nan(6, 10, num_sim);


for cn = 1:1:6
    for cr = 1:1:10
        Nsur_kgha_O(cn,cr,:) = Nitr.Nsur.Nsur_kgkm_Agg(cn,cr,54)./100;
        Psur_kgha_O(cn,cr,:) = Phos.Psur.Psur_kgkm_Agg(cn,cr,54)./100;
        BlueW_Lha_O(cn,cr,:) = Wat.Blue.BlueW_Agg(cn,cr,54)./100;
        AreaH_ha_O(cn,cr,:) = AreaH_FAO_Agg(cn,cr,54).*100;
        AreaH_ha_Delta_O(cn,cr,:) = portf.HARVST_Delta(cn,cr).*100;
    end
end

%% Nitrogen
% soy
Nsur_kgha_soy = Nsur_kgha_O;
Nsur_kgha_soy(:,5,:) = soyN_kgha_dist;

Nsur_kg_Agg_soy = squeeze(nansum(Nsur_kgha_soy .* AreaH_ha_Delta_O,2));
Nsur_kg_Agg_soy_std = nanstd(Nsur_kg_Agg_soy,0,2);

Nsur_kgha_Agg_soy_glb = squeeze(nansum(nansum(Nsur_kgha_soy .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Nsur_kg_Agg_soy_glb = Nsur_kgha_Agg_soy_glb .* portf.HARVST_DeltaGB .*100;

Nsur_kg_Agg_soy_std_glb = nanstd(Nsur_kg_Agg_soy_glb,0,1);
% Nsur_kg_Agg_soy_glb = squeeze(nansum(nansum(Nsur_kgha_soy .* AreaH_ha_Delta_O,2),1));


% Oth_CrGr
Nsur_kgha_crgr = Nsur_kgha_O;
Nsur_kgha_crgr(:,4,:) = crgrN_kgha_dist;

Nsur_kg_Agg_crgr = squeeze(nansum(Nsur_kgha_crgr .* AreaH_ha_Delta_O,2));
Nsur_kg_Agg_crgr_std = nanstd(Nsur_kg_Agg_crgr,0,2);

Nsur_kgha_Agg_crgr_glb = squeeze(nansum(nansum(Nsur_kgha_crgr .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Nsur_kg_Agg_crgr_glb = Nsur_kgha_Agg_crgr_glb .* portf.HARVST_DeltaGB .*100;

Nsur_kg_Agg_crgr_std_glb = nanstd(Nsur_kg_Agg_crgr_glb,0,1);

%Nsur_kgha_Agg_crgr = squeeze(nansum(Nsur_kgha_crgr .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));


% OthAgri
Nsur_kgha_oagri = Nsur_kgha_O;
Nsur_kgha_oagri(:,10,:) = oagriN_kgha_dist;

Nsur_kg_Agg_oagri = squeeze(nansum(Nsur_kgha_oagri .* AreaH_ha_Delta_O,2));
Nsur_kg_Agg_oagri_std = nanstd(Nsur_kg_Agg_oagri,0,2);
 
Nsur_kgha_Agg_oagri_glb = squeeze(nansum(nansum(Nsur_kgha_oagri .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Nsur_kg_Agg_oagri_glb = Nsur_kgha_Agg_oagri_glb .* portf.HARVST_DeltaGB .*100;
 
Nsur_kg_Agg_oagri_std_glb = nanstd(Nsur_kg_Agg_oagri_glb,0,1);


% Nsur_kgha_Agg_oagri = squeeze(nansum(Nsur_kgha_oagri .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));

% wheat
Nsur_kgha_wheat = Nsur_kgha_O;
Nsur_kgha_wheat(:,2,:) = wheatN_kgha_dist;

Nsur_kg_Agg_wheat = squeeze(nansum(Nsur_kgha_wheat .* AreaH_ha_Delta_O,2));
Nsur_kg_Agg_wheat_std = nanstd(Nsur_kg_Agg_wheat,0,2);
 
Nsur_kgha_Agg_wheat_glb = squeeze(nansum(nansum(Nsur_kgha_wheat .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Nsur_kg_Agg_wheat_glb = Nsur_kgha_Agg_wheat_glb .* portf.HARVST_DeltaGB .*100;
 
Nsur_kg_Agg_wheat_std_glb = nanstd(Nsur_kg_Agg_wheat_glb,0,1);


% Nsur_kgha_Agg_wheat = squeeze(nansum(Nsur_kgha_wheat .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));

% Sugarcrop
Nsur_kgha_sugar = Nsur_kgha_O;
Nsur_kgha_sugar(:,2,:) = sugarN_kgha_dist;

Nsur_kg_Agg_sugar = squeeze(nansum(Nsur_kgha_sugar .* AreaH_ha_Delta_O,2));
Nsur_kg_Agg_sugar_std = nanstd(Nsur_kg_Agg_sugar,0,2);
 
Nsur_kgha_Agg_sugar_glb = squeeze(nansum(nansum(Nsur_kgha_sugar .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Nsur_kg_Agg_sugar_glb = Nsur_kgha_Agg_sugar_glb .* portf.HARVST_DeltaGB .*100;
 
Nsur_kg_Agg_sugar_std_glb = nanstd(Nsur_kg_Agg_sugar_glb,0,1);


% Nsur_kgha_Agg_sugar = squeeze(nansum(Nsur_kgha_sugar .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));

%% Phosphorus
% soy
Psur_kgha_soy = Psur_kgha_O;
Psur_kgha_soy(:,5,:) = soyP_kgha_dist;
 
Psur_kg_Agg_soy = squeeze(nansum(Psur_kgha_soy .* AreaH_ha_Delta_O,2));
Psur_kg_Agg_soy_std = nanstd(Psur_kg_Agg_soy,0,2);
 
Psur_kgha_Agg_soy_glb = squeeze(nansum(nansum(Psur_kgha_soy .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Psur_kg_Agg_soy_glb = Psur_kgha_Agg_soy_glb .* portf.HARVST_DeltaGB .*100;
 
Psur_kg_Agg_soy_std_glb = nanstd(Psur_kg_Agg_soy_glb,0,1);
% Psur_kg_Agg_soy_glb = squeeze(nansum(nansum(Psur_kgha_soy .* AreaH_ha_Delta_O,2),1));
 
 
% Oth_CrGr
Psur_kgha_crgr = Psur_kgha_O;
Psur_kgha_crgr(:,4,:) = crgrP_kgha_dist;
 
Psur_kg_Agg_crgr = squeeze(nansum(Psur_kgha_crgr .* AreaH_ha_Delta_O,2));
Psur_kg_Agg_crgr_std = nanstd(Psur_kg_Agg_crgr,0,2);
 
Psur_kgha_Agg_crgr_glb = squeeze(nansum(nansum(Psur_kgha_crgr .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Psur_kg_Agg_crgr_glb = Psur_kgha_Agg_crgr_glb .* portf.HARVST_DeltaGB .*100;
 
Psur_kg_Agg_crgr_std_glb = nanstd(Psur_kg_Agg_crgr_glb,0,1);
 
%Psur_kgha_Agg_crgr = squeeze(nansum(Psur_kgha_crgr .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));
 
 
% OthAgri
Psur_kgha_oagri = Psur_kgha_O;
Psur_kgha_oagri(:,10,:) = oagriP_kgha_dist;
 
Psur_kg_Agg_oagri = squeeze(nansum(Psur_kgha_oagri .* AreaH_ha_Delta_O,2));
Psur_kg_Agg_oagri_std = nanstd(Psur_kg_Agg_oagri,0,2);
 
Psur_kgha_Agg_oagri_glb = squeeze(nansum(nansum(Psur_kgha_oagri .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Psur_kg_Agg_oagri_glb = Psur_kgha_Agg_oagri_glb .* portf.HARVST_DeltaGB .*100;
 
Psur_kg_Agg_oagri_std_glb = nanstd(Psur_kg_Agg_oagri_glb,0,1);

 
% Psur_kgha_Agg_oagri = squeeze(nansum(Psur_kgha_oagri .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));
 
% wheat
Psur_kgha_wheat = Psur_kgha_O;
Psur_kgha_wheat(:,2,:) = wheatP_kgha_dist;
 
Psur_kg_Agg_wheat = squeeze(nansum(Psur_kgha_wheat .* AreaH_ha_Delta_O,2));
Psur_kg_Agg_wheat_std = nanstd(Psur_kg_Agg_wheat,0,2);
 
Psur_kgha_Agg_wheat_glb = squeeze(nansum(nansum(Psur_kgha_wheat .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Psur_kg_Agg_wheat_glb = Psur_kgha_Agg_wheat_glb .* portf.HARVST_DeltaGB .*100;
 
Psur_kg_Agg_wheat_std_glb = nanstd(Psur_kg_Agg_wheat_glb,0,1);
 
 
% Psur_kgha_Agg_wheat = squeeze(nansum(Psur_kgha_wheat .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));
 
% Sugarcrop
Psur_kgha_sugar = Psur_kgha_O;
Psur_kgha_sugar(:,2,:) = sugarP_kgha_dist;
 
Psur_kg_Agg_sugar = squeeze(nansum(Psur_kgha_sugar .* AreaH_ha_Delta_O,2));
Psur_kg_Agg_sugar_std = nanstd(Psur_kg_Agg_sugar,0,2);
 
Psur_kgha_Agg_sugar_glb = squeeze(nansum(nansum(Psur_kgha_sugar .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
Psur_kg_Agg_sugar_glb = Psur_kgha_Agg_sugar_glb .* portf.HARVST_DeltaGB .*100;
 
Psur_kg_Agg_sugar_std_glb = nanstd(Psur_kg_Agg_sugar_glb,0,1);
 
 
% Psur_kgha_Agg_sugar = squeeze(nansum(Psur_kgha_sugar .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));

%% Irrigation water

BlueW_Lha_soy = BlueW_Lha_O;
BlueW_Lha_soy(:,5,:) = soyW_Lha_dist;
 
BlueW_L_Agg_soy = squeeze(nansum(BlueW_Lha_soy .* AreaH_ha_Delta_O,2));
BlueW_L_Agg_soy_std = nanstd(BlueW_L_Agg_soy,0,2);
 
BlueW_Lha_Agg_soy_glb = squeeze(nansum(nansum(BlueW_Lha_soy .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
BlueW_L_Agg_soy_glb = BlueW_Lha_Agg_soy_glb .* portf.HARVST_DeltaGB .*100;
 
BlueW_L_Agg_soy_std_glb = nanstd(BlueW_L_Agg_soy_glb,0,1);
% BlueW_L_Agg_soy_glb = squeeze(nansum(nansum(BlueW_Lha_soy .* AreaH_ha_Delta_O,2),1));
 
 
% Oth_CrGr
BlueW_Lha_crgr = BlueW_Lha_O;
BlueW_Lha_crgr(:,4,:) = crgrW_Lha_dist;
 
BlueW_L_Agg_crgr = squeeze(nansum(BlueW_Lha_crgr .* AreaH_ha_Delta_O,2));
BlueW_L_Agg_crgr_std = nanstd(BlueW_L_Agg_crgr,0,2);
 
BlueW_Lha_Agg_crgr_glb = squeeze(nansum(nansum(BlueW_Lha_crgr .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
BlueW_L_Agg_crgr_glb = BlueW_Lha_Agg_crgr_glb .* portf.HARVST_DeltaGB .*100;
 
BlueW_L_Agg_crgr_std_glb = nanstd(BlueW_L_Agg_crgr_glb,0,1);
 
%BlueW_Lha_Agg_crgr = squeeze(nansum(BlueW_Lha_crgr .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));
 
 
% OthAgri
BlueW_Lha_oagri = BlueW_Lha_O;
BlueW_Lha_oagri(:,10,:) = oagriW_Lha_dist;
 
BlueW_L_Agg_oagri = squeeze(nansum(BlueW_Lha_oagri .* AreaH_ha_Delta_O,2));
BlueW_L_Agg_oagri_std = nanstd(BlueW_L_Agg_oagri,0,2);
 
BlueW_Lha_Agg_oagri_glb = squeeze(nansum(nansum(BlueW_Lha_oagri .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
BlueW_L_Agg_oagri_glb = BlueW_Lha_Agg_oagri_glb .* portf.HARVST_DeltaGB .*100;
 
BlueW_L_Agg_oagri_std_glb = nanstd(BlueW_L_Agg_oagri_glb,0,1);
 
 
% BlueW_Lha_Agg_oagri = squeeze(nansum(BlueW_Lha_oagri .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));
 
% wheat
BlueW_Lha_wheat = BlueW_Lha_O;
BlueW_Lha_wheat(:,2,:) = wheatW_Lha_dist;
 
BlueW_L_Agg_wheat = squeeze(nansum(BlueW_Lha_wheat .* AreaH_ha_Delta_O,2));
BlueW_L_Agg_wheat_std = nanstd(BlueW_L_Agg_wheat,0,2);
 
BlueW_Lha_Agg_wheat_glb = squeeze(nansum(nansum(BlueW_Lha_wheat .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
BlueW_L_Agg_wheat_glb = BlueW_Lha_Agg_wheat_glb .* portf.HARVST_DeltaGB .*100;
 
BlueW_L_Agg_wheat_std_glb = nanstd(BlueW_L_Agg_wheat_glb,0,1);
 
 
% BlueW_Lha_Agg_wheat = squeeze(nansum(BlueW_Lha_wheat .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));
 
% Sugarcrop
BlueW_Lha_sugar = BlueW_Lha_O;
BlueW_Lha_sugar(:,2,:) = sugarW_Lha_dist;
 
BlueW_L_Agg_sugar = squeeze(nansum(BlueW_Lha_sugar .* AreaH_ha_Delta_O,2));
BlueW_L_Agg_sugar_std = nanstd(BlueW_L_Agg_sugar,0,2);
 
BlueW_Lha_Agg_sugar_glb = squeeze(nansum(nansum(BlueW_Lha_sugar .* AreaH_ha_O, 2),1) ./ nansum(nansum(AreaH_ha_O,2),1));
BlueW_L_Agg_sugar_glb = BlueW_Lha_Agg_sugar_glb .* portf.HARVST_DeltaGB .*100;
 
BlueW_L_Agg_sugar_std_glb = nanstd(BlueW_L_Agg_sugar_glb,0,1);
 
 
% BlueW_Lha_Agg_sugar = squeeze(nansum(BlueW_Lha_sugar .* AreaH_ha_O, 2) ./ nansum(AreaH_ha_O,2));



