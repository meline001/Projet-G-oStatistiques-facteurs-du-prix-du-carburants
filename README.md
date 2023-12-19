# Projet-GeoStatistiques-facteurs-du-prix-du-carburants
Projet de géostatistique présentant les facteurs géographiques et socio-économiques qui influent sur le prix du carburant d’une station à une autre en France métropolitaine en 2019 et en 2023.    
Projet réalisé dans le cadre d'études GéoDataScience par I. BOUIBDALLAOUI, T. DARDANT, M. REUCHE  

La plupart des codes sont fait en R. Vous devez donc avoir installés un logiciel qui lit du R auparavant pour pouvoir utilsés nos codes.  

## Données
*Carburant : _insérer lien données/Répertoire_  
*Population par iris : _insérer lien données/Répertoire_  
*Revenus par iris : _insérer lien données/Répertoire_  
*Magasins : _insérer lien données/Répertoire_  
*Routes : _insérer lien données/Répertoire_  
*Départements : _insérer lien données/Répertoire_  
*Iris : _insérer lien données/Répertoire_  

## Utilisation 
Tout d'abord récupérer les données du carburant puis utiliser le code _nom code_ qui va permettre de transformer ces données dan sla bonne projection et les joindres au iris afin que nous puissions les utiliser par la suite.  
_Explication du code_  
Récupérer ensuite le reste des données.  

### Prix Moyen du carburant en France
Pour afficher le prix moyen du carburant par département, il vous faut les données du **carburant** de 2019 et/ou 2023 ainsi que les données des **départements**.  
Récupérez le code **PrixMoyenCarburantFrance.R**. Rentrez le chemin vers vos fichiers dans le code et lancez le. Ce code travaille sur le gazole, le SP98 et le SP95. Il vous affichera la moyenne des prix pour chaque carburant dans chaque département de France. Il vous affichera aussi un histogramme qui repressentera des classes des prix moyen pour chaque carburant et le nombre de départements qui se trouve dans cette tranche de prix. Cela permettra de mettre en avant le prix moyen le plus répandu en France. Enfin vous pourrez observé le prix moyen national de chaque carburant.   
  
