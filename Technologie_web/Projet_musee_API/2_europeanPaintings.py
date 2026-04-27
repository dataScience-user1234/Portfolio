import requests
import json

url = "https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds=11"
req = requests.get(url)

if req.status_code == 200:
    data = req.json()
    print("\n")
    print("Les clés principales :",data.keys()) # Quels sont les clés de la boîte departementId ?

    print("Nombre d'oeuvres total : ", data['total'])

    print("Les 10 premiers IDs : ", data['objectIDs'][:10])
    # J'ai maintenant une liste de numéro
    # Je vais récupérer les données avec l'URL ../public/collection/v1/objects/{id_objet}

    mes_id = data['objectIDs'][10:11] + data['objectIDs'][14:21] + data['objectIDs'][22:24]
    # j'ai enlevé certaines oeuvres

    donnee = []
    print("Récupération en cours...")

    for i in mes_id:
        url = f"https://collectionapi.metmuseum.org/public/collection/v1/objects/{i}"
        req = requests.get(url)
        
        if req.status_code == 200:
            details = req.json()

            # print(details.keys())
            mon_objet = {
                "id" : details['objectID'],
                "image" : details['primaryImage'],
                "artiste" : details['artistDisplayName'],
                "titre" : details['title'],
            }

            donnee.append(mon_objet)

        else:
            print("Erreur de connexion à l'API objects")

    print(f"J'ai récupéré {len(donnee)} oeuvres !")

# sauvegarde en json
    with open("ma_data.json", "w", encoding='utf-8') as f:
        json.dump(donnee, f, indent=4) # indent=4 pour que ce soit joli à lire
        
    print("Données sauvegardées dans 'ma_data.json' !")

else:
    print("Erreur de connexion à l'API département")

