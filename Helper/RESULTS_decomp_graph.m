function RESULTS_decomp_graph(var_dep,var_tot,tlt,y_label,filename,country_label,crop_label,result_dir)
dim = size(var_dep);
co_dim = dim(1);
cr_dim = dim(2);
c = ...
   [     0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840;
    0.6816    0.7812    0.9324;
    0.8387    0.3042    0.6900;
    0.4600    0.7597    0.9590;
    0.5477    0.3999    0.0376];

%%% Nitrogen Surplus Changes
%%% Adding global impacts
var_dep_global(1:co_dim+1,1:cr_dim) = nan;
var_dep_global(2:co_dim+1,1:cr_dim) = var_dep;
var_dep_global(1,1:cr_dim) = nansum(var_dep,1);
var_tot_global(1:co_dim+1,1) = nan;
var_tot_global(2:co_dim+1,1) = var_tot;
var_tot_global(1,1) = nansum(var_tot,1);

var_dep_pos = var_dep_global;
var_dep_neg = var_dep_global;
var_dep_pos(var_dep_pos<0) = 0;
var_dep_neg(var_dep_neg>0) = 0;

figure('units','normalized','outerposition',[0 0 1 1]);
b_p = bar(1:co_dim+1,var_dep_pos,'stacked');
hold on;
b_n = bar(1:co_dim+1,var_dep_neg,'stacked');
xticklabels(country_label);
for k=1:cr_dim
  set(b_p(k),'facecolor',c(k,:))
  set(b_n(k),'facecolor',c(k,:))
  set(b_p(k),'EdgeColor',c(k,:))
  set(b_n(k),'EdgeColor',c(k,:))
end
xticklabels(country_label);
hold on;
s = scatter(1:co_dim,var_tot_global,100,'k','filled')
h = [b_p,s];
label = horzcat(crop_label, "Total");
leg1 = legend(h,label);
ylabel(y_label);
title(tlt,'FontSize',16);
hold off;
print([result_dir filename], '-djpeg');

end

