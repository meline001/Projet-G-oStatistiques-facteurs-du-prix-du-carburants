# Installer le package readr
#install.packages("readr")

# Charger le package readr
library(readr)
library(ggplot2)

# Lire le fichier CSV avec readr en fonction de l'année
data_pop <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_pop_2019_med19.csv")
data_pop <- read_csv("../1_Preparation_Donnees_Carburant/Donnee_Prep/df_resultat_pop_2023_med23.csv")

# Afficher les premières lignes du dataframe
head(data)

##### Analyse Univarier Population Gazole #####
# Sélectionner les lignes ou la colonne 'PrixNom' est égale à 'Gazole'
gazole_data <- data_pop[data_pop$PrixNom == "Gazole", ]
# Afficher les donnees filtres
#print(gazole_data)

###########################################################
gazole_data <- read_csv("Data_All/Gazole_Data_2019.csv")
gazole_data <- read_csv("Data_All/Gazole_Data_2023.csv")

gazole_data <- gazole_data %>%
  mutate(classe = case_when(
    dist_autoroute.x < 500 ~ 1,
    dist_autoroute.x > 500 & dist_autoroute.x < 30000 ~ 2,
    dist_autoroute.x > 30000 ~ 3,
    TRUE ~ NA_integer_  # Gestion par défaut si aucune condition n'est satisfaite
  ))

#filtre
gazole_data <- gazole_data[gazole_data$dist_autoroute.x <= 500, ]
gazole_data <- gazole_data[gazole_data$dist_autoroute.x >= 30000, ]
###########################################################



# Resume statistique pour la colonne "P19_POP"
summary(gazole_data$P19_POP)
# Resume statistique pour la colonne "Prix"
summary(gazole_data$PrixValeur.x)

# Moyenne pour la colonne "P19_POP"
mean_P19_POP <- mean(gazole_data$P19_POP)
# Mediane pour la colonne "P19_POP"
median_P19_POP <- median(gazole_data$P19_POP)
# ecart-type pour la colonne "P19_POP"
sd_P19_POP <- sd(gazole_data$P19_POP)
# Afficher les resultats
cat("Moyenne P19_POP:", mean_P19_POP, "\n")
cat("Mediane P19_POP:", median_P19_POP, "\n")
cat("ecart-type P19_POP:", sd_P19_POP, "\n")

# Histogramme pour la colonne "Pop19"
hist(gazole_data$P19_POP, main = "Distribution de P19_POP", xlab = "P19_POP")
#histo1 <- hist(gazole_data$P19_POP, main = "Distribution de P19_POP", xlab = "P19_POP")
#png("histo_POP19_Gazole_23.png", width = 800, height = 600, res = 120)
#plot(histo1)
#dev.off()


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
#histo2 <- hist(gazole_data$PrixValeur, main = "Distribution de PrixValeur", xlab = "PrixValeur")
#png("histo_PrixValeur_Gazole_23.png", width = 800, height = 600, res = 120)
#plot(histo2)
#dev.off()

# Boite a moustaches pour la colonne "P19_POP"
boxplot(gazole_data$P19_POP, main = "Boite a moustaches de P19_POP")
# Boite a moustaches pour la colonne "PrixValeur"
boxplot(gazole_data$PrixValeur.x, main = "Boite a moustaches de PrixValeur")
######################################

# Creer un graphique de dispersion entre P19_POP et PrixValeur
plot(gazole_data$nb_shop_point, gazole_data$PrixValeur.x, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre P19_POP et PrixValeur
correlation <- cor(gazole_data$nb_shop_point, gazole_data$PrixValeur.x)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(gazole_data$nb_shop_point, gazole_data$PrixValeur.x)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation, "\n")

# Ajouter une ligne de regression lineaire
lm_model <- lm(PrixValeur.x ~ nb_shop_point, data = gazole_data)
abline(lm_model, col = "red")













##### Analyse Bivarier Population Gazole #####

# Creer un graphique de dispersion entre P19_POP et PrixValeur
plot(gazole_data$P19_POP, gazole_data$PrixValeur, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre P19_POP et PrixValeur
correlation <- cor(gazole_data$P19_POP, gazole_data$PrixValeur)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(gazole_data$P19_POP, gazole_data$PrixValeur)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation, "\n")

# Ajouter une ligne de regression lineaire
lm_model <- lm(PrixValeur ~ P19_POP, data = gazole_data)
abline(lm_model, col = "red")

###########
plot(gazole_data$P19_POP, gazole_data$PrixValeur.x, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16, cex = 0.6)


# Calculer la correlation entre P19_POP et PrixValeur
correlation <- cor(gazole_data$P19_POP, gazole_data$PrixValeur.x)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(gazole_data$P19_POP, gazole_data$PrixValeur.x)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation, "\n")

# Ajouter une ligne de regression lineaire
lm_model <- lm(PrixValeur.x ~ P19_POP, data = gazole_data)
abline(lm_model, col = "red")

######################################


##### Analyse Univarier Population SP98 #####
# Selectionner les lignes ou la colonne 'PrixNom' est egale a 'SP98'
SP98_data <- data_pop[data_pop$PrixNom == "SP98", ]
# Afficher les donnees filtrees
#print(SP98_data)

###########################################################
SP98_data <- read_csv("Data_All/SP98_Data_2019.csv")
SP98_data <- read_csv("Data_All/SP98_Data_2023.csv")

SP98_data <- SP98_data %>%
  mutate(classe = case_when(
    dist_autoroute.x < 500 ~ 1,
    dist_autoroute.x > 500 & dist_autoroute.x < 30000 ~ 2,
    dist_autoroute.x > 30000 ~ 3,
    TRUE ~ NA_integer_  # Gestion par défaut si aucune condition n'est satisfaite
  ))

#filtre
SP98_data <- SP98_data[SP98_data$dist_autoroute.x <= 500, ]
SP98_data <- SP98_data[SP98_data$dist_autoroute.x >= 30000, ]
###########################################################


# Resumer statistique pour la colonne "P19_POP"
summary(SP98_data$P19_POP)
# Resumer statistique pour la colonne "Prix"
summary(SP98_data$PrixValeur.x)

# Moyenne pour la colonne "P19_POP"
mean_P19_POP_SP98 <- mean(SP98_data$P19_POP)
# Mediane pour la colonne "P19_POP"
median_P19_POP_SP98 <- median(SP98_data$P19_POP)
# ecart-type pour la colonne "P19_POP"
sd_P19_POP_SP98 <- sd(SP98_data$P19_POP)
# Afficher les resultats
cat("Moyenne P19_POP:", mean_P19_POP_SP98, "\n")
cat("Mediane P19_POP:", median_P19_POP_SP98, "\n")
cat("ecart-type P19_POP:", sd_P19_POP_SP98, "\n")

# Histogramme pour la colonne "Pop19"
hist(SP98_data$P19_POP, main = "Distribution de P19_POP", xlab = "P19_POP")
#histo3 <- hist(SP98_data$P19_POP, main = "Distribution de P19_POP", xlab = "P19_POP")
#png("histo_Pop19_SP98_23.png", width = 800, height = 600, res = 120)
#plot(histo3)
#dev.off()

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
#histo4 <- hist(SP98_data$PrixValeur, main = "Distribution de PrixValeur", xlab = "PrixValeur")
#png("histo_PrixValeur_SP98_23.png", width = 800, height = 600, res = 120)
#plot(histo4)
#dev.off()

# Boite a moustaches pour la colonne "P19_POP"
boxplot(SP98_data$P19_POP, main = "Boite a moustaches de P19_POP")
# Boite a moustaches pour la colonne "PrixValeur"
boxplot(SP98_data$PrixValeur.x, main = "Boite a moustaches de PrixValeur")
######################################

##### Analyse Bivarier Population SP98 #####
# Creer un graphique de dispersion entre P19_POP et PrixValeur
plot(SP98_data$P19_POP, SP98_data$PrixValeur, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre P19_POP et PrixValeur
correlation_SP98 <- cor(SP98_data$P19_POP, SP98_data$PrixValeur)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(SP98_data$P19_POP, SP98_data$PrixValeur)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation_SP98, "\n")

# Ajouter une ligne de regression lineaire
lm_model_SP98 <- lm(PrixValeur ~ P19_POP, data = SP98_data)
abline(lm_model_SP98, col = "red")


# Creer un graphique de dispersion entre P19_POP et PrixValeur
plot(SP98_data$P19_POP, SP98_data$PrixValeur.x, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre P19_POP et PrixValeur
correlation_SP98 <- cor(SP98_data$P19_POP, SP98_data$PrixValeur.x)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(SP98_data$P19_POP, SP98_data$PrixValeur.x)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation_SP98, "\n")

# Ajouter une ligne de regression lineaire
lm_model_SP98 <- lm(PrixValeur.x ~ P19_POP, data = SP98_data)
abline(lm_model_SP98, col = "red")
######################################

##### Analyse Univarier Population SP95 #####
# Selectionner les lignes ou la colonne 'PrixNom' est egale z 'SP95'
SP95_data <- data_pop[data_pop$PrixNom == "SP95", ]
# Afficher les donnees filtrees
#print(SP95_data)

###########################################################
SP95_data <- read_csv("Data_All/SP95_Data_2019.csv")
SP95_data <- read_csv("Data_All/SP95_Data_2023.csv")

SP95_data <- SP95_data %>%
  mutate(classe = case_when(
    dist_autoroute.x < 500 ~ 1,
    dist_autoroute.x > 500 & dist_autoroute.x < 30000 ~ 2,
    dist_autoroute.x > 30000 ~ 3,
    TRUE ~ NA_integer_  # Gestion par défaut si aucune condition n'est satisfaite
  ))

#filtre
SP95_data <- SP95_data[SP95_data$dist_autoroute.x <= 500, ]
SP95_data <- SP95_data[SP95_data$dist_autoroute.x >= 30000, ]
###########################################################

# Resumer statistique pour la colonne "P19_POP"
summary(SP95_data$P19_POP)
# Resumer statistique pour la colonne "Prix"
summary(SP95_data$PrixValeur.x)

# Moyenne pour la colonne "P19_POP"
mean_P19_POP_SP95 <- mean(SP95_data$P19_POP)
# Mediane pour la colonne "P19_POP"
median_P19_POP_SP95 <- median(SP95_data$P19_POP)
# ecart-type pour la colonne "P19_POP"
sd_P19_POP_SP95 <- sd(SP95_data$P19_POP)
# Afficher les resultats
cat("Moyenne P19_POP:", mean_P19_POP_SP95, "\n")
cat("Mediane P19_POP:", median_P19_POP_SP95, "\n")
cat("ecart-type P19_POP:", sd_P19_POP_SP95, "\n")

# Histogramme pour la colonne "Pop19"
hist(SP95_data$P19_POP, main = "Distribution de P19_POP", xlab = "P19_POP")
#histo5 <- hist(SP95_data$P19_POP, main = "Distribution de P19_POP", xlab = "P19_POP")
#png("histo_Pop19_SP95_23.png", width = 800, height = 600, res = 120)
#plot(histo5)
#dev.off()

# Moyenne pour la colonne "PrixValeur"
mean_PrixValeur_SP95 <- mean(SP95_data$PrixValeur.x)
# Mediane pour la colonne "PrixValeur"
median_PrixValeur_SP95 <- median(SP95_data$PrixValeur.x)
# ecart-type pour la colonne "PrixValeur"
sd_PrixValeur_SP95 <- sd(SP95_data$PrixValeur.x)
# Afficher les resultats
cat("Moyenne PrixValeur:", mean_PrixValeur_SP95, "\n")
cat("Mediane PrixValeur:", median_PrixValeur_SP95, "\n")
cat("ecart-type PrixValeur:", sd_PrixValeur_SP95, "\n")

# Histogramme pour la colonne "PrixValeur"
hist(SP95_data$PrixValeur.x, main = "Distribution de PrixValeur", xlab = "PrixValeur")
#histo6 <- hist(SP95_data$PrixValeur, main = "Distribution de PrixValeur", xlab = "PrixValeur")
#png("histo_PrixValeur_SP95_23.png", width = 800, height = 600, res = 120)
#plot(histo6)
#dev.off()

# Boite a moustaches pour la colonne "P19_POP"
boxplot(SP95_data$P19_POP, main = "Boite a moustaches de P19_POP")
# Boite a moustaches pour la colonne "PrixValeur"
boxplot(SP95_data$PrixValeur.x, main = "Boite a moustaches de PrixValeur")
######################################

##### Analyse Bivarier Population SP95 #####
# Creer un graphique de dispersion entre P19_POP et PrixValeur
plot(SP95_data$P19_POP, SP95_data$PrixValeur, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre P19_POP et PrixValeur
correlation_SP95 <- cor(SP95_data$P19_POP, SP95_data$PrixValeur)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(SP95_data$P19_POP, SP95_data$PrixValeur)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation_SP95, "\n")

# Ajouter une ligne de regression lineaire
lm_model_SP95 <- lm(PrixValeur ~ P19_POP, data = SP95_data)
abline(lm_model_SP95, col = "red")


# Creer un graphique de dispersion entre P19_POP et PrixValeur
plot(SP95_data$P19_POP, SP95_data$PrixValeur.x, 
     main = "Graphique de dispersion entre P19_POP et PrixValeur",
     xlab = "P19_POP", ylab = "PrixValeur", pch = 16)

# Calculer la correlation entre P19_POP et PrixValeur
correlation_SP95 <- cor(SP95_data$P19_POP, SP95_data$PrixValeur.x)
# Calculer la pvalue et l'intervale de confiance de la correlation entre P19_POP et PrixValeur
cor.test(SP95_data$P19_POP, SP95_data$PrixValeur.x)
# Afficher la correlation
cat("Correlation entre P19_POP et PrixValeur:", correlation_SP95, "\n")

# Ajouter une ligne de regression lineaire
lm_model_SP95 <- lm(PrixValeur.x ~ P19_POP, data = SP95_data)
abline(lm_model_SP95, col = "red")
######################################

