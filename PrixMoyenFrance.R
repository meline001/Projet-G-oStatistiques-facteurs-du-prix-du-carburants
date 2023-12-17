## Prix moyen du Carburants sur la France ##

#librarie 
library(stringr)
#library(tidyverse)
library(dplyr)
library(mapsf)
library(sf)
library(sqldf)

  ## Ouverture de fichiers ##

PrixMoyen2019 = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/data/Carburant_PrixMoy_2019.csv", sep=",")
PrixMoyen2023 = read.csv("C:/Users/melin/Documents/ing3/UE1/projetGeostat/data/Carburant_PrixMoy_2023.csv", sep=",")
departement = st_read("C:/Users/melin/Documents/ing3/UE1/projetGeostat/data/departements.geojson")

dep_simples <- st_simplify(departement,preserveTopology = T, 1000)
#plot(dep_simples$geometry)

#names(departement)
## Idée : si le code postal comporte que 4 chiffres ajouter un 0 devant.

######################### 2019 #########################

  ## Rajout du 0 dans le code postal pour premier département ##

PrixMoyen2019$CodePostal = ifelse (nchar(PrixMoyen2019$CodePostal) == 4, paste0("0",PrixMoyen2019$CodePostal),PrixMoyen2019$CodePostal)
  


  ## jointure des départements et des régions avec le prix moyen ##

PrixMoyen2019$dep_code = str_sub(PrixMoyen2019$CodePostal, 1, 2)
#PrixMoyen2019 = transform(PrixMoyen2019,CodeDep=as.numeric(PrixMoyen2019$CodeDep))


  ## supprime le format liste de l'attribut natif depcode ##

dep_simples$dep_code <-  unlist(departement$dep_code)
#prixmoyenDep19 = inner_join(departement,PrixMoyen2019 )  
prixmoyenDep19 = inner_join(dep_simples,PrixMoyen2019 )  

#class(prixmoyenDep19)
#plot(prixmoyenDep19[,"PrixValeur"])


  ## Sélection selon le carburant ##
#class(prixmoyenDep19)
prixmoyenDep19_Gazole = prixmoyenDep19[prixmoyenDep19$PrixNom=='Gazole',]
prixmoyenDep19_E85 = prixmoyenDep19[prixmoyenDep19$PrixNom=='E85',]
prixmoyenDep19_E10 = prixmoyenDep19[prixmoyenDep19$PrixNom=='E10',]
prixmoyenDep19_SP98 = prixmoyenDep19[prixmoyenDep19$PrixNom=='SP98',]
prixmoyenDep19_SP95 = prixmoyenDep19[prixmoyenDep19$PrixNom=='SP95',]
prixmoyenDep19_GPLc = prixmoyenDep19[prixmoyenDep19$PrixNom=='GPLc',]
# E85 E10 SP98 SP95 GPLc 


### Affichage Par départements ###

    ### Gazole ###

st_prixMoyen2019_Gazole = st_as_sf(prixmoyenDep19_Gazole, sf_column_name  = "geometry")
st_prixMoyen2019_Gazole = transform(st_prixMoyen2019_Gazole,PrixValeur=as.numeric(prixmoyenDep19_Gazole$PrixValeur))
class(st_prixMoyen2019_Gazole$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_Gazole, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du Gazole par département en 2019",pos='center', bg='white', fg='black')


    ### E85 ###

st_prixMoyen2019_E85 = st_as_sf(prixmoyenDep19_E85, sf_column_name  = "geometry")
st_prixMoyen2019_E85 = transform(st_prixMoyen2019_E85,PrixValeur=as.numeric(prixmoyenDep19_E85$PrixValeur))
class(st_prixMoyen2019_E85$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_E85, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du E85 par département en 2019",pos='center', bg='white', fg='black')


    ### E10 ###

st_prixMoyen2019_E10 = st_as_sf(prixmoyenDep19_E10, sf_column_name  = "geometry")
st_prixMoyen2019_E10 = transform(st_prixMoyen2019_E10,PrixValeur=as.numeric(prixmoyenDep19_E10$PrixValeur))
class(st_prixMoyen2019_E10$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_E10, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du E10 par département en 2019",pos='center', bg='white', fg='black')


    ### SP98 ###

st_prixMoyen2019_SP98 = st_as_sf(prixmoyenDep19_SP98, sf_column_name  = "geometry")
st_prixMoyen2019_SP98 = transform(st_prixMoyen2019_SP98,PrixValeur=as.numeric(prixmoyenDep19_SP98$PrixValeur))
class(st_prixMoyen2019_SP98$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_SP98, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du SP98 par département en 2019",pos='center', bg='white', fg='black')


    ### SP95 ###

st_prixMoyen2019_SP95 = st_as_sf(prixmoyenDep19_SP95, sf_column_name  = "geometry")
st_prixMoyen2019_SP95 = transform(st_prixMoyen2019_SP95,PrixValeur=as.numeric(prixmoyenDep19_SP95$PrixValeur))
class(st_prixMoyen2019_SP95$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_SP95, type = 'choro', var = "PrixValeur", nbreaks = 5)
mf_title("Prix moyen du SP95 par département en 2019",pos='center', bg='white', fg='black')


    ### GPLc ###

st_prixMoyen2019_GPLc = st_as_sf(prixmoyenDep19_GPLc, sf_column_name  = "geometry")
st_prixMoyen2019_GPLc = transform(st_prixMoyen2019_GPLc,PrixValeur=as.numeric(prixmoyenDep19_GPLc$PrixValeur))
class(st_prixMoyen2019_GPLc$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_GPLc, type = 'choro', var = "PrixValeur", nbreaks = 4)
mf_title("Prix moyen du GPLc par département en 2019",pos='center', bg='white', fg='black')


######################### 2023 #########################


PrixMoyen2023$CodePostal = ifelse (nchar(PrixMoyen2023$CodePostal) == 4, paste0("0",PrixMoyen2023$CodePostal),PrixMoyen2023$CodePostal)



## jointure des départements et des régions avec le prix moyen ##

PrixMoyen2023$dep_code = str_sub(PrixMoyen2023$CodePostal, 1, 2)
#PrixMoyen2019 = transform(PrixMoyen2019,CodeDep=as.numeric(PrixMoyen2019$CodeDep))


## supprime le format liste de l'attribut natif depcode ##

dep_simples$dep_code <-  unlist(departement$dep_code)
#prixmoyenDep19 = inner_join(departement,PrixMoyen2019 )  
prixmoyenDep23 = inner_join(dep_simples,PrixMoyen2023 )  

#class(prixmoyenDep19)
#plot(prixmoyenDep19[,"PrixValeur"])


## Sélection selon le carburant ##
#class(prixmoyenDep19)
prixmoyenDep23_Gazole = prixmoyenDep23[prixmoyenDep23$PrixNom=='Gazole',]
prixmoyenDep23_E85 = prixmoyenDep23[prixmoyenDep23$PrixNom=='E85',]
prixmoyenDep23_E10 = prixmoyenDep23[prixmoyenDep23$PrixNom=='E10',]
prixmoyenDep23_SP98 = prixmoyenDep23[prixmoyenDep23$PrixNom=='SP98',]
prixmoyenDep23_SP95 = prixmoyenDep23[prixmoyenDep23$PrixNom=='SP95',]
prixmoyenDep23_GPLc = prixmoyenDep23[prixmoyenDep23$PrixNom=='GPLc',]
# E85 E10 SP98 SP95 GPLc 


### Affichage Par départements ###

### Gazole ###

st_prixMoyen2023_Gazole = st_as_sf(prixmoyenDep23_Gazole, sf_column_name  = "geometry")
st_prixMoyen2023_Gazole = transform(st_prixMoyen2023_Gazole,PrixValeur=as.numeric(prixmoyenDep23_Gazole$PrixValeur))
class(st_prixMoyen2023_Gazole$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_Gazole, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du Gazole par département en 2023",pos='center', bg='white', fg='black')


### E85 ###

st_prixMoyen2023_E85 = st_as_sf(prixmoyenDep23_E85, sf_column_name  = "geometry")
st_prixMoyen2023_E85 = transform(st_prixMoyen2023_E85,PrixValeur=as.numeric(prixmoyenDep23_E85$PrixValeur))
class(st_prixMoyen2023_E85$PrixValeur)
#na.omit(st_prixMoyen2023_E85$PrixValeur)
#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_E85, type = 'choro', var = "PrixValeur", nbreaks = 5)
mf_title("Prix moyen du E85 par département en 2023",pos='center', bg='white', fg='black')


### E10 ###

st_prixMoyen2023_E10 = st_as_sf(prixmoyenDep23_E10, sf_column_name  = "geometry")
st_prixMoyen2023_E10 = transform(st_prixMoyen2023_E10,PrixValeur=as.numeric(prixmoyenDep23_E10$PrixValeur))
class(st_prixMoyen2023_E10$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_E10, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du E10 par département en 2023",pos='center', bg='white', fg='black')


### SP98 ###

st_prixMoyen2023_SP98 = st_as_sf(prixmoyenDep23_SP98, sf_column_name  = "geometry")
st_prixMoyen2023_SP98 = transform(st_prixMoyen2023_SP98,PrixValeur=as.numeric(prixmoyenDep23_SP98$PrixValeur))
class(st_prixMoyen2023_SP98$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_SP98, type = 'choro', var = "PrixValeur", nbreaks = 7)
mf_title("Prix moyen du SP98 par département en 2023",pos='center', bg='white', fg='black')


### SP95 ###

st_prixMoyen2023_SP95 = st_as_sf(prixmoyenDep23_SP95, sf_column_name  = "geometry")
st_prixMoyen2023_SP95 = transform(st_prixMoyen2023_SP95,PrixValeur=as.numeric(prixmoyenDep23_SP95$PrixValeur))
class(st_prixMoyen2023_SP95$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_SP95, type = 'choro', var = "PrixValeur", nbreaks = 5)
mf_title("Prix moyen du SP95 par département en 2023",pos='center', bg='white', fg='black')


### GPLc ###

st_prixMoyen2023_GPLc = st_as_sf(prixmoyenDep23_GPLc, sf_column_name  = "geometry")
st_prixMoyen2023_GPLc = transform(st_prixMoyen2023_GPLc,PrixValeur=as.numeric(prixmoyenDep23_GPLc$PrixValeur))
class(st_prixMoyen2023_GPLc$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_GPLc, type = 'choro', var = "PrixValeur", nbreaks = 4)
mf_title("Prix moyen du GPLc par département en 2023",pos='center', bg='white', fg='black')
