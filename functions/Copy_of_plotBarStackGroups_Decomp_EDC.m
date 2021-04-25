function [] = plotBarStackGroups_Decomp_Extreme(data_US,data_CN, groupLabels,ylabel1,unit,tlt,result_dir,filename)
%%% This function is modified based on https://www.mathworks.com/matlabcentral/fileexchange/32884-plot-groups-of-stacked-bars.
%%% Before using this function, we need to use fEDCData to prepare the
%%% data_US and Data_CN input.
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

NumGroupsPerAxis = size(data_US, 1);
NumStacksPerGroup = size(data_US, 2);
NumElement = size(data_US,3);

% Count off the number of bins
groupBins = 1:NumGroupsPerAxis;
MaxGroupWidth = 0.65; % Fraction of 1. If 1, then we have all bars in groups touching
groupOffset = MaxGroupWidth/NumStacksPerGroup;
barw = groupOffset - 0.025;

figure('units','normalized','outerposition',[0 0 1 1]);
[ha, pos] = tight_subplot(2,1,[0 0],[.1 .05],[.025 .01]) 
%% first figure
axes(ha(1));
    hold on; 
%yyaxis left
for i=1:NumStacksPerGroup

    Y = squeeze(data_US(:,i,:));
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

s(i) = scatter(groupDrawPos,data_CN(:,i),30,'k','filled')

end

A1 = get(gca,'position');
% Increase the height of the first and third subplots by 10%
A1(1) = A1(1)*3;
A1_diff = A1(4) * 0.75;
% Increase the height of the subplot, but this will keep the
% bottom in the same place
A1(4) = A1(4) + A1_diff;
% So also move the subplot down to decrease the gap to the next
% one.
A1(2) = A1(2) - A1_diff;
A1(3) = A1(3)*0.95;

set(gca,'position',A1);

ax = gca;
ax.YRuler.Exponent = 0;

yticklb = get(gca, 'YTick');
yticklen = length(yticklb);
yticklb = [[""],sprintfc('%1.1e',yticklb(2:yticklen))];

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
ylabel([ylabel1  newline 'by Region and Crop Type']);
for k=1:NumElement
  set(b_p(:,k),'facecolor',c(k,:))
  set(b_n(:,k),'facecolor',c(k,:))
  set(b_p(:,k),'EdgeColor',c(k,:))
  set(b_n(:,k),'EdgeColor',c(k,:))
end
for i = 1:2
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    groupDrawPos = (internalPosCount)* groupOffset + groupBins;
    xpos = groupDrawPos(1)-0.05;
    ypos = nansum(Y_neg(1,:),2).*1.03;
    text(xpos,ypos,['S',num2str(i)])
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

X1 = xlim;

title(tlt,'FontSize',16);

hold on
%yyaxis right
%% Second figure
axes(ha(2));

b_t = bar(stackData_tot_diff,'BarWidth',barw,'FaceColor','r');

set(b_t,'FaceAlpha',0.5);
set(b_t,'EdgeAlpha',0);



%minb_t = 6*nanmin(stackData_tot_diff);
%maxb_t = 1.5*nanmax(stackData_tot_diff);
%if maxb_t<0
%    maxb_t = 0;
%end
%ylim([minb_t,maxb_t])
ylabel(['Total' newline 'Changes ',unit]);

A2 = get(gca,'position');

A2(1) = A1(1);

A2_diff = A2(4)*0.75;
A2(4) = A2(4)- A2_diff;
%A2(4) = A2(4)*0.2;
%A2(2) = A2(2) + A2(4);         % change the vertical position
A2(3) = A2(3)*0.861*0.95;
 


xlim(X1)
hold on;

plot([1.5 1.5],ylim,':','LineWidth',2,'Color',[0.5 0.5 0.5]);

leg1 = legend(h,label,'Location','northeastoutside');


[~, objH] = legend(h,label,'Location','northeastoutside','FontSize',10);
set(findobj(objH, 'Tag', 'S1XXXXXXXXXXXXX'), 'Vis', 'off');
set(findobj(objH, 'Tag', 'S2XXXXXXXXXXXXX'), 'Vis', 'off');  
set(findobj(objH, 'Tag', 'S3XXXXXXXXXXXXX'), 'Vis', 'off');
set(findobj(objH, 'Tag', 'S4XXXXXXXXXXXXX'), 'Vis', 'off'); 
set(findobj(objH, 'Tag', 'S5XXXXXXXXXXXXX'), 'Vis', 'off');
set(findobj(objH, 'Tag', 'S6XXXXXXXXXXXXX'), 'Vis', 'off');

pos1 = get(objH(NumElement+2), 'Pos');   
pos2 = get(objH(NumElement+3), 'Pos');  
pos3 = get(objH(NumElement+4), 'Pos');   
pos4 = get(objH(NumElement+5), 'Pos');
pos5 = get(objH(NumElement+6), 'Pos');
pos6 = get(objH(NumElement+7), 'Pos');

% Get text box position
set(objH(NumElement+2), 'Pos', [0.1 pos1(2:3)-0.035], 'String', ['S1:   25% tariff increase' newline '        on the US agriculture']); 
set(objH(NumElement+3), 'Pos', [0.1 pos2(2:3)], 'String', ['']); 
set(objH(NumElement+4), 'Pos', [0.1 pos3(2:3)-0.09], 'String', ['S2:   25% tariff increase' newline '        on the US agriculture' newline ...
    '        with mobile land and' newline '        homogenous soybeans']); 
set(objH(NumElement+5), 'Pos', [0.1 pos4(2:3)], 'String', ['']); 
set(objH(NumElement+6), 'Pos', [0.1 pos5(2:3)], 'String', ['']); 
set(objH(NumElement+7), 'Pos', [0.1 pos6(2:3)], 'String', ['']); 





hold off;

set(gca,'XTickMode','manual');
set(gca,'XTick',1:NumGroupsPerAxis);
%set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',groupLabels);
set(gca, 'FontSize', 10)
set(gca,'position',A2);
%set(gca,'TickDir','out')
%set(gca,'XColor','none')
box off;

%yticklabels(get(gca, 'YTick'));
ylabel2 = get(gca,'YTick');
set(gca,'YTickLabel',sprintfc('%1.1e',ylabel2))



%plot([1.5 1.5],[ylabel2(1) ylabel2(length(ylabel2))],':','LineWidth',2,'Color',[0.5 0.5 0.5]);


print([result_dir filename], '-djpeg');



end 


