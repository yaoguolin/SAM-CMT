%% Calories 

           [CalorProd_AggCO_POPD, CalorPNIm_AggCO_POPD,CalorProd_ExpCO_POPD,CalorPNIm_ExpCO_POPD,....
            CalorProd_Agg,       CalorProd_Exp,            CalorProd_Delta,   ...
            CalorProd_AggCO,     CalorProd_ExpCO,          CalorProd_DeltaCO,  ... 
            CalorImTrdQnt_Agg,   CalorImTrdQnt_Exp,        CalorImTrdQnt_Delta,...
            CalorExport_Agg,     CalorImport_Agg,          CalorNetImp_Agg,    ...
            CalorPNIm_Agg,       CalorExport_Exp,          CalorImport_Exp,    ...
            CalorNetImp_Exp,     CalorPNIm_Exp,            CalorExport_Delta,  ...
            CalorImport_Delta,   CalorNetImp_Delta,        CalorPNIm_Delta,    ...
            CalorExport_AggCO,   CalorImport_AggCO,        CalorNetImp_AggCO,  ...
            CalorPNIm_AggCO,     CalorExport_ExpCO,        CalorImport_ExpCO,  ...
            CalorNetImp_ExpCO,   CalorPNIm_ExpCO,          CalorExport_DeltaCO,...
            CalorImport_DeltaCO, CalorNetImp_DeltaCO,      CalorPNIm_DeltaCO,...
            CalorCont_Agg]...
= fNUTR_CAL(CalorCont,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

CalorProd_PopRatio = CalorProd_AggCO_POPD./2000;
CalorPNIm_PopRatio = CalorPNIm_AggCO_POPD ./2000; 

CalorProd_PopRatioExp = CalorProd_ExpCO_POPD./2000;
CalorPNIm_PopRatioExp = CalorPNIm_ExpCO_POPD ./2000; 

%% Protein
           [ProtProd_AggCO_POPD, ProtPNIm_AggCO_POPD,ProtProd_ExpCO_POPD, ProtPNIm_ExpCO_POPD,...
            ProtProd_Agg,       ProtProd_Exp,            ProtProd_Delta,   ...
            ProtProd_AggCO,     ProtProd_ExpCO,          ProtProd_DeltaCO,  ... 
            ProtImTrdQnt_Agg,   ProtImTrdQnt_Exp,        ProtImTrdQnt_Delta,...
            ProtExport_Agg,     ProtImport_Agg,          ProtNetImp_Agg,    ...
            ProtPNIm_Agg,       ProtExport_Exp,          ProtImport_Exp,    ...
            ProtNetImp_Exp,     ProtPNIm_Exp,            ProtExport_Delta,  ...
            ProtImport_Delta,   ProtNetImp_Delta,        ProtPNIm_Delta,    ...
            ProtExport_AggCO,   ProtImport_AggCO,        ProtNetImp_AggCO,  ...
            ProtPNIm_AggCO,     ProtExport_ExpCO,        ProtImport_ExpCO,  ...
            ProtNetImp_ExpCO,   ProtPNIm_ExpCO,          ProtExport_DeltaCO,...
            ProtImport_DeltaCO, ProtNetImp_DeltaCO,      ProtPNIm_DeltaCO,...
            ProtCont_Agg]...
= fNUTR_CAL(ProtCont,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

ProtProd_PopRatio = ProtProd_AggCO_POPD./56;
ProtPNIm_PopRatio = ProtPNIm_AggCO_POPD ./56;

ProtProd_PopRatioExp = ProtProd_ExpCO_POPD./56;
ProtPNIm_PopRatioExp = ProtPNIm_ExpCO_POPD ./56;

%% Fat
           [FatProd_AggCO_POPD,FatPNIm_AggCO_POPD,FatProd_ExpCO_POPD, FatPNIm_ExpCO_POPD,...
            FatProd_Agg,       FatProd_Exp,            FatProd_Delta,   ...
            FatProd_AggCO,     FatProd_ExpCO,          FatProd_DeltaCO,  ... 
            FatImTrdQnt_Agg,   FatImTrdQnt_Exp,        FatImTrdQnt_Delta,...
            FatExport_Agg,     FatImport_Agg,          FatNetImp_Agg,    ...
            FatPNIm_Agg,       FatExport_Exp,          FatImport_Exp,    ...
            FatNetImp_Exp,     FatPNIm_Exp,            FatExport_Delta,  ...
            FatImport_Delta,   FatNetImp_Delta,        FatPNIm_Delta,    ...
            FatExport_AggCO,   FatImport_AggCO,        FatNetImp_AggCO,  ...
            FatPNIm_AggCO,     FatExport_ExpCO,        FatImport_ExpCO,  ...
            FatNetImp_ExpCO,   FatPNIm_ExpCO,          FatExport_DeltaCO,...
            FatImport_DeltaCO, FatNetImp_DeltaCO,      FatPNIm_DeltaCO,...
            FatCont_Agg]...
= fNUTR_CAL(FatCont,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

FatProd_PopRatio = FatProd_AggCO_POPD./38;
FatPNIm_PopRatio = FatPNIm_AggCO_POPD ./38;

FatProd_PopRatioExp = FatProd_ExpCO_POPD./38;
FatPNIm_PopRatioExp = FatPNIm_ExpCO_POPD ./38;

%% Carb
           [CarbProd_AggCO_POPD,CarbPNIm_AggCO_POPD,CarbProd_ExpCO_POPD, CarbPNIm_ExpCO_POPD,...
            CarbProd_Agg,       CarbProd_Exp,            CarbProd_Delta,   ...
            CarbProd_AggCO,     CarbProd_ExpCO,          CarbProd_DeltaCO,  ... 
            CarbImTrdQnt_Agg,   CarbImTrdQnt_Exp,        CarbImTrdQnt_Delta,...
            CarbExport_Agg,     CarbImport_Agg,          CarbNetImp_Agg,    ...
            CarbPNIm_Agg,       CarbExport_Exp,          CarbImport_Exp,    ...
            CarbNetImp_Exp,     CarbPNIm_Exp,            CarbExport_Delta,  ...
            CarbImport_Delta,   CarbNetImp_Delta,        CarbPNIm_Delta,    ...
            CarbExport_AggCO,   CarbImport_AggCO,        CarbNetImp_AggCO,  ...
            CarbPNIm_AggCO,     CarbExport_ExpCO,        CarbImport_ExpCO,  ...
            CarbNetImp_ExpCO,   CarbPNIm_ExpCO,          CarbExport_DeltaCO,...
            CarbImport_DeltaCO, CarbNetImp_DeltaCO,      CarbPNIm_DeltaCO,...
            CarbCont_Agg]...
= fNUTR_CAL(Carb,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

CarbProd_PopRatio = CarbProd_AggCO_POPD./130;
CarbPNIm_PopRatio = CarbPNIm_AggCO_POPD ./130;

CarbProd_PopRatioExp = CarbProd_ExpCO_POPD./130;
CarbPNIm_PopRatioExp = CarbPNIm_ExpCO_POPD ./130;

%% Calcium (Ca)
           [CalcProd_AggCO_POPD,CalcPNIm_AggCO_POPD,CalcProd_ExpCO_POPD, CalcPNIm_ExpCO_POPD,...
            CalcProd_Agg,       CalcProd_Exp,            CalcProd_Delta,   ...
            CalcProd_AggCO,     CalcProd_ExpCO,          CalcProd_DeltaCO,  ... 
            CalcImTrdQnt_Agg,   CalcImTrdQnt_Exp,        CalcImTrdQnt_Delta,...
            CalcExport_Agg,     CalcImport_Agg,          CalcNetImp_Agg,    ...
            CalcPNIm_Agg,       CalcExport_Exp,          CalcImport_Exp,    ...
            CalcNetImp_Exp,     CalcPNIm_Exp,            CalcExport_Delta,  ...
            CalcImport_Delta,   CalcNetImp_Delta,        CalcPNIm_Delta,    ...
            CalcExport_AggCO,   CalcImport_AggCO,        CalcNetImp_AggCO,  ...
            CalcPNIm_AggCO,     CalcExport_ExpCO,        CalcImport_ExpCO,  ...
            CalcNetImp_ExpCO,   CalcPNIm_ExpCO,          CalcExport_DeltaCO,...
            CalcImport_DeltaCO, CalcNetImp_DeltaCO,      CalcPNIm_DeltaCO,...
            CalcCont_Agg]...
= fNUTR_CAL(Ca,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);


CalcProd_PopRatio = CalcProd_AggCO_POPD./1000;
CalcPNIm_PopRatio = CalcPNIm_AggCO_POPD ./1000;

CalcProd_PopRatioExp = CalcProd_ExpCO_POPD./1000;
CalcPNIm_PopRatioExp = CalcPNIm_ExpCO_POPD ./1000;

%% Iron (Fe)
           [FeProd_AggCO_POPD,FePNIm_AggCO_POPD,FeProd_ExpCO_POPD,FePNIm_ExpCO_POPD,...
            FeProd_Agg,       FeProd_Exp,            FeProd_Delta,   ...
            FeProd_AggCO,     FeProd_ExpCO,          FeProd_DeltaCO,  ... 
            FeImTrdQnt_Agg,   FeImTrdQnt_Exp,        FeImTrdQnt_Delta,...
            FeExport_Agg,     FeImport_Agg,          FeNetImp_Agg,    ...
            FePNIm_Agg,       FeExport_Exp,          FeImport_Exp,    ...
            FeNetImp_Exp,     FePNIm_Exp,            FeExport_Delta,  ...
            FeImport_Delta,   FeNetImp_Delta,        FePNIm_Delta,    ...
            FeExport_AggCO,   FeImport_AggCO,        FeNetImp_AggCO,  ...
            FePNIm_AggCO,     FeExport_ExpCO,        FeImport_ExpCO,  ...
            FeNetImp_ExpCO,   FePNIm_ExpCO,          FeExport_DeltaCO,...
            FeImport_DeltaCO, FeNetImp_DeltaCO,      FePNIm_DeltaCO,...
            FeCont_Agg]...
= fNUTR_CAL(Fe,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

FeProd_PopRatio = FeProd_AggCO_POPD./8;
FePNIm_PopRatio = FePNIm_AggCO_POPD ./8;

FeProd_PopRatioExp = FeProd_ExpCO_POPD./8;
FePNIm_PopRatioExp = FePNIm_ExpCO_POPD ./8;

%% Fiber
           [FiberProd_AggCO_POPD,FiberPNIm_AggCO_POPD,FiberProd_ExpCO_POPD,FiberPNIm_ExpCO_POPD,...
            FiberProd_Agg,       FiberProd_Exp,            FiberProd_Delta,   ...
            FiberProd_AggCO,     FiberProd_ExpCO,          FiberProd_DeltaCO,  ... 
            FiberImTrdQnt_Agg,   FiberImTrdQnt_Exp,        FiberImTrdQnt_Delta,...
            FiberExport_Agg,     FiberImport_Agg,          FiberNetImp_Agg,    ...
            FiberPNIm_Agg,       FiberExport_Exp,          FiberImport_Exp,    ...
            FiberNetImp_Exp,     FiberPNIm_Exp,            FiberExport_Delta,  ...
            FiberImport_Delta,   FiberNetImp_Delta,        FiberPNIm_Delta,    ...
            FiberExport_AggCO,   FiberImport_AggCO,        FiberNetImp_AggCO,  ...
            FiberPNIm_AggCO,     FiberExport_ExpCO,        FiberImport_ExpCO,  ...
            FiberNetImp_ExpCO,   FiberPNIm_ExpCO,          FiberExport_DeltaCO,...
            FiberImport_DeltaCO, FiberNetImp_DeltaCO,      FiberPNIm_DeltaCO,...
            FiberCont_Agg]...
= fNUTR_CAL(Fiber,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

FiberProd_PopRatio = FiberProd_AggCO_POPD./38;
FiberPNIm_PopRatio = FiberPNIm_AggCO_POPD ./38;

FiberProd_PopRatioExp = FiberProd_ExpCO_POPD./38;
FiberPNIm_PopRatioExp = FiberPNIm_ExpCO_POPD ./38;

%% Folate
           [FolProd_AggCO_POPD,FolPNIm_AggCO_POPD,FolProd_ExpCO_POPD,FolPNIm_ExpCO_POPD,...
            FolProd_Agg,       FolProd_Exp,            FolProd_Delta,   ...
            FolProd_AggCO,     FolProd_ExpCO,          FolProd_DeltaCO,  ... 
            FolImTrdQnt_Agg,   FolImTrdQnt_Exp,        FolImTrdQnt_Delta,...
            FolExport_Agg,     FolImport_Agg,          FolNetImp_Agg,    ...
            FolPNIm_Agg,       FolExport_Exp,          FolImport_Exp,    ...
            FolNetImp_Exp,     FolPNIm_Exp,            FolExport_Delta,  ...
            FolImport_Delta,   FolNetImp_Delta,        FolPNIm_Delta,    ...
            FolExport_AggCO,   FolImport_AggCO,        FolNetImp_AggCO,  ...
            FolPNIm_AggCO,     FolExport_ExpCO,        FolImport_ExpCO,  ...
            FolNetImp_ExpCO,   FolPNIm_ExpCO,          FolExport_DeltaCO,...
            FolImport_DeltaCO, FolNetImp_DeltaCO,      FolPNIm_DeltaCO,...
            FolCont_Agg]...
= fNUTR_CAL(Fol,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

FolProd_PopRatio = FolProd_AggCO_POPD./400;
FolPNIm_PopRatio = FolPNIm_AggCO_POPD ./400;

FolProd_PopRatioExp = FolProd_ExpCO_POPD./400;
FolPNIm_PopRatioExp = FolPNIm_ExpCO_POPD ./400;

%% Potassium (K)
           [KProd_AggCO_POPD,KPNIm_AggCO_POPD,KProd_ExpCO_POPD,KPNIm_ExpCO_POPD,...
            KProd_Agg,       KProd_Exp,            KProd_Delta,   ...
            KProd_AggCO,     KProd_ExpCO,          KProd_DeltaCO,  ... 
            KImTrdQnt_Agg,   KImTrdQnt_Exp,        KImTrdQnt_Delta,...
            KExport_Agg,     KImport_Agg,          KNetImp_Agg,    ...
            KPNIm_Agg,       KExport_Exp,          KImport_Exp,    ...
            KNetImp_Exp,     KPNIm_Exp,            KExport_Delta,  ...
            KImport_Delta,   KNetImp_Delta,        KPNIm_Delta,    ...
            KExport_AggCO,   KImport_AggCO,        KNetImp_AggCO,  ...
            KPNIm_AggCO,     KExport_ExpCO,        KImport_ExpCO,  ...
            KNetImp_ExpCO,   KPNIm_ExpCO,          KExport_DeltaCO,...
            KImport_DeltaCO, KNetImp_DeltaCO,      KPNIm_DeltaCO,...
            KCont_Agg]...
= fNUTR_CAL(K,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

KProd_PopRatio = KProd_AggCO_POPD./4.7;
KPNIm_PopRatio = KPNIm_AggCO_POPD ./4.7;

KProd_PopRatioExp = KProd_ExpCO_POPD./4.7;
KPNIm_PopRatioExp = KPNIm_ExpCO_POPD ./4.7;

%% Magnesium (Mg)
           [MgProd_AggCO_POPD,MgPNIm_AggCO_POPD,MgProd_ExpCO_POPD,MgPNIm_ExpCO_POPD,...
            MgProd_Agg,       MgProd_Exp,            MgProd_Delta,   ...
            MgProd_AggCO,     MgProd_ExpCO,          MgProd_DeltaCO,  ... 
            MgImTrdQnt_Agg,   MgImTrdQnt_Exp,        MgImTrdQnt_Delta,...
            MgExport_Agg,     MgImport_Agg,          MgNetImp_Agg,    ...
            MgPNIm_Agg,       MgExport_Exp,          MgImport_Exp,    ...
            MgNetImp_Exp,     MgPNIm_Exp,            MgExport_Delta,  ...
            MgImport_Delta,   MgNetImp_Delta,        MgPNIm_Delta,    ...
            MgExport_AggCO,   MgImport_AggCO,        MgNetImp_AggCO,  ...
            MgPNIm_AggCO,     MgExport_ExpCO,        MgImport_ExpCO,  ...
            MgNetImp_ExpCO,   MgPNIm_ExpCO,          MgExport_DeltaCO,...
            MgImport_DeltaCO, MgNetImp_DeltaCO,      MgPNIm_DeltaCO,...
            MgCont_Agg]...
= fNUTR_CAL(Mg,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

MgProd_PopRatio = MgProd_AggCO_POPD./400;
MgPNIm_PopRatio = MgPNIm_AggCO_POPD ./400;

MgProd_PopRatioExp = MgProd_ExpCO_POPD./400;
MgPNIm_PopRatioExp = MgPNIm_ExpCO_POPD ./400;

%% Sodium (Na)
           [NaProd_AggCO_POPD,NaPNIm_AggCO_POPD,NaProd_ExpCO_POPD,NaPNIm_ExpCO_POPD,...
            NaProd_Agg,       NaProd_Exp,            NaProd_Delta,   ...
            NaProd_AggCO,     NaProd_ExpCO,          NaProd_DeltaCO,  ... 
            NaImTrdQnt_Agg,   NaImTrdQnt_Exp,        NaImTrdQnt_Delta,...
            NaExport_Agg,     NaImport_Agg,          NaNetImp_Agg,    ...
            NaPNIm_Agg,       NaExport_Exp,          NaImport_Exp,    ...
            NaNetImp_Exp,     NaPNIm_Exp,            NaExport_Delta,  ...
            NaImport_Delta,   NaNetImp_Delta,        NaPNIm_Delta,    ...
            NaExport_AggCO,   NaImport_AggCO,        NaNetImp_AggCO,  ...
            NaPNIm_AggCO,     NaExport_ExpCO,        NaImport_ExpCO,  ...
            NaNetImp_ExpCO,   NaPNIm_ExpCO,          NaExport_DeltaCO,...
            NaImport_DeltaCO, NaNetImp_DeltaCO,      NaPNIm_DeltaCO,...
            NaCont_Agg]...
= fNUTR_CAL(Na,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

NaProd_PopRatio = NaProd_AggCO_POPD./1500;
NaPNIm_PopRatio = NaPNIm_AggCO_POPD ./1500;

NaProd_PopRatioExp = NaProd_ExpCO_POPD./1500;
NaPNIm_PopRatioExp = NaPNIm_ExpCO_POPD ./1500;
%% Niacin
           [NiacProd_AggCO_POPD,NiacPNIm_AggCO_POPD,NiacProd_ExpCO_POPD,NiacPNIm_ExpCO_POPD,...
            NiacProd_Agg,       NiacProd_Exp,            NiacProd_Delta,   ...
            NiacProd_AggCO,     NiacProd_ExpCO,          NiacProd_DeltaCO,  ... 
            NiacImTrdQnt_Agg,   NiacImTrdQnt_Exp,        NiacImTrdQnt_Delta,...
            NiacExport_Agg,     NiacImport_Agg,          NiacNetImp_Agg,    ...
            NiacPNIm_Agg,       NiacExport_Exp,          NiacImport_Exp,    ...
            NiacNetImp_Exp,     NiacPNIm_Exp,            NiacExport_Delta,  ...
            NiacImport_Delta,   NiacNetImp_Delta,        NiacPNIm_Delta,    ...
            NiacExport_AggCO,   NiacImport_AggCO,        NiacNetImp_AggCO,  ...
            NiacPNIm_AggCO,     NiacExport_ExpCO,        NiacImport_ExpCO,  ...
            NiacNetImp_ExpCO,   NiacPNIm_ExpCO,          NiacExport_DeltaCO,...
            NiacImport_DeltaCO, NiacNetImp_DeltaCO,      NiacPNIm_DeltaCO,...
            NiacCont_Agg]...
= fNUTR_CAL(Niac,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

NiacProd_PopRatio = NiacProd_AggCO_POPD./16;
NiacPNIm_PopRatio = NiacPNIm_AggCO_POPD ./16;

NiacProd_PopRatioExp = NiacProd_ExpCO_POPD./16;
NiacPNIm_PopRatioExp = NiacPNIm_ExpCO_POPD ./16;

%% Riboflavin
           [RiboProd_AggCO_POPD,RiboPNIm_AggCO_POPD,RiboProd_ExpCO_POPD,RiboPNIm_ExpCO_POPD,...
            RiboProd_Agg,       RiboProd_Exp,            RiboProd_Delta,   ...
            RiboProd_AggCO,     RiboProd_ExpCO,          RiboProd_DeltaCO,  ... 
            RiboImTrdQnt_Agg,   RiboImTrdQnt_Exp,        RiboImTrdQnt_Delta,...
            RiboExport_Agg,     RiboImport_Agg,          RiboNetImp_Agg,    ...
            RiboPNIm_Agg,       RiboExport_Exp,          RiboImport_Exp,    ...
            RiboNetImp_Exp,     RiboPNIm_Exp,            RiboExport_Delta,  ...
            RiboImport_Delta,   RiboNetImp_Delta,        RiboPNIm_Delta,    ...
            RiboExport_AggCO,   RiboImport_AggCO,        RiboNetImp_AggCO,  ...
            RiboPNIm_AggCO,     RiboExport_ExpCO,        RiboImport_ExpCO,  ...
            RiboNetImp_ExpCO,   RiboPNIm_ExpCO,          RiboExport_DeltaCO,...
            RiboImport_DeltaCO, RiboNetImp_DeltaCO,      RiboPNIm_DeltaCO,...
            RiboCont_Agg]...
= fNUTR_CAL(Ribo,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

RiboProd_PopRatio = RiboProd_AggCO_POPD./1.3;
RiboPNIm_PopRatio = RiboPNIm_AggCO_POPD ./1.3;

RiboProd_PopRatioExp = RiboProd_ExpCO_POPD./1.3;
RiboPNIm_PopRatioExp = RiboPNIm_ExpCO_POPD ./1.3;

%% Sugar
           [SugarProd_AggCO_POPD,SugarPNIm_AggCO_POPD,SugarProd_ExpCO_POPD,SugarPNIm_ExpCO_POPD,...
            SugarProd_Agg,       SugarProd_Exp,            SugarProd_Delta,   ...
            SugarProd_AggCO,     SugarProd_ExpCO,          SugarProd_DeltaCO,  ... 
            SugarImTrdQnt_Agg,   SugarImTrdQnt_Exp,        SugarImTrdQnt_Delta,...
            SugarExport_Agg,     SugarImport_Agg,          SugarNetImp_Agg,    ...
            SugarPNIm_Agg,       SugarExport_Exp,          SugarImport_Exp,    ...
            SugarNetImp_Exp,     SugarPNIm_Exp,            SugarExport_Delta,  ...
            SugarImport_Delta,   SugarNetImp_Delta,        SugarPNIm_Delta,    ...
            SugarExport_AggCO,   SugarImport_AggCO,        SugarNetImp_AggCO,  ...
            SugarPNIm_AggCO,     SugarExport_ExpCO,        SugarImport_ExpCO,  ...
            SugarNetImp_ExpCO,   SugarPNIm_ExpCO,          SugarExport_DeltaCO,...
            SugarImport_DeltaCO, SugarNetImp_DeltaCO,      SugarPNIm_DeltaCO,...
            SugarCont_Agg]...
= fNUTR_CAL(Sugar,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

SugarProd_PopRatio = SugarProd_AggCO_POPD./90;
SugarPNIm_PopRatio = SugarPNIm_AggCO_POPD ./90;

SugarProd_PopRatioExp = SugarProd_ExpCO_POPD./90;
SugarPNIm_PopRatioExp = SugarPNIm_ExpCO_POPD ./90;

%% Thiamin
           [ThiaProd_AggCO_POPD,ThiaPNIm_AggCO_POPD,ThiaProd_ExpCO_POPD,ThiaPNIm_ExpCO_POPD,...
            ThiaProd_Agg,       ThiaProd_Exp,            ThiaProd_Delta,   ...
            ThiaProd_AggCO,     ThiaProd_ExpCO,          ThiaProd_DeltaCO,  ... 
            ThiaImTrdQnt_Agg,   ThiaImTrdQnt_Exp,        ThiaImTrdQnt_Delta,...
            ThiaExport_Agg,     ThiaImport_Agg,          ThiaNetImp_Agg,    ...
            ThiaPNIm_Agg,       ThiaExport_Exp,          ThiaImport_Exp,    ...
            ThiaNetImp_Exp,     ThiaPNIm_Exp,            ThiaExport_Delta,  ...
            ThiaImport_Delta,   ThiaNetImp_Delta,        ThiaPNIm_Delta,    ...
            ThiaExport_AggCO,   ThiaImport_AggCO,        ThiaNetImp_AggCO,  ...
            ThiaPNIm_AggCO,     ThiaExport_ExpCO,        ThiaImport_ExpCO,  ...
            ThiaNetImp_ExpCO,   ThiaPNIm_ExpCO,          ThiaExport_DeltaCO,...
            ThiaImport_DeltaCO, ThiaNetImp_DeltaCO,      ThiaPNIm_DeltaCO,...
            ThiaCont_Agg]...
= fNUTR_CAL(Thia,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

ThiaProd_PopRatio = ThiaProd_AggCO_POPD./1.2;
ThiaPNIm_PopRatio = ThiaPNIm_AggCO_POPD ./1.2;

ThiaProd_PopRatioExp = ThiaProd_ExpCO_POPD./1.2;
ThiaPNIm_PopRatioExp = ThiaPNIm_ExpCO_POPD ./1.2;

%% Vitamin A
           [VAProd_AggCO_POPD,VAPNIm_AggCO_POPD,VAProd_ExpCO_POPD,VAPNIm_ExpCO_POPD,...
            VAProd_Agg,       VAProd_Exp,            VAProd_Delta,   ...
            VAProd_AggCO,     VAProd_ExpCO,          VAProd_DeltaCO,  ... 
            VAImTrdQnt_Agg,   VAImTrdQnt_Exp,        VAImTrdQnt_Delta,...
            VAExport_Agg,     VAImport_Agg,          VANetImp_Agg,    ...
            VAPNIm_Agg,       VAExport_Exp,          VAImport_Exp,    ...
            VANetImp_Exp,     VAPNIm_Exp,            VAExport_Delta,  ...
            VAImport_Delta,   VANetImp_Delta,        VAPNIm_Delta,    ...
            VAExport_AggCO,   VAImport_AggCO,        VANetImp_AggCO,  ...
            VAPNIm_AggCO,     VAExport_ExpCO,        VAImport_ExpCO,  ...
            VANetImp_ExpCO,   VAPNIm_ExpCO,          VAExport_DeltaCO,...
            VAImport_DeltaCO, VANetImp_DeltaCO,      VAPNIm_DeltaCO,...
            VACont_Agg]...
= fNUTR_CAL(VA,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

VAProd_PopRatio = VAProd_AggCO_POPD./900;
VAPNIm_PopRatio = VAPNIm_AggCO_POPD ./900;

VAProd_PopRatioExp = VAProd_ExpCO_POPD./900;
VAPNIm_PopRatioExp = VAPNIm_ExpCO_POPD ./900;
%% Vitamin B12
           [VB12Prod_AggCO_POPD,VB12PNIm_AggCO_POPD,VB12Prod_ExpCO_POPD,VB12PNIm_ExpCO_POPD,...
            VB12Prod_Agg,       VB12Prod_Exp,            VB12Prod_Delta,   ...
            VB12Prod_AggCO,     VB12Prod_ExpCO,          VB12Prod_DeltaCO,  ... 
            VB12ImTrdQnt_Agg,   VB12ImTrdQnt_Exp,        VB12ImTrdQnt_Delta,...
            VB12Export_Agg,     VB12Import_Agg,          VB12NetImp_Agg,    ...
            VB12PNIm_Agg,       VB12Export_Exp,          VB12Import_Exp,    ...
            VB12NetImp_Exp,     VB12PNIm_Exp,            VB12Export_Delta,  ...
            VB12Import_Delta,   VB12NetImp_Delta,        VB12PNIm_Delta,    ...
            VB12Export_AggCO,   VB12Import_AggCO,        VB12NetImp_AggCO,  ...
            VB12PNIm_AggCO,     VB12Export_ExpCO,        VB12Import_ExpCO,  ...
            VB12NetImp_ExpCO,   VB12PNIm_ExpCO,          VB12Export_DeltaCO,...
            VB12Import_DeltaCO, VB12NetImp_DeltaCO,      VB12PNIm_DeltaCO,...
            VB12Cont_Agg]...
= fNUTR_CAL(VB12,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

VB12Prod_PopRatio = VB12Prod_AggCO_POPD./2.4;
VB12PNIm_PopRatio = VB12PNIm_AggCO_POPD ./2.4;

VB12Prod_PopRatioExp = VB12Prod_ExpCO_POPD./2.4;
VB12PNIm_PopRatioExp = VB12PNIm_ExpCO_POPD ./2.4;

%% Vitamin B6
           [VB6Prod_AggCO_POPD,VB6PNIm_AggCO_POPD,VB6Prod_ExpCO_POPD,VB6PNIm_ExpCO_POPD,...
            VB6Prod_Agg,       VB6Prod_Exp,            VB6Prod_Delta,   ...
            VB6Prod_AggCO,     VB6Prod_ExpCO,          VB6Prod_DeltaCO,  ... 
            VB6ImTrdQnt_Agg,   VB6ImTrdQnt_Exp,        VB6ImTrdQnt_Delta,...
            VB6Export_Agg,     VB6Import_Agg,          VB6NetImp_Agg,    ...
            VB6PNIm_Agg,       VB6Export_Exp,          VB6Import_Exp,    ...
            VB6NetImp_Exp,     VB6PNIm_Exp,            VB6Export_Delta,  ...
            VB6Import_Delta,   VB6NetImp_Delta,        VB6PNIm_Delta,    ...
            VB6Export_AggCO,   VB6Import_AggCO,        VB6NetImp_AggCO,  ...
            VB6PNIm_AggCO,     VB6Export_ExpCO,        VB6Import_ExpCO,  ...
            VB6NetImp_ExpCO,   VB6PNIm_ExpCO,          VB6Export_DeltaCO,...
            VB6Import_DeltaCO, VB6NetImp_DeltaCO,      VB6PNIm_DeltaCO,...
            VB6Cont_Agg]...
= fNUTR_CAL(VB6,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

VB6Prod_PopRatio = VB6Prod_AggCO_POPD./1.3;
VB6PNIm_PopRatio = VB6PNIm_AggCO_POPD ./1.3;

VB6Prod_PopRatioExp = VB6Prod_ExpCO_POPD./1.3;
VB6PNIm_PopRatioExp = VB6PNIm_ExpCO_POPD ./1.3;

%% Vitamin C
           [VCProd_AggCO_POPD,VCPNIm_AggCO_POPD,VCProd_ExpCO_POPD,VCPNIm_ExpCO_POPD,...
            VCProd_Agg,       VCProd_Exp,            VCProd_Delta,   ...
            VCProd_AggCO,     VCProd_ExpCO,          VCProd_DeltaCO,  ... 
            VCImTrdQnt_Agg,   VCImTrdQnt_Exp,        VCImTrdQnt_Delta,...
            VCExport_Agg,     VCImport_Agg,          VCNetImp_Agg,    ...
            VCPNIm_Agg,       VCExport_Exp,          VCImport_Exp,    ...
            VCNetImp_Exp,     VCPNIm_Exp,            VCExport_Delta,  ...
            VCImport_Delta,   VCNetImp_Delta,        VCPNIm_Delta,    ...
            VCExport_AggCO,   VCImport_AggCO,        VCNetImp_AggCO,  ...
            VCPNIm_AggCO,     VCExport_ExpCO,        VCImport_ExpCO,  ...
            VCNetImp_ExpCO,   VCPNIm_ExpCO,          VCExport_DeltaCO,...
            VCImport_DeltaCO, VCNetImp_DeltaCO,      VCPNIm_DeltaCO,...
            VCCont_Agg]...
= fNUTR_CAL(VC,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

VCProd_PopRatio = VCProd_AggCO_POPD./90;
VCPNIm_PopRatio = VCPNIm_AggCO_POPD ./90;

VCProd_PopRatioExp = VCProd_ExpCO_POPD./90;
VCPNIm_PopRatioExp = VCPNIm_ExpCO_POPD ./90;
%% Vitamin D
           [VDProd_AggCO_POPD,VDPNIm_AggCO_POPD,VDProd_ExpCO_POPD,VDPNIm_ExpCO_POPD,...
            VDProd_Agg,       VDProd_Exp,            VDProd_Delta,   ...
            VDProd_AggCO,     VDProd_ExpCO,          VDProd_DeltaCO,  ... 
            VDImTrdQnt_Agg,   VDImTrdQnt_Exp,        VDImTrdQnt_Delta,...
            VDExport_Agg,     VDImport_Agg,          VDNetImp_Agg,    ...
            VDPNIm_Agg,       VDExport_Exp,          VDImport_Exp,    ...
            VDNetImp_Exp,     VDPNIm_Exp,            VDExport_Delta,  ...
            VDImport_Delta,   VDNetImp_Delta,        VDPNIm_Delta,    ...
            VDExport_AggCO,   VDImport_AggCO,        VDNetImp_AggCO,  ...
            VDPNIm_AggCO,     VDExport_ExpCO,        VDImport_ExpCO,  ...
            VDNetImp_ExpCO,   VDPNIm_ExpCO,          VDExport_DeltaCO,...
            VDImport_DeltaCO, VDNetImp_DeltaCO,      VDPNIm_DeltaCO,...
            VDCont_Agg]...
= fNUTR_CAL(VD,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

VDProd_PopRatio = VDProd_AggCO_POPD./15;
VDPNIm_PopRatio = VDPNIm_AggCO_POPD ./15;

VDProd_PopRatioExp = VDProd_ExpCO_POPD./15;
VDPNIm_PopRatioExp = VDPNIm_ExpCO_POPD ./15;

%% Vitamin E
           [VEProd_AggCO_POPD,VEPNIm_AggCO_POPD,VEProd_ExpCO_POPD,VEPNIm_ExpCO_POPD,...
            VEProd_Agg,       VEProd_Exp,            VEProd_Delta,   ...
            VEProd_AggCO,     VEProd_ExpCO,          VEProd_DeltaCO,  ... 
            VEImTrdQnt_Agg,   VEImTrdQnt_Exp,        VEImTrdQnt_Delta,...
            VEExport_Agg,     VEImport_Agg,          VENetImp_Agg,    ...
            VEPNIm_Agg,       VEExport_Exp,          VEImport_Exp,    ...
            VENetImp_Exp,     VEPNIm_Exp,            VEExport_Delta,  ...
            VEImport_Delta,   VENetImp_Delta,        VEPNIm_Delta,    ...
            VEExport_AggCO,   VEImport_AggCO,        VENetImp_AggCO,  ...
            VEPNIm_AggCO,     VEExport_ExpCO,        VEImport_ExpCO,  ...
            VENetImp_ExpCO,   VEPNIm_ExpCO,          VEExport_DeltaCO,...
            VEImport_DeltaCO, VENetImp_DeltaCO,      VEPNIm_DeltaCO,...
            VECont_Agg]...
= fNUTR_CAL(VE,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);


VEProd_PopRatio = VEProd_AggCO_POPD./15;
VEPNIm_PopRatio = VEPNIm_AggCO_POPD ./15;

VEProd_PopRatioExp = VEProd_ExpCO_POPD./15;
VEPNIm_PopRatioExp = VEPNIm_ExpCO_POPD ./15;
%% Zinc
           [ZnProd_AggCO_POPD,ZnPNIm_AggCO_POPD,ZnProd_ExpCO_POPD,ZnPNIm_ExpCO_POPD,...
            ZnProd_Agg,       ZnProd_Exp,            ZnProd_Delta,   ...
            ZnProd_AggCO,     ZnProd_ExpCO,          ZnProd_DeltaCO,  ... 
            ZnImTrdQnt_Agg,   ZnImTrdQnt_Exp,        ZnImTrdQnt_Delta,...
            ZnExport_Agg,     ZnImport_Agg,          ZnNetImp_Agg,    ...
            ZnPNIm_Agg,       ZnExport_Exp,          ZnImport_Exp,    ...
            ZnNetImp_Exp,     ZnPNIm_Exp,            ZnExport_Delta,  ...
            ZnImport_Delta,   ZnNetImp_Delta,        ZnPNIm_Delta,    ...
            ZnExport_AggCO,   ZnImport_AggCO,        ZnNetImp_AggCO,  ...
            ZnPNIm_AggCO,     ZnExport_ExpCO,        ZnImport_ExpCO,  ...
            ZnNetImp_ExpCO,   ZnPNIm_ExpCO,          ZnExport_DeltaCO,...
            ZnImport_DeltaCO, ZnNetImp_DeltaCO,      ZnPNIm_DeltaCO,...
            ZnCont_Agg]...
= fNUTR_CAL(Zn,Product_FAO,Product_FAO_Agg,ImTrdQnt,pop_SAM,prod_port,trade_port,cr_ind,cr_dim,co_dim,MAPPING,yr_base,yr_trd);

ZnProd_PopRatio = ZnProd_AggCO_POPD./11;
ZnPNIm_PopRatio = ZnPNIm_AggCO_POPD ./11;

ZnProd_PopRatioExp = ZnProd_ExpCO_POPD./11;
ZnPNIm_PopRatioExp = ZnPNIm_ExpCO_POPD ./11;