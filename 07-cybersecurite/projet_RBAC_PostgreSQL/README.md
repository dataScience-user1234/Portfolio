**Projet Contrôle d'Accès RBAC - Base de Données Hospitalière**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre de la SAE 2.08 du BUT Science des Données. L'objectif principal est de mettre en place un système de contrôle d'accès basé sur les rôles (RBAC) au sein d'une base de données relationnelle sécurisée.

**Contexte et Travail Effectué**

Nous avons choisi de travailler sur une base de données simulant le système de gestion d'un hôpital. Notre premier travail a consisté à adapter un script SQL de création de base (initialement conçu pour Oracle) pour le rendre parfaitement fonctionnel sous PostgreSQL, en modifiant notamment les types de données et les formats de date.

Dans un second temps, nous avons analysé l'organisation de l'établissement pour identifier les différents métiers et créer des rôles précis (administrateur, médecin, infirmier, réceptionniste, pharmacien). Nous avons ensuite rédigé les scripts permettant de créer les utilisateurs, de leur attribuer ces rôles, et de définir strictement leurs privilèges (droits de lecture, d'insertion, etc.). Enfin, un scénario de test nous a permis de prouver que notre architecture garantit efficacement la sécurité et la séparation des responsabilités.

**Contenu du dossier**

* `SAE2_08_rapport.pdf` : Notre compte-rendu détaillant nos choix d'implémentation, la définition des rôles et les résultats de nos tests d'accès.
* `Projet-implementation-RBAC.pdf` : Le sujet initial présentant les consignes et les attentes du projet.
* `script_hopital_postgresql.sql` : Le script de création des tables et d'insertion des données de l'hôpital, adapté pour PostgreSQL.
* `RBAC_postgresql_script_question6.sql` : Le script de sécurité gérant la création des comptes utilisateurs, la définition des rôles et l'attribution des privilèges d'accès.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>