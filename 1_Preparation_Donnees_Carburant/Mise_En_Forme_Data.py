import pandas as pd

# Chemin vers votre fichier CSV
chemin_vers_csv = "Donnee_Carburant/PrixCarburants_annuel_2019.csv"
# chemin_vers_csv = "Donnee_Carburant/PrixCarburants_annuel_2023.csv"
# remplacer 2019 par 2023

# Lire le fichier CSV
data_frame = pd.read_csv(chemin_vers_csv)

# Supprimer les colonnes "horaires" et "services"
colonnes_a_supprimer = ["Horaires", "Services"]
data_frame = data_frame.drop(colonnes_a_supprimer, axis=1)

# Convertir le champ "PrixMaj" en format datetime si ce n'est pas déjà fait
data_frame['PrixMaj'] = pd.to_datetime(data_frame['PrixMaj'])

# correction code postaux
data_frame['CodePostal'] = data_frame['CodePostal'].apply(lambda x: '0' + str(x) if len(str(x)) == 4 else str(x))

# conversion des données en wgs84
data_frame['Longitude'] = data_frame['Longitude']/100000
data_frame['Latitude'] = data_frame['Latitude']/100000


# Définir les conditions
condition_1 = (data_frame['PrixMaj'] >= "2019-01-01") & (data_frame['PrixMaj'] < "2019-04-01")
condition_2 = (data_frame['PrixMaj'] >= "2019-04-01") & (data_frame['PrixMaj'] < "2019-07-01")
condition_3 = (data_frame['PrixMaj'] >= "2019-07-01") & (data_frame['PrixMaj'] < "2019-10-01")
condition_4 = (data_frame['PrixMaj'] >= "2019-10-01") 

# # Créer des DataFrames en fonction des conditions
df_condition_1 = data_frame[condition_1]
df_condition_2 = data_frame[condition_2]
df_condition_3 = data_frame[condition_3]
df_condition_4 = data_frame[condition_4]

# Calculer la moyenne du champ "PrixValeur" en groupant par les champs "Ville" et "NomCarburant"
moyenne_par_groupe_condition_1 = df_condition_1.groupby(['Adresse', 'PrixID','CodePostal','ID','Latitude','Longitude','PrixNom','Ville'])['PrixValeur'].mean().reset_index()
moyenne_par_groupe_condition_2 = df_condition_2.groupby(['Adresse', 'PrixID','CodePostal','ID','Latitude','Longitude','PrixNom','Ville'])['PrixValeur'].mean().reset_index()
moyenne_par_groupe_condition_3 = df_condition_3.groupby(['Adresse', 'PrixID','CodePostal','ID','Latitude','Longitude','PrixNom','Ville'])['PrixValeur'].mean().reset_index()
moyenne_par_groupe_condition_4 = df_condition_4.groupby(['Adresse', 'PrixID','CodePostal','ID','Latitude','Longitude','PrixNom','Ville'])['PrixValeur'].mean().reset_index()

# correction des données de Prix moyen
# Pour 2019 erreur de décimale
moyenne_par_groupe_condition_1['PrixValeur'] = moyenne_par_groupe_condition_1['PrixValeur']/1000
moyenne_par_groupe_condition_2['PrixValeur'] = moyenne_par_groupe_condition_2['PrixValeur']/1000
moyenne_par_groupe_condition_3['PrixValeur'] = moyenne_par_groupe_condition_3['PrixValeur']/1000
moyenne_par_groupe_condition_4['PrixValeur'] = moyenne_par_groupe_condition_4['PrixValeur']/1000

# Exporter les DataFrames en tant que fichiers CSV
moyenne_par_groupe_condition_1.to_csv("Carburant_PrixMoy_Q1_2019.csv", index=False)
moyenne_par_groupe_condition_2.to_csv("Carburant_PrixMoy_Q2_2019.csv", index=False)
moyenne_par_groupe_condition_3.to_csv("Carburant_PrixMoy_Q3_2019.csv", index=False)
moyenne_par_groupe_condition_4.to_csv("Carburant_PrixMoy_Q4_2019.csv", index=False)

# Pour toute l'année
data = data_frame.groupby(['Adresse', 'PrixID','CodePostal','ID','Latitude','Longitude','PrixNom','Ville'])['PrixValeur'].mean().reset_index()
# Pour 2019 erreur de décimale
data['PrixValeur'] = data['PrixValeur']/1000
data.to_csv("Donnee_Carburant/Carburant_PrixMoy_2019.csv", index=False)
# data.to_csv("Donnee_Carburant/Carburant_PrixMoy_2023.csv", index=False)



