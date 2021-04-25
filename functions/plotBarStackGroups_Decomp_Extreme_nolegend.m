function [] = plotBarStackGroups_Decomp_Extreme_nolegend(stackData,stackData_tot, groupLabels,eleLabels,ylabel1,unit,tlt)
%%% This function is modified based on https://www.mathworks.com/matlabcentral/fileexchange/32884-plot-groups-of-stacked-bars.
%%% Before using this function, we need to use fstackData to prepare the
%%% stackData input.
%%% Plot a set of stacked bars, but group them according to labels provided.
%%%
%%% Params: 
%%%      stackData is a 3D matrix (i.e., stackData(i, j, k) => (Group, Stack, StackElement)) 
%%%      groupLabels is a CELL type (i.e., { 'a', 1 , 20, 'because' };)
%%%
%%% Copyright 2011 Evan Bollig (bollig at scs DOT fsu ANOTHERDOT edu

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

NumGroupsPerAxis = size(stackData, 1);
NumStacksPerGroup = size(stackData, 2);
NumElement = size(stackData,3);

stackData_pos = stackData;
stackData_pos(stackData_pos<0) = 0;
stackData_neg = stackData;
stackData_neg(stackData_neg>0) = 0;

stackData_tot_diff = stackData_tot(:,2) - stackData_tot(:,1);

% Count off the number of bins
groupBins = 1:NumGroupsPerAxis;
MaxGroupWidth = 0.65; % Fraction of 1. If 1, then we have all bars in groups touching
groupOffset = MaxGroupWidth/NumStacksPerGroup;
barw = groupOffset - 0.025;

figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(1,1,[0 0],[.1 .05],[.07 .01]) 
%% first figure
axes(ha(1));
    hold on; 
%yyaxis left
for i=1:NumStacksPerGroup

    Y_pos = squeeze(stackData_pos(:,i,:));
    Y_neg = squeeze(stackData_neg(:,i,:));
    % Center the bars:
    
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    
    % Offset the group draw positions:
    groupDrawPos = (internalPosCount)* groupOffset + groupBins;
    
    b_p(i,:) = bar(ha(1),Y_pos, 'stacked');
    b_n(i,:) = bar(ha(1),Y_neg, 'stacked');
    set(b_p(i,:),'BarWidth',barw);
    set(b_n(i,:),'BarWidth',barw);
    set(b_p(i,:),'XData',groupDrawPos);
    set(b_n(i,:),'XData',groupDrawPos);

s(i) = scatter(groupDrawPos,stackData_tot(:,i),30,'k','filled')

end

xlim([0.4,7.6])

ax = gca;
ax.YRuler.Exponent = 0;

yticklb = get(gca, 'YTick');

set(gca,'YTickLabel',yticklb)

%yticklabels(yticklb);


p1 = plot(NumStacksPerGroup,nan(size(NumStacksPerGroup)));
p2 = plot(NumStacksPerGroup,nan(size(NumStacksPerGroup)));
p3 = plot(NumStacksPerGroup,nan(size(NumStacksPerGroup)));
p4 = plot(NumStacksPerGroup,nan(size(NumStacksPerGroup)));
p5 = plot(NumStacksPerGroup,nan(size(NumStacksPerGroup)));
p6 = plot(NumStacksPerGroup,nan(size(NumStacksPerGroup)));

h = [b_p(1,:),s(:,1),p1,p2,p3,p4,p5,p6];
label = horzcat(eleLabels, "Total","S1XXXXXXXXXXXXX","S2XXXXXXXXXXXXX","S3XXXXXXXXXXXXX","S4XXXXXXXXXXXXX","S5XXXXXXXXXXXXX","S6XXXXXXXXXXXXX");
ylabel([ylabel1]);
for k=1:NumElement
  set(b_p(:,k),'facecolor',c(k,:))
  set(b_n(:,k),'facecolor',c(k,:))
  set(b_p(:,k),'EdgeColor',c(k,:))
  set(b_n(:,k),'EdgeColor',c(k,:))
end

tt = ["Standard","Extreme"];
for i = 1:2
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    groupDrawPos = (internalPosCount)* groupOffset + groupBins;
    xpos = groupDrawPos(1)-0.155;
    ypos = nansum(Y_neg(1,:),2).*1.03;
    text(xpos,ypos,tt(i),'FontSize',11)
end

%hline(0,'r','')
hold on;
y = get(gca,'ylim');
plot([1.5 1.5],y,':','LineWidth',2,'Color',[0.5 0.5 0.5]);


set(gca,'XTickMode','manual');
set(gca,'XTick',1:NumGroupsPerAxis);
set(gca, 'FontSize', 10)
set(gca,'YTickMode','manual');
%set(gca,'XColor','none')




hold on
%yyaxis right
%% Second figure


set(gca,'XTickMode','manual');
set(gca,'XTick',1:NumGroupsPerAxis);
%set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',groupLabels);
set(gca, 'FontSize', 16)
%set(gca,'TickDir','out')
%set(gca,'XColor','none')


%yticklabels(get(gca, 'YTick'));



%plot([1.5 1.5],[ylabel2(1) ylabel2(length(ylabel2))],':','LineWidth',2,'Color',[0.5 0.5 0.5]);


title(tlt,'FontSize',18)


end 


