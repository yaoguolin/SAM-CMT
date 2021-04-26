function [NutrProd,Nutr_Cap] = NutrProd2dim(NutrCont,CropProd,pop,baseyr)
%%% Calculate nutrition supply for H-index from two-dimentional CropProd
%%% variable
%%% Output: Nutrition Production and Nutrition per capita
dim = size(CropProd);
co_dim = dim(1);
cr_dim = dim(2);

NutrProd = squeeze(NutrCont(:,:,baseyr)) .* CropProd;

for cn = 1:1:co_dim
        Nutr_Cap(cn,:) = NutrProd(cn,:) ./pop(cn,baseyr);
end


%{
NutrProd(1:co_dim,1:cr_dim) = nan;
Nutr_Cap(1:co_dim,1:cr_dim) = nan;
for cn = 1:1:co_dim
        NutrCont_reshape = permute(NutrCont,[2,1]);
        NutrProd(cn,:) = NutrCont_reshape.* CropProd(cn,:);
        %%% calories per capita
        Nutr_Cap(cn,:) = NutrProd(cn,:) ./pop(cn,y);
end
%}
end

