### Projet Géostat ###
## Jointure revenus et iris ##

# Librairie
library(dplyr)

#lecture revenus 
#fichier revenus et on utilise le revenus médian de l'iris. 

revenus = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/BASE_TD_FILO_DEC_IRIS_2018/BASE_TD_FILO_DEC_IRIS_2018.csv", sep=";")
iris = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/georef-france-iris.csv", sep=";")


#transformation d'une colone type 'character' en type 'integer'
revenus2=transform(revenus,IRIS=as.numeric(revenus$IRIS))


#Jointure
jointure =  full_join(revenus2,iris, by=c("IRIS"="Code.Officiel.IRIS"))

#On garde que les colonnes intéressante
jpointure_bis = jointure[,c(1,5,26,28:32,47)]

write.csv(jpointure_bis, "C:/Users/melin/Documents/ing3/UE1/projetGeostat/RevenusParIris.csv", row.names=FALSE)
