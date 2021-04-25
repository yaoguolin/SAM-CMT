function [h]=RESULTS_decomp_graph09262019_nototal(var_dep,var_tot,tlt,y_label,country_label)
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
    0.4600    0.6597    0.9590;
    0.5477    0.3999    0.0376];

%%% Nitrogen Surplus Changes
%%% Adding global impacts


var_dep_pos = var_dep;
var_dep_neg = var_dep;
var_dep_pos(var_dep_pos<0) = 0;
var_dep_neg(var_dep_neg>0) = 0;

%figure('units','normalized','outerposition',[0 0 1 1]);
b_p = bar(1:co_dim,var_dep_pos,'stacked','BarWidth',0.7);
hold on;
b_n = bar(1:co_dim,var_dep_neg,'stacked','BarWidth',0.7);
xticklabels(country_label);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 14)
for k=1:cr_dim
  set(b_p(k),'facecolor',c(k,:))
  set(b_n(k),'facecolor',c(k,:))
  set(b_p(k),'EdgeColor',c(k,:))
  set(b_n(k),'EdgeColor',c(k,:))
end
xticklabels(country_label);
set(gca, 'FontSize', 14)
hold on;
h = [b_p];
%leg1 = legend(h,label,'Location','northeastoutside');
ylabel(y_label);
title(tlt,'FontSize',16);
hold off;

end

