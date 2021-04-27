Psur_kgkm_avg_sumCN = nanmean(Psur_kgkm_avg,1);
Psur_kgkm_sumCN = nanmean(Psur_kgkm(:,:,54),1);

figure;
plot(Psur_kgkm_sumCN);
hold on
plot(Psur_kgkm_avg_sumCN);
legend({"2014","AVG2014-2016"})
hold off

[Nsur_kgkm_avg_sumCN,Nsur_kgkm_sumCN] = checkintensity(Nsur_kgkm_avg,Nsur_kgkm(:,:,54),"Nsur");
[Psur_kgkm_avg_sumCN,Psur_kgkm_sumCN] = checkintensity(Psur_kgkm_avg,Psur_kgkm(:,:,54),"Psur");
[BlueW_Lkm_avg_sumCN,BlueW_Lkm_sumCN] = checkintensity(BlueW_Lkm_avg,BlueW_Lkm(:,:,54),"BlueW")
[h2oDeplete_Lkm_avg_sumCN,h2oDeplete_Lkm_sumCN] = checkintensity(h2oDeplete_Lkm_avg,h2oDeplete_Lkm(:,:,54),"h2oDeplete")

Nsur_kgkm_sumCN_diff = Nsur_kgkm_avg_sumCN - Nsur_kgkm_sumCN;
Nsur_kgkm_sumCN_diff_desc = sort(Nsur_kgkm_sumCN_diff,'descend');
Nsur_kgkm_sumCN_diff_desc5 = Nsur_kgkm_sumCN_diff_desc(1:5);
Nsur_kgkm_sumCN_diff_pos = nan(5,1);


for i = 1:1:5
    Nsur_kgkm_sumCN_diff_pos(i,1) = find(Nsur_kgkm_sumCN_diff==Nsur_kgkm_sumCN_diff_desc5(i))
end

FAOSTAT_CrName_FAO(Nsur_kgkm_sumCN_diff_pos)





Psur_kgkm_sumCN_diff_desc = sort(Psur_kgkm_sumCN,'descend');
Psur_kgkm_sumCN_diff_desc5 = Psur_kgkm_sumCN_diff_desc(1:5);
Psur_kgkm_sumCN_diff_pos = nan(5,1);

for i = 1:1:5
    Psur_kgkm_sumCN_diff_pos(i,1) = find(Psur_kgkm_sumCN==Psur_kgkm_sumCN_diff_desc5(i))
end

FAOSTAT_CrName_FAO(Psur_kgkm_sumCN_diff_pos)


h2oDeplete_Lkm_avg_sumCN_gt0 = find(h2oDeplete_Lkm_avg_sumCN>0);
FAOSTAT_CrName_FAO(h2oDeplete_Lkm_avg_sumCN_gt0)

Nsur_kgkm_2014 = reshape(Nsur_kgkm(:,:,54),37060,1);
Psur_kgkm_2014 = reshape(Psur_kgkm(:,:,54),37060,1);

Pmin = nanmin(Psur_kgkm_2014);
Pmin_pos = find(Psur_kgkm_2014==Pmin);
Psur_kgkm_2014(Pmin_pos) = nan;

figure;
scatter(Nsur_kgkm_2014,Psur_kgkm_2014);
xlabel('Nsur kgkm 2014')
ylabel('Psur kgkm 2014')


Nsur_kgkm_avgf = reshape(Nsur_kgkm_avg,37060,1);
Psur_kgkm_avgf  = reshape(Psur_kgkm_avg,37060,1);

Pmin = nanmin(Psur_kgkm_avgf);
Pmin_pos = find(Psur_kgkm_avgf==Pmin);
Psur_kgkm_avgf(Pmin_pos) = nan;

figure;
scatter(Nsur_kgkm_avgf,Psur_kgkm_avgf);
xlabel('Nsur kgkm avg')
ylabel('Psur kgkm avg')

for i = 1:1:5
    Pmax = nanmax(Psur_kgkm_2014);
    Pmax_pos = find(Psur_kgkm_2014==Pmax);
    Psur_kgkm_2014(Pmax_pos) = nan;
end

figure;
scatter(Nsur_kgkm_2014,Psur_kgkm_2014);
xlabel('Nsur kgkm 2014')
ylabel('Psur kgkm 2014')

for i = 1:1:5
    Pmax = nanmax(Psur_kgkm_avgf);
    Pmax_pos = find(Psur_kgkm_avgf==Pmax);
    Psur_kgkm_avgf(Pmax_pos) = nan;
end

figure;
scatter(Nsur_kgkm_avgf,Psur_kgkm_avgf);
xlabel('Nsur kgkm avg')
ylabel('Psur kgkm avg')