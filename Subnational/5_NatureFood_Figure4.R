rm(list = ls())
setwd("C:/Research/Post-Doc Research/HarvestedAreaYield/HarvestedAreaYield175Crops_Geotiff/HarvestedAreaYield175Crops_Geotiff")

library(maptools)
library(rgeos)
library(rgdal)
library(sf)
library(ggplot2)
library(raster)
library(RColorBrewer)
library(ggthemes)

# read the shape file for World Map
shp_path <- 'E:/Research/SAM-CMT/MapCode/world countries/'
shp_name <- "world_country_admin_boundary_shapefile_with_fips_codes.shp"
shp_file <- paste(shp_path, shp_name, sep="")
world_map <- st_read(shp_file)

################# Map for the World##################
resultData <- read.csv(file="grid_results_aez_negative2zero_07222020.csv", header=TRUE, sep=",")
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

Nsur_normal_max = ceiling(max(abs(resultData_Draw$Nsur_kgha_Delta_normal_ALL),na.rm = T))
Psur_normal_max = ceiling(max(abs(resultData_Draw$Psur_kgha_Delta_normal_ALL),na.rm = T))
BlueW_normal_max = ceiling(max(abs(resultData_Draw$BlueW_Lha_Delta_normal_ALL),na.rm = T))

Nsur_soy_max = ceiling(max(abs(resultData_Draw$Nsur_kgha_Delta_soy_ALL),na.rm = T))
Psur_soy_max = ceiling(max(abs(resultData_Draw$Psur_kgha_Deltaha_soy_ALL),na.rm = T))
BlueW_soy_max = ceiling(max(abs(resultData_Draw$BlueW_Lha_Delta_soy_ALL),na.rm = T))

## 10132019 Added: Blue water use
### ColorCodes: N: yellow =2 P: red = 3  BlueWater: blue = 4
#### N and P: Orange =6   P and B: Purple =12   N and B: Green = 8
### All: Balck = 24

result_overlap <- cbind(resultData_Draw[,1:7],resultData_Draw[,11:16]);

result_overlap$Nsur_normal_b <- ifelse(result_overlap$Nsur_kgha_Delta_normal_ALL > 0, 2, 1)
result_overlap$Psur_normal_b <- ifelse(result_overlap$Psur_kgha_Delta_normal_ALL > 0, 3, 1)
result_overlap$Blue_normal_b <- ifelse(result_overlap$BlueW_Lha_Delta_normal_ALL > 0, 4, 1)
result_overlap$hotspot_normal <- result_overlap$Nsur_normal_b * result_overlap$Psur_normal_b * result_overlap$Blue_normal_b

result_overlap[is.na(result_overlap$hotspot_normal),"hotspot_normal"] <- -999999999

result_overlap$Harvested_Area0 <- result_overlap$Harvested_Area
result_overlap$Harvested_Area0 <- cut(result_overlap$Harvested_Area, 
                                      breaks = c(-Inf, 50, 500, 1500, 2500, 5000, 10000, 25000, 50000, 100000, Inf),
                                      labels = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9), right = FALSE)

#result_overlap$Harvested_Area_use <- ifelse(result_overlap$Harvested_Area > 178060, 178060, log(result_overlap$Harvested_Area))
result_overlap$Harvested_Area_use <- log(result_overlap$Harvested_Area)
result_overlap$Harvested_Area_use  <- ifelse(result_overlap$Harvested_Area_use < -5, -5, result_overlap$Harvested_Area_use)

result_overlap[result_overlap$Harvested_Area == 0,'Harvested_Area_use'] <- -999999999

result_overlap$Harvested_Area0 <- as.numeric(result_overlap$Harvested_Area0)

result_overlap_China <- result_overlap[result_overlap$GTAPCODE=="CHINA",]
result_overlap_USA <- result_overlap[result_overlap$GTAPCODE=="USA",]
result_overlap_USA <- result_overlap_USA[result_overlap_USA$Latitude<50 & result_overlap_USA$Latitude>20 & result_overlap_USA$Longitude < -60,]
result_overlap_Brazil <- result_overlap[result_overlap$GTAPCODE=="BRAZIL" | result_overlap$GTAPCODE=="S_o_Amer",]


total_area_max = max(abs(result_overlap_China$Harvested_Area_use), abs(result_overlap_USA$Harvested_Area_use), abs(result_overlap_Brazil$Harvested_Area_use))
total_area_min = floor(min(result_overlap_China$Harvested_Area_use,result_overlap_USA$Harvested_Area_use, result_overlap_Brazil$Harvested_Area_use))

#c_def <- c('grey','white','yellow','red','blue','orange','green','purple','black')
#zCuts <- c(-1000000000,0,1.5,2.5,3.5,4.5,6.5,8.5,12.5,25)

#label_hotspot = c('No cropland','No Degradation','N Surplus ONLY','P Surplus ONLY','Blue Water ONLY','N and P Surplus','N Surplus and Blue Water','P Surplus and Blue Water','N and P Surplus and Blue Water')


#plotmap_disc(result_overlap,result_overlap$hotspot_normal,"Environmental Degradation",c_def,"Hotspot_normal.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)

### Soy

result_overlap$Nsur_soy_b <- ifelse(result_overlap$Nsur_kgha_Delta_soy_ALL > 0, 2, 1)
result_overlap$Psur_soy_b <- ifelse(result_overlap$Psur_kgha_Deltaha_soy_ALL > 0, 3, 1)
result_overlap$Blue_soy_b <- ifelse(result_overlap$BlueW_Lha_Delta_soy_ALL > 0, 4, 1)
result_overlap$hotspot_soy <- result_overlap$Nsur_soy_b * result_overlap$Psur_soy_b * result_overlap$Blue_soy_b

result_overlap[is.na(result_overlap$hotspot_soy),"hotspot_soy"] <- -999999999

c_def <- c('grey','white','yellow','red','blue','orange','green','purple','black')
zCuts <- c(-1000000000,0,1.5,2.5,3.5,4.5,6.5,8.5,12.5,25)

label_hotspot = c('No cropland','No Degradation','N Surplus ONLY','P Surplus ONLY','Blue Water ONLY','N and P Surplus','N Surplus and Blue Water','P Surplus and Blue Water','N and P Surplus and Blue Water')
#dir_hotspot = "./IMG4/hotspot/"

#plotmap_disc(result_overlap,result_overlap$hotspot_soy,"Environmental Degradation",c_def,"Hotspot_soy.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)


################# Map for China 10152019##################
resultData_China <- resultData_Draw[resultData_Draw$GTAPCODE=="CHINA",]
#area_normal_China <- area_normal_changes[area_normal_changes$GTAPCODE == "CHINA",]
#area_soy_China <- area_soy_changes[area_soy_changes$GTAPCODE == "CHINA",]

shp_path_China <- 'E:/Research/SAM-CMT/MapCode/China Boundary Clean/'
shp_name_China <- "China_Boundary_Clean.shp"
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

plotmap_cont_CHN_nolegend <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = China_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(legend.position="none",axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

img_IntN = "./NatureFoodImage/"
img_IntE = "./NatureFoodImage/"

colfunc<-colorRampPalette(c("Springgreen3","springgreen","white","red","firebrick4"))

p_n_china <- plotmap_cont_CHN_nolegend(resultData_China,resultData_China$Nsur_kgha_Delta_normal_ALL,"kg N/ha",colfunc(20),"Nsur_kgha_normal_delta_china.jpg", img_IntN,mina = -8, maxb = 8)
p_n_china_soy <- plotmap_cont_CHN_nolegend(resultData_China,resultData_China$Nsur_kgha_Delta_soy_ALL,"kg N/ha",colfunc(20),"Nsur_kgha_soy_delta_china.jpg", img_IntE,mina = -8, maxb = 8)

p_p_china <- plotmap_cont_CHN_nolegend(resultData_China,resultData_China$Psur_kgha_Delta_normal_ALL,"kg P/ha",colfunc(20),"Psur_kgha_normal_delta_china.jpg", img_IntN,mina = -1*Psur_normal_max, maxb = Psur_normal_max)
p_p_china_soy <- plotmap_cont_CHN_nolegend(resultData_China,resultData_China$Psur_kgha_Deltaha_soy_ALL,"kg P/ha",colfunc(20),"Psur_kgha_soy_delta_china.jpg", img_IntE,mina = -1*Psur_normal_max, maxb = Psur_normal_max)

p_b_china <- plotmap_cont_CHN_nolegend(resultData_China,resultData_China$BlueW_Lha_Delta_normal_ALL,"L/ha",colfunc(20),"BLUE_Lha_normal_delta_china.jpg", img_IntN,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)
p_b_china_soy <- plotmap_cont_CHN_nolegend(resultData_China,resultData_China$BlueW_Lha_Delta_soy_ALL,"L/ha",colfunc(20),"BLUE_Lha_soy_delta_china.jpg", img_IntE,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)




## China Overlap Hotspot

#result_overlap_China <- result_overlap[result_overlap$GTAPCODE=="CHINA",]


plotmap_disc_CHN <- function(dt, vrb, zCuts, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_sf(data = China_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  #theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}


## 07232020: Overlay two layers
plotmap_disc_CHN2 <- function(dt, vrb, vrb2, zCuts, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T), minc, maxd) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, fill = "white", aes(x = Longitude, y =Latitude,  alpha = vrb2)) +
    scale_alpha(range = c(0.9, 0.0), limits = c(minc, maxd), guide = 'none') + 
    geom_sf(data = China_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(legend.position="none", axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  #theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}




#c_def <- c('grey','white','yellow','red','blue','orange','green','purple','black')
#zCuts <- c(-1000000000,0,1.5,2.5,3.5,4.5,6.5,8.5,12.5,25)


c_def <- c('white','yellow','red','blue','orange','green','purple','sienna4')
zCuts <- c(-1000000000,1.5,2.5,3.5,4.5,6.5,8.5,12.5,25)

label_hotspot = c('No cropland/no degradation','N surplus only','P surplus only','Blue water only','N and P surplus','N surplus and Blue water','P surplus and blue water','N and P surplus and blue water')

### ColorCodes: N: yellow =2 P: red = 3  BlueWater: blue = 4
#### N and P: Orange =6   P and B: Purple =12   N and B: Green = 8
### All: Balck = 24

dir_hotspot = "./NatureFoodImage/"


hotspot_china <- plotmap_disc_CHN(result_overlap_China,result_overlap_China$hotspot_normal,zCuts,"Environmental Degradation",c_def,"Hotspot_normal_China.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)
hotspot_overlay_china <- plotmap_disc_CHN2(result_overlap_China,result_overlap_China$hotspot_normal,result_overlap_China$Harvested_Area_use,zCuts,"Environmental Degradation",c_def,"Hotspot_normal2_China.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25,
                  minc = total_area_min, maxd = total_area_max)


c_def1 <- c('white','yellow','red','blue','green','purple','sienna4')
zCuts1 <- c(-1000000000,1.5,2.5,3.5,4.5,8.5,12.5,25)
label_hotspot1 = c('No cropland/no degradation','N surplus only','P surplus only','Blue water only','N surplus and blue water','P surplus and blue water','N and P surplus and blue water')

hotspot_china_soy <- plotmap_disc_CHN(result_overlap_China,result_overlap_China$hotspot_soy,zCuts1,"Environmental Degradation",c_def1,"Hotspot_soy.jpg",label_hotspot1,dir_hotspot,mina =-1000000000 , maxb = 25)
hotspot_overlay_china_soy <- plotmap_disc_CHN2(result_overlap_China,result_overlap_China$hotspot_soy,result_overlap_China$Harvested_Area_use,zCuts1,"Environmental Degradation",c_def1,"Hotspot_soy2.jpg",label_hotspot1,dir_hotspot,mina =-1000000000 , maxb = 25, 
                  minc = 0, maxd = total_area_max)

p_n_china / p_p_china / p_b_china / hotspot_overlay_china


################# Map for USA 10152019##################
resultData_USA <- resultData_Draw[resultData_Draw$GTAPCODE=="USA",]
resultData_USA <- resultData_USA[resultData_USA$Latitude<50 & resultData_USA$Latitude>20 & resultData_USA$Longitude < -60,]

#area_normal_USA <- area_normal_changes[area_normal_changes$GTAPCODE=="USA",]
#area_normal_USA <- area_normal_USA[area_normal_USA$Latitude<50 & area_normal_USA$Latitude>20 & area_normal_USA$Longitude < -60,]

#area_soy_USA <- area_soy_changes[area_soy_changes$GTAPCODE=="USA",]
#area_soy_USA <- area_soy_USA[area_soy_USA$Latitude<50 & area_soy_USA$Latitude>20 & area_soy_USA$Longitude < -60,]


shp_path_USA <- 'E:/Research/SAM-CMT/MapCode/US Boundary State/'
shp_name_USA <- "USA_mainland.shp"
shp_file_USA <- paste(shp_path_USA, shp_name_USA, sep="")
USA_map <- st_read(shp_file_USA)


plotmap_cont_USA <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = USA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}


plotmap_cont_USA_nolegend <- function(dt, vrb, tlt, colr,nm,img_dir,mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill = vrb)) +
    scale_fill_gradientn(colours = colr,name = tlt,limits = c(mina,maxb)) +
    geom_sf(data = USA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(legend.position="none", axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

img_IntN = "./NatureFoodImage/"
img_IntE = "./NatureFoodImage/"

p_n_usa <- plotmap_cont_USA_nolegend(resultData_USA,resultData_USA$Nsur_kgha_Delta_normal_ALL,"Nsur Changes kg/ha",colfunc(20),"Nsur_kgha_normal_delta_usa.jpg", img_IntN,mina = -8, maxb = 8)
p_n_usa_soy <- plotmap_cont_USA_nolegend(resultData_USA,resultData_USA$Nsur_kgha_Delta_soy_ALL,"Nsur Changes kg/ha",colfunc(20),"Nsur_kgha_soy_delta_usa.jpg", img_IntE,mina = -8, maxb = 8)

p_p_usa <- plotmap_cont_USA_nolegend(resultData_USA,resultData_USA$Psur_kgha_Delta_normal_ALL,"Psur Changes kg/ha",colfunc(20),"Psur_kgha_normal_usa.jpg", img_IntN,mina = -1*Psur_normal_max, maxb = Psur_normal_max)
p_n_usa_soy <- plotmap_cont_USA_nolegend(resultData_USA,resultData_USA$Psur_kgha_Deltaha_soy_ALL,"Psur Changes kg/ha",colfunc(20),"Psur_kgha_soy_usa.jpg", img_IntE,mina = -1*Psur_normal_max, maxb = Psur_normal_max)

p_b_usa <- plotmap_cont_USA_nolegend(resultData_USA,resultData_USA$BlueW_Lha_Delta_normal_ALL,"Irrigation Water Use Changes L/ha",colfunc(20),"BlueW_kgha_normal_delta_usa.jpg", img_IntN,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)
p_b_usa_soy <- plotmap_cont_USA_nolegend(resultData_USA,resultData_USA$BlueW_Lha_Delta_soy_ALL,"Irrigatioin Water Use Changes L/ha",colfunc(20),"BlueW_kgha_soy_delta_usa.jpg", img_IntE,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)

#plotmap_cont_USA(area_normal_USA,area_normal_USA$CropH_Area,"Harvested Area Changes ha",colfunc(20),"Area_ha_normal_delta_usa.jpg", img_IntN,mina = -1*Area_normal_max, maxb = Area_normal_max)
#plotmap_cont_USA(area_soy_USA,area_soy_USA$CropH_Area,"Harvested Area Changes ha",colfunc(20),"Area_ha_soy_delta_usa.jpg", img_IntE,mina = -1*Area_normal_max, maxb = Area_normal_max)


## USA Overlap Hotspot

#result_overlap_USA <- result_overlap[result_overlap$GTAPCODE=="USA",]
#result_overlap_USA <- result_overlap_USA[result_overlap_USA$Latitude<50 & result_overlap_USA$Latitude>20 & result_overlap_USA$Longitude < -60,]



plotmap_disc_USA <- function(dt, vrb, zCuts, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_sf(data = USA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  #theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}


## 07232020: Overlay two layers
plotmap_disc_USA2 <- function(dt, vrb, vrb2, zCuts, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T), minc, maxd) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, fill = "white", aes(x = Longitude, y =Latitude,  alpha = vrb2)) +
    scale_alpha(range = c(0.90, 0.00), limits = c(minc, maxd), guide = 'none') + 
    geom_sf(data = USA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(legend.position = "None", axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  #theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}



#c_def <- c('grey','white','yellow','red','blue','orange','green','purple','black')
#zCuts <- c(-1000000000,0,1.5,2.5,3.5,4.5,6.5,8.5,12.5,25)

#label_hotspot = c('No cropland','No Degradation','N Surplus ONLY','P Surplus ONLY','Blue Water ONLY','N and P Surplus','N Surplus and Blue Water','P Surplus and Blue Water','N and P Surplus and Blue Water')
dir_hotspot = "./NatureFoodImage/"


#plotmap_disc_USA(result_overlap_USA,result_overlap_USA$hotspot_normal,zCuts,"Environmental Degradation",c_def,"Hotspot_normal1.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)
#plotmap_disc_USA(result_overlap_USA,result_overlap_USA$hotspot_soy,zCuts,"Environmental Degradation",c_def,"Hotspot_soy1.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)

hotspot_overlay_usa <- plotmap_disc_USA2(result_overlap_USA,result_overlap_USA$hotspot_normal,result_overlap_USA$Harvested_Area_use,zCuts,"Environmental Degradation",c_def,"Hotspot_normal2_usa.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25, 
                  minc = total_area_min, maxd = total_area_max)
hotspot_overlay_usa_soy <- plotmap_disc_USA2(result_overlap_USA,result_overlap_USA$hotspot_soy,result_overlap_USA$Harvested_Area_use,zCuts,"Environmental Degradation",c_def,"Hotspot_soy2_usa.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25,
                  minc = total_area_min, maxd = total_area_max)


################# Map for Brazil 10152019##################
resultData_Brazil <- resultData_Draw[resultData_Draw$GTAPCODE=="BRAZIL" | resultData_Draw$GTAPCODE=="S_o_Amer",]
#area_normal_Brazil <- area_normal_changes[area_normal_changes$GTAPCODE=="BRAZIL" | area_normal_changes$GTAPCODE=="S_o_Amer",]
#area_soy_Brazil <- area_soy_changes[area_soy_changes$GTAPCODE=="BRAZIL" | area_soy_changes$GTAPCODE=="S_o_Amer",]


shp_path_Brazil <- 'E:/Research/SAM-CMT/MapCode/Brazil Province Boundary/'
shp_name_Brazil <- "Brazil_Boundary.shp"
shp_file_Brazil <- paste(shp_path_Brazil, shp_name_Brazil, sep="")
Brazil_map <- st_read(shp_file_Brazil)

shp_path_SA <- 'E:/Research/SAM-CMT/MapCode/South_America/'
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

img_IntN = "./NatureFoodImage/"
img_IntE = "./NatureFoodImage/"

p_n_brazil <- plotmap_cont_Brazil(resultData_Brazil,resultData_Brazil$Nsur_kgha_Delta_normal_ALL,"kg N/ha",colfunc(20),"Nsur_kgha_normal_delta_brazil.jpg", img_IntN,mina = -8, maxb = 8)
p_n_brazil_soy <- plotmap_cont_Brazil(resultData_Brazil,resultData_Brazil$Nsur_kgha_Delta_soy_ALL,"kg N/ha",colfunc(20),"Nsur_kgha_soy_delta_brazil.jpg", img_IntE,mina = -8, maxb = 8)

p_p_brazil <- plotmap_cont_Brazil(resultData_Brazil,resultData_Brazil$Psur_kgha_Delta_normal_ALL,"kg P/ha",colfunc(20),"Psur_kgha_normal_delta_brazil.jpg", img_IntN,mina = -1*Psur_normal_max, maxb = Psur_normal_max)
p_p_brazil_soy <- plotmap_cont_Brazil(resultData_Brazil,resultData_Brazil$Psur_kgha_Delta_soy_ALL,"kg p/ha",colfunc(20),"Psur_kgha_soy_delta_brazil.jpg", img_IntE,mina = -1*Psur_normal_max, maxb = Psur_normal_max)

p_b_brazil <- plotmap_cont_Brazil(resultData_Brazil,resultData_Brazil$BlueW_Lha_Delta_normal_ALL,"L/ha",colfunc(20),"BlueW_Lha_normal_delta_brazil.jpg", img_IntN,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)
p_b_brazil_soy <- plotmap_cont_Brazil(resultData_Brazil,resultData_Brazil$BlueW_Lha_Delta_soy_ALL,"L/ha",colfunc(20),"BlueW_Lha_soy_delta_brazil.jpg", img_IntE,mina = -1*BlueW_normal_max, maxb = BlueW_normal_max)


## Brazil Overlap Hotspot

#result_overlap_Brazil <- result_overlap[result_overlap$GTAPCODE=="BRAZIL" | result_overlap$GTAPCODE=="S_o_Amer",]

plotmap_disc_Brazil <- function(dt, vrb, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T) ) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_sf(data = Brazil_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +
    geom_sf(data = SA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  #theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}

plotmap_disc_Brazil2 <- function(dt, vrb, vrb2, zCuts, tlt, colr,nm,labeltext,img_dir, mina = min(vrb,na.rm = T),maxb = max(vrb, na.rm = T), minc, maxd) {
  
  pp <- ggplot() + geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, aes(x = Longitude, y =Latitude,  fill =cut(vrb,zCuts) )) +
    scale_fill_manual(values = colr,name = tlt,label= labeltext) +
    geom_raster(data = dt ,hjust = 0.5, vjust = 0.5, fill = "white", aes(x = Longitude, y =Latitude,  alpha = vrb2)) +
    scale_alpha(range = c(0.9, 0.00), limits = c(minc, maxd), guide = 'none') + 
    geom_sf(data = Brazil_map, size = 0.1, color = "grey",fill = "white", alpha = 0) +
    geom_sf(data = SA_map, size = 0.1, color = "grey",fill = "white", alpha = 0) + geom_bar() +
    coord_sf() + theme_bw() +
    theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.ticks = element_blank(),axis.title.y=element_blank(),axis.title.x=element_blank(),rect = element_blank(),panel.grid = element_line(color = "white") )
  
  
  #theme(legend.text=element_text(size=12),axis.text=element_text(size=12))
  
  imgDir = img_dir
  
  ggsave(paste(imgDir,nm), plot = pp,
         scale = 1, width = 10, height = 5,
         dpi = 1000)
  return(pp)
}


#c_def <- c('grey','white','yellow','red','blue','orange','green','purple','black')
#zCuts <- c(-1000000000,0,1.5,2.5,3.5,4.5,6.5,8.5,12.5,25)

#label_hotspot = c('No cropland','No Degradation','N Surplus ONLY','P Surplus ONLY','Irrig. Water ONLY','N and P Surplus','N Surplus and Irrig.Water','P Surplus and Irrig.Water','N and P Surplus and Irri.Water')
dir_hotspot = "./NatureFoodImage/"

#plotmap_disc_Brazil(result_overlap_Brazil,result_overlap_Brazil$hotspot_normal,"Environmental Degradation",c_def,"Hotspot_normal1.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)
#plotmap_disc_Brazil(result_overlap_Brazil,result_overlap_Brazil$hotspot_soy,"Environmental Degradation",c_def,"Hotspot_soy1.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25)

hotspot_overlay_brazil <- plotmap_disc_Brazil2(result_overlap_Brazil,result_overlap_Brazil$hotspot_normal,result_overlap_Brazil$Harvested_Area_use,zCuts,"Environmental Degradation",c_def,"Hotspot_normal2_brazil.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25, 
                     minc = total_area_min, maxd = total_area_max)
hotspot_overlay_brazil_soy <- plotmap_disc_Brazil2(result_overlap_Brazil,result_overlap_Brazil$hotspot_soy,result_overlap_Brazil$Harvested_Area_use,zCuts,"Environmental Degradation",c_def,"Hotspot_soy2_brazil.jpg",label_hotspot,dir_hotspot,mina =-1000000000 , maxb = 25, 
                     minc = total_area_min, maxd = total_area_max)

(p_n_china + p_n_usa + p_n_brazil) / (p_p_china + p_p_usa + p_p_brazil) / (p_b_china + p_b_usa + p_b_brazil) / (hotspot_overlay_china + hotspot_overlay_usa + hotspot_overlay_brazil)

