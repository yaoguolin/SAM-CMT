
%% Trade Balance of crops
TRA_BAL_crops_N = trade_bal_deltaco2 ./ 1000000; % normal million US$
TRA_BAL_crops_E = trade_bal_deltaco ./ 1000000;% extreme
%% Trade Balance total
TRA_BAL_N = [-305;-457;106;1155;183;-684];
TRA_BAL_E = [-237;-406;152;1060;335;-903];

%% Economic Welfare
EWF_N = [-2206;15.9;1532;-1745;672;575];
EWF_E = [-3089;-92.4;2033;-2308;1064;567];

TR_WF_EDC_US = nan(2,5);
TR_WF_EDC_CN = nan(2,5);

TR_WF_EDC_US(1,1) = TRA_BAL_crops_N(1,1);
TR_WF_EDC_US(1,2) = TRA_BAL_N(1,1);
TR_WF_EDC_US(1,3) = EWF_N(1,1);
TR_WF_EDC_US(1,4) = Econ2.Nsur_DC_US_avg_Delta./1000000;
TR_WF_EDC_US(1,5) = Phos2.Psur.Psur_kg_DeltaCO(1,1).*22.15./1000000;

TR_WF_EDC_US(2,1) = TRA_BAL_crops_E(1,1);
TR_WF_EDC_US(2,2) = TRA_BAL_E(1,1);
TR_WF_EDC_US(2,3) = EWF_E(1,1);
TR_WF_EDC_US(2,4) = Econ.Nsur_DC_US_avg_Delta./1000000;
TR_WF_EDC_US(2,5) = Phos.Psur.Psur_kg_DeltaCO(1,1).*22.15./1000000;


TR_WF_EDC_CN(1,1) = TRA_BAL_crops_N(4,1);
TR_WF_EDC_CN(1,2) = TRA_BAL_N(4,1);
TR_WF_EDC_CN(1,3) = EWF_N(4,1);
TR_WF_EDC_CN(1,4) = Econ2.Nsur_DC_CN_avg_Delta./1000000;
TR_WF_EDC_CN(1,5) = Phos2.Psur.Psur_kg_DeltaCO(4,1).*22.15.*0.1./1000000;

TR_WF_EDC_CN(2,1) = TRA_BAL_crops_E(4,1);
TR_WF_EDC_CN(2,2) = TRA_BAL_E(4,1);
TR_WF_EDC_CN(2,3) = EWF_E(4,1);
TR_WF_EDC_CN(2,4) = Econ.Nsur_DC_CN_avg_Delta./1000000;
TR_WF_EDC_CN(2,5) = Phos.Psur.Psur_kg_DeltaCO(4,1).*22.15.*0.1./1000000;

%%% Define Error Bars
err_US_pos = [Econ2.Nsur_DC_US_max_Delta - Econ2.Nsur_DC_US_avg_Delta,...
              Econ.Nsur_DC_US_max_Delta - Econ.Nsur_DC_US_avg_Delta]./1000000;
err_US_neg = [Econ2.Nsur_DC_US_avg_Delta - Econ2.Nsur_DC_US_min_Delta,
              Econ.Nsur_DC_US_avg_Delta - Econ.Nsur_DC_US_min_Delta]./1000000;
          
err_US_posP = [1.52*Phos2.Psur.Psur_kg_DeltaCO(1,1),1.52*Phos.Psur.Psur_kg_DeltaCO(1,1)].*0.1./1000000;
err_US_negP = [1.52*Phos2.Psur.Psur_kg_DeltaCO(1,1),1.52*Phos.Psur.Psur_kg_DeltaCO(1,1)].*0.1./1000000;
        


err_CN_pos = [Econ2.Nsur_DC_CN_max_Delta - Econ2.Nsur_DC_CN_avg_Delta,...
              Econ.Nsur_DC_CN_max_Delta - Econ.Nsur_DC_CN_avg_Delta]./1000000;
err_CN_neg = [Econ2.Nsur_DC_CN_avg_Delta - Econ2.Nsur_DC_CN_min_Delta,
              Econ.Nsur_DC_CN_avg_Delta - Econ.Nsur_DC_CN_min_Delta]./1000000;

err_CN_posP = [1.52*Phos2.Psur.Psur_kg_DeltaCO(4,1),1.52*Phos.Psur.Psur_kg_DeltaCO(4,1)].*0.1./1000000;
err_CN_negP = [1.52*Phos2.Psur.Psur_kg_DeltaCO(4,1),1.52*Phos.Psur.Psur_kg_DeltaCO(4,1)].*0.1./1000000;
  

y_US = TR_WF_EDC_US(:,4);
x_US = [1.15,2.15];

y_USP = TR_WF_EDC_US(:,5);
x_USP = [1.31,2.31];

y_CN = TR_WF_EDC_CN(:,4);
x_CN = [0.6,2];

y_CNP = TR_WF_EDC_CN(:,5);
x_CNP = [0.65,2.05];
c = ...
   [     0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
%    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840;
    0.6816    0.7812    0.9324;
    0.8387    0.3042    0.6900;
    0.4600    0.6597    0.9590;
    0.5477    0.3999    0.0376];

ytick_both = -5000:500:1500;
xtick_both = {'Standard','Extreme'};

figure('units','normalized','outerposition',[0 0 1 1]);

%   in:  Nh      number of axes in hight (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins 


b_US = bar(TR_WF_EDC_US,'EdgeColor','none','BarWidth', 1);

for k = 1:1:5
    set(b_US(:,k),'facecolor',c(k,:))
end

hold on
errorbar(x_US,y_US,err_US_pos,err_US_neg,'o','Color','k','LineWidth',1);

%hold on
%errorbar(x_USP,y_USP,err_US_posP,err_US_negP,'o','Color','k','LineWidth',1);


ylim([-5000,1500])
%xtick_US = get(gca,'XLim');
set(gca,'YTick',ytick_both)
set(gca,'YTickLabel',ytick_both,'FontSize',12)
set(gca,'XTickLabel',xtick_both,'FontSize',12)
ylabel('Million US$','FontSize',14)
%pos_US = get(gca,'Position')
title('USA','FontSize',16);
text([0.66,0.82,0.98,1.14,1.3],[-170,-170,-170,-170,-170],{'CTB','RTB','REW','NDC','PDC'})
text([0.66,0.82,0.98,1.14,1.3]+1,[-170,-170,-170,-170,-170],{'CTB','RTB','REW','NDC','PDC'})
hold off;


legend({'Crop Trade Balance (CTB)','Regional Trade Balance (RTB)',...
    'Regional Economic Welfare (REW)',...
    'N Surplus Economic Damage Cost (NDC)','P Surplus Economic Damange Cost (PDC)'},'Location','southeast','FontSize',12)



