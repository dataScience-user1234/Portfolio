# 🏛️ Ma Collection Privée - MET Museum API

> **🌍 Voir le projet en ligne :** [Cliquez ici pour visiter la galerie](https://dataScience-user1234.github.io/Portfolio/Projet_musee_API) *(N'oublie pas de remplacer ce lien par le tien !)*

Ce projet est une application Python qui interagit avec l'API publique du **Metropolitan Museum of Art (MET)** de New York. L'objectif est d'extraire des données sur des peintures européennes et de générer automatiquement une galerie web (HTML/CSS) pour les exposer.

## 🎯 Objectifs du projet
* Comprendre et manipuler une **API REST** publique.
* Traiter des données au format **JSON**.
* Automatiser la création d'une page web dynamique avec Python.

## ⚙️ Comment fonctionne le pipeline de données ?

Le projet est divisé en trois scripts Python distincts qui s'exécutent à la suite :

1. **`1_musee.py` (L'éclaireur) :** Interroge l'API pour récupérer la liste des départements du musée et cibler celui des "Peintures Européennes".
2. **`2_europeanPaintings.py` (Le collecteur) :** Récupère une sélection d'œuvres, interroge l'API pour obtenir leurs détails précis (Titre, Artiste, URL de l'image), et sauvegarde ces données brutes dans le fichier `ma_data.json`.
3. **`3_site.py` (Le constructeur) :** Lit le fichier JSON et génère automatiquement le fichier final `index.html` contenant le design et la structure de la galerie web.

## 🛠️ Technologies Utilisées
* **Python** (librairies `requests`, `json`)
* **HTML5 & CSS3** (Flexbox)
* **API REST** (The Metropolitan Museum of Art Collection API)

## 🚀 Exécuter le projet en local

Pour regénérer le site vous-même depuis votre terminal :
1. Lancez la récupération des données : `python 2_europeanPaintings.py`
2. Générez la page web : `python 3_site.py`
3. Ouvrez le fichier `index.html` généré dans votre navigateur !