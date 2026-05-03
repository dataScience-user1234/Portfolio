import pandas as pd
from datetime import datetime

# On va créer une fonction pour enregistrer les modifications réalisées
# Cela nous permettra de garder une trace des changements qu'on effectue

def enregistrer_modification(description):
    """
    Ici, on consigne une description des changements dans un fichier journal.

    Paramètres:
    description (str): C'est la description des ajustements réalisés.
    """
    with open("journal_des_modifications.txt", "a", encoding="utf-8") as fichier_log:
        fichier_log.write(description + "\n")

# D'abord, on charge nos fichiers CSV dans des DataFrames
# Ce sera la base de nos opérations de nettoyage et transformation
donnees_hospital = pd.read_csv("hospital_data.csv")
donnees_hospital_supplementaires = pd.read_csv("additional_hospital_data.csv")

enregistrer_modification("Les fichiers CSV ont été chargés dans des DataFrames.")

# Maintenant, on va supprimer les lignes où des données importantes manquent
# Par exemple, si 'Diagnosis' ou 'TreatmentCost' est vide, on enlève ces lignes
donnees_hospital = donnees_hospital.dropna(subset=["Diagnosis", "TreatmentCost"])
donnees_hospital_supplementaires = donnees_hospital_supplementaires.dropna(subset=["Diagnosis", "TreatmentCost"])

enregistrer_modification("Les lignes avec des données manquantes dans 'Diagnosis' ou 'TreatmentCost' ont été supprimées.")

# Ici, on va nettoyer la colonne 'Diagnosis'
# On met tout en majuscule et on enlève les espaces inutiles
donnees_hospital["Diagnosis"] = donnees_hospital["Diagnosis"].str.upper().str.strip()
donnees_hospital_supplementaires["Diagnosis"] = donnees_hospital_supplementaires["Diagnosis"].str.upper().str.strip()

enregistrer_modification("La colonne 'Diagnosis' a été uniformisée.")

# On s'occupe maintenant des dates pour les convertir dans un format lisible (DD/MM/YYYY)
donnees_hospital["DOB"] = pd.to_datetime(donnees_hospital["DOB"], errors="coerce").dt.strftime("%d/%m/%Y")
donnees_hospital["LastVisit"] = pd.to_datetime(donnees_hospital["LastVisit"], errors="coerce").dt.strftime("%d/%m/%Y")
donnees_hospital_supplementaires["DOB"] = pd.to_datetime(donnees_hospital_supplementaires["DOB"], errors="coerce").dt.strftime("%d/%m/%Y")
donnees_hospital_supplementaires["LastVisit"] = pd.to_datetime(donnees_hospital_supplementaires["LastVisit"], errors="coerce").dt.strftime("%d/%m/%Y")

enregistrer_modification("Les colonnes de dates ont été transformées au format DD/MM/YYYY.")

# Maintenant, on remplit les valeurs manquantes dans les colonnes clés
# Pour 'Diagnosis', on met 'Inconnu' par défaut
# Pour 'TreatmentCost', on calcule la moyenne pour remplacer les valeurs vides
donnees_hospital["Diagnosis"] = donnees_hospital["Diagnosis"].fillna("Inconnu")
donnees_hospital_supplementaires["Diagnosis"] = donnees_hospital_supplementaires["Diagnosis"].fillna("Inconnu")

donnees_hospital["TreatmentCost"] = donnees_hospital["TreatmentCost"].fillna(donnees_hospital["TreatmentCost"].mean())
donnees_hospital_supplementaires["TreatmentCost"] = donnees_hospital_supplementaires["TreatmentCost"].fillna(donnees_hospital_supplementaires["TreatmentCost"].mean())

enregistrer_modification("Les valeurs manquantes ont été remplies dans 'Diagnosis' et 'TreatmentCost'.")

# On fixe une valeur par défaut pour 'LastVisit' pour éviter des trous
donnees_hospital["LastVisit"] = donnees_hospital["LastVisit"].fillna("31/12/2024")
donnees_hospital_supplementaires["LastVisit"] = donnees_hospital_supplementaires["LastVisit"].fillna("31/12/2024")

enregistrer_modification("Une date par défaut a été appliquée pour 'LastVisit'.")

# Sauvegardons les fichiers nettoyés pour ne pas perdre notre travail
donnees_hospital.to_csv("hospital_nettoyer.csv", index=False)
donnees_hospital_supplementaires.to_csv("additionnal_hospital_nettoyer.csv", index=False)

enregistrer_modification("Les fichiers nettoyés ont été enregistrés.")

# On ajoute une colonne 'Age' pour calculer l'âge à partir de 'DOB'
date_actuelle = datetime.now()

donnees_hospital["Age"] = pd.to_datetime(donnees_hospital["DOB"], errors="coerce", format="%d/%m/%Y").apply(
    lambda x: date_actuelle.year - x.year if pd.notnull(x) else None
)
donnees_hospital_supplementaires["Age"] = pd.to_datetime(donnees_hospital_supplementaires["DOB"], errors="coerce", format="%d/%m/%Y").apply(
    lambda x: date_actuelle.year - x.year if pd.notnull(x) else None
)

enregistrer_modification("On a ajouté une colonne 'Age' dans les deux DataFrames.")

# Ajoutons maintenant une colonne 'Statut' qui indique si le patient est sain ou malade
donnees_hospital["Statut"] = donnees_hospital["Diagnosis"].apply(lambda x: "Sain" if x == "HEALTHY" else "Malade")
donnees_hospital_supplementaires["Statut"] = donnees_hospital_supplementaires["Diagnosis"].apply(lambda x: "Sain" if x == "HEALTHY" else "Malade")

enregistrer_modification("La colonne 'Statut' a été créée pour indiquer l'état de santé.")

# Passons à la fusion des deux DataFrames
# On va les réunir en utilisant la colonne 'PatientID'
donnees_fusionnees = pd.merge(donnees_hospital, donnees_hospital_supplementaires, on="PatientID", how="outer", suffixes=("_df1", "_df2"))

enregistrer_modification("On a fusionné les deux DataFrames grâce à 'PatientID'.")

# Gérons les doublons après la fusion
# Par exemple, on combine les colonnes 'Name', 'DOB', etc.
donnees_fusionnees["Nom"] = donnees_fusionnees["Name_df1"].fillna(donnees_fusionnees["Name_df2"])
donnees_fusionnees["DOB"] = donnees_fusionnees["DOB_df1"].fillna(donnees_fusionnees["DOB_df2"])
donnees_fusionnees["Diagnosis"] = donnees_fusionnees["Diagnosis_df1"].fillna(donnees_fusionnees["Diagnosis_df2"])
donnees_fusionnees["LastVisit"] = donnees_fusionnees["LastVisit_df1"].fillna(donnees_fusionnees["LastVisit_df2"])
donnees_fusionnees["TreatmentCost"] = donnees_fusionnees["TreatmentCost_df1"].fillna(donnees_fusionnees["TreatmentCost_df2"])
donnees_fusionnees["Age"] = donnees_fusionnees["Age_df1"].fillna(donnees_fusionnees["Age_df2"])
donnees_fusionnees["Statut"] = donnees_fusionnees["Statut_df1"].fillna(donnees_fusionnees["Statut_df2"])

# On supprime les colonnes en doublon qui ne sont plus utiles
donnees_fusionnees = donnees_fusionnees.drop(columns=[
    "Name_df1", "DOB_df1", "Diagnosis_df1", "LastVisit_df1", "TreatmentCost_df1", "Age_df1", "Statut_df1",
    "Name_df2", "DOB_df2", "Diagnosis_df2", "LastVisit_df2", "TreatmentCost_df2", "Age_df2", "Statut_df2"
])

enregistrer_modification("Les colonnes en doublon ont été supprimées après la fusion.")

# Enfin, on sauvegarde les données fusionnées dans un nouveau fichier
donnees_fusionnees.to_csv("donnees_hopital_final.csv", index=False)

enregistrer_modification("Les données fusionnées ont été enregistrées dans 'donnees_hopital_final.csv'.")