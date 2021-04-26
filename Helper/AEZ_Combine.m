%% National Base Cases

AEZ_CELL{1} = squeeze(AEZS.Intensity.Nsur_kgkm_AEZ_AggCO(:,:,54)) ./100; % base Nsur intensity
AEZ_CELL{2} = squeeze(AEZS.Intensity.Nsur_kgkm_AEZ_Agg(:,:,5,54)) ./100; % base soybean Nsur intensity
AEZ_CELL{3} = squeeze(AEZS.Intensity.Nsur_Vir_AEZ_kgkm_AggCO(:,:,54))./100  % base virtual nitrogen
AEZ_CELL{4} = squeeze(AEZS.Intensity.Nsur_Alt_AEZ_kgkm_AggCO(:,:,54))./100  % base alternative nitrogen


%% Extreme Cases National

AEZ_CELL{5} = AEZS.Intensity.Nsur_kgkm_AEZ_DeltaCO ./100;
AEZ_CELL{6} = AEZS.Intensity.Nsur_Vir_AEZ_kgkm_DeltaCO ./100;
AEZ_CELL{7} = AEZS.Intensity.Nsur_Alt_AEZ_kgkm_DeltaCO ./100;
AEZ_CELL{8} = AEZS.Intensity.Psur_kgkm_AEZ_DeltaCO ./100;
AEZ_CELL{9} = AEZS.Intensity.h2oDeplete_Lkm_AEZ_DeltaCO ./100;
AEZ_CELL{10} = AEZS.Intensity.BlueW_Lkm_AEZ_DeltaCO ./100;



%% Extreme Cases Soybean
%{
AEZ_CELL{5} = squeeze(AEZS.Intensity.Nsur_kgkm_AEZ_Delta(:,:,5)) ./100;
AEZ_CELL{6} = squeeze(AEZS.Intensity.Psur_kgkm_AEZ_Delta(:,:,5)) ./100;
AEZ_CELL{7} = squeeze(AEZS.Intensity.h2oDeplete_Lkm_AEZ_Delta(:,:,5)) ./100;
AEZ_CELL{8} = squeeze(AEZS.Intensity.BlueW_Lkm_AEZ_Delta(:,:,5)) ./100;
%}
%% Normal Cases National
AEZ_CELL{11} = AEZS2.Intensity.Nsur_kgkm_AEZ_DeltaCO ./100;
AEZ_CELL{12} = AEZS2.Intensity.Nsur_Vir_AEZ_kgkm_DeltaCO ./100;
AEZ_CELL{13} = AEZS2.Intensity.Nsur_Alt_AEZ_kgkm_DeltaCO ./100;
AEZ_CELL{14} = AEZS2.Intensity.Psur_kgkm_AEZ_DeltaCO ./100;
AEZ_CELL{15} = AEZS2.Intensity.h2oDeplete_Lkm_AEZ_DeltaCO ./100;
AEZ_CELL{16} = AEZS2.Intensity.BlueW_Lkm_AEZ_DeltaCO ./100;


%% Normal Cases Soybean
%{
AEZ_CELL{13} = squeeze(AEZS2.Intensity.Nsur_kgkm_AEZ_Delta(:,:,5)) ./100;
AEZ_CELL{14} = squeeze(AEZS2.Intensity.Psur_kgkm_AEZ_Delta(:,:,5)) ./100;
AEZ_CELL{15} = squeeze(AEZS2.Intensity.h2oDeplete_Lkm_AEZ_Delta(:,:,5)) ./100;
AEZ_CELL{16} = squeeze(AEZS2.Intensity.BlueW_Lkm_AEZ_Delta(:,:,5)) ./100;
%}

%% Load Country GIS Mapping
i = 0;
%%% Create Region-AEZ identifier
CN_AEZ = strings(108,1);
for cn = 1:1:6
    for az = 1:1:18
        i = i+1;
        CN_AEZ(i,1) = [CN_ARY{cn},num2str(az)];
    end
end

%%% AEZ_CELL from wide to long
for n = 1:1:16
    clear temp;
    temp(1:108,1) = nan;
    for cn = 1:1:6
      temp((cn-1)*18+1:cn*18,1) = transpose(AEZ_CELL{n}(cn,1:18));
    end
    AEZ_CELL_LONG{n} = temp;
end

%%% load in GIS data
GIS_FILE = 'GISMAP_CNMAP_R.csv';
clear fname;
fname = [dir 'Application' dir_s 'Inputs' dir_s GIS_FILE];
fid = fopen(fname)

fmt = '%f	%f	%f	%s	%f	%s	%s %s';                                %***
hd_no = 8;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt,'delimiter',',');
fclose(fid);

CN_AEZ_ARY = Raw_Data{8};
data_len = length(CN_AEZ_ARY);
%%% Rearrange data based on CN_AEZ_ARY order
AEZ_CELL_ARRANGE(1:data_len,1:16) = nan;

for n = 1:1:16
    for i = 1:1:data_len
        clear ind;
        ind = find(CN_AEZ_ARY(i) == CN_AEZ);
        if length(ind) == 1
            AEZ_CELL_ARRANGE(i,n) = AEZ_CELL_LONG{n}(ind,1);
        else
            AEZ_CELL_ARRANGE(i,n) = nan;
        end
    end
end
