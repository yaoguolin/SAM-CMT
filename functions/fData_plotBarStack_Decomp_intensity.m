function [var_dep_global,var_tot_global,var_dep_pos,var_dep_neg,...
          int_delta_co,int_new_tot,int_org_tot] = ...
    fData_plotBarStack_Decomp_intensity(var_dep,var_tot,int_co,int_gb,int_expco,int_expgb)

dim = size(var_dep);
co_dim = dim(1);
cr_dim = dim(2);


var_dep_global(1:co_dim+1,1:cr_dim) = nan;
var_dep_global(2:co_dim+1,1:cr_dim) = var_dep;
var_dep_global(1,1:cr_dim) = nansum(var_dep,1);
var_tot_global(1:co_dim+1,1) = nan;
var_tot_global(2:co_dim+1,1) = var_tot;
var_tot_global(1,1) = nansum(var_tot,1);

var_dep_pos = var_dep_global;
var_dep_neg = var_dep_global;
var_dep_pos(var_dep_pos<0) = 0;
var_dep_neg(var_dep_neg>0) = 0;


int_deltaco = int_expco - int_co;
int_deltagb = int_expgb - int_gb;

int_delta_co(1:co_dim+1,1) = nan;
int_delta_co(2:co_dim+1,1) = int_deltaco;
int_delta_co(1,1) = int_deltagb;

int_new_tot(1:co_dim+1,1) = nan;
int_new_tot(2:co_dim+1,1) = int_expco;
int_new_tot(1,1) = int_expgb;

int_org_tot(1:co_dim+1,1) = nan;
int_org_tot(2:co_dim+1,1) = int_co;
int_org_tot(1,1) = int_gb;

end

