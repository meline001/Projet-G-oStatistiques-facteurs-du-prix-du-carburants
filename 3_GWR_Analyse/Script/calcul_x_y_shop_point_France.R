library(sf)
library(dplyr)


#Charger les données France Shop constitue l'ensemble des centres commerciaux et points d'achat (supermarchés, stations-service, achat de voitures, etc.) en France

shop <- read.csv("Donnee_PrixCarburants/france_shops_point.csv")

#Extraire les coordonnées x y à partir de l'expression 'the_geom' dans ce cas ne permet pas de convertir en couche vecteur.

for( i in 1: nrow(shop)){
  chaine <- shop$the_geom[i]
  resultat <- unlist(strsplit(chaine, ' ' ))
  resultat <- setdiff(resultat,resultat[1])
  shop$x[i]<- as.numeric(substr(resultat[1],2, nchar(resultat[1]) ))
  shop$y[i]<- as.numeric(substr(resultat[2],1, nchar(resultat[2])-1 ))
}

st_write(shop, "shop_FM.csv")

# Ensuite, nous avons créé une couche vecteur à partir de ces coordonnées, les avons projetées en EPSG : 2154, et supprimé les champs non nécessaires.
