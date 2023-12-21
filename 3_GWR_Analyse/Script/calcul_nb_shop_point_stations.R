library(sf)
library(dplyr)


#Charger les données shop point FM 
shop_FM <- st_read('Donnee_PrixCarburants/shop_FM_Rgf93.gpkg')

#Supprimer les stations-service
shop_FM<- shop_FM [shop_FM$shop!= 'gas',]

#Charger les données des stations FM avec la distance par rapport à l'autoroute.
stations <- st_read("Donnee_PrixCarburants/stations_avec_dist_auto_FM_2154.gpkg")

#cartographie les données
plot(shop_FM$geom, cex=0.1)
plot(stations$geom, col="blue", cex=0.1, add=T)

#Compter le nombre de points d'achat autour des stations

#Exemple sur une station
point <- stations[5,]$geom
#Créer un buffer de 500m autour de la station
buffer <- st_buffer(point, 500)
#Compter le nombre de points d'achat qui intersectent le buffer
intersection <- st_intersection( shop_FM, buffer)
print(nrow(intersection))

#Cartographier le résultat 
plot(buffer)
plot(point, col="red", add = T)
plot (intersection, col="green", add=T)

#Boucle sur le reste des stations
nb_shop <- c()
for( i in 1: nrow(stations)){
  une_station <- stations[i,]
  point <- une_station$geom
  buffer <- st_buffer(point, 500)
  intersection <- st_intersection( shop_FM, buffer)
  n<- nrow(intersection)
  print(n)
  nb_shop  <- c(nb_shop, n)
  cat("station numéro", i , "/" ,nrow(stations) , "\n")
}

stations$nb_shop_point <- nb_shop
st_write(stations, "stations_avec_dist_auto_shop.gpkg")
  


