library(sf)
library(dplyr)
library(spgwr)
library(ggplot2)


#Charger données stations FM
stations <- st_read("Donnee_PrixCarburants/stations_avec_dist_auto_FM_2154.gpkg")

#charger données autoroute
autoroute <- st_read("Donnee_PrixCarburants/autoroutes_2154.gpkg")

#Prix gazole
stations_gas<- stations[stations$PrixNom == 'Gazole',]

#Filtrer par une distance de 5000 mètres, qui représente la médiane et capture la moitié des données.
stations_gas_5km<- stations_gas[stations_gas$dist_autoroute < 500,]


#simple modele linéaire 
model1 <- lm( stations_gas_5km$PrixValeur~ stations_gas_5km$dist_autoroute)
summary(model1)
cor.test(stations_gas_5km$PrixValeur, stations_gas_5km$dist_autoroute)
#cor = -0.452379 et p-value < 2.2e-16 
plot(data= stations_gas_5km, PrixValeur~ dist_autoroute)
abline(model1, col = "red") 

#Tracer les résidus pour voir s’il y a une structure spatiale évidente
resids<-residuals(model1)
colours <- c("dark blue", "blue", "red", "dark red") 
map.resids <- SpatialPointsDataFrame(data=data.frame(resids), coords=cbind(stations_gas_5km$Longitude,stations_gas_5km$Latitude))
spplot(map.resids, cuts=quantile(resids), col.regions=colours, cex=1) 

# GWR
GWRbandwidth <- gwr.sel( PrixValeur ~ dist_autoroute, data=stations_gas_5km, coords=cbind(stations_gas_5km$Longitude,stations_gas_5km$Latitude),adapt=T) 

#Exécuter le modéle GWR
gwr.model = gwr( PrixValeur ~ dist_autoroute, data=stations_gas_5km, coords=cbind(stations_gas_5km$Longitude,stations_gas_5km$Latitude), adapt=GWRbandwidth, hatmatrix=TRUE, se.fit=TRUE) 
#Afficher les résultats du modéle
gwr.model
results<-as.data.frame(gwr.model$SDF)
head(results)

#Attacher les coefficients à notre trame de données d’origine
stations_gas_5km$dist_autoroute <- results$dist_autoroute

#Charger les régions de France métropolitaine
region_2015 <- st_read("Donnee_PrixCarburants/region_FM_2154.gpkg")

#Cartographier les résultats de GWR
gwr.point1 <- ggplot(stations_gas_5km, aes(x = Longitude, y = Latitude, color = dist_autoroute)) + 
  geom_point() +
  scale_colour_gradient2(
    low = "red", mid = "white", high = "blue",
    midpoint = 0, na.value = "grey50",
    guide = "colourbar", guide_legend(title = "Coefs")
  )

gwr.point1

#################### cartographier les points et région #####################
color<- function(val,mi,ma){if(val<0){
  colorRamp(c("white","red"))(abs(val/mi))
}else{colorRamp(c("white","blue"))(val/ma)}}
plotcols=sapply(stations_gas_5km$dist_autoroute,color,min(stations_gas_5km$dist_autoroute),max(stations_gas_5km$dist_autoroute))
plot(stations_gas_5km$Longitude,stations_gas_5km$Latitude,col=plotcols)

# Tracer les points
gwr.point2 <- ggplot(region_2015) + geom_sf()+
  geom_point(data=stations_gas_5km, mapping=aes(x = Longitude, y = Latitude, colour = dist_autoroute)) +
  scale_colour_gradient2(
    low = "red", mid = "white", high = "blue",
    midpoint = 0, na.value = "grey50",
    guide = "colourbar", guide_legend(title = "Coefs")
  )

# Tracer les polygones par-dessus les points
gwr.point2 

