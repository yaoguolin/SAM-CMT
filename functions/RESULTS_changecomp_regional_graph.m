function RESULTS_changecomp_regional_graph(var_original,var_new,var_changes,...
    tlt,y_label_left,y_label_right,lgd,filename,country_label,result_dir)

%%% Nitrogen Use Efficiency Changes
dim = size(var_original);
co_dim = dim(1);


figure('units','normalized','outerposition',[0 0 1 1]);
yyaxis left
b = bar(var_changes);
ylabel(y_label_left);
hold on;

yyaxis right
s1 = scatter(1:co_dim,var_original,65,'filled','g');
set(gca,'XTick',1:co_dim,'XTickLabel',country_label)
ylabel(y_label_right);
hold on;
s2 = scatter(1:co_dim,var_new,65,'filled','r');
title(tlt,'FontSize',16);
legend(lgd);
hold off;
print([result_dir filename], '-djpeg');

end



