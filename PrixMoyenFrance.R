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
departement = st_read("C:/Users/melin/Documents/ing3/UE1/projetGeostat/GEOFLA_2-2_DEPARTEMENT_SHP_LAMB93_FXX_2016-06-28/GEOFLA/1_DONNEES_LIVRAISON_2021-02-00129/GEOFLA_2-2_SHP_LAMB93_FR-ED161/DEPARTEMENT/DEPARTEMENT.shp")

dep_simples <- st_simplify(departement,preserveTopology = T, 1000)
#plot(dep_simples$geometry)

#names(departement)
## Idée : si le code postal comporte que 4 chiffres ajouter un 0 devant.

######################### 2019 #########################

  ## Rajout du 0 dans le code postal pour premier département ##

PrixMoyen2019$CodePostal = ifelse (nchar(PrixMoyen2019$CodePostal) == 4, paste0("0",PrixMoyen2019$CodePostal),PrixMoyen2019$CodePostal)
  


  ## jointure des départements et des régions avec le prix moyen ##

PrixMoyen2019$CODE_DEPT = str_sub(PrixMoyen2019$CodePostal, 1, 2)
#PrixMoyen2019 = transform(PrixMoyen2019,CodeDep=as.numeric(PrixMoyen2019$CodeDep))


  ## supprime le format liste de l'attribut natif depcode ##

dep_simples$CODE_DEPT <-  unlist(departement$CODE_DEPT)
#prixmoyenDep19 = inner_join(departement,PrixMoyen2019 )  
prixmoyenDep19 = inner_join(dep_simples,PrixMoyen2019 )  

#class(prixmoyenDep19)
#plot(prixmoyenDep19[,"PrixValeur"])


  ## Sélection selon le carburant ##
#class(prixmoyenDep19)
prixmoyenDep19_Gazole = prixmoyenDep19[prixmoyenDep19$PrixNom=='Gazole',] %>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep19_SP98 = prixmoyenDep19[prixmoyenDep19$PrixNom=='SP98',] %>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep19_SP95 = prixmoyenDep19[prixmoyenDep19$PrixNom=='SP95',] %>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
#prixmoyenDep19_E85 = prixmoyenDep19[prixmoyenDep19$PrixNom=='E85',]
#prixmoyenDep19_E10 = prixmoyenDep19[prixmoyenDep19$PrixNom=='E10',]
#prixmoyenDep19_GPLc = prixmoyenDep19[prixmoyenDep19$PrixNom=='GPLc',]
# E85 E10 SP98 SP95 GPLc 

#max = 1.748 -> SP98
#min = 1.424 -> Gazole

# 1.42,1.46,1.49,1.53,1.55,1.58,1.63,1.74,1.75

### Affichage Par départements ###

    ### Gazole ###

st_prixMoyen2019_Gazole = st_as_sf(prixmoyenDep19_Gazole, sf_column_name  = "geometry")
st_prixMoyen2019_Gazole = transform(st_prixMoyen2019_Gazole,PrixValeur=as.numeric(prixmoyenDep19_Gazole$PrixValeur))
class(st_prixMoyen2019_Gazole$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_Gazole, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd=3)
mf_title("Prix moyen du Gazole par département en 2019",pos='center', bg='white', fg='black')

hist(prixmoyenDep19_Gazole$PrixValeur, breaks=20, xlim=c(1.4,1.65),
     main="Moyenne du prix du gazole dans les départements en 2019", 
     xlab="Prix moyen du Gazole",ylab="Nb de départements")
abline(v=mean(prixmoyenDep19_Gazole$PrixValeur), col='red')
text("Moyenne nationale", x = 1.51, y=30, srt = 0, pos =2,cex=0.8,col='red')



    ### SP98 ###

st_prixMoyen2019_SP98 = st_as_sf(prixmoyenDep19_SP98, sf_column_name  = "geometry")
st_prixMoyen2019_SP98 = transform(st_prixMoyen2019_SP98,PrixValeur=as.numeric(prixmoyenDep19_SP98$PrixValeur))
class(st_prixMoyen2019_SP98$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_SP98, type = 'choro', var = "PrixValeur", 
       nbreaks=4, leg_val_rnd=3 )
mf_title("Prix moyen du SP98 par département en 2019",pos='center', bg='white', fg='black')

hist(prixmoyenDep19_SP98$PrixValeur, breaks=20, xlim=c(1.55,1.68), ylim = c(0,35),
     main="Moyenne du prix du SP98 dans les départements en 2019", 
     xlab="Prix moyen du SP98",ylab="Nb de départements")
abline(v=mean(prixmoyenDep19_SP98$PrixValeur), col='red')
text("Moyenne nationale", x = 1.60, y=35, srt = 0, pos =2,cex=0.8,col='red')


    ### SP95 ###

st_prixMoyen2019_SP95 = st_as_sf(prixmoyenDep19_SP95, sf_column_name  = "geometry")
st_prixMoyen2019_SP95 = transform(st_prixMoyen2019_SP95,PrixValeur=as.numeric(prixmoyenDep19_SP95$PrixValeur))
class(st_prixMoyen2019_SP95$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2019_SP95, type = 'choro', var = "PrixValeur",
       nbreaks = 4, leg_val_rnd=3)
mf_title("Prix moyen du SP95 par département en 2019",pos='center', bg='white', fg='black')


hist(prixmoyenDep19_SP95$PrixValeur, breaks=20, xlim=c(1.45,1.65), ylim = c(0,35),
     main="Moyenne du prix du SP95 dans les départements en 2019", 
     xlab="Prix moyen du SP95",ylab="Nb de départements", freq = T)
abline(v=mean(prixmoyenDep19_SP95$PrixValeur), col='red')
text("Moyenne nationale", x = 1.565, y=35, srt = 0, pos =2,cex=0.8,col='red')


######################### 2023 #########################


PrixMoyen2023$CodePostal = ifelse (nchar(PrixMoyen2023$CodePostal) == 4, paste0("0",PrixMoyen2023$CodePostal),PrixMoyen2023$CodePostal)



## jointure des départements et des régions avec le prix moyen ##

PrixMoyen2023$CODE_DEPT= str_sub(PrixMoyen2023$CodePostal, 1, 2)
#PrixMoyen2019 = transform(PrixMoyen2019,CodeDep=as.numeric(PrixMoyen2019$CodeDep))


## supprime le format liste de l'attribut natif depcode ##

dep_simples$CODE_DEPT <-  unlist(departement$CODE_DEPT)
#prixmoyenDep19 = inner_join(departement,PrixMoyen2019 )  
prixmoyenDep23 = inner_join(dep_simples,PrixMoyen2023 )  

#class(prixmoyenDep19)
#plot(prixmoyenDep19[,"PrixValeur"])


## Sélection selon le carburant ##
#class(prixmoyenDep19)
prixmoyenDep23_Gazole = prixmoyenDep23[prixmoyenDep23$PrixNom=='Gazole',]%>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep23_SP98 = prixmoyenDep23[prixmoyenDep23$PrixNom=='SP98',]%>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep23_SP95 = prixmoyenDep23[prixmoyenDep23$PrixNom=='SP95',]%>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
#prixmoyenDep23_E85 = prixmoyenDep23[prixmoyenDep23$PrixNom=='E85',]
#prixmoyenDep23_E10 = prixmoyenDep23[prixmoyenDep23$PrixNom=='E10',]
#prixmoyenDep23_GPLc = prixmoyenDep23[prixmoyenDep23$PrixNom=='GPLc',]
# E85 E10 SP98 SP95 GPLc 


### Affichage Par départements ###

### Gazole 2023###

st_prixMoyen2023_Gazole = st_as_sf(prixmoyenDep23_Gazole, sf_column_name  = "geometry")
st_prixMoyen2023_Gazole = transform(st_prixMoyen2023_Gazole,PrixValeur=as.numeric(prixmoyenDep23_Gazole$PrixValeur))
class(st_prixMoyen2023_Gazole$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_Gazole, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd=3, col_na='grey')
mf_title("Prix moyen du Gazole par département en 2023",pos='center', bg='white', fg='black')

hist(prixmoyenDep23_Gazole$PrixValeur, breaks=20, xlim=c(1.75,2.05), ylim=c(0,30),
     main="Moyenne du prix du gazole dans les départements en 2023", 
     xlab="Prix moyen du Gazole",ylab="Nb de départements")
abline(v=mean(prixmoyenDep23_Gazole$PrixValeur), col='red')
text("Moyenne nationale", x = 1.86, y=30, srt = 0, pos=1,cex=0.8,col='red')



### SP98 2023###

st_prixMoyen2023_SP98 = st_as_sf(prixmoyenDep23_SP98, sf_column_name  = "geometry")
st_prixMoyen2023_SP98 = transform(st_prixMoyen2023_SP98,PrixValeur=as.numeric(prixmoyenDep23_SP98$PrixValeur))
class(st_prixMoyen2023_SP98$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_SP98, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd = 3)
mf_title("Prix moyen du SP98 par département en 2023",pos='center', bg='white', fg='black')

hist(prixmoyenDep23_SP98$PrixValeur, breaks=20, xlim=c(1.90,2.15), ylim=c(0,30),
     main="Moyenne du prix du SP98 dans les départements en 2023", 
     xlab="Prix moyen du SP98",ylab="Nb de départements")
abline(v=mean(prixmoyenDep23_SP98$PrixValeur), col='red')
text("Moyenne nationale", x = 1.985, y=30, srt = 0, pos=1,cex=0.8,col='red')


### SP95 2023###

st_prixMoyen2023_SP95 = st_as_sf(prixmoyenDep23_SP95, sf_column_name  = "geometry")
st_prixMoyen2023_SP95 = transform(st_prixMoyen2023_SP95,PrixValeur=as.numeric(prixmoyenDep23_SP95$PrixValeur))
class(st_prixMoyen2023_SP95$PrixValeur)

#prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
#n_breaks pour changer la discrétisation 
mf_map(st_prixMoyen2023_SP95, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd=3)
mf_title("Prix moyen du SP95 par département en 2023",pos='center', bg='white', fg='black')

hist(prixmoyenDep23_SP95$PrixValeur, breaks=20, xlim=c(1.8,2.30), ylim=c(0,30),
     main="Moyenne du prix du SP95 dans les départements en 2023", 
     xlab="Prix moyen du SP95",ylab="Nb de départements")
abline(v=mean(prixmoyenDep23_SP95$PrixValeur), col='red')
text("Moyenne nationale", x = 1.96, y=30, srt = 0, pos=1,cex=0.8,col='red')













# 
# ### E85 2023###
# 
# st_prixMoyen2023_E85 = st_as_sf(prixmoyenDep23_E85, sf_column_name  = "geometry")
# st_prixMoyen2023_E85 = transform(st_prixMoyen2023_E85,PrixValeur=as.numeric(prixmoyenDep23_E85$PrixValeur))
# class(st_prixMoyen2023_E85$PrixValeur)
# #na.omit(st_prixMoyen2023_E85$PrixValeur)
# #prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
# #n_breaks pour changer la discrétisation 
# mf_map(st_prixMoyen2023_E85, type = 'choro', var = "PrixValeur", nbreaks = 5)
# mf_
# mf_title("Prix moyen du E85 par département en 2023",pos='center', bg='white', fg='black')
# 
# 
# ### E10 2023###
# 
# st_prixMoyen2023_E10 = st_as_sf(prixmoyenDep23_E10, sf_column_name  = "geometry")
# st_prixMoyen2023_E10 = transform(st_prixMoyen2023_E10,PrixValeur=as.numeric(prixmoyenDep23_E10$PrixValeur))
# class(st_prixMoyen2023_E10$PrixValeur)
# 
# #prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
# #n_breaks pour changer la discrétisation 
# mf_map(st_prixMoyen2023_E10, type = 'choro', var = "PrixValeur", nbreaks = 7)
# mf_title("Prix moyen du E10 par département en 2023",pos='center', bg='white', fg='black')
# 
# 
# 
# ### GPLc 2023###
# 
# st_prixMoyen2023_GPLc = st_as_sf(prixmoyenDep23_GPLc, sf_column_name  = "geometry")
# st_prixMoyen2023_GPLc = transform(st_prixMoyen2023_GPLc,PrixValeur=as.numeric(prixmoyenDep23_GPLc$PrixValeur))
# class(st_prixMoyen2023_GPLc$PrixValeur)
# 
# #prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
# #n_breaks pour changer la discrétisation 
# mf_map(st_prixMoyen2023_GPLc, type = 'choro', var = "PrixValeur", nbreaks = 5)
# mf_title("Prix moyen du GPLc par département en 2023",pos='center', bg='white', fg='black')
# 
# 
# 
# ### E85 2019###
# 
# st_prixMoyen2019_E85 = st_as_sf(prixmoyenDep19_E85, sf_column_name  = "geometry")
# st_prixMoyen2019_E85 = transform(st_prixMoyen2019_E85,PrixValeur=as.numeric(prixmoyenDep19_E85$PrixValeur))
# class(st_prixMoyen2019_E85$PrixValeur)
# 
# #prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
# #n_breaks pour changer la discrétisation 
# mf_map(st_prixMoyen2019_E85, type = 'choro', var = "PrixValeur", nbreaks = 7)
# mf_title("Prix moyen du E85 par département en 2019",pos='center', bg='white', fg='black')
# 
# 
# ### E10 2019###
# 
# st_prixMoyen2019_E10 = st_as_sf(prixmoyenDep19_E10, sf_column_name  = "geometry")
# st_prixMoyen2019_E10 = transform(st_prixMoyen2019_E10,PrixValeur=as.numeric(prixmoyenDep19_E10$PrixValeur))
# class(st_prixMoyen2019_E10$PrixValeur)
# 
# #prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
# #n_breaks pour changer la discrétisation 
# mf_map(st_prixMoyen2019_E10, type = 'choro', var = "PrixValeur", nbreaks = 7)
# mf_title("Prix moyen du E10 par département en 2019",pos='center', bg='white', fg='black')
# 
# 
# 
# ### GPLc 2019###
# 
# st_prixMoyen2019_GPLc = st_as_sf(prixmoyenDep19_GPLc, sf_column_name  = "geometry")
# st_prixMoyen2019_GPLc = transform(st_prixMoyen2019_GPLc,PrixValeur=as.numeric(prixmoyenDep19_GPLc$PrixValeur))
# class(st_prixMoyen2019_GPLc$PrixValeur)
# 
# #prop_choro dans style lorsqu'il y a deux variabke a montré cercle + couleurs
# #n_breaks pour changer la discrétisation 
# mf_map(st_prixMoyen2019_GPLc, type = 'choro', var = "PrixValeur", nbreaks = 4)
# mf_title("Prix moyen du GPLc par département en 2019",pos='center', bg='white', fg='black')
