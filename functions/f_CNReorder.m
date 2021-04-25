function [Var_new] = f_CNReorder(Var)

Var_new = nan(size(Var));
Var_new(1,:) = Var(4,:);
Var_new(2,:) = Var(1,:);
Var_new(3,:) = Var(3,:);
Var_new(4,:) = Var(5,:);
Var_new(5,:) = Var(2,:);
Var_new(6,:) = Var(6,:);

end

