function [H_index] = f_H_index_nutr(NutrCont,CropProd,pop,yr_no)
%%% H index calculation of a function
%%% NutrCont: Nutrient Content g per kg
%%% population data
%%% Calculate Calories production
[NutrProd,Nutr_Cap] = f_NutrProd(NutrCont,CropProd,pop,yr_no);
%{
NutrProd(1:218,1:170,1:56) = nan;
Nutr_Cap(1:218,1:170,1:56) = nan;
for cn = 1:1:218
    for y = 1:1:56
        NutrCont_reshape = permute(NutrCont,[2,1]);
        NutrProd(cn,:,y) = NutrCont_reshape.* CropProd(cn,:,y);
        %%% calories per capita
        Nutr_Cap(cn,:,y) = NutrProd(cn,:,y) ./pop(cn,y);
    end
end
%}
Nutr_Cap(isnan(Nutr_Cap))=-9999;

%%% Ranking Nutr supply per capita for each country
[Nutr_Rank,Ind_crop] = sort(Nutr_Cap,2,'descend');
%xus = reshape(Calor_Rank(207,:,:),170,56);
H_index = f_H_index(Nutr_Rank,yr_no); %% the core function of calculating H index
end

