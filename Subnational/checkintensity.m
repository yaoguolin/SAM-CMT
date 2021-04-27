function [int_avg_sumCN,int_sumCN]=checkintensity(int_avg,int_2014,tlt)
int_avg_sumCN = nanmean(int_avg,1);
int_sumCN = nanmean(int_2014,1);

figure;
plot(int_sumCN);
hold on
plot(int_avg_sumCN);
legend({"2014","AVG2014-2016"})
hold off
title(tlt)
end

