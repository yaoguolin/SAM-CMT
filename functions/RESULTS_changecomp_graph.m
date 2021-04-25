function RESULTS_changecomp_graph(var_original,var_new,var_changes,...
    var_original_global,var_new_global,var_changes_global,...
    tlt,y_label_left,y_label_right,lgd,filename,country_label,result_dir)

%%% Nitrogen Use Efficiency Changes
dim = size(var_original);
co_dim = dim(1);
var_changes_tot(1:co_dim+1,1) = nan;
var_changes_tot(2:co_dim+1,1) = var_changes;
var_changes_tot(1,1) = var_changes_global;

var_new_tot(1:co_dim+1,1) = nan;
var_new_tot(2:co_dim+1,1) = var_new;
var_new_tot(1,1) = var_new_global;

var_original_tot(1:co_dim+1,1) = nan;
var_original_tot(2:co_dim+1,1) = var_original;
var_original_tot(1,1) = var_original_global;

figure('units','normalized','outerposition',[0 0 1 1]);
yyaxis left
b = bar(var_changes_tot);
ylabel(y_label_left);
hold on;

yyaxis right
s1 = scatter(1:co_dim+1,var_original_tot,65,'filled','g');
set(gca,'XTick',1:co_dim+1,'XTickLabel',country_label)
ylabel(y_label_right);
hold on;
s2 = scatter(1:co_dim+1,var_new_tot,65,'filled','r');
title(tlt,'FontSize',16);
legend(lgd);
hold off;
print([result_dir filename], '-djpeg');

end

