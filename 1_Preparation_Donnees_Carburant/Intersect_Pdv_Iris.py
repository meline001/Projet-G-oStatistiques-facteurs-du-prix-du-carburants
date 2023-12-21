import geopandas as gpd
import pandas as pd
from pyproj import Proj, Transformer

# Chemin vers votre fichier CSV avec des coordonnées (longitude, latitude)
# chemin_vers_csv_coord = "Donnee_Carburant/Carburant_PrixMoy_2019.csv"
chemin_vers_csv_coord = "Donnee_Carburant/Carburant_PrixMoy_2023.csv"

# Chemin vers votre fichier CSV avec un géoshape
chemin_vers_csv_geoshape = "Donnee_georef-france-iris/georef-france-iris-millesime.shp"

# Chemin pour exporter les résultats de l'intersection en CSV
chemin_export_csv_resultat = "Donnee_Prep/resultat_intersection.csv"

# Lire les données CSV avec des coordonnées
df_coord = pd.read_csv(chemin_vers_csv_coord)

# Lire les données CSV avec un géoshape
gdf_geoshape = gpd.read_file(chemin_vers_csv_geoshape)

# Convertir le DataFrame avec des coordonnées en GeoDataFrame
gdf_coord = gpd.GeoDataFrame(df_coord, geometry=gpd.points_from_xy(df_coord.Longitude, df_coord.Latitude))

# Intersection des deux GeoDataFrames
resultat_intersection = gpd.sjoin(gdf_coord, gdf_geoshape, how="inner", op="intersects")

# Supprimer les colonnes inutiles
colonnes = resultat_intersection.columns
colonnes_a_supprimer = colonnes[9:30]
resultat_intersection = resultat_intersection.drop(colonnes_a_supprimer, axis=1)
colonnes_a_supprimer = colonnes[31:40]
resultat_intersection = resultat_intersection.drop(colonnes_a_supprimer, axis=1)

resultat_intersection['iris_code'] = resultat_intersection['iris_code'].str[2:-2]


# lecture du fichier sur la pop en fonction de l'iris
chemin_vers_pop = 'Donnee_Insee/base-ic-evol-struct-pop-2019_csv/base-ic-evol-struct-pop-2019.csv'

df2_pop =  pd.read_csv(chemin_vers_pop,sep=';')
df2_pop = df2_pop.rename(columns={'IRIS': 'iris_code'})
# df2['iris_code'] = df2['iris_code'].astype(str)
df2_pop['iris_code'] = df2_pop['iris_code'].apply(lambda x: '0' + str(x) if len(str(x)) == 8 else str(x))

# Jointure des données revenues selon iris 
df_resultat = pd.merge(resultat_intersection, df2_pop, on='iris_code', how='inner')

# retire les colonnes pop inutiles
colonnes_pop = df_resultat.columns
colonnes_a_supprimer_pop = colonnes_pop[15:86]
df_resultat = df_resultat.drop(colonnes_a_supprimer_pop, axis=1)

# lecture du fichier sur les revenues en fonction de l'iris
chemin_vers_revenues = 'Donnee_Insee/BASE_TD_FILO_DISP_IRIS_2020_CSV/BASE_TD_FILO_DISP_IRIS_2020.csv'
# chemin_vers_revenues = 'Donnee_Insee/BASE_TD_FILO_DISP_IRIS_2019/BASE_TD_FILO_DISP_IRIS_2019.csv'

df_revenu =  pd.read_csv(chemin_vers_revenues,sep=';')
df_revenu = df_revenu.rename(columns={'IRIS': 'iris_code'})
# df2['iris_code'] = df2['iris_code'].astype(str)
df_revenu['iris_code'] = df_revenu['iris_code'].apply(lambda x: '0' + str(x) if len(str(x)) == 8 else str(x))

# Jointure des données revenues selon iris 
df_resultat2 = pd.merge(resultat_intersection, df_revenu, on='iris_code', how='inner')

# retire les colonnes revenue inutiles
colonnes_revenu = df_resultat2.columns
colonnes_a_supprimer_revenu = colonnes_revenu[13:38]
df_resultat2 = df_resultat2.drop(colonnes_a_supprimer_revenu, axis=1)


# Exporter les résultats de l'intersection en tant que fichier CSV
resultat_intersection.to_csv(chemin_export_csv_resultat, index=False)
# # export pop 2019
# df_resultat.to_csv('df_resultat_pop_2019_med19.csv', index=False)
# # export revenues 2019
# df_resultat2.to_csv('df_resultat_revenu_2019_med19.csv', index=False)

# # export pop 2023
df_resultat.to_csv('Donnee_Prep/df_resultat_pop_2023_med23.csv', index=False)
# export revenues
#df_resultat2.to_csv('Donnee_Prep/df_resultat_revenu_2023_med23.csv', index=False)

