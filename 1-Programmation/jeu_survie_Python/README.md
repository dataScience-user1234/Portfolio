**Jeu de Survie Post-Apocalyptique en Python**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre du cours de Bases de Programmation 2 du BUT Science des Données. Il s'agit d'un jeu de gestion et de survie textuel où le joueur doit maintenir un campement de survivants dans un monde infesté de zombies.

**Contexte et Travail Effectué**

J'ai conçu ce programme en adoptant une architecture modulaire pour garantir la clarté et la maintenabilité du code. Le développement a porté sur la création de plusieurs systèmes interconnectés : une boucle de jeu tour par tour, la gestion de statistiques individuelles pour les survivants (santé, force, précision), un système de ressources critiques (eau, nourriture, munitions) et un algorithme de combat simulant des attaques de hordes de zombies.

Un accent particulier a été mis sur la qualité du code à travers le respect des conventions de nommage Python, l'intégration de Docstrings pour chaque fonction et la mise en place d'une série de tests unitaires pour valider la robustesse des mécaniques de jeu (consommation des ressources, initialisation et recherche de survivants).

**Fonctionnalités Clés**
* **Gestion du Camp :** Surveillance de l'état de santé des survivants et des stocks de ressources.
* **Expéditions :** Système de choix permettant de partir en quête de vivres ou de recruter de nouveaux alliés.
* **Système de Combat :** Gestion des affrontements avec utilisation stratégique des munitions ou combat au corps à corps en cas de pénurie.
* **Survie Dynamique :** Consommation automatique des ressources et impact direct sur la santé du groupe à chaque tour.

**Contenu du dossier**
* `main.py` : Le point d'entrée du programme gérant la boucle principale et les interactions avec le joueur.
* `survivants.py` : Module dédié à la gestion des personnages et de leurs attributs.
* `ressources.py` : Logique de gestion, de collecte et de consommation des stocks du camp.
* `zombies.py` : Simulation des événements d'attaque et résolution des combats.
* `tests.py` : Suite de tests unitaires garantissant le bon fonctionnement des modules.
* `projet.pdf` : Cahier des charges et consignes officielles du projet.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>