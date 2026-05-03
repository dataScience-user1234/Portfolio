**Conception d'un Système d'Information Décisionnel et ETL - Talend**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre de la SAE 3-02 du BUT Science des Données. L'objectif principal était de concevoir et mettre en œuvre un Système d'Information Décisionnel (SID) complet à partir d'une base de données opérationnelle (SIO).

**Contexte et Méthodologie de Travail**

Notre mission consistait à restructurer les données d'une entreprise de vente en ligne pour répondre aux besoins d'aide à la décision de deux services métiers spécifiques : le service finances (analyse des ventes) et le service logistique (gestion des livraisons). 

Pour mener à bien cette intégration de données dans un Data Warehouse, nous avons suivi une méthodologie stricte :

*   **Analyse du SIO :** Nous avons étudié le Modèle Conceptuel de Données (MCD) de la base de données transactionnelle source pour en comprendre la structure et les limites analytiques.
*   **Modélisation Décisionnelle :** Nous avons conçu un schéma en étoile en créant deux tables de faits (`fait_ventes` et `fait_livraisons`) et plusieurs tables de dimensions (`dim_client`, `dim_produit`, `dim_employe`, `dim_messager`).
*   **Processus ETL avec Talend :** Nous avons mis en place des flux d'Extraction, Transformation et Chargement (ETL) à l'aide de l'outil Talend. Le composant `tMap` a été central pour nettoyer, formater et router les données opérationnelles vers le SID tout en garantissant leur cohérence.
*   **Reporting Décisionnel :** Nous avons rédigé des requêtes SQL (sous forme de vues) permettant d'extraire des indicateurs clés (chiffre d'affaires par catégorie, taux de retard par transporteur, frais de port par pays) à destination d'outils de restitution comme Excel pour orienter les décisions de gestion.

**Contenu du dossier**

*   `Rapport.pdf` : Notre rapport complet détaillant le passage du SIO au SID, les captures d'écran des jobs Talend, et l'explication des décisions de gestion associées à chaque requête de reporting.
*   `creation_SIO.sql` : Le script PostgreSQL initial permettant de créer et de peupler la base de données opérationnelle.
*   `creation_SID.sql` : Le script contenant la création des tables de faits et de dimensions de notre Data Warehouse, ainsi que l'ensemble de nos requêtes de reporting.
*   `reporting.sql` : Les requêtes d'analyse métier (vues SQL) calculant les indicateurs finaux pour les tableaux de bord des services finances et logistique.
*   `consignes.txt` : Le cahier des charges énumérant les étapes de conception et les livrables attendus.
*   `projet.pdf` : Le sujet de travaux pratiques détaillant le cas concret de l'entreprise et la structure initiale de la base de données.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>