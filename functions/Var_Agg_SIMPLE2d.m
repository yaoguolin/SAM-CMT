function [AGG_VAR] = Var_Agg_SIMPLE2d(var_name,mapp)
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

for i=1:1:co_dim
    ind{i} = find(co_map == co_array(i));
        AGG_VAR(i,:) = nansum(var_name(ind{i},:),1);
    end
end


