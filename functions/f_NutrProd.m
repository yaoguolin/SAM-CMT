function [NutrProd,Nutr_Cap] = f_NutrProd(NutrCont,CropProd,pop,yr_no)
%%% Calculate nutrition supply for H-index
%%% Output: Nutrition Production and Nutrition per capita
dim = size(CropProd);
co_dim = dim(1);
cr_dim = dim(2);
y_dim = yr_no;
NutrProd(1:co_dim,1:cr_dim,1:y_dim) = nan;
Nutr_Cap(1:co_dim,1:cr_dim,1:y_dim) = nan;
for cn = 1:1:co_dim
    for y = 1:1:y_dim
        NutrCont_reshape = permute(NutrCont,[2,1]);
        NutrProd(cn,:,y) = NutrCont_reshape.* CropProd(cn,:,y);
        %%% calories per capita
        Nutr_Cap(cn,:,y) = NutrProd(cn,:,y) ./pop(cn,y);
    end
end
end

