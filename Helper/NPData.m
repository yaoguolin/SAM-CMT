%% Prepare A script for Nitrogen Inputs and Phosphorus Inputs for the most recent three years
load('basic_P_SAM.mat')

load('Nbudget_28-Jan-2019.mat')

save('basic_N_SAM_F.mat','Ndep_kgkm','Nfer_kgkm','Nfix_kgkm','Ninput_kgkm','Nman_kgkm',...
    'Noutput_kgkm','Nsur_kgkm','Nyield_kgkm','contentN')