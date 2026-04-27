import requests

url = "https://collectionapi.metmuseum.org/public/collection/v1/departments"
req = requests.get(url)

if req.status_code == 200:
    data = req.json()
        # print(data.keys()) va afficher le dictionnaire (clé) dict_keys(['departments'])
        # puis print(data['departments']) pour afficher la liste (le tiroir)
        # enfin pour afficher les attributs : data['departments'][0]
    for i in data['departments']:
        print(f"ID : {i['departmentId']} - Nom : {i['displayName']}")

else:
    print("Erreur de connexion à l'API")

# J'ai choisi l'ID 11 - European Paintings

# Pour résumer: 
la_liste = data['departments']
premier_departement = la_liste[0]
print(premier_departement.keys())