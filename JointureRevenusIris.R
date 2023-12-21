### Projet Géostat ###
## Jointure revenus et iris ##

# Librairie
library(dplyr)

#lecture revenus 
#fichier revenus et on utilise le revenus médian de l'iris. 

revenus2023 = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/BASE_TD_FILO_DEC_IRIS_2018/BASE_TD_FILO_DEC_IRIS_2018.csv", sep=";")
revenus2019 = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/BASE_TD_FILO_DISP_IRIS_2019.csv", sep=";")
iris = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/georef-france-iris.csv", sep=";")


#transformation d'une colone type 'character' en type 'integer'
revenus2023_2=transform(revenus2023,IRIS=as.numeric(revenus$IRIS))
revenus2019_2 = transform(revenus2019,IRIS=as.numeric(revenus2019$IRIS))

#Jointure
jointure2023 =  full_join(revenus2023_2,iris, by=c("IRIS"="Code.Officiel.IRIS"))
jointure2019 = full_join(revenus2019_2,iris, by=c("IRIS"="Code.Officiel.IRIS"))

#On garde que les colonnes intéressante
jointure2023_bis = jointure[,c(1,5,26:32,47)]
jointure2019_bis = jointure[,c(1,5,26:32,47)]

write.csv(jointure2023_bis, "C:/Users/melin/Documents/ing3/UE1/projetGeostat/RevenusParIris2023.csv", row.names=FALSE)
write.csv(jpointure_bis, "C:/Users/melin/Documents/ing3/UE1/projetGeostat/RevenusParIris2019.csv", row.names=FALSE)
