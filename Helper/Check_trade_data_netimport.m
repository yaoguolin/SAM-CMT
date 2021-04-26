reformExQuantMat_RO = permute(reformExQuantMat,[2,1,3,4]);
reformExValMat_RO = permute(reformExValMat,[2,1,3,4]);

importTrdQnt(100,20,56,31)
reformExQuantMat_RO(100,20,56,31)
reformImQuantMat(100,20,56,31)

importTrdQnt(56,31,207,40)
reformExQuantMat_RO(207,40,56,31)
reformImQuantMat(207,40,56,31)

importTrdVal(56,31,207,40)
reformExValMat_RO(207,40,56,31)
reformImValMat(207,40,56,31)

importTrdVal(56,31,40,207)
reformExValMat_RO(40,207,56,31)
reformImValMat(40,207,56,31)

importTrdVal(143,31,40,207)
reformExValMat_RO(40,207,143,31)
reformImValMat(40,207,143,31)

importTrdVal(155,31,207,40)
reformExValMat_RO(207,40,155,31)
reformImValMat(207,40,155,31)

importTrdQnt(155,31,40,207)
reformExQuantMat_RO(40,207,155,31)
reformImQuantMat(40,207,155,31)

importTrdVal(120,31,40,207)
reformExValMat_RO(40,207,120,31)
reformImValMat(40,207,120,31)



importTrdVal(56,31,40,207)
reformExValMat_RO(40,207,56,31)
reformImValMat(40,207,56,31)

importTrdQnt_RO = permute(importTrdQnt,[1,2,4,3]);
importTrdVal_RO = permute(importTrdVal,[1,2,4,3]);

importTrdQnt_net = importTrdQnt - importTrdQnt_RO;
importTrdVal_net = importTrdVal - importTrdVal_RO;

importTrdQnt_net(importTrdQnt_net<0) = 0;
importTrdVal_net(importTrdVal_net<0) = 0;

nansum(nansum(nansum(nansum(netImTrdQnt - importTrdQnt_net))))
nansum(nansum(nansum(nansum(netImTrdVal - importTrdVal_net))))

netImTrdVal(88,31,40,207)
importTrdVal_net(88,31,40,207)





