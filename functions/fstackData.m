function [stackData,stackData_tot] = fstackData(var_dep1,var_tot1,var_dep2,var_tot2)

% This function is prepared to stack two scenarios' results and generate a
% global column
dim = size(var_dep1);
co_dim = dim(1);
cr_dim = dim(2);

var_dep_global1(1:co_dim+1,1:cr_dim) = nan;
var_dep_global1(2:co_dim+1,1:cr_dim) = var_dep1;
var_dep_global1(1,1:cr_dim) = nansum(var_dep1,1);
var_tot_global1(1:co_dim+1,1) = nan;
var_tot_global1(2:co_dim+1,1) = var_tot1;
var_tot_global1(1,1) = nansum(var_tot1,1);


var_dep_global2(1:co_dim+1,1:cr_dim) = nan;
var_dep_global2(2:co_dim+1,1:cr_dim) = var_dep2;
var_dep_global2(1,1:cr_dim) = nansum(var_dep2,1);
var_tot_global2(1:co_dim+1,1) = nan;
var_tot_global2(2:co_dim+1,1) = var_tot2;
var_tot_global2(1,1) = nansum(var_tot2,1);

stackData(1:co_dim+1,1,1:cr_dim) = var_dep_global1;
stackData(1:co_dim+1,2,1:cr_dim) = var_dep_global2;

stackData_tot(1:co_dim+1,1) = var_tot_global1;
stackData_tot(1:co_dim+1,2) = var_tot_global2;

end

