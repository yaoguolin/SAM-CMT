function [] = plotBarStack_Decomp_intensity(n, co_dim,cr_dim,var_dep_global,var_tot_global,var_dep_pos,var_dep_neg,...
          int_delta_co,int_new_tot,int_org_tot,country_label,crop_label,...
          y_label,y_label_left,y_label_right,...
          tlt_left,tlt_right,lgd2,result_dir,filename)

%%% This function is prepared for nutrient pollution and pollution
%%% intensity comparisons

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

figure('units','normalized','outerposition',[0 0 1 1]);

[ha, pos] = tight_subplot(n,2,[0.04 0.05],[.1 .05],[.04 .1]) 

%% first figure
for i = 1:n
    axes(ha(2*i-1));
    %    hold on; 

    %subplot(1,2,1)

    b_p = bar(1:co_dim+1,var_dep_pos{i},'stacked');
    hold on;
    b_n = bar(1:co_dim+1,var_dep_neg{i},'stacked');
    %xticklabels(country_label);
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 14)

    for k=1:cr_dim
      set(b_p(k),'facecolor',c(k,:))
      set(b_n(k),'facecolor',c(k,:))
      set(b_p(k),'EdgeColor',c(k,:))
      set(b_n(k),'EdgeColor',c(k,:))
    end

    hold on;
    s = scatter(1:co_dim+1,var_tot_global{i},50,'k','filled')
    hold on;
    y = get(gca,'ylim');
    plot([1.5 1.5],y,':','LineWidth',2,'Color',[0.5 0.5 0.5]);

    hold off;
    %h = [b_p,s];
    %label = horzcat(crop_label, "Total");
    %leg1 = legend(h,label,'Location','northeast');
    ylabel(y_label(i));

    set(gca,'XTickMode','manual');
    set(gca,'XTick',1:co_dim+1);
    set(gca, 'FontSize', 10)
    set(gca,'YTickMode','manual');
   if i < n
        set(gca,'Xticklabel',[]);
   else set(gca,'Xticklabel',country_label);
   end
    %set(gca,'XColor','none')

    title(tlt_left(i),'FontSize',12);

    box off;

    %xa = get(gca,'Position')
    %yyaxis right
    %% Second figure
    axes(ha(2*i));
    %subplot(1,2,2)

    yyaxis left
    b = bar(int_delta_co{i},'FaceAlpha',0.5,'EdgeAlpha',0);
    ylabel(y_label_left(i));
    hold on;

    yyaxis right
    s1 = scatter(1:co_dim+1,int_org_tot{i},65,'filled','r');
    % set(gca,'XTick',1:co_dim+1,'XTickLabel',country_label)
    ylabel(y_label_right(i));
    hold on;
    s2 = scatter(1:co_dim+1,int_new_tot{i},40,'filled','g','MarkerFaceAlpha',0.8);
    title(tlt_right(i),'FontSize',12);


    hold on;
    v = plot([1.5 1.5],ylim,':','LineWidth',2,'Color',[0.5 0.5 0.5]);

    lb = [b,s1,s2];
 %   legend(lb,lgd2,'Location','northeast');

    hold off;



    set(gca,'XTickMode','manual');
    %set(gca,'XTickLabelMode','manual');
    set(gca,'XTickLabel',country_label);
    set(gca, 'FontSize', 10)
   if i < n
        set(gca,'Xticklabel',[]);
   else set(gca,'Xticklabel',country_label);
   end
    box off;

end

%h = [b_p,s,b,s1,s2];
%label = horzcat(crop_label, "Total",lgd2);
%legg = legend(h,label,'Location','northeast');
    
end 


