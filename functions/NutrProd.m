function [NutrProd,Nutr_Cap] = f_NutrProd(NutrCont,CropProd,pop)
%%% Calculate nutrition supply for H-index
%%% Output: Nutrition Production and Nutrition per capita
dim = size(CropProd);
co_dim = dim(1);
cr_dim = dim(2);
NutrProd(1:co_dim,1:cr_dim,1:56) = nan;
Nutr_Cap(1:co_dim,1:cr_dim,1:56) = nan;
for cn = 1:1:co_dim
    for y = 1:1:56
        NutrCont_reshape = permute(NutrCont,[2,1]);
        NutrProd(cn,:,y) = NutrCont_reshape.* CropProd(cn,:,y);
        %%% calories per capita
        Nutr_Cap(cn,:,y) = NutrProd(cn,:,y) ./pop(cn,y);
    end
end
end

