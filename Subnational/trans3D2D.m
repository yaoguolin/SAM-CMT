function [var2d] = trans3D2D(var3d)
%%% Transform a 3D variable to a 2D variable
    sz = size(var3d);
    dim1 = sz(1);
    dim2 = sz(2);
    dim3 = sz(3);
    dimt = dim1*dim2;
    var2d = nan(dimt,dim3);
    %indx_array = nan(dimt,2);

    for j = 1:1:dim2
        for i = 1:1:dim1
            clear ind
            ind = (j-1)*dim1+i;
            var2d(ind,:) = var3d(i,j,:);
            %indx_array(ind,1) = longi(j);
            %indx_array(ind,2) = lati(i);
        end
    end
end

