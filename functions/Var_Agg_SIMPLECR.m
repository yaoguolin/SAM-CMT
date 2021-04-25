function [AGG_VAR] = Var_Agg_SIMPLECR(var_name,mapp)
%%% var_name: 170*218*56
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

    for j = 1:1:cr_dim
        indcr{j} = find(cr_map == cr_array(j));
        AGG_VAR(:,j,:) = nansum(var_name(:,indcr{j},:),2);
    end
end


