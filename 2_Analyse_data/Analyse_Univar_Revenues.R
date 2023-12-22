# Installer le package readr
#install.packages("readr")

# Charger le package readr
library(readr)

# Lire le fichier CSV avec readr
#data_revenu <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_revenu_2019_med19.csv")
#data_revenu <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_revenu_2023_med23.csv")

# Afficher les premières lignes du dataframe
#head(data_revenu)

##### Analyse Univarier Revenues Gazole #####
### cas globale
# Sélectionner les lignes ou la colonne 'PrixNom' est égale à 'Gazole'
#gazole_data <- data_revenu[data_revenu$PrixNom == "Gazole", ]
#gazole_data <- data_revenu[data_revenu$PrixValeur >= 1.2, ]
# Afficher les donnees filtres
#print(gazole_data)

#gazole_data$DISP_MED20 <- as.integer(gazole_data$DISP_MED20)
#head(gazole_data)
#gazole_data <- na.omit(gazole_data)

###########################################################
### cas particulier
gazole_data <- read_csv("Data_All/Gazole_Data_2019.csv")
#gazole_data <- read_csv("Data_All/Gazole_Data_2023.csv")

gazole_data <- gazole_data %>%
  mutate(classe = case_when(
    dist_autoroute.x < 500 ~ 1,
    dist_autoroute.x > 500 & dist_autoroute.x < 30000 ~ 2,
    dist_autoroute.x > 30000 ~ 3,
    TRUE ~ NA_integer_  # Gestion par défaut si aucune condition n'est satisfaite
  ))

# filtre
gazole_data <- gazole_data[gazole_data$dist_autoroute.x <= 500, ]
gazole_data <- gazole_data[gazole_data$dist_autoroute.x >= 30000, ]
###########################################################

# Resume statistique pour la colonne "DISP_MED19" ou "DISP_MED20"
summary(gazole_data$DISP_MED19)
#summary(gazole_data$DISP_MED20)
# Resume statistique pour la colonne "Prix"
summary(gazole_data$PrixValeur.x)

# Moyenne pour la colonne "DISP_MED20"
mean_DISP_MED20 <- mean(gazole_data$DISP_MED19)
#mean_DISP_MED20 <- mean(gazole_data$DISP_MED20)
# Mediane pour la colonne "DISP_MED20"
median_DISP_MED20 <- median(gazole_data$DISP_MED19)
#median_DISP_MED20 <- median(gazole_data$DISP_MED20)
# ecart-type pour la colonne "DISP_MED20"
sd_DISP_MED20 <- sd(gazole_data$DISP_MED19)
#sd_DISP_MED20 <- sd(gazole_data$DISP_MED20)
# Afficher les resultats
cat("Moyenne DISP_MED:", mean_DISP_MED20, "\n")
c#at("Mediane DISP_MED:", median_DISP_MED20, "\n")
cat("ecart-type DISP_MED:", sd_DISP_MED20, "\n")

# Histogramme pour la colonne "DISP_MED20"
hist(gazole_data$DISP_MED19, main = "Distribution de DISP_MED19", xlab = "DISP_MED19")
#hist(gazole_data$DISP_MED20, main = "Distribution de DISP_MED20", xlab = "DISP_MED20")

# Moyenne pour la colonne "PrixValeur"
mean_PrixValeur <- mean(gazole_data$PrixValeur.x)
# Mediane pour la colonne "PrixValeur"
median_PrixValeur <- median(gazole_data$PrixValeur.x)
# ecart-type pour la colonne "PrixValeur"
sd_PrixValeur <- sd(gazole_data$PrixValeur.x)
# Afficher les resultats
cat("Moyenne PrixValeur:", mean_PrixValeur, "\n")
cat("Mediane PrixValeur:", median_PrixValeur, "\n")
cat("ecart-type PrixValeur:", sd_PrixValeur, "\n")

# Histogramme pour la colonne "PrixValeur"
hist(gazole_data$PrixValeur.x, main = "Distribution de PrixValeur", xlab = "PrixValeur")

# Boite a moustaches pour la colonne "DISP_MED20"
boxplot(gazole_data$DISP_MED19, main = "Boite a moustaches de DISP_MED19")
#boxplot(gazole_data$DISP_MED20, main = "Boite a moustaches de DISP_MED20")
# Boite a moustaches pour la colonne "PrixValeur"
boxplot(gazole_data$PrixValeur.x, main = "Boite a moustaches de PrixValeur")
######################################

##### Analyse Bivarier Revenues Gazole #####

# Creer un graphique de dispersion entre DISP_MED19 et PrixValeur
plot(gazole_data$PrixValeur.x, gazole_data$DISP_MED19,main = "Graphique de dispersion entre DISP_MED19 et PrixValeur",xlab = "PrixValeur", ylab = "DISP_MED20", pch = 16)

# Creer un graphique de dispersion entre DISP_MED20 et PrixValeur
#plot(gazole_data$PrixValeur.x, gazole_data$DISP_MED20, 
     main = "Graphique de dispersion entre DISP_MED20 et PrixValeur",
     xlab = "PrixValeur", ylab = "DISP_MED20", pch = 16)

# Calculer la correlation entre DISP_MED20 et PrixValeur
correlation <- cor(gazole_data$PrixValeur.x, gazole_data$DISP_MED19)
#correlation <- cor(gazole_data$PrixValeur.x, gazole_data$DISP_MED20)
# Calculer la pvalue et l'intervale de confiance de la correlation entre DISP_MED20 et PrixValeur
cor.test(gazole_data$PrixValeur.x, gazole_data$DISP_MED19)
#cor.test(gazole_data$PrixValeur.x, gazole_data$DISP_MED20)
# Afficher la correlation
cat("Correlation entre DISP_MED et PrixValeur:", correlation, "\n")

# Ajouter une ligne de regression lineaire
lm_model <- lm(DISP_MED19 ~ PrixValeur.x, data = gazole_data)
#lm_model <- lm(DISP_MED20 ~ PrixValeur.x, data = gazole_data)
abline(lm_model, col = "red")
######################################


##### Analyse Univarier Population SP98 #####
### cas globale
# Selectionner les lignes ou la colonne 'PrixNom' est egale a 'SP98'
#SP98_data <- data_revenu[data_revenu$PrixNom == "SP98", ]
# Afficher les donnees filtrees
#SP98_data$DISP_MED20 <- as.integer(SP98_data$DISP_MED20)
#SP98_data <- na.omit(SP98_data)
#head(SP98_data)

###########################################################
### cas particulier
SP98_data <- read_csv("Data_All/SP98_Data_2019.csv")
#SP98_data <- read_csv("Data_All/SP98_Data_2023.csv")

SP98_data <- SP98_data %>%
  mutate(classe = case_when(
    dist_autoroute.x < 500 ~ 1,
    dist_autoroute.x > 500 & dist_autoroute.x < 30000 ~ 2,
    dist_autoroute.x > 30000 ~ 3,
    TRUE ~ NA_integer_  # Gestion par défaut si aucune condition n'est satisfaite
  ))

# filtre
SP98_data <- SP98_data[SP98_data$dist_autoroute.x <= 500, ]
SP98_data <- SP98_data[SP98_data$dist_autoroute.x >= 30000, ]
###########################################################


# Resumer statistique pour la colonne "DISP_MED20"
summary(SP98_data$DISP_MED19)
#summary(SP98_data$DISP_MED20)
# Resumer statistique pour la colonne "Prix"
summary(SP98_data$PrixValeur.x)

# Moyenne pour la colonne "DISP_MED20"
mean_DISP_MED20_SP98 <- mean(SP98_data$DISP_MED19)
#mean_DISP_MED20_SP98 <- mean(SP98_data$DISP_MED20)
# Mediane pour la colonne "DISP_MED20"
median_DISP_MED20_SP98 <- median(SP98_data$DISP_MED19)
#median_DISP_MED20_SP98 <- median(SP98_data$DISP_MED20)
# ecart-type pour la colonne "DISP_MED20"
sd_DISP_MED20_SP98 <- sd(SP98_data$DISP_MED19)
#sd_DISP_MED20_SP98 <- sd(SP98_data$DISP_MED20)
# Afficher les resultats
cat("Moyenne DISP_MED:", mean_DISP_MED20_SP98, "\n")
#cat("Mediane DISP_MED:", median_DISP_MED20_SP98, "\n")
cat("ecart-type DISP_MED:", sd_DISP_MED20_SP98, "\n")

# Histogramme pour la colonne "DISP_MED20"
hist(SP98_data$DISP_MED19, main = "Distribution de DISP_MED19", xlab = "DISP_MED19")
#hist(SP98_data$DISP_MED20, main = "Distribution de DISP_MED20", xlab = "DISP_MED20")


# Moyenne pour la colonne "PrixValeur"
mean_PrixValeur_SP98 <- mean(SP98_data$PrixValeur.x)
# Mediane pour la colonne "PrixValeur"
median_PrixValeur_SP98 <- median(SP98_data$PrixValeur.x)
# ecart-type pour la colonne "PrixValeur"
sd_PrixValeur_SP98 <- sd(SP98_data$PrixValeur.x)
# Afficher les resultats
cat("Moyenne PrixValeur:", mean_PrixValeur_SP98, "\n")
cat("Mediane PrixValeur:", median_PrixValeur_SP98, "\n")
cat("ecart-type PrixValeur:", sd_PrixValeur_SP98, "\n")

# Histogramme pour la colonne "PrixValeur"
hist(SP98_data$PrixValeur.x, main = "Distribution de PrixValeur", xlab = "PrixValeur")

# Boite a moustaches pour la colonne "DISP_MED20"
boxplot(SP98_data$DISP_MED19, main = "Boite a moustaches de DISP_MED19")
#boxplot(SP98_data$DISP_MED20, main = "Boite a moustaches de DISP_MED20")
# Boite a moustaches pour la colonne "PrixValeur"
boxplot(SP98_data$PrixValeur.x, main = "Boite a moustaches de PrixValeur")
######################################

##### Analyse Bivarier Revenues SP98 #####

# Creer un graphique de dispersion entre DISP_MED20 et PrixValeur
plot(SP98_data$PrixValeur.x, SP98_data$DISP_MED19, main = "Graphique de dispersion entre DISP_MED19 et PrixValeur", xlab = "DISP_MED19", ylab = "PrixValeur", pch = 16)

#plot(SP98_data$PrixValeur.x, SP98_data$DISP_MED20, 
     main = "Graphique de dispersion entre DISP_MED20 et PrixValeur",
     xlab = "DISP_MED20", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre DISP_MED20 et PrixValeur
correlation_SP98 <- cor(SP98_data$PrixValeur.x, SP98_data$DISP_MED19)
#correlation_SP98 <- cor(SP98_data$PrixValeur.x, SP98_data$DISP_MED20)
# Calculer la pvalue et l'intervale de confiance de la correlation entre DISP_MED20 et PrixValeur
cor.test(SP98_data$PrixValeur.x, SP98_data$DISP_MED19)
#cor.test(SP98_data$PrixValeur.x, SP98_data$DISP_MED20)
# Afficher la correlation
cat("Correlation entre DISP_MED20 et PrixValeur:", correlation_SP98, "\n")

# Ajouter une ligne de regression lineaire
lm_model_SP98 <- lm(DISP_MED19 ~ PrixValeur.x, data = SP98_data)
#lm_model_SP98 <- lm(DISP_MED20 ~ PrixValeur.x, data = SP98_data)
abline(lm_model_SP98, col = "red")
######################################

##### Analyse Univarier Revenues SP95 #####
### cas globale
# Selectionner les lignes ou la colonne 'PrixNom' est egale z 'SP95'
# SP95_data <- data_revenu[data_revenu$PrixNom == "SP95", ]
# Afficher les donnees filtrees
#SP95_data$DISP_MED20 <- as.integer(SP95_data$DISP_MED20)
#SP95_data <- na.omit(SP95_data)
#head(SP95_data)

###########################################################
### cas particulier
SP95_data <- read_csv("Data_All/SP95_Data_2019.csv")
#SP95_data <- read_csv("Data_All/SP95_Data_2023.csv")

SP95_data <- SP95_data %>%
  mutate(classe = case_when(
    dist_autoroute.x < 500 ~ 1,
    dist_autoroute.x > 500 & dist_autoroute.x < 30000 ~ 2,
    dist_autoroute.x > 30000 ~ 3,
    TRUE ~ NA_integer_  # Gestion par défaut si aucune condition n'est satisfaite
  ))

# filtre
SP95_data <- SP95_data[SP95_data$dist_autoroute.x <= 500, ]
SP95_data <- SP95_data[SP95_data$dist_autoroute.x >= 30000, ]
###########################################################

# Resumer statistique pour la colonne "DISP_MED20"
summary(SP95_data$DISP_MED19)
#summary(SP95_data$DISP_MED20)
# Resumer statistique pour la colonne "Prix"
summary(SP95_data$PrixValeur.x)

# Moyenne pour la colonne "DISP_MED20"
mean_DISP_MED20_SP95 <- mean(SP95_data$DISP_MED19)
#mean_DISP_MED20_SP95 <- mean(SP95_data$DISP_MED20)
# Mediane pour la colonne "DISP_MED20"
median_DISP_MED20_SP95 <- median(SP95_data$DISP_MED19)
#median_DISP_MED20_SP95 <- median(SP95_data$DISP_MED20)
# ecart-type pour la colonne "DISP_MED20"
sd_DISP_MED20_SP95 <- sd(SP95_data$DISP_MED19)
#sd_DISP_MED20_SP95 <- sd(SP95_data$DISP_MED20)
# Afficher les resultats
cat("Moyenne DISP_MED20:", mean_DISP_MED20_SP95, "\n")
#cat("Mediane DISP_MED20:", median_DISP_MED20_SP95, "\n")
cat("ecart-type DISP_MED20:", sd_DISP_MED20_SP95, "\n")

# Histogramme pour la colonne "DISP_MED"
hist(SP95_data$DISP_MED19, main = "Distribution de DISP_MED19", xlab = "DISP_MED19")
#hist(SP95_data$DISP_MED20, main = "Distribution de DISP_MED20", xlab = "DISP_MED20")


# Moyenne pour la colonne "PrixValeur"
mean_PrixValeur_SP95 <- mean(SP95_data$PrixValeur.x)
# Mediane pour la colonne "PrixValeur"
median_PrixValeur_SP95 <- median(SP95_data$PrixValeur.x)
# ecart-type pour la colonne "PrixValeur"
sd_PrixValeur_SP95 <- sd(SP95_data$PrixValeur.x)
# Afficher les resultats
cat("Moyenne PrixValeur:", mean_PrixValeur_SP95, "\n")
#cat("Mediane PrixValeur:", median_PrixValeur_SP95, "\n")
cat("ecart-type PrixValeur:", sd_PrixValeur_SP95, "\n")

# Histogramme pour la colonne "PrixValeur"
hist(SP95_data$PrixValeur.x, main = "Distribution de PrixValeur", xlab = "PrixValeur")

# Boite a moustaches pour la colonne "DISP_MED20"
boxplot(SP95_data$DISP_MED19, main = "Boite a moustaches de DISP_MED19")
#boxplot(SP95_data$DISP_MED20, main = "Boite a moustaches de DISP_MED20")
# Boite a moustaches pour la colonne "PrixValeur"
boxplot(SP95_data$PrixValeur.x, main = "Boite a moustaches de PrixValeur")
######################################

##### Analyse Bivarier Population SP95 #####

# Creer un graphique de dispersion entre DISP_MED20 et PrixValeur
plot(SP95_data$DISP_MED19, SP95_data$PrixValeur.x, 
     main = "Graphique de dispersion entre DISP_MED19 et PrixValeur",
     xlab = "DISP_MED19", ylab = "PrixValeur", pch = 16)

#plot(SP95_data$DISP_MED20, SP95_data$PrixValeur.x, 
     main = "Graphique de dispersion entre DISP_MED20 et PrixValeur",
     xlab = "DISP_MED20", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre DISP_MED20 et PrixValeur
correlation_SP95 <- cor(SP95_data$DISP_MED19, SP95_data$PrixValeur.x)
#correlation_SP95 <- cor(SP95_data$DISP_MED20, SP95_data$PrixValeur.x)
# Calculer la pvalue et l'intervale de confiance de la correlation entre DISP_MED20 et PrixValeur
cor.test(SP95_data$DISP_MED19, SP95_data$PrixValeur.x)
#cor.test(SP95_data$DISP_MED20, SP95_data$PrixValeur.x)
# Afficher la correlation
cat("Correlation entre DISP_MED20 et PrixValeur:", correlation_SP95, "\n")

# Ajouter une ligne de regression lineaire
lm_model_SP95 <- lm(PrixValeur.x ~ DISP_MED19, data = SP95_data)
#lm_model_SP95 <- lm(PrixValeur.x ~ DISP_MED20, data = SP95_data)
abline(lm_model_SP95, col = "red")
######################################
