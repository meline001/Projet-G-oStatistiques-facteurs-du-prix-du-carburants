library(sf)
library(dplyr)


# Charger les données autoroutières pour la France métropolitaine aprés un filtrage des routes et projection en EPSG: 2154 sur QGIS
autoroute <- st_read("Donnee_PrixCarburants/autoroutes_2154.gpkg")

# Charger les données des stations en France métropolitaine après une projection en EPSG:2154 sur QGIS
stations_FM <- st_read('Donnee_PrixCarburants/stations_FM_2154.gpkg')

# Cartographier les données
plot(stations_FM$geom, cex=0.1)
plot(autoroute$geom, col="orange", add=T)

# Calculer la distance entre les stations et l'autoroute pour un test sur une station.
une_station <- stations_FM[22222,]
les_distances <- st_distance(une_station,autoroute)
min(les_distances)

# Calculer la distance entre les stations et l'autoroute pour pour toutes les stations.
nb_stations <- nrow(stations_FM)
dist_plus_proche <- c()
for( i in 1: nrow(stations_FM)){
  une_station <- stations_FM[i,]
  les_distances <- st_distance(une_station, autoroute)
  distance_min <- min(les_distances)
  dist_plus_proche <- c(dist_plus_proche, distance_min)
  cat("station numéro", i , "/" , nb_stations, "\n")
}

#Créer un champs dist_autoroute dans la table stations
stations_FM$dist_autoroute <- dist_plus_proche

#Créer une nouvelle couche à partir de la couche stations 
st_write(stations_FM, "stations_avec_dist_auto_FM.gpkg")

#Après, nous projetons la couche en EPSG : 2154 sur QGIS, car la couche n'a pas conservé le système de projection.




