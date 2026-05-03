import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import time

URL_LISTE = "https://fr.wikipedia.org/wiki/Liste_des_monarques_de_France"
HEADERS = {"User-Agent": "Mozilla/5.0 (IUT Aurillac; SAE SD)"}

def clean_text(text):
    if not text: return "Inconnu"
    text = re.sub(r'\[.*?\]', '', text) 
    text = re.sub(r'\(.*?\)', '', text) 
    text = re.sub(r'([a-z0-9])([A-Z])', r'\1 \2', text)
    return text.replace('\xa0', ' ').strip()

def extract_year(text):
    """ Extrait juste l'année pour la chronologie """
    match = re.search(r'\d{3,4}', str(text))
    return int(match.group()) if match else None

def count_children(text):
    """ Transforme le texte en nombre d'enfants exploitable """
    if not text or "Inconnu" in text or "Aucun" in text: return 0
    numbers = {"Un": 1, "Deux": 2, "Trois": 3, "Quatre": 4, "Cinq": 5}
    for word, val in numbers.items():
        if word in text: return val
    return len(re.findall(r'[A-Z][a-z]+', text))

def get_roi_details(url_roi):
    try:
        res = requests.get(url_roi, headers=HEADERS, timeout=5)
        soup = BeautifulSoup(res.text, "lxml")
        infobox = soup.find("table", class_="infobox")
        details = {"Pere": "Inconnu", "Mere": "Inconnue", "Enfants": "Inconnus"}
        if infobox:
            for row in infobox.find_all("tr"):
                th, td = row.find("th"), row.find("td")
                if th and td:
                    label, val = th.get_text(), td.get_text()
                    if "Père" in label: details["Pere"] = clean_text(val)
                    if "Mère" in label: details["Mere"] = clean_text(val)
                    if "Enfant" in label: details["Enfants"] = clean_text(val)
        return details
    except:
        return {"Pere": "Erreur", "Mere": "Erreur", "Enfants": "Erreur"}

print("Démarrage de la collecte...")
response = requests.get(URL_LISTE, headers=HEADERS)
soup = BeautifulSoup(response.text, "lxml")
data_rois = []

for table in soup.find_all("table", class_="wikitable"):
    for row in table.find_all("tr")[1:]:
        cells = row.find_all("td")
        if len(cells) >= 3:
            link = cells[1].find("a")
            if link and 'href' in link.attrs:
                url = "https://fr.wikipedia.org" + link['href']
                famille = get_roi_details(url)
                
                
                data_rois.append({
                    "Nom": clean_text(link.get_text()),
                    "Annee_Debut": extract_year(cells[2].get_text()),
                    "Pere": famille["Pere"],
                    "Mere": famille["Mere"],
                    "Nb_Enfants": count_children(famille["Enfants"]),
                    "Enfants_Liste": clean_text(famille["Enfants"])
                })
                time.sleep(0.05)

df = pd.DataFrame(data_rois).dropna(subset=['Annee_Debut'])
df.to_csv("rois_france_final.csv", index=False, encoding="utf-8-sig")
print(f"OK : {len(df)} monarques enregistrés.")