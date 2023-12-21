                      ## Prix moyen du Carburant en France ##

#Auteur : Méline REUCHE
#Date : 19/12/23
#   Ce code à pour objectif de calculer le prix moyen du gazole, du SP98 et du SP95 
#   pour chaque département de France métropolitaine en 2019 et en 2023. 
#   Ce code montrera aussi le nombre de départements avec le même 
#   prix moyen pour chaque carburant ainsi que la moyenne nationale. 

#######################################################################################################################

#librarie 
library(stringr)
library(dplyr)
library(mapsf)
library(sf)
library(sqldf)

  ## Ouverture de fichiers ##

PrixMoyen2019 = read.csv("data/Carburant_PrixMoy_2019.csv", sep=",")
PrixMoyen2023 = read.csv("data/Carburant_PrixMoy_2023.csv", sep=",")
departement = st_read("data/DEPARTEMENT.shp")

## Simplification du tracé des départements pour que le temps de chargement soit moins long 

dep_simples <- st_simplify(departement,preserveTopology = T, 1000)

# afficher la carte de France avec les départements
#plot(dep_simples$geometry)


            ######################### 2019 #########################

  ## Ajout du 0 dans le code postal pour les 9 premier départements ##

PrixMoyen2019$CodePostal = ifelse (nchar(PrixMoyen2019$CodePostal) == 4, paste0("0",PrixMoyen2019$CodePostal),PrixMoyen2019$CodePostal)
PrixMoyen2019$CODE_DEPT = str_sub(PrixMoyen2019$CodePostal, 1, 2)


  ## supprime le format liste de l'attribut natif CODE_DEPT ##

dep_simples$CODE_DEPT <-  unlist(departement$CODE_DEPT)

  ## Jointure entre les départements et les prix des carburants ##

prixmoyenDep19 = inner_join(dep_simples,PrixMoyen2019 )  


  ## Sélection selon le carburant et moyenne des prix par départements ##

prixmoyenDep19_Gazole = prixmoyenDep19[prixmoyenDep19$PrixNom=='Gazole',] %>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep19_SP98 = prixmoyenDep19[prixmoyenDep19$PrixNom=='SP98',] %>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep19_SP95 = prixmoyenDep19[prixmoyenDep19$PrixNom=='SP95',] %>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))



                        #### Affichage Par départements ####

    ### Gazole 2019 ###

st_prixMoyen2019_Gazole = st_as_sf(prixmoyenDep19_Gazole, sf_column_name  = "geometry")
st_prixMoyen2019_Gazole = transform(st_prixMoyen2019_Gazole,PrixValeur=as.numeric(prixmoyenDep19_Gazole$PrixValeur))

#Affichage de la carte et sa légende 

mf_map(st_prixMoyen2019_Gazole, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd=3)
mf_title("Prix moyen du Gazole par département en 2019",pos='center', bg='white', fg='black')

#Affichage de l'histogramme 

hist(prixmoyenDep19_Gazole$PrixValeur, breaks=20, xlim=c(1.4,1.65),
     main="Nombre de départements selon le prix moyen du gazole en 2019", 
     xlab="Prix moyen du gazole",ylab="Nb de départements")
abline(v=mean(prixmoyenDep19_Gazole$PrixValeur), col='red')
text("Moyenne nationale", x = 1.51, y=30, srt = 0, pos =2,cex=0.8,col='red')



    ### SP98 2019 ###

st_prixMoyen2019_SP98 = st_as_sf(prixmoyenDep19_SP98, sf_column_name  = "geometry")
st_prixMoyen2019_SP98 = transform(st_prixMoyen2019_SP98,PrixValeur=as.numeric(prixmoyenDep19_SP98$PrixValeur))
class(st_prixMoyen2019_SP98$PrixValeur)

#Affichage de la carte et sa légende 

mf_map(st_prixMoyen2019_SP98, type = 'choro', var = "PrixValeur", 
       nbreaks=4, leg_val_rnd=3 )
mf_title("Prix moyen du SP98 par département en 2019",pos='center', bg='white', fg='black')

#Affichage de l'histogramme

hist(prixmoyenDep19_SP98$PrixValeur, breaks=20, xlim=c(1.55,1.68), ylim = c(0,35),
     main="Nombre de départements selon le prix moyen du SP98 en 2019", 
     xlab="Prix moyen du SP98",ylab="Nb de départements")
abline(v=mean(prixmoyenDep19_SP98$PrixValeur), col='red')
text("Moyenne nationale", x = 1.60, y=35, srt = 0, pos =2,cex=0.8,col='red')


    ### SP95 2019 ###

st_prixMoyen2019_SP95 = st_as_sf(prixmoyenDep19_SP95, sf_column_name  = "geometry")
st_prixMoyen2019_SP95 = transform(st_prixMoyen2019_SP95,PrixValeur=as.numeric(prixmoyenDep19_SP95$PrixValeur))
class(st_prixMoyen2019_SP95$PrixValeur)

#Affichage de la carte et sa légende

mf_map(st_prixMoyen2019_SP95, type = 'choro', var = "PrixValeur",
       nbreaks = 4, leg_val_rnd=3)
mf_title("Prix moyen du SP95 par département en 2019",pos='center', bg='white', fg='black')

#Affichage de l'histogramme

hist(prixmoyenDep19_SP95$PrixValeur, breaks=20, xlim=c(1.45,1.65), ylim = c(0,35),
     main="Nombre de département selon le prix moyen du SP95 en 2019", 
     xlab="Prix moyen du SP95",ylab="Nb de départements", freq = T)
abline(v=mean(prixmoyenDep19_SP95$PrixValeur), col='red')
text("Moyenne nationale", x = 1.565, y=35, srt = 0, pos =2,cex=0.8,col='red')


          ######################### 2023 #########################

  ## Ajout du 0 dans le code postal pour les 9 premier départements ##
PrixMoyen2023$CodePostal = ifelse (nchar(PrixMoyen2023$CodePostal) == 4, paste0("0",PrixMoyen2023$CodePostal),PrixMoyen2023$CodePostal)
PrixMoyen2023$CODE_DEPT= str_sub(PrixMoyen2023$CodePostal, 1, 2)

  ## supprime le format liste de l'attribut natif depcode ##

dep_simples$CODE_DEPT <-  unlist(departement$CODE_DEPT)

  ## Jointure entre les départements et le prix du carburant ##
prixmoyenDep23 = inner_join(dep_simples,PrixMoyen2023 )  


  ## Sélection selon le carburant et calcul du prix moyen selon le département et le type de carburant ##

prixmoyenDep23_Gazole = prixmoyenDep23[prixmoyenDep23$PrixNom=='Gazole',]%>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep23_SP98 = prixmoyenDep23[prixmoyenDep23$PrixNom=='SP98',]%>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))
prixmoyenDep23_SP95 = prixmoyenDep23[prixmoyenDep23$PrixNom=='SP95',]%>% group_by(NOM_DEPT) %>% summarize(PrixValeur = mean(PrixValeur))



                          ### Affichage Par départements ###

    ### Gazole 2023 ###

st_prixMoyen2023_Gazole = st_as_sf(prixmoyenDep23_Gazole, sf_column_name  = "geometry")
st_prixMoyen2023_Gazole = transform(st_prixMoyen2023_Gazole,PrixValeur=as.numeric(prixmoyenDep23_Gazole$PrixValeur))
class(st_prixMoyen2023_Gazole$PrixValeur)

#Affichage de la carte et sa légende

mf_map(st_prixMoyen2023_Gazole, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd=3, col_na='grey')
mf_title("Prix moyen du Gazole par département en 2023",pos='center', bg='white', fg='black')

#Affichage de l'histogramme

hist(prixmoyenDep23_Gazole$PrixValeur, breaks=20, xlim=c(1.75,2.05), ylim=c(0,30),
     main="Nombre de département selon le prix moyen du gazole en 2023", 
     xlab="Prix moyen du Gazole",ylab="Nb de départements")
abline(v=mean(prixmoyenDep23_Gazole$PrixValeur), col='red')
text("Moyenne nationale", x = 1.86, y=30, srt = 0, pos=1,cex=0.8,col='red')



    ### SP98 2023 ###

st_prixMoyen2023_SP98 = st_as_sf(prixmoyenDep23_SP98, sf_column_name  = "geometry")
st_prixMoyen2023_SP98 = transform(st_prixMoyen2023_SP98,PrixValeur=as.numeric(prixmoyenDep23_SP98$PrixValeur))
class(st_prixMoyen2023_SP98$PrixValeur)

# Affichage de la carte et sa légende

mf_map(st_prixMoyen2023_SP98, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd = 3)
mf_title("Prix moyen du SP98 par département en 2023",pos='center', bg='white', fg='black')

#Affichage de l'histogramme

hist(prixmoyenDep23_SP98$PrixValeur, breaks=20, xlim=c(1.90,2.15), ylim=c(0,30),
     main="Nombre de département selon le prix moyen du SP98 en 2023", 
     xlab="Prix moyen du SP98",ylab="Nb de départements")
abline(v=mean(prixmoyenDep23_SP98$PrixValeur), col='red')
text("Moyenne nationale", x = 1.985, y=30, srt = 0, pos=1,cex=0.8,col='red')


    ### SP95 2023###

st_prixMoyen2023_SP95 = st_as_sf(prixmoyenDep23_SP95, sf_column_name  = "geometry")
st_prixMoyen2023_SP95 = transform(st_prixMoyen2023_SP95,PrixValeur=as.numeric(prixmoyenDep23_SP95$PrixValeur))
class(st_prixMoyen2023_SP95$PrixValeur)

#Affichage de la crate et sa légende

mf_map(st_prixMoyen2023_SP95, type = 'choro', var = "PrixValeur", 
       nbreaks = 4, leg_val_rnd=3)
mf_title("Prix moyen du SP95 par département en 2023",pos='center', bg='white', fg='black')

#Affichage de l'histogramme

hist(prixmoyenDep23_SP95$PrixValeur, breaks=20, xlim=c(1.8,2.30), ylim=c(0,40),
     main="Nombre de département selon le prix moyen du SP95 en 2023", 
     xlab="Prix moyen du SP95",ylab="Nb de départements")
abline(v=mean(prixmoyenDep23_SP95$PrixValeur), col='red')
text("Moyenne nationale", x = 1.96, y=35, srt = 0, pos=1,cex=0.8,col='red')
