**Nettoyage et Fusion de Données Hospitalières en Python**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre de la SAE 1.02 du BUT Science des Données. L'objectif était de développer un script Python capable de lire, nettoyer, transformer et fusionner plusieurs sources de données brutes pour les rendre exploitables et prêtes à l'analyse.

**Contexte et Méthodologie de Travail**

Nous avons travaillé sur des dossiers de patients issus de deux bases de données distinctes d'une organisation de santé. Le but était de consolider ces informations (diagnostics, coûts de traitement, dates de visite) pour optimiser la gestion future des traitements.

Pour accomplir cette mission, nous avons développé un pipeline de traitement de données utilisant **Python et la bibliothèque Pandas** :

1. **Nettoyage et Standardisation :** Traitement des valeurs manquantes (suppression des lignes critiques incomplètes, imputation par la moyenne pour les coûts), uniformisation des chaînes de caractères (diagnostics en majuscules sans espaces superflus) et formatage rigoureux des dates au format européen (`DD/MM/YYYY`).
2. **Feature Engineering (Enrichissement) :** Création de nouvelles variables analytiques, notamment le calcul automatique de l'`Age` des patients à partir de leur date de naissance, et l'attribution d'un `Statut` (Sain/Malade) basé sur les règles métiers.
3. **Fusion et Déduplication :** Jointure externe (`pd.merge`) des deux jeux de données sur l'identifiant patient (`PatientID`), suivie d'une consolidation manuelle des colonnes en doublon (nom, dates, etc.) pour obtenir une base unique et propre.
4. **Traçabilité :** Implémentation d'une fonction de journalisation générant un fichier texte (`journal_des_modifications.txt`) pour historiser chaque étape de transformation appliquée aux données.

**Contenu du dossier**

* `nettoyage_hopital.py` : Le script Python abondamment commenté contenant toute la logique de nettoyage et de fusion (initialement nommé script.txt).
* `hospital_data.csv` et `additional_hospital_data.csv` : Les deux jeux de données bruts d'origine.
* `hospital_nettoyer.csv` et `additionnal_hospital_nettoyer.csv` : Les fichiers de données de transition après la phase de nettoyage.
* `donnees_hopital_final.csv` : Le fichier cible final, propre, enrichi et fusionné.
* `journal_des_modifications.txt` : Génération du fichier contenant toutes les modifications effectuées pendant le script python.
* `Rapport.pdf` : Notre document de synthèse expliquant nos choix d'implémentation.
* `projet.pdf` : Les consignes du projet.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>