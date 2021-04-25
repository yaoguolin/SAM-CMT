function [var1out, var2out] = Non_NAN_PAIRS(var1,var2)
var = var1.*var2;
var(~isnan(var))=1;
var1out = var1 .* var;
var2out = var2 .* var;
end

