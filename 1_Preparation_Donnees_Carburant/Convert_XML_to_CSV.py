import csv
import xml.etree.ElementTree as ET

def process_pdv(node):
    id = node.get("id")
    latitude = node.get("latitude")
    longitude = node.get("longitude")
    code_postal = node.get("cp")
    population = node.get("pop")

    adresse = node.find("adresse").text
    ville = node.find("ville").text

    horaire_info = [f"{jour.get('nom')}:{jour.get('ferme')}" for jour in node.findall(".//jour")]
    horaires_str = ", ".join(horaire_info)

    services_str = ", ".join(service.text for service in node.findall(".//services/service"))

    prix_data = []
    for prix_node in node.findall(".//prix"):
        prix_nom = prix_node.get("nom")
        prix_id = prix_node.get("id")
        prix_maj = prix_node.get("maj")
        prix_valeur = prix_node.get("valeur")
        prix_data.append([id, latitude, longitude, code_postal, population, adresse, ville,
                          horaires_str, services_str, prix_nom, prix_id, prix_maj, prix_valeur])

    return prix_data

def xml_to_csv(xml_file_path, csv_file_path):
    tree = ET.parse(xml_file_path)
    root = tree.getroot()

    with open(csv_file_path, mode='w', newline='', encoding='utf-8') as csvfile:
        csv_writer = csv.writer(csvfile)
       
        # Écrire l'en-tête du CSV
        csv_writer.writerow(["ID", "Latitude", "Longitude", "CodePostal", "Population",
                             "Adresse", "Ville", "Horaires", "Services", "PrixNom", "PrixID", "PrixMaj", "PrixValeur"])

        # Traitement des éléments pdv
        for pdv_node in root.findall(".//pdv"):
            prix_data = process_pdv(pdv_node)
            csv_writer.writerows(prix_data)

# Chemin vers le fichier XML
xml_file_path = "Donnee_Brute/XML/PrixCarburants_annuel_2019.xml"
# xml_file_path = "Donnee_Brute/XML/PrixCarburants_annuel_2023.xml"

# Chemin vers le fichier CSV de sortie
csv_file_path = "Donnee_Carburant/PrixCarburants_annuel_2019.csv"
# csv_file_path = "Donnee_Carburant/PrixCarburants_annuel_2023.csv"

# Convertir XML en CSV
xml_to_csv(xml_file_path, csv_file_path)