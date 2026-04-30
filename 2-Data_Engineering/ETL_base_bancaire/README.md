**Refonte d'une Base de Données Bancaire (SAE 2-01)**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre de la SAE 2-01 du BUT Science des Données. L'objectif était d'accompagner la transformation numérique d'une agence bancaire en migrant son système de gestion, basé sur un fichier plat rudimentaire, vers une base de données relationnelle robuste sous PostgreSQL.

**Contexte et Travail Effectué**

Pour mener à bien cette migration de type ETL (Extract, Transform, Load), j'ai conçu une architecture de données complète (MCD et MLD) respectant les formes normales (3FN). Le processus s'est déroulé en trois grandes étapes :

1. Nettoyage des données : Création d'un script Python (avec Pandas) pour corriger les incohérences de formatage du fichier brut, notamment sur les dates de naissance et les dates d'opérations.
2. Structuration : Écriture d'un script SQL pour créer les tables définitives (clients, agents, comptes, mouvements, parrainages) avec toutes les contraintes d'intégrité associées (clés primaires/étrangères, types de données adaptés comme BIGINT pour les numéros de compte).
3. Intégration : Importation du fichier nettoyé dans une table temporaire, puis élaboration d'un script de requêtes SQL complexes (utilisant SELECT DISTINCT ON) pour ventiler et insérer proprement les données dans les tables cibles sans créer de doublons. 

Enfin, j'ai développé des vues SQL spécifiques pour générer des tableaux de bord automatisés à destination de la direction (suivi des comptes dormants et état annuel des parrainages).

**Contenu du dossier**

* `Rapport.pdf` : Mon rapport de projet incluant le Modèle Conceptuel de Données (MCD), le Modèle Logique de Données (MLD) et les explications des choix d'architecture.
* `nettoyage_donnees.py` : Le script Python de préparation et de standardisation des données brutes.
* `script_table_vues.sql` : Le script de création du schéma relationnel (tables, contraintes) et des vues d'analyse.
* `alimentation_table.sql` : Le script de ventilation des données depuis la zone d'attente (table temporaire) vers les tables finales.
* `sae_donnees_bancaires.csv` : Le fichier d'origine de la banque contenant les données non structurées.
* `sae_donnees_bancaires_nettoyee.csv` : Le fichier propre généré par le script Python, prêt à être importé dans PostgreSQL.
* `Projet.pdf` : Le cahier des charges initial du projet.

**Ordre d'exécution recommandé pour tester le projet**

1. Lancer `nettoyage_donnees.py` pour générer le CSV propre.
2. Exécuter `script_table_vues.sql` dans PostgreSQL pour créer l'architecture.
3. Importer le CSV propre dans la table temporaire via la commande : `\copy TABLE_TEMPORAIRE FROM 'sae_donnees_bancaires_nettoyee.csv' DELIMITER ',' CSV HEADER;`
4. Exécuter `alimentation_table.sql` pour peupler définitivement la base de données.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>