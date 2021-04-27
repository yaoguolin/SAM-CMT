function [var1d] = trans2D1D(var2d)
%%% Transform a 3D variable to a 2D variable
sz = size(var2d);
dim1 = sz(1);
dim2 = sz(2);
dimt = dim1*dim2;
var1d = nan(dimt,1);
%indx_array = nan(dimt,2);

for j = 1:1:dim2
    for i = 1:1:dim1
        clear ind
        ind = (j-1)*dim1+i;
        var1d(ind) = var2d(i,j);
        %indx_array(ind,1) = longi(j);
        %indx_array(ind,2) = lati(i);
    end
end


end

