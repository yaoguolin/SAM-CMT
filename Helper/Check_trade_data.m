tradePCntry = baseTrdPartCoDef(:,1);
tradePCntry = table2array(tradePCntry);
chinaMain = find(tradePCntry==41);
chinaTai = find(tradePCntry==214);
chinaHK = find(tradePCntry==96);
chinaMacao = find(tradePCntry==128);

USAP = find(tradePCntry == 231);
BraP = find(tradePCntry == 21);
ArgP = find(tradePCntry == 9);

tradeRCntry = baseTrdRepCoDef(:,1);
tradeRCntry = table2array(tradeRCntry);

chinaMainR = find(tradeRCntry==41);
chinaTaiR = find(tradeRCntry==214);
chinaHKR = find(tradeRCntry==96);
chinaMacaoR = find(tradeRCntry==128);

USAR = find(tradeRCntry == 231);
BraR = find(tradeRCntry == 21);
ArgR = find(tradeRCntry == 9);

Crp = baseTrdCrpDef(:,1);
Crp = table2array(Crp);

wheat = transpose([17,20,21,16,18,22,110,15]);
WHT(1:length(wheat),1) = nan;
for i = 1:length(wheat)
    WHT(i) = find(Crp == wheat(i));
end

maize = transpose([59,61,58,57,56,447,448]);
MAZ(1:length(maize),1) = nan;
for i = 1:length(maize)
    MAZ(i) = find(Crp == maize(i));
end

soybean = transpose([238,240,239,237,236]);
SOY(1:length(soybean),1) = nan;
for i = 1:length(soybean)
    SOY(i) = find(Crp == soybean(i));
end

crtrImQuantMat(USAP,SOY,31,chinaMainR)
crtrImQuantMat(USAP,SOY,31,chinaTaiR)
crtrImQuantMat(chinaMain,WHT,23,USAR)

reformImQuantMat(207,40,134,31)
