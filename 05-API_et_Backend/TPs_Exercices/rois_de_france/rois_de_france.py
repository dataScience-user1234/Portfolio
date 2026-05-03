import requests
import bs4

url = "https://fr.wikipedia.org/wiki/Liste_des_monarques_de_France"

headers = {
    "User-Agent" : "Mozilla/5.0"
}

req = requests.get(url, headers=headers)

print(f"Statut de la connexion : {req.status_code}")

soup = bs4.BeautifulSoup(req.text, "html.parser")

tableaux = soup.find_all("table", class_ = "wikitable")

#on ouvre un fichier pour écrire les résultats
with open("liste_rois.txt", "w", encoding="utf-8") as fichier:

# On parcourt chaque tableau trouvé (les 9)
    for table in tableaux:
        # On parcourt chaque ligne du tableau
        for ligne in table.find_all('tr'):
            case = ligne.find_all(['td', 'th'])
            
            # On nettoie le texte
            donnees = [c.get_text(strip=True) for c in case]
            
            # On vérifie qu'on a bien assez de colonnes pour éviter les erreurs
            # (Nom en 1, Dates en 2 -> il faut au moins 3 colonnes)
            if len(donnees) >= 3:
                nom = donnees[1]
                regne = donnees[2]
                
                # On écrit dans le fichier
                ligne_a_ecrire = f"Roi : {nom} | Règne : {regne}\n"
                fichier.write(ligne_a_ecrire)

print("Terminé ! Regarde le fichier 'liste_rois.txt'.")