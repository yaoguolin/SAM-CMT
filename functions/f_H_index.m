function [H_index] = f_H_index(var_rank,yr_no)
%%% var_rank: ranked variable from the largest to the samllest
%%% Calculate H index
dim = size(var_rank);
co_dim = dim(1);
cr_dim = dim(2);
y_dim = yr_no;
H_index(1:co_dim,1:y_dim) = nan;
for cn = 1:1:co_dim
    for y = 1:1:y_dim  
        for i = 1:1:cr_dim
            if var_rank(cn,i,y)>=i
            H_index(cn,y) = i;           
            end
        end
    end
end
end

