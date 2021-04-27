rm(list = ls())
setwd("C:/Research/Post-Doc Research/HarvestedAreaYield/HarvestedAreaYield175Crops_Geotiff/HarvestedAreaYield175Crops_Geotiff")

library(maptools)
library(rgeos)
library(rgdal)
library(sf)
library(ggplot2)
library(raster)
library(RColorBrewer)

# read the shape file for World Map
shp_path <- 'C:/Users/gyao/Google Drive/ArcGIS/world countries/'
shp_name <- "world_country_admin_boundary_shapefile_with_fips_codes.shp"
shp_file <- paste(shp_path, shp_name, sep="")
world_map <- st_read(shp_file)
################# Map for the World##################
resultData <- read.csv(file="grid_results_aez_negative2zero_level_07222020.csv", header=TRUE, sep=",")
long <- resultData$Longitude
lat <- resultData$Latitude

resultData[resultData$Harvested_Area == 0,8:16] <- NA 
resultData_R <- resultData
resultData_R[resultData_R$GTAPCODE=='null',8:16]<-NA
resultData_R[resultData_R$GTAPCODE=='OTHER',8:16]<-NA
resultData_RF <- resultData_R[resultData_R$GTAPCODE!='OTHER'& resultData_R$GTAPCODE!='Null',]
#resultData_RF <- resultData_R[resultData_R$GTAPCODE!='OTHER'& resultData_R$GTAPCODE!='null' &
#                                resultData_R$GTAPCODE!='EU27' & resultData_R$GTAPCODE!='S_o_Amer',]
resultData_RR <- resultData_R[resultData_R$Harvested_Area==0,]
#resultData_Draw <- rbind(resultData_RF,resultData_RR)
resultData_Draw <- resultData_RF

#resultData_Draw[is.na(resultData_Draw$Nsur_kgha_ALL),]<- 
resultData_Draw[resultData_Draw$Harvested_Area==0,8:10]<- -999999999

resultData_Q <- resultData
resultData_Q[resultData_Q$GTAPCODE=='null',8:16]<-NA




c_def <- c('white','darkgreen','green','lightgreen','wheat','yellow','gold','lightcoral','red','darkred')
zCuts <- c(-1000000000,-0.0000001,2500000,500000,1000000,2000000,4000000,6000000,10000000,15000000,70419001)

plotmap_disc <- function(dt, vrb, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_sf(data = world_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() + theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

## Nsur levels
label_Nsur = c('No cropland','0-2.5E+05','2.5E+05-5.0E+05','5.0E+05-1.0E+06','1.0E+06-2.0E+06','2.0E+06-4.0E+06','4.0E+06-6.0E+06','6.0E+06-1.0E+07','1.0E+07-1.5E+07','>1.5E+07')
dir_Nsur = "./IMG4/"

plotmap_disc(resultData_Draw,resultData_Draw$Nsur_kg_ALL,"Nsur kg",c_def,"Nsur_kg.jpg",label_Nsur,dir_Nsur,mina = 0, maxb = 70419001)

## Psur levels

c_def <- c('white','darkgreen','green','lightgreen','wheat','yellow','gold','lightcoral','red','darkred')
zCuts <- c(-1000000000,-0.000001,0.000000000001,10000,20000,100000,200000,400000,1000000,2000000,12314000)

label_Psur = c('No cropland','0','0-1.0E+04','1.0E+04-2.0E+04','2.0E+04-1.0E+05','1.0E+05-2.0E+05','2.0E+05-4.0E+05','4.0E+05-1.0E+06','1.0E+06-2.0E+06','>2.0E+06')
dir_Psur = "./IMG4/"

plotmap_disc(resultData_Draw,resultData_Draw$Psur_kg_ALL,"Psur kg",c_def,"Psur_kg.jpg",label_Psur,dir_Psur,mina = 0, maxb = 12314000)

## Blue water use
c_def <- c('white','darkgreen','green','lightgreen','wheat','yellow','gold','lightcoral','red','darkred')
zCuts <- c(-1000000000,-0.000001,500000000,1000000000,5000000000,10000000000,20000000000,30000000000,40000000000,100000000000,6.4668e+11)

label_blue = c('No cropland','0-5.0E+08','5.0E+08-1.0E+09','1.0E+09-5.0E+09','5.0E+09-1.0E+10','1.0E+10-2.5E+10','2.5E+10-3.0E+10','3.0E+10-4.0E+10','4.0E+10-1.0E+11','>1.0E+11')
dir_blue = "./IMG4/"

plotmap_disc(resultData_Draw,resultData_Draw$BlueW_L_ALL,"Blue Water L",c_def,"BlueW_L.jpg",label_blue,dir_blue,mina = 0, maxb = 6.4668e+11)





### Changes


plotmap_cont <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {

  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = world_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() + theme(legend.text=element_text(size=12),axis.text=element_text(size=12))

imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}


Nsur_Q75 <- quantile(resultData_Q$Nsur_kg_GRID, c(.75),na.rm = T)
Psur_Q75 <- quantile(resultData_Q$Psur_kg_GRID, c(.75),na.rm = T)
BlueW_Q75 <- quantile(resultData_Q$BlueW_L_GRID, c(.75),na.rm = T)

#colfunc<-colorRampPalette(c("seagreen","green","yellow","red","firebrick4"))
colfunc<-colorRampPalette(c("darkgreen","springgreen","yellow","red","firebrick4"))
colfunc2<-colorRampPalette(c("darkgreen","springgreen","white","pink","tomato","red","firebrick3","firebrick4"))
colfunc_red<-colorRampPalette(c("white","red"))

colfunc_green<-colorRampPalette(c("white","lightgreen","green","darkgreen"))


resultData_DrawD <- resultData_Draw[resultData_Draw$Harvested_Area!=0,]

Nsur_normal_max = ceiling(max(abs(resultData_Draw$Nsur_kg_Delta_normal_ALL),na.rm = T))
Psur_normal_max = ceiling(max(abs(resultData_Draw$Psur_kg_Delta_normal_ALL),na.rm = T))
BlueW_normal_max = ceiling(max(abs(resultData_Draw$BlueW_L_Delta_normal_ALL),na.rm = T))

Nsur_soy_max = ceiling(max(abs(resultData_Draw$Nsur_kg_Delta_soy_ALL),na.rm = T))
Psur_soy_max = ceiling(max(abs(resultData_Draw$Psur_kg_Delta_soy_ALL),na.rm = T))
BlueW_soy_max = ceiling(max(abs(resultData_Draw$BlueW_L_Delta_soy_ALL),na.rm = T))

## Nsur changes
img_IntN = "./IMG4/LevelChanges/normal/"
img_IntE = "./IMG4/LevelChanges/soy/"
plotmap_cont(resultData_DrawD,resultData_DrawD$Nsur_kg_Delta_normal_ALL,"Nsur Changes kg",colfunc(20),"Nsur_kg_normal_delta.jpg", img_IntN,mina = -1*Nsur_normal_max, maxb = Nsur_normal_max)
plotmap_cont(resultData_DrawD,resultData_DrawD$Nsur_kg_Delta_soy_ALL,"Nsur Changes kg",colfunc(20),"Nsur_kg_soy_delta.jpg", img_IntE,mina = -1*Nsur_normal_max, maxb = Nsur_normal_max)

## Psur Changes
plotmap_cont(resultData_DrawD,resultData_DrawD$Psur_kg_Delta_normal_ALL,"Psur Changes kg",colfunc(20),"Psur_kg_normal_delta.jpg", img_IntN,mina = -1*Psur_normal_max, maxb = Psur_normal_max)
plotmap_cont(resultData_DrawD,resultData_DrawD$Psur_kg_Delta_extreme_ALL,"Psur Changes kg",colfunc(20),"Psur_kg_extreme_delta.jpg", img_IntE,mina = -1*Psur_extreme_max, maxb = Psur_extreme_max)

## BlueW Changes
plotmap_cont(resultData_DrawD,resultData_DrawD$BlueW_L_Delta_normal_ALL,"Blue Water Changes kg",colfunc(20),"BlueW_L_normal_delta.jpg", img_IntN,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)
plotmap_cont(resultData_DrawD,resultData_DrawD$BlueW_L_Delta_extreme_ALL,"Blue Water Changes kg",colfunc(20),"BlueW_L_extreme_delta.jpg", img_IntE,mina = -1*BlueW_extreme_max, maxb = BlueW_extreme_max)

area_max = max(resultData_DrawD$Harvested_Area)
## Harvested Area
plotmap_cont(resultData_DrawD,resultData_DrawD$Harvested_Area,"Harvested Area ha",colfunc_green(20),"harvestedarea.jpg", dir_blue,mina = 0, maxb = 500000)

### END ###



################# Map for China ##################
resultData_China <- resultData_Draw[resultData_Draw$GTAPCODE=="CHINA",]
shp_path_China <- 'C:/Users/gyao/Google Drive/ArcGIS/China Boundary Province/'
shp_name_China <- "China_Boundary.shp"
shp_file_China <- paste(shp_path_China, shp_name_China, sep="")
China_map <- st_read(shp_file_China)


plotmap_cont_CHN <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = China_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

img_IntN = "./IMG4/China/"
img_IntE = "./IMG4/China/"

Nsur_max = ceiling(max(abs(resultData_Draw$Nsur_kg_Delta_normal_ALL),na.rm = T))
Nsur_max_s = ceiling(max(abs(resultData_Draw$Nsur_kg_Delta_soy_ALL),na.rm = T))
Nsur_max = max(Nsur_max,Nsur_max_s)

Psur_max = ceiling(max(abs(resultData_Draw$Psur_kg_Delta_normal_ALL),na.rm = T))
Psur_max_s = ceiling(max(abs(resultData_Draw$Psur_kg_Delta_soy_ALL),na.rm = T))
Psur_max = max(Psur_max,Psur_max_s)

BlueW_max = ceiling(max(abs(resultData_Draw$BlueW_L_Delta_normal_ALL),na.rm = T))
BlueW_max_s = ceiling(max(abs(resultData_Draw$BlueW_L_Delta_soy_ALL),na.rm = T))
BlueW_max = max(BlueW_max,BlueW_max_s)



colfunc<-colorRampPalette(c("darkgreen","springgreen","white","red","firebrick4"))

plotmap_cont_CHN(resultData_China,resultData_China$Nsur_kg_Delta_normal_ALL,"Nsur changes kg",colfunc(20),"Nsur_kg_normal_delta.jpg", img_IntN,mina = -1 * Nsur_max, maxb = Nsur_max)
plotmap_cont_CHN(resultData_China,resultData_China$Nsur_kg_Delta_soy_ALL,"Nsur changes kg",colfunc(20),"Nsur_kg_soy_delta.jpg", img_IntE,mina = -1* Nsur_max, maxb = Nsur_max)

plotmap_cont_CHN(resultData_China,resultData_China$Psur_kg_Delta_normal_ALL,"Psur changes kg",colfunc(20),"Psur_kg_normal_delta.jpg", img_IntN,mina = -1 * Psur_max, maxb = Psur_max)
plotmap_cont_CHN(resultData_China,resultData_China$Psur_kg_Delta_soy_ALL,"Psur changes kg",colfunc(20),"Psur_kg_soy_delta.jpg", img_IntE,mina = -1* Psur_max, maxb = Psur_max)


plotmap_cont_CHN(resultData_China,resultData_China$BlueW_L_Delta_normal_ALL,"Blue water use changes L",colfunc(20),"BLUE_L_normal_delta.jpg", img_IntN,mina = -1*BlueW_max, maxb = BlueW_max)
plotmap_cont_CHN(resultData_China,resultData_China$BlueW_L_Delta_soy_ALL,"Blue water use Changes L",colfunc(20),"BLUE_L_soy_delta.jpg", img_IntE,mina = -1*BlueW_max, maxb = BlueW_max)



################# Map for US ##################
resultData_USA <- resultData_Draw[resultData_Draw$GTAPCODE=="USA",]
resultData_USA <- resultData_USA[resultData_USA$Latitude<50 & resultData_USA$Latitude>20 & resultData_USA$Longitude < -60,]

shp_path_USA <- 'C:/Users/gyao/Google Drive/ArcGIS/US Boundary State/'
shp_name_USA <- "USA_mainland.shp"
shp_file_USA <- paste(shp_path_USA, shp_name_USA, sep="")
US_map <- st_read(shp_file_USA)


plotmap_cont_USA <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = US_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

img_IntN = "./IMG4/USA/"
img_IntE = "./IMG4/USA/"

plotmap_cont_USA(resultData_USA,resultData_USA$Nsur_kg_Delta_normal_ALL,"Nsur changes kg",colfunc(20),"Nsur_kg_normal_delta.jpg", img_IntN,mina = -1*Nsur_max, maxb = Nsur_max)
plotmap_cont_USA(resultData_USA,resultData_USA$Nsur_kg_Delta_soy_ALL,"Nsur changes kg",colfunc(20),"Nsur_kg_soy_delta.jpg", img_IntE,mina = -1*Nsur_max, maxb = Nsur_max)

plotmap_cont_USA(resultData_USA,resultData_USA$Psur_kg_Delta_normal_ALL,"Psur changes kg",colfunc(20),"Psur_kg_normal_delta.jpg", img_IntN,mina = -1*Psur_max, maxb = Psur_max)
plotmap_cont_USA(resultData_USA,resultData_USA$Psur_kg_Delta_soy_ALL,"Psur changes kg",colfunc(20),"Psur_kg_soy_delta.jpg", img_IntE,mina = -1*Psur_max, maxb = Psur_max)

plotmap_cont_USA(resultData_USA,resultData_USA$BlueW_L_Delta_normal_ALL,"Blue water use changes L",colfunc(20),"BlueW_L_normal_delta.jpg", img_IntN,mina = -1*BlueW_max, maxb = BlueW_max)
plotmap_cont_USA(resultData_USA,resultData_USA$BlueW_L_Delta_soy_ALL,"Blue Water use changes L",colfunc(20),"BlueW_L_soy_delta.jpg", img_IntE,mina = -1*BlueW_max, maxb = BlueW_max)



################# Map for Brazil ##################

resultData_Brazil <- resultData_Draw[resultData_Draw$GTAPCODE=="BRAZIL" | resultData_Draw$GTAPCODE=="S_o_Amer",]


shp_path_Brazil <- 'C:/Users/gyao/Google Drive/ArcGIS/Brazil Province Boundary/'
shp_name_Brazil <- "Brazil_Boundary.shp"
shp_file_Brazil <- paste(shp_path_Brazil, shp_name_Brazil, sep="")
Brazil_map <- st_read(shp_file_Brazil)

shp_path_SA <- 'C:/Users/gyao/Google Drive/ArcGIS/South_America/'
shp_name_SA <- "South_America.shp"
shp_file_SA <- paste(shp_path_SA, shp_name_SA, sep="")
SA_map <- st_read(shp_file_SA)


plotmap_cont_Brazil <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = Brazil_map, size = 0.1, color = "grey",fill = "white", alpha = 0) + 
    geom_sf(data = SA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +
    geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}


img_IntN = "./IMG4/Brazil/"
img_IntE = "./IMG4/Brazil/"


#### Plot map for crops

##### base harvested area in ha
crpary_GTAP2d_aez<- read.csv(file="crpary_GTAP2d_aez.csv", header=TRUE, sep=",")
crpary_normal_GTAP2d_aez<- read.csv(file="crpary_normal_GTAP2d_aez.csv", header=TRUE, sep=",")
crpary_extreme_GTAP2d_aez<- read.csv(file="crpary_extreme_GTAP2d_aez.csv", header=TRUE, sep=",")
crpary_normal_GTAP_delta2d_aez<- read.csv(file="crpary_normal_GTAP_delta2d_aez.csv", header=TRUE, sep=",")
crpary_extreme_GTAP_delta2d_aez<- read.csv(file="crpary_extreme_GTAP_delta2d_aez.csv", header=TRUE, sep=",")

Fcrpary_GTAP2d_aez <- crpary_GTAP2d_aez[crpary_GTAP2d_aez$GTAPCODE != 'OTHER' & crpary_GTAP2d_aez$GTAPCODE != 'null',]
Fcrpary_normal_GTAP2d_aez <- crpary_normal_GTAP2d_aez[crpary_normal_GTAP2d_aez$GTAPCODE != 'OTHER' & crpary_normal_GTAP2d_aez$GTAPCODE != 'null',]
Fcrpary_extreme_GTAP2d_aez <- crpary_extreme_GTAP2d_aez[crpary_extreme_GTAP2d_aez$GTAPCODE != 'OTHER' & crpary_extreme_GTAP2d_aez$GTAPCODE != 'null',]
Fcrpary_normal_GTAP_delta2d_aez <- crpary_normal_GTAP_delta2d_aez[crpary_normal_GTAP_delta2d_aez$GTAPCODE != 'OTHER' & crpary_normal_GTAP_delta2d_aez$GTAPCODE != 'null',]
Fcrpary_extreme_GTAP_delta2d_aez <- crpary_extreme_GTAP_delta2d_aez[crpary_extreme_GTAP_delta2d_aez$GTAPCODE != 'OTHER' & crpary_extreme_GTAP_delta2d_aez$GTAPCODE != 'null',]


crpary_GTAP2d_aez<- read.csv(file="crpary_GTAP2d_aez.csv", header=TRUE, sep=",")
crpary_normal_GTAP2d_aez<- read.csv(file="crpary_normal_GTAP2d_aez.csv", header=TRUE, sep=",")
crpary_extreme_GTAP2d_aez<- read.csv(file="crpary_extreme_GTAP2d_aez.csv", header=TRUE, sep=",")
crpary_normal_GTAP_delta2d_aez<- read.csv(file="crpary_normal_GTAP_delta2d_aez.csv", header=TRUE, sep=",")
crpary_extreme_GTAP_delta2d_aez<- read.csv(file="crpary_extreme_GTAP_delta2d_aez.csv", header=TRUE, sep=",")

Fcrpary_GTAP2d_aez <- crpary_GTAP2d_aez[crpary_GTAP2d_aez$GTAPCODE == 'USA' | crpary_GTAP2d_aez$GTAPCODE == 'CHINA' | crpary_GTAP2d_aez$GTAPCODE == 'BRAZIL'|crpary_GTAP2d_aez$GTAPCODE == 'S_o_Amer'|crpary_GTAP2d_aez$GTAPCODE == 'EU27',]
Fcrpary_normal_GTAP2d_aez <- crpary_normal_GTAP2d_aez[crpary_normal_GTAP2d_aez$GTAPCODE == 'USA' | crpary_normal_GTAP2d_aez$GTAPCODE == 'CHINA' | crpary_normal_GTAP2d_aez$GTAPCODE == 'BRAZIL'|crpary_normal_GTAP2d_aez$GTAPCODE == 'S_o_Amer'|crpary_normal_GTAP2d_aez$GTAPCODE == 'EU27',]
Fcrpary_extreme_GTAP2d_aez <- crpary_extreme_GTAP2d_aez[crpary_extreme_GTAP2d_aez$GTAPCODE == 'USA' | crpary_extreme_GTAP2d_aez$GTAPCODE == 'CHINA' | crpary_extreme_GTAP2d_aez$GTAPCODE == 'BRAZIL'|crpary_extreme_GTAP2d_aez$GTAPCODE == 'S_o_Amer'|crpary_extreme_GTAP2d_aez$GTAPCODE == 'EU27',]
Fcrpary_normal_GTAP2d_aez <- crpary_normal_GTAP2d_aez[crpary_normal_GTAP2d_aez$GTAPCODE == 'USA' | crpary_normal_GTAP2d_aez$GTAPCODE == 'CHINA' | crpary_normal_GTAP2d_aez$GTAPCODE == 'BRAZIL'|crpary_normal_GTAP2d_aez$GTAPCODE == 'S_o_Amer'|crpary_normal_GTAP2d_aez$GTAPCODE == 'EU27',]
Fcrpary_extreme_GTAP2d_aez <- crpary_extreme_GTAP2d_aez[crpary_extreme_GTAP2d_aez$GTAPCODE == 'USA' | crpary_extreme_GTAP2d_aez$GTAPCODE == 'CHINA' | crpary_extreme_GTAP2d_aez$GTAPCODE == 'BRAZIL'|crpary_extreme_GTAP2d_aez$GTAPCODE == 'S_o_Amer'|crpary_extreme_GTAP2d_aez$GTAPCODE == 'EU27',]



headers = c('Paddy_Rice', 'Wheat', 'Sorghum', 'Oth_CrGr', 'Soybeans', 'palmf', 'Rapeseed',
           'Oth_Oilseeds', 'Sugar_Crop', 'OthAgri', 'Pasturecrop')

colfuncgreen<-colorRampPalette(c("white","lightgreen","springgreen","darkgreen"))

colfuncgreen<-colorRampPalette(c("white","green"))

for(i in 1:10){
  tlt = paste('harvested_area_',headers[i], ".jpg", sep=" ")
  plotmap(Fcrpary_GTAP2d_aez,Fcrpary_GTAP2d_aez[,2+i],"ha",colfuncgreen(20),tlt,mina = 0)
}

colfuncrdgn<-colorRampPalette(c("firebrick4","red","white","springgreen","darkgreen"))


for(i in 1:10){
  var_max = ceiling(max(abs(Fcrpary_extreme_GTAP2d_aez[,2+i]),na.rm = T))
  tlt = paste('harvested_area_changes_',headers[i], ".jpg", sep=" ")
  plotmap(Fcrpary_extreme_GTAP2d_aez,Fcrpary_extreme_GTAP2d_aez[,2+i],"ha changes",colfunc(20),tlt,mina = -1*var_max, maxb = var_max)
}


#################### Color codes for intensity changes ##########################
# 8 darkred: > 75 percentile and become worse
# 7 red: > 75 percentile and no change
# 6 pink: > 75 percentile and become better
# 5 lightgodenrod1: > 75 percentile and now < 75 percentile
# 4 gold: <= 75 percentile and now > 75 percentile
# 3 lightgreen: <= 75 percentile and become worse
# 2 green: <=75 percentile and no change
# 1 darkgreen: <= 75 percentile and become better
# -1 grey: no data

### Legend
op <- par(bg = "white")
plot(c(0, 10), c(0, 10), type = "n", xlab="", ylab="")

rect(2, 1, 4, 2, col="coral",border="white")
rect(4, 1, 6, 2, col="red",border="white")
rect(6, 1, 8, 2, col="red4",border="white")

rect(2, 2, 4, 3, col="lightgoldenrod1",border="white")
rect(4, 2, 6, 3, col="gold",border="white")
rect(6, 2, 8, 3, col="goldenrod",border="white")

rect(2, 3, 4, 4, col="darkgreen",border="white")
rect(4, 3, 6, 4, col="green",border="white")
rect(6, 3, 8, 4, col="lightgreen",border="white")


### Function of assigning color

colorcode_f <- function(dt,newcol,newcol1,orgcol,changecol,updcol,benchmkL,benchmkU){
  dt[,newcol1] <- dt[,orgcol]
  dt[,newcol] <- dt[,orgcol]
  dt[is.na(dt[,newcol]),newcol] <- -1
  dt[is.na(dt[,orgcol]),orgcol] <- 0
  dt[is.na(dt[,changecol]),changecol] <- 0
  dt[,updcol] <- dt[,orgcol] + dt[,changecol]
  dt[dt[,updcol] > benchmkU & !is.na(dt[,newcol1]) & dt[,changecol] > 0,newcol] <- 9
  dt[dt[,updcol] > benchmkU & !is.na(dt[,newcol1]) & dt[,changecol] == 0,newcol] <- 8
  dt[dt[,updcol] > benchmkU & !is.na(dt[,newcol1]) & dt[,changecol] < 0,newcol] <- 7

  dt[dt[,updcol] <= benchmkU & dt[,updcol] >= benchmkL & !is.na(dt[,newcol1]) & dt[,changecol] > 0,newcol] <- 6
  dt[dt[,updcol] <= benchmkU & dt[,updcol] >= benchmkL & !is.na(dt[,newcol1]) & dt[,changecol] == 0,newcol] <- 5
  dt[dt[,updcol] <= benchmkU & dt[,updcol] >= benchmkL & !is.na(dt[,newcol1]) & dt[,changecol] < 0,newcol] <- 4  
  
  dt[dt[,updcol] < benchmkL & !is.na(dt[,newcol1]) & dt[,changecol] > 0 ,newcol] <- 3
  dt[dt[,updcol] < benchmkL & !is.na(dt[,newcol1]) & dt[,changecol] == 0,newcol] <- 2
  dt[dt[,updcol] < benchmkL & !is.na(dt[,newcol1]) & dt[,changecol] < 0,newcol] <- 1
  return(dt)
}



GlobalArea = 1.3E9

Nsur_L = 39
Psur_L = 2
BlueW_L = 780E12/GlobalArea


Nsur_U = 52
Psur_U = 4
BlueW_U = 3190E12/GlobalArea


resultData_Colr <- resultData_RF
resultData_Colr <- resultData_Colr[resultData_Colr$Harvested_Area>0,]


resultData_Colr<- colorcode_f(resultData_Colr,'Nsur_CS','Nsur_kgha_ALL_copy','Nsur_kgha_ALL','Nsur_kgha_Delta_normal_ALL','Nsur_kgha_ALL_upd',Nsur_L,Nsur_U)
resultData_Colr<- colorcode_f(resultData_Colr,'Psur_CS','Psur_kgha_ALL_copy','Psur_kgha_ALL','Psur_kgha_Delta_normal_ALL','Psur_kgha_ALL_upd',Psur_L,Psur_U)
resultData_Colr<- colorcode_f(resultData_Colr,'BlueW_CS','BlueW_Lha_ALL_copy','BlueW_Lha_ALL','BlueW_Lha_Delta_normal_ALL','BlueW_Lha_ALL_upd',BlueW_L,BlueW_U)

resultData_ColrE <- resultData_RF
resultData_ColrE <- resultData_ColrE[resultData_ColrE$Harvested_Area>0,]

resultData_ColrE<- colorcode_f(resultData_ColrE,'Nsur_CE','Nsur_kgha_ALL_copy','Nsur_kgha_ALL','Nsur_kgha_Delta_extreme_ALL','Nsur_kgha_ALL_updE',Nsur_L,Nsur_U)
resultData_ColrE<- colorcode_f(resultData_ColrE,'Psur_CE','Psur_kgha_ALL_copy','Psur_kgha_ALL','Psur_kgha_Deltaha_extreme_ALL','Psur_kgha_ALL_updE',Psur_L,Psur_U)
resultData_ColrE<- colorcode_f(resultData_ColrE,'BlueW_CE','BlueW_Lha_ALL_copy','BlueW_Lha_ALL','BlueW_Lha_Delta_extreme_ALL','BlueW_Lha_ALL_updE',BlueW_L,BlueW_U)

resultData_score<-resultData_Colr[,1:7]
resultData_score[,'Nsur_CS'] <- resultData_Colr[,'Nsur_CS']
resultData_score[,'Psur_CS'] <- resultData_Colr[,'Psur_CS']
resultData_score[,'BlueW_CS'] <- resultData_Colr[,'BlueW_CS']

resultData_score[,'Nsur_CE'] <- resultData_ColrE[,'Nsur_CE']
resultData_score[,'Psur_CE'] <- resultData_ColrE[,'Psur_CE']
resultData_score[,'BlueW_CE'] <- resultData_ColrE[,'BlueW_CE']


#scale_fill_brewer(palette="RdYlGn")

plotmap_sc <- function(dt, vrb,nm,tt) {
  cols = c("-1"="grey","1"="darkgreen","2"="green","3"="lightgreen","4"="lightgoldenrod1","5"="gold", "6" = "goldenrod",
           "7"="coral","8"="red","9"="red4")
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = factor(vrb))) +
    scale_fill_manual(values = cols,name = tt)+ 
    geom_sf(data = world_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() + theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = "./IMG3NewPB/Score/"
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

s_header <- c("Nsur_CS","Psur_CS","BlueW_CS","Nsur_CE","Psur_CE","BlueW_CE")

for(i in 1:6){
    tlt = paste('Score_',s_header[i], ".jpg", sep=" ")
    plotmap_sc(resultData_score,resultData_score[,7+i],tlt,'Score')
  }

#### End######
