# Installer et charger les packages nécessaires
install.packages("factoextra")  
install.packages("readr")       
install.packages("dplyr")       
install.packages("ggplot2")     
install.packages("sf")

library(readr)
library(dplyr)
library(factoextra)
library(ggplot2)
library(sf)

# Charger les données depuis le fichier CSV
#2019
data_pop <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_pop_2019_med19.csv")
#data_rev <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_revenu_2019_med19.csv")
#2023
data_pop <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_pop_2023_med23.csv")
data_rev <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_revenu_2023_med23.csv")

data_dist <- st_read("Donnee_Spatial/stations_avec_dist_auto_FM_2154.gpkg")
data_shop <- st_read("Donnee_Spatial/stations_avec_dist_auto_shop_FM.gpkg")

##################### ACP GAZOLE #####################

gazole_data_pop <- data_pop[data_pop$PrixNom == "Gazole", ]
gazole_data_rev <- data_rev[data_rev$PrixNom == "Gazole", ]
gazole_data_dist <- data_dist[data_dist$PrixNom == "Gazole", ]
gazole_data_shop <- data_shop[data_shop$PrixNom == "Gazole", ]
#gazole_data_rev$DISP_MED19 <- as.numeric(gazole_data_rev$DISP_MED19)
gazole_data_rev$DISP_MED20 <- as.numeric(gazole_data_rev$DISP_MED20)
gazole_data_rev <- na.omit(gazole_data_rev)

merged_df <- inner_join(gazole_data_pop, gazole_data_rev, by = "ID")
merged_df <- inner_join(merged_df, gazole_data_dist, by = "ID")
merged_df <- inner_join(merged_df, gazole_data_shop, by = "ID")

###
#write.csv(merged_df, "Data_All/Gazole_Data_2019.csv", row.names = TRUE)
write.csv(merged_df, "Data_All/Gazole_Data_2023.csv", row.names = TRUE)
###

# filtre distance
#merged_df <- merged_df[merged_df$dist_autoroute.y <= 500, ]
merged_df <- merged_df[merged_df$dist_autoroute.y >= 30000, ]

# Sélectionner les colonnes d'intérêt
#colonnes_interet <- c("PrixValeur.x","dist_autoroute.y","nb_shop_point", "P19_POP","DISP_MED19")
colonnes_interet <- c("PrixValeur.x","dist_autoroute.y","nb_shop_point", "P19_POP","DISP_MED20")
data_acp <- merged_df[, colonnes_interet]

# Standardiser les données (centrer et réduire)
data_acp_standardise <- scale(data_acp)

# Réaliser l'ACP
acp_resultat <- prcomp(data_acp_standardise, scale. = TRUE)

# Afficher un résumé des résultats de l'ACP
summary(acp_resultat)

# Diagramme des valeurs propres
fviz_eig(acp_resultat, addlabels = TRUE)

# Visualisation des individus et des variables dans le premier plan principal
fviz_pca_ind(acp_resultat, col.ind = "cos2", pointsize = 1, repel = F, geom.ind = "point")
fviz_pca_var(acp_resultat, col.var = "contrib", pointsize = 2, repel = TRUE)

######################################################

##################### ACP SP98 #####################

SP98_data_pop <- data_pop[data_pop$PrixNom == "SP98", ]
SP98_data_rev <- data_rev[data_rev$PrixNom == "SP98", ]
SP98_data_dist <- data_dist[data_dist$PrixNom == "SP98", ]
SP98_data_shop <- data_shop[data_shop$PrixNom == "SP98", ]

#SP98_data_rev$DISP_MED19 <- as.numeric(SP98_data_rev$DISP_MED19)
SP98_data_rev$DISP_MED20 <- as.numeric(SP98_data_rev$DISP_MED20)
SP98_data_rev <- na.omit(SP98_data_rev)

merged_df <- inner_join(SP98_data_pop, SP98_data_rev, by = "ID")
merged_df <- inner_join(merged_df, SP98_data_dist, by = "ID")
merged_df <- inner_join(merged_df, SP98_data_shop, by = "ID")

###
#write.csv(merged_df, "Data_All/SP98_Data_2019.csv", row.names = TRUE)
write.csv(merged_df, "Data_All/SP98_Data_2023.csv", row.names = TRUE)
###

# filtre distance
#merged_df <- merged_df[merged_df$dist_autoroute.y <= 500, ]
merged_df <- merged_df[merged_df$dist_autoroute.y >= 30000, ]

# Sélectionner les colonnes d'intérêt
#colonnes_interet <- c("PrixValeur.x", "P19_POP","DISP_MED19","dist_autoroute.y","nb_shop_point")
colonnes_interet <- c("PrixValeur.x", "P19_POP","DISP_MED20","dist_autoroute.y","nb_shop_point")
data_acp <- merged_df[, colonnes_interet]

# Standardiser les données (centrer et réduire)
data_acp_standardise <- scale(data_acp)

# Réaliser l'ACP
acp_resultat <- prcomp(data_acp_standardise, scale. = TRUE)

# Afficher un résumé des résultats de l'ACP
summary(acp_resultat)

# Diagramme des valeurs propres
fviz_eig(acp_resultat, addlabels = TRUE)

# Visualisation des individus et des variables dans le premier plan principal
fviz_pca_ind(acp_resultat, col.ind = "cos2", pointsize = 1, repel = F, geom.ind = "point")
fviz_pca_var(acp_resultat, col.var = "contrib", pointsize = 2, repel = TRUE)

######################################################

##################### ACP SP95 #####################

SP95_data_pop <- data_pop[data_pop$PrixNom == "SP95", ]
SP95_data_rev <- data_rev[data_rev$PrixNom == "SP95", ]
SP95_data_dist <- data_dist[data_dist$PrixNom == "SP95", ]
SP95_data_shop <- data_shop[data_shop$PrixNom == "SP95", ]

#SP95_data_rev$DISP_MED19 <- as.numeric(SP95_data_rev$DISP_MED19)
SP95_data_rev$DISP_MED20 <- as.numeric(SP95_data_rev$DISP_MED20)
SP95_data_rev <- na.omit(SP95_data_rev)

merged_df <- inner_join(SP95_data_pop, SP95_data_rev, by = "ID")
merged_df <- inner_join(merged_df, SP95_data_dist, by = "ID")
merged_df <- inner_join(merged_df, SP95_data_shop, by = "ID")

###
#write.csv(merged_df, "Data_All/SP95_Data_2019.csv", row.names = TRUE)
write.csv(merged_df, "Data_All/SP95_Data_2023.csv", row.names = TRUE)
###

# filtre distance
#merged_df <- merged_df[merged_df$dist_autoroute.y <= 500, ]
merged_df <- merged_df[merged_df$dist_autoroute.y >= 30000, ]

# Sélectionner les colonnes d'intérêt
#colonnes_interet <- c("PrixValeur.x", "P19_POP","DISP_MED19","dist_autoroute.y","nb_shop_point")
colonnes_interet <- c("PrixValeur.x", "P19_POP","DISP_MED20","dist_autoroute.y","nb_shop_point")
data_acp <- merged_df[, colonnes_interet]

# Standardiser les données (centrer et réduire)
data_acp_standardise <- scale(data_acp)

# Réaliser l'ACP
acp_resultat <- prcomp(data_acp_standardise, scale. = TRUE)

# Afficher un résumé des résultats de l'ACP
summary(acp_resultat)

# Diagramme des valeurs propres
fviz_eig(acp_resultat, addlabels = TRUE)

# Visualisation des individus et des variables dans le premier plan principal
fviz_pca_ind(acp_resultat, col.ind = "cos2", pointsize = 1, repel = F, geom.ind = "point")
fviz_pca_var(acp_resultat, col.var = "contrib", pointsize = 2, repel = TRUE)

######################################################
