function [AGG_VAR_TRD] = Var_Agg_TRD(var_name,mapp)
%%% Trade variable aggregation
%%% var_name: 170*28*218*218
%%% mapp include:
%%% crp_map: an ordered array with correct mapping of the new crop
%%% aggregation
%%% co_map: an ordered array with correct mapping of the new country
%%% aggregation
%%% crp_array: a set of crops with desired orders
%%% co_array: a set of countries 

cr_map = mapp{1,1};
co_map = mapp{1,2};
cr_array = mapp{1,3};
co_array = mapp{1,4};

%%% cr_dim: new crop dimension
%%% co_dim: new country dimension

co_dim = length(co_array);
cr_dim = length(cr_array);

for im = 1:co_dim
    ind{im} = find(co_map == co_array(im));
    for ex = 1:co_dim
        ind{ex} = find(co_map == co_array(ex));
        for cr = 1:cr_dim
            indcr{cr} = find(cr_map == cr_array(cr));
            AGG_VAR_TRD(cr,:,im,ex) = nansum(nansum(nansum(var_name(indcr{cr},:,ind{im},ind{ex}),4),3),1);
        end
    end
end
%AGG_VAR_TRD(AGG_VAR_TRD==0)=nan;
end

