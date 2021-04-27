clear;

dir = 'C:\Research\Post-Doc Research\HarvestedAreaYield\HarvestedAreaYield175Crops_Geotiff\HarvestedAreaYield175Crops_Geotiff\'; %***
dir_s = '\';                                              %***

load([dir 'basic_FAO_SAM.mat'])
load([dir 'basic_N_SAM_F.mat'])
load([dir 'basic_P_SAM2.mat'])
load([dir 'BLUE_water.mat'])
load([dir 'water_depletion_WUE_SAM_56yr.mat'])

lati = 90:-0.5:-89.5;
longi = -180:0.5:179.5;

%% Blue Water and Ground Water Depletion

WF_Blue_m3ton_56(1:218,1:170,1:56) = nan;
WF_Blue_m3ton_56(1:218,1:170,1:54) = WF_Blue_m3ton;  %L/kg
WF_Blue_m3ton_56(1:218,1:170,55) = WF_Blue_m3ton_56(1:218,1:170,54); 
WF_Blue_m3ton_56(1:218,1:170,56) = WF_Blue_m3ton_56(1:218,1:170,54);
BlueW_Lkm = WF_Blue_m3ton_56 .* Product_FAO ./ AreaH_FAO;

h2oDeplete_Lkm = h2oDeplete_3d_gf .* Product_FAO ./AreaH_FAO;

%% Get the average of the last three years
Psur_kgkm = Pinput_kgkm - Pyield_kgkm;

%{
Nsur_1 = Nsur_kgkm>0 .*1;
Psur_1 = Psur_kgkm>0 .*1;
BlueW_1 = BlueW_Lkm>0 .*1;
h2oDeplete_1 = h2oDeplete_Lkm>0 .*1;
AreaH_1 = AreaH_FAO>0 .*1;

AreaH_N = AreaH_FAO .* AreaH_1 .* Nsur_1;
AreaH_P = AreaH_FAO .* AreaH_1 .* Psur_1;
AreaH_B = AreaH_FAO .* AreaH_1 .* BlueW_1;
AreaH_G = AreaH_FAO .* AreaH_1 .* h2oDeplete_1;

Nsur_kg = Nsur_kgkm .* AreaH_FAO;
Psur_kg = Psur_kgkm .* AreaH_FAO;
BlueW_L = BlueW_Lkm .* AreaH_FAO;
h2oDeplete_L = h2oDeplete_Lkm .* AreaH_FAO;

Nsur_kgkm_avg = nansum(Nsur_kg(:,:,54:56),3) ./nansum(AreaH_N(:,:,54:56),3);
Psur_kgkm_avg = nansum(Psur_kg(:,:,54:56),3) ./nansum(AreaH_P(:,:,54:56),3);
BlueW_L_avg = nansum(BlueW_L(:,:,54:56),3) ./nansum(AreaH_B(:,:,54:56),3);
h2oDeplete_L_avg = nansum(h2oDeplete_L(:,:,54:56),3) ./nansum(AreaH_G(:,:,54:56),3);
%}

Nsur_kgkm_avg = nanmean(Nsur_kgkm(:,:,54:56),3);
Psur_kgkm_avg = nanmean(Psur_kgkm(:,:,54:56),3);
BlueW_Lkm_avg = nanmean(BlueW_Lkm(:,:,54:56),3);
h2oDeplete_Lkm_avg = nanmean(h2oDeplete_Lkm(:,:,54:56),3);

% Sudan == Ethiopia
Nsur_kgkm_avg(182,:) = Nsur_kgkm_avg(64,:);
load('ProcessedHArea_Grided_30mins.mat', 'crpary_SAM')

%% load GTAP longitude and latitude data
%{
clear fname;
fname = [dir 'GridtoSAMCNNames.csv'];%%%% from gridded country names to SAM country names
fid = fopen(fname);

fmt = '%s %f %s';                                    %***
hd_no = 3;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);

         GRIDCN_LIST = string(Raw_Data{1,1});
         SAMORDER_LIST = Raw_Data{1,2};
%}

%%% load GTAP longitude and latitude data
clear fname;
fname = [dir 'GTAP_AEZ_Mapping.csv'];
fid = fopen(fname);

fmt = '%f %f %f %f %s %f %s %f %f';                                    %***
hd_no = 9;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);

         LONG_LIST = Raw_Data{1,2};
         LATI_LIST = Raw_Data{1,3};
         AEZ_LIST = Raw_Data{1,4};
         CN_LIST = string(Raw_Data{1,5});
         GTAP_LIST = string(Raw_Data{1,7});
         CNORDER_LIST = Raw_Data{1,8};
         GTAPORDER_LIST = Raw_Data{1,9};

n = length(LONG_LIST);

llaez = nan(360,720);
llcn = nan(360,720);
llgtap = nan(360,720);

for lj = 1:1:720
    for li = 1:1:360
        clear llindx
        llindx = find(LATI_LIST == lati(li) & LONG_LIST == longi(lj));
        if length(llindx) == 1
            llaez(li,lj) = AEZ_LIST(llindx);
            llcn(li,lj) = CNORDER_LIST(llindx);
            llgtap(li,lj) = GTAPORDER_LIST(llindx);
        end
    end
end

%% Intensity Calculation

%%% Calculate total nutrient pollution or water usage

[Nsur_kgkm_GRID,Nsur_kg_GRID] = CalculateTotalPollution(Nsur_kgkm_avg,crpary_SAM,llcn);
[Psur_kgkm_GRID,Psur_kg_GRID] = CalculateTotalPollution(Psur_kgkm_avg,crpary_SAM,llcn);
[BlueW_Lkm_GRID,BlueW_L_GRID] = CalculateTotalPollution(BlueW_Lkm_avg,crpary_SAM,llcn);
[h2oDeplete_Lkm_GRID,h2oDeplete_L_GRID] = CalculateTotalPollution(h2oDeplete_Lkm_avg,crpary_SAM,llcn);


%{
Nsur_kg_GRID = nan(360,720,170);
Psur_kg_GRID = nan(360,720,170);
BlueW_L_GRID = nan(360,720,170);
h2oDeplete_L_GRID = nan(360,720,170);


for li = 1:1:360
    for lj = 1:1:720
        cnind = llcn(li,lj);
        if (isnan(cnind)==1) || (cnind == 999)
            Nsur_kg_GRID(li,lj,:) = nan; 
            Psur_kg_GRID(li,lj,:) = nan; 
            BlueW_L_GRID(li,lj,:) = nan; 
            h2oDeplete_L_GRID(li,lj,:) = nan;
        else    
            Nsur_kg_GRID(li,lj,:) = squeeze(Nsur_kgkm_avg(cnind,:)) .* reshape(crpary_SAM(li,lj,:),1,170); 
            Psur_kg_GRID(li,lj,:) = squeeze(Psur_kgkm_avg(cnind,:)) .*reshape(crpary_SAM(li,lj,:),1,170); 
            BlueW_L_GRID(li,lj,:) = squeeze(BlueW_Lkm_avg(cnind,:)) .*reshape(crpary_SAM(li,lj,:),1,170); 
            h2oDeplete_L_GRID(li,lj,:) = squeeze(h2oDeplete_Lkm_avg(cnind,:)) .* reshape(crpary_SAM(li,lj,:),1,170);
        end
    end
end

%%% Calculate intensity

Nsur_kg_GRID_1 = (~isnan(Nsur_kg_GRID) & Nsur_kg_GRID ~= 0).*1;
Psur_kg_GRID_1 = (~isnan(Psur_kg_GRID) & Psur_kg_GRID ~= 0).*1;
BlueW_L_GRID_1 = (~isnan(BlueW_L_GRID) & BlueW_L_GRID ~=0).*1;
h2oDeplete_L_GRID_1 = (~isnan(h2oDeplete_L_GRID) & h2oDeplete_L_GRID ~=0).*1;
crpary_SAM_1 =  (~isnan(crpary_SAM) & crpary_SAM ~=0).*1;

crpary_SAM_N = crpary_SAM_1 .* Nsur_kg_GRID_1 .* crpary_SAM;
crpary_SAM_P = crpary_SAM_1 .* Psur_kg_GRID_1 .* crpary_SAM;
crpary_SAM_B = crpary_SAM_1 .* BlueW_L_GRID_1 .* crpary_SAM;
crpary_SAM_G = crpary_SAM_1 .* h2oDeplete_L_GRID_1 .* crpary_SAM;

Nsur_kgkm_GRID = nansum(Nsur_kg_GRID,3)./ nansum(crpary_SAM_N,3); %*****************
Psur_kgkm_GRID = nansum(Psur_kg_GRID,3)./ nansum(crpary_SAM_P,3); %*****************
BlueW_Lkm_GRID = nansum(BlueW_L_GRID,3)./ nansum(crpary_SAM_B,3); %*****************
h2oDeplete_Lkm_GRID = nansum(h2oDeplete_L_GRID,3)./ nansum(crpary_SAM_G,3); %*****************
%}
%% Intensity after shocks

%%% Import new harvested area data for each grid for 170 crop types based
%%% on the % changes for 6 regions and 10 crop types

%%% Load Simulated results
load('SAM_CMT_Inputs.mat', 'CR_MAP')
load('SAM_CMT_Inputs.mat', 'CN_MAP')

load('SAM_CMT_Inputs.mat', 'CN_ARY')
load('SAM_CMT_Inputs.mat', 'CN_MAP')
load('SAM_CMT_Inputs.mat', 'CR_ARY')
load('SAM_CMT_Inputs.mat', 'CR_IND')
load('SAM_CMT_Inputs.mat', 'CR_MAP')


%%% Normal Case Harvested area
clear fname;
fname = [dir 'harvst_aez_reg_all.csv'];
fid = fopen(fname);

fmt = ' %f %s %f %f %f %f %f %f %f %f %f %f %f';            %***
hd_no = 13;                                               %***


Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);
      
        harvst_changes_normal = cell2mat(Raw_Data(3:13));        %***

%%% Extreme Case Harvested area
clear fname;
fname = [dir 'harvst_aez_reg_extreme.csv'];
fid = fopen(fname);

fmt = ' %f %s %f %f %f %f %f %f %f %f %f %f %f';            %***
hd_no = 13;                                               %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);
      
        harvst_changes_extreme = cell2mat(Raw_Data(3:13));        %***

%%% Harvested Area after the changes
%%%% Normal Cases
harvst_aez_normal = nan(6,18,11);
harvst_aez_extreme = nan(6,18,11);
for cn = 1:1:6
    cnend = cn*18;
    cnstd = (cn - 1)*18 + 1;
    harvst_aez_normal(cn,:,:) = harvst_changes_normal(cnstd:cnend,:);
    harvst_aez_extreme(cn,:,:) = harvst_changes_extreme(cnstd:cnend,:);
end

%%% Multiply each grid cell with harvested area changes and get the new
%%% area and get the area changes for each grid cell
%%%%% Mapping each country, mapping each crop, and mapping AEZ

%%% Load crop mapping
%%%% Load GTAP Crop Mapping
clear fname;
%%% Load GTAP mapping
fname = [dir 'Crop_Mapping_FAO_GTAP_6.csv'];
fid = fopen(fname);

fmt = ' %f %s %s %f ';                                    %***
hd_no = 4;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);

        CR_MAP = string(Raw_Data{1,3});                   %***
        CR_MAP_NO = Raw_Data{1,4};                        %***

crpary_normal = nan(360,720,170);
crpary_extreme = nan(360,720,170);

for li = 1:1:360
    for lj = 1:1:720
        for cc = 1:1:170
            
            aezind = llaez(li,lj);
            gtapind = llgtap(li,lj);
            ccind = CR_MAP_NO(cc);

            if isnan(aezind) || isnan(gtapind) ||gtapind == 999
                crpary_normal(li,lj,cc) = 0;
                crpary_extreme(li,lj,cc) = 0;
            else
                crpary_normal(li,lj,cc) = crpary_SAM(li,lj,cc).*harvst_aez_normal(gtapind,aezind,ccind)./100;
                crpary_extreme(li,lj,cc) = crpary_SAM(li,lj,cc).*harvst_aez_extreme(gtapind,aezind,ccind)./100;
            end
        end
    end
end

%% Calculate new intensity and intensity changes
%%%% New harvested area
crpary_normal_new = crpary_SAM + crpary_normal;
crpary_extreme_new = crpary_SAM + crpary_extreme;

[Nsur_kgkm_GRID_normal,Nsur_kg_GRID_normal] = CalculateTotalPollution(Nsur_kgkm_avg,crpary_normal_new,llcn);
[Nsur_kgkm_GRID_extreme,Nsur_kg_GRID_extreme] = CalculateTotalPollution(Nsur_kgkm_avg,crpary_extreme_new,llcn);

[Psur_kgkm_GRID_normal,Psur_kg_GRID_normal] = CalculateTotalPollution(Psur_kgkm_avg,crpary_normal_new,llcn);
[Psur_kgkm_GRID_extreme,Psur_kg_GRID_extreme] = CalculateTotalPollution(Psur_kgkm_avg,crpary_extreme_new,llcn);

[BlueW_Lkm_GRID_normal,BlueW_L_GRID_normal] = CalculateTotalPollution(BlueW_Lkm_avg,crpary_normal_new,llcn);
[BlueW_Lkm_GRID_extreme,BlueW_L_GRID_extreme] = CalculateTotalPollution(BlueW_Lkm_avg,crpary_extreme_new,llcn);

[h2oDeplete_Lkm_GRID_normal,h2oDeplete_L_GRID_normal] = CalculateTotalPollution(h2oDeplete_Lkm_avg,crpary_normal_new,llcn);
[h2oDeplete_Lkm_GRID_extreme,h2oDeplete_L_GRID_extreme] = CalculateTotalPollution(h2oDeplete_Lkm_avg,crpary_extreme_new,llcn);

%%% Delta Changes
Nsur_kgkm_GRID_Delta_normal = Nsur_kgkm_GRID_normal - Nsur_kgkm_GRID;
Psur_kgkm_GRID_Delta_normal = Psur_kgkm_GRID_normal - Psur_kgkm_GRID;
BlueW_Lkm_GRID_Delta_normal = BlueW_Lkm_GRID_normal - BlueW_Lkm_GRID;
h2oDeplete_Lkm_GRID_Delta_normal = h2oDeplete_Lkm_GRID_normal - h2oDeplete_Lkm_GRID;

Nsur_kgkm_GRID_Delta_extreme = Nsur_kgkm_GRID_extreme - Nsur_kgkm_GRID;
Psur_kgkm_GRID_Delta_extreme = Psur_kgkm_GRID_extreme - Psur_kgkm_GRID;
BlueW_Lkm_GRID_Delta_extreme = BlueW_Lkm_GRID_extreme - BlueW_Lkm_GRID;
h2oDeplete_Lkm_GRID_Delta_extreme = h2oDeplete_Lkm_GRID_extreme - h2oDeplete_Lkm_GRID;


%%% Compile all results into one table

[Nsur_kgkm_GRID2d] = trans2D1D(Nsur_kgkm_GRID);
[Psur_kgkm_GRID2d] = trans2D1D(Psur_kgkm_GRID);
[BlueW_Lkm_GRID2d] = trans2D1D(BlueW_Lkm_GRID);
[h2oDeplete_Lkm_GRID2d] = trans2D1D(h2oDeplete_Lkm_GRID);

[Nsur_kgkm_GRID_Delta_normal2d] = trans2D1D(Nsur_kgkm_GRID_Delta_normal);
[Psur_kgkm_GRID_Delta_normal2d] = trans2D1D(Psur_kgkm_GRID_Delta_normal);
[BlueW_Lkm_GRID_Delta_normal2d] = trans2D1D(BlueW_Lkm_GRID_Delta_normal);
[h2oDeplete_Lkm_GRID_Delta_normal2d] = trans2D1D(h2oDeplete_Lkm_GRID_Delta_normal);

[Nsur_kgkm_GRID_Delta_extreme2d] = trans2D1D(Nsur_kgkm_GRID_Delta_extreme);
[Psur_kgkm_GRID_Delta_extreme2d] = trans2D1D(Psur_kgkm_GRID_Delta_extreme);
[BlueW_Lkm_GRID_Delta_extreme2d] = trans2D1D(BlueW_Lkm_GRID_Delta_normal);
[h2oDeplete_Lkm_GRID_Delta_extreme2d] = trans2D1D(h2oDeplete_Lkm_GRID_Delta_normal);

crpary_SAM_tot = squeeze(nansum(crpary_SAM,3));

indx_array = nan(259200,2);

for j = 1:1:720
    for i = 1:1:360
        clear ind
        ind = (j-1)*360+i;
        crpary_SAM_tot2d(ind)= crpary_SAM_tot(i,j);
        indx_array(ind,1) = longi(j);
        indx_array(ind,2) = lati(i);
    end
end

grid_compile = nan(259200,15);
grid_compile(:,1:2) = indx_array;
grid_compile(:,3) = crpary_SAM_tot2d.*100;
grid_compile(:,4) = Nsur_kgkm_GRID2d./100;
grid_compile(:,5) = Psur_kgkm_GRID2d./100;
grid_compile(:,6) = BlueW_Lkm_GRID2d./100;
grid_compile(:,7) = h2oDeplete_Lkm_GRID2d./100;

grid_compile(:,8) = Nsur_kgkm_GRID_Delta_normal2d./100;
grid_compile(:,9) = Psur_kgkm_GRID_Delta_normal2d./100;
grid_compile(:,10) = BlueW_Lkm_GRID_Delta_normal2d./100;
grid_compile(:,11) = h2oDeplete_Lkm_GRID_Delta_normal2d./100;

grid_compile(:,12) = Nsur_kgkm_GRID_Delta_extreme2d./100;
grid_compile(:,13) = Psur_kgkm_GRID_Delta_extreme2d./100;
grid_compile(:,14) = BlueW_Lkm_GRID_Delta_extreme2d./100;
grid_compile(:,15) = h2oDeplete_Lkm_GRID_Delta_extreme2d./100;







