function [stackData,stackData_tot] = fstackData_GlobalDecomp(var_reg_decomp,var_reg_tot,var_glb_decomp,var_glb_tot)

% This function is prepared to stack two scenarios' results and generate a
% global column
dim = size(var_reg_decomp);
co_dim = dim(1);
cr_dim = dim(2);

stackData = nan(co_dim+1,cr_dim);
stackData(1,1:cr_dim) = var_glb_decomp;
stackData(2:co_dim+1,1:cr_dim) = var_reg_decomp;

stackData_tot = nan(co_dim+1,1);
stackData_tot(2:co_dim+1,1) = var_reg_tot;
stackData_tot(1,1) = var_glb_tot;

end

