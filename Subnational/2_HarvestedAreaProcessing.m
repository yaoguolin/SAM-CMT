clear;

%%% First: Run From_tiff_to_numpy_array_from_5mins_to_30mins.ipynb and get
%%% 'earthstats_area_ha_2000_30mins.mat'

%%% Second: Run this script and process data
%% Directory Setting
dir = 'C:\Research\Post-Doc Research\HarvestedAreaYield\HarvestedAreaYield175Crops_Geotiff\HarvestedAreaYield175Crops_Geotiff\'; %***
dir_s = '\';                                              %***

load([dir 'earthstats_area_ha_2000_30mins.mat'])
load([dir 'basic_FAO_SAM.mat'])

%% Load Crop Mapping
clear fname;
%%% Load GTAP mapping
fname = [dir 'Crop_Mapping.csv'];
fid = fopen(fname);

fmt = ' %s %s %s %f ';                                    %***
hd_no = 4;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);

        CR_LIST = string(Raw_Data{1,2});

%% Load GTAP Mapping
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
        
%% From 175 crops to 170 SAM Crop
crpary_SAM = nan(360,720,170);        

for c = 1:1:170
    clear cind;
    cind = find(FAOSTAT_CrName_FAO(c) == CR_LIST);
    if length(cind)==1
        crpary_SAM(:,:,c) = crpary(:,:,cind);
    end
end

%% From 170 SAM Crop to 11 Crop Types
crpary_GTAP = nan(360,720,11);
CR_ARY = ["Paddy_Rice","Wheat","Sorghum","Oth_CrGr","Soybeans","palmf","Rapeseed",...
    "Oth_Oilseeds","Sugar_Crop","OthAgri","Pasturecrop"];

for c = 1:1:11
    clear gcind;
    gcind = find(CR_ARY(c) == CR_MAP);
    crpary_GTAP(:,:,c) = nansum(crpary_SAM(:,:,gcind),3);
end

%% Expand Crops to 2d array
crpary_GTAP_2d = nan(259200,11);
indx_array = nan(259200,2);

%%% Generate longitude and latitude arrays
lati = 90:-0.5:-89.5;
longi = -180:0.5:179.5;


for j = 1:1:720
    for i = 1:1:360
        clear ind
        ind = (j-1)*360+i;
        crpary_GTAP_2d(ind,:) = crpary_GTAP(i,j,:);
        indx_array(ind,1) = longi(j);
        indx_array(ind,2) = lati(i);
    end
end

save([dir 'ProcessedHArea_Grided_30mins.mat'])
%% END
%% Add AEZ dimension
%%% Generate longitude and latitude arrays
lati = -90:0.5:89.5;
longi = -180:0.5:179.5;

%%% load GTAP longitude and latitude data
clear fname;
fname = [dir 'GTAP_AEZ_Mapping.csv'];
fid = fopen(fname);

fmt = '%f %f %f %f %s %f ';                                    %***
hd_no = 6;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt, 'delimiter',',');
fclose(fid);

         LONG_LIST = Raw_Data{1,2};
         LATI_LIST = Raw_Data{1,3};
         AEZ_LIST = Raw_Data{1,6};
         CN_LIST = string(Raw_Data{1,5});
         
%%% Mapping longitude, latitude, and AEZs
llaez = nan(360,720);
for li = 1:1:360
    for lj = 1:1:720
        clear llindx
        llindx = find(lati(li) == LATI_LIST & longi(lj) == LONG_LIST);
        if length(llindx) == 1
            llaez(li,lj) = AEZ_LIST(llindx);
        end
    end
end

%%% 
