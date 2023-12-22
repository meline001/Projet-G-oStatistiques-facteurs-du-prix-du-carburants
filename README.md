# Projet-GeoStatistiques-facteurs-du-prix-du-carburants
Projet de géostatistique présentant les facteurs géographiques et socio-économiques qui influent sur le prix du carburant d’une station à une autre en France métropolitaine en 2019 et en 2023.    
Projet réalisé dans le cadre d'études GéoDataScience par I. BOUABDALLAOUI, T. DARDANT, M. REUCHE  

La plupart des codes sont fait en R. Vous devez donc avoir installés un logiciel qui lit du R auparavant pour pouvoir utilsés nos codes.  

### Description des modules
Les différents modules sont rangés dans des dossiers séparés :  
* **1_Preparation_Donnees_Carburant** correspond au gros traitement de préparation des données XML du carburant pour pouvoir les exploiter dans nos analyses.   
* **2_Analyses_data** correspond aux analyses portant sur la population et le revenu disponible en fonction des iris par rapport au prix des carburants.  
* **3_GWR_Analyse** correspond aux traitements pour extraire les informations de distance et de nombre de shop des stations ainsi que le code permettant l'analyse gwr.  
* **4_Cartographie** est une analyse spatiale du prix moyen des carburants en France.

## Données
* Carburant : _https://www.prix-carburants.gouv.fr/rubrique/opendata/_.  
* Population par iris 2019 : _https://www.insee.fr/fr/statistiques/6543200#consulter_.  
* Revenus par iris 2019: _https://www.insee.fr/fr/statistiques/6049648_.  
* Revenus par iris 2020: _https://www.insee.fr/fr/statistiques/7233950_.  
* Magasins : _https://www.data.gouv.fr/fr/datasets/localisations-des-magasins-dans-openstreetmap/_.  
* Routes : _https://geoservices.ign.fr/route500_.  
* Départements : _https://wxs.ign.fr/oikr5jryiph0iwhw36053ptm/telechargement/inspire/GEOFLA_THEME-DEPARTEMENTS_2016-01-01$GEOFLA_2-2_DEPARTEMENT_SHP_LAMB93_FXX_2016-06-28/file/GEOFLA_2-2_DEPARTEMENT_SHP_LAMB93_FXX_2016-06-28.7z_.  
* Iris : _https://public.opendatasoft.com/explore/embed/dataset/georef-france-iris/table/?flg=fr-fr&disjunctive.reg_name&disjunctive.dep_name&disjunctive.arrdep_name&disjunctive.ze2020_name&disjunctive.bv2022_name&disjunctive.epci_name&disjunctive.ept_name&disjunctive.com_name&disjunctive.com_arm_name&disjunctive.iris_name&sort=year&refine.reg_name=Auvergne-Rh%C3%B4ne-Alpes&refine.reg_name=Bourgogne-Franche-Comt%C3%A9&refine.reg_name=Bretagne&refine.reg_name=Centre-Val%20de%20Loire&refine.reg_name=Grand%20Est&refine.reg_name=Hauts-de-France&refine.reg_name=%C3%8Ele-de-France&refine.reg_name=Normandie&refine.reg_name=Nouvelle-Aquitaine&refine.reg_name=Occitanie&refine.reg_name=Pays%20de%20la%20Loire&refine.reg_name=Provence-Alpes-C%C3%B4te%20d'Azur_.  

## Utilisation 

### Convertion XML vers CSV
Télécharger les données du carburant en suivant le lien ci dessus et ajouter les fichiers dans le dossier **XML** de **Donnee_Brute** et utilisé le fichier **Convert_XML_to_CSV.py**.

### Mise en forme 
Reprendre les données obtenues après convertion xml vers csv et utilisé le fichier **Mise_En_Forme_Data.py**.

### Intersect pdv iris
Reprendre les données obtenues après Mise en forme et téléchargée les données manquantes en suivant les liens ci dessus et utilisé le fichier **Intersect_Pdv_Iris.py**.

### Comparaison de la population et du prix du carburant
Tout d'abord récupérez les donnéede Data_All et Donnee_Spatial dans le repertoire 2_Analyse_data , faire tourner le fichier **Analyse_Univar_Pop19.R**.  

### Comparaison du revenu median disponible et du prix du carburant
Tout d'abord récupérez les donnéede Data_All et Donnee_Spatial dans le repertoire 2_Analyse_data , faire tourner le fichier **Analyse_Univar_Revenues.R** .


### Comparaison du prix du carburant et de la distance routière 
Tout d'abord récupérez les donnée sur les **routes**, le **carburant**.  


### Comparaison du prix du carburant et la distance de la station-service à un magasin 
Tout d'abord récupérez les donnée sur les **magasins**, le **carburant**.   

### ACP
Tout d'abord récupérez les donnée de Data_All et Donnee_Spatial dans le repertoire 2_Analyse_data  , faire tourner le fichier **ACP_POP_REVENU.R**.  

### Prix Moyen du carburant en France
Pour afficher le prix moyen du carburant par département, il vous faut les données du **carburant** de 2019 et/ou 2023 ainsi que les données des **départements**.  
Récupérez le code **PrixMoyenCarburantFrance.R**. Rentrez le chemin vers vos fichiers dans le code et lancez le. Ce code travaille sur le gazole, le SP98 et le SP95. Il vous affichera la moyenne des prix pour chaque carburant dans chaque département de France. Il vous affichera aussi un histogramme qui repressentera des classes des prix moyen pour chaque carburant et le nombre de départements qui se trouve dans cette tranche de prix. Cela permettra de mettre en avant le prix moyen le plus répandu en France. Enfin vous pourrez observé le prix moyen national de chaque carburant.   




