####### Projet Geostatistique - Prix du carburant ####### 

## Script pour détecter les doublons ##

#Librarie 

library(dplyr)
library(readr)
library(ggplot2)

# Ouverture du fichier

PopCommune <- read_csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/population-francaise-communes.csv",col_names = F)

#Verification des doublons 
doublons = duplicated(PopCommune)

#Suppression des doublons
suppDoublons = distinct(PopCommune)
