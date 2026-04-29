import pandas as pd

# Chemin vers le fichier
chemin_fichier = "C:\\Users\\s2mfa\\OneDrive\\Documents\\semestre_2\\projet_RD\\Appartement_Etudiant_Promo.csv"

# Importer le fichier CSV
df = pd.read_csv(chemin_fichier)

# Renommer les colonnes
df = df.rename(columns={
    "Dans quel quartier se trouve votre appartement ?": "quartier",
    "Quelle est la superficie de votre appartement ? (en m², ex. 25 ou 30.5)": "superficie",
    "Quel est le loyer mensuel de votre appartement ? (en €, hors charges, ex. 400)": "loyer",
    "Combien de pièces principales a votre appartement ? (séjour + chambres, hors cuisine/salle de bain)": "nb_pieces"
})

# Garder les colonnes utiles
df = df[["quartier", "superficie", "loyer", "nb_pieces"]]

# Convertir les colonnes en numérique
df["superficie"] = pd.to_numeric(df["superficie"], errors='coerce')
df["loyer"] = pd.to_numeric(df["loyer"], errors='coerce')
df["nb_pieces"] = pd.to_numeric(df["nb_pieces"], errors='coerce')

# Supprimer les lignes incomplètes
df = df.dropna()

# Afficher les premières lignes
print(df.head())

# Enregistrement du fichier nettoyé dans le dossier souhaité
df.to_csv("C:/Users/s2mfa/OneDrive/Documents/semestre_2/projet_RD/Appartement_Etudiant_Promo_nettoye.csv", index=False)
