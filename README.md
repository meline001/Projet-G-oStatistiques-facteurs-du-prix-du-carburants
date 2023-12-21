# Projet-GeoStatistiques-facteurs-du-prix-du-carburants
Projet de géostatistique présentant les facteurs géographiques et socio-économiques qui influent sur le prix du carburant d’une station à une autre en France métropolitaine en 2019 et en 2023.    
Projet réalisé dans le cadre d'études GéoDataScience par I. BOUABDALLAOUI, T. DARDANT, M. REUCHE  

La plupart des codes sont fait en R. Vous devez donc avoir installés un logiciel qui lit du R auparavant pour pouvoir utilsés nos codes.  

### Description des modules
Les différents modules sont rangés dans des dossiers séparés :
*1_Preparation_Donnees_Carburant correspond au gros traitement de préparation des données XML du carburant pour pouvoir les exploiter dans nos analyses. 
*2_Analyses_data correspond aux analyses portant sur la population et le revenu disponible en fonction des iris par rapport au prix des carburants.
*3_GWR_Analyse correspond aux traitements pour extraire les informations de distance et de nombre de shop des stations ainsi que le code permettant l'analyse gwr
*4_Cartographie est une analyse spatiale du prix moyen des carburants en France.

## Données
*Carburant : _https://www.prix-carburants.gouv.fr/rubrique/opendata/_.
*Population par iris 2019 : _https://www.insee.fr/fr/statistiques/6543200#consulter_.
*Revenus par iris 2019: _https://www.insee.fr/fr/statistiques/6049648_.
*Revenus par iris 2020: _https://www.insee.fr/fr/statistiques/7233950_.
*Magasins : _insérer lien données/Répertoire_.
*Routes : _insérer lien données/Répertoire_.
*Départements : _insérer lien données/Répertoire_.
*Iris : _insérer lien données/Répertoire_.

## Utilisation 
Tout d'abord récupérer les données du carburant puis utiliser le code _nom code_ qui va permettre de transformer ces données dans la bonne projection et les joindres au iris afin que nous puissions les utiliser par la suite.  
_Explication du code_  
Récupérer ensuite le reste des données.  

### Prix Moyen du carburant en France
Pour afficher le prix moyen du carburant par département, il vous faut les données du **carburant** de 2019 et/ou 2023 ainsi que les données des **départements**.  
Récupérez le code **PrixMoyenCarburantFrance.R**. Rentrez le chemin vers vos fichiers dans le code et lancez le. Ce code travaille sur le gazole, le SP98 et le SP95. Il vous affichera la moyenne des prix pour chaque carburant dans chaque département de France. Il vous affichera aussi un histogramme qui repressentera des classes des prix moyen pour chaque carburant et le nombre de départements qui se trouve dans cette tranche de prix. Cela permettra de mettre en avant le prix moyen le plus répandu en France. Enfin vous pourrez observé le prix moyen national de chaque carburant.   

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
Tout d'abord récupérez les donnée sur les **routes**, le **carburant** et le fichier **nomfichier.R**.  


### Comparaison du prix du carburant et la distance de la station-service à un magasin 
Tout d'abord récupérez les donnée sur les **magasins**, le **carburant** et le fichier **nomfichier.R**.  

### ACP
Tout d'abord récupérez les donnée de Data_All et Donnee_Spatial dans le repertoire 2_Analyse_data  , faire tourner le fichier **ACP_POP_REVENU.R**.  





