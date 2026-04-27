import json 

# --- ETAPE 1 : LECTURE DES DONNÉES ---
try:
    with open("ma_data.json", "r", encoding='utf-8') as f:
        liste_oeuvres = json.load(f)
except FileNotFoundError:
    print("Erreur : Lance d'abord 'recup.py' pour récupérer les données !")
    exit()

# --- ETAPE 2 : CONSTRUCTION DU HTML ---
print(f"Création du site pour {len(liste_oeuvres)} oeuvres...")

html_content = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Ma Galerie MET</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; background-color: #333; color: white; padding: 20px; }
        h1 { text-align: center; }
        .galerie { display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; }
        .carte { background: #444; border-radius: 10px; width: 300px; padding: 10px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.3); }
        .carte img { max-width: 100%; height: auto; border-radius: 5px; }
        .titre { font-weight: bold; margin-top: 10px; color: #ffcc00; }
        .artiste { font-style: italic; color: #ccc; font-size: 0.9em;}
    </style>
</head>
<body>
    <h1>🏛️ Ma Collection Privée</h1>
    <div class="galerie">
"""

# On boucle sur les données qu'on a chargées du JSON
for oeuvre in liste_oeuvres:
    html_content += f"""
        <div class="carte">
            <img src="{oeuvre['image']}" alt="oeuvre">
            <div class="titre">{oeuvre['titre']}</div>
            <div class="artiste">{oeuvre['artiste']}</div>
        </div>
    """

html_content += """
    </div>
</body>
</html>
"""

# --- ETAPE 3 : ECRITURE DU FICHIER FINAL ---
with open("ma_galerie.html", "w", encoding='utf-8') as f:
    f.write(html_content)

print("🎉 Site généré ! Ouvre 'ma_galerie.html'.")