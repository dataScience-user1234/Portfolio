**Ma Collection Privée - MET Museum API**

Pour visiter la galerie : 
(https://dataScience-user1234.github.io/Portfolio/Technologie_web/Projet_musee_API/)

Ce projet est une application Python qui interagit avec l'API publique du **Metropolitan Museum of Art (MET)** de New York. L'objectif est d'extraire des données sur des peintures européennes et de générer automatiquement une galerie web pour les exposer.

**Objectifs**
* Comprendre et manipuler une API REST publique.
* Traiter des données au format JSON.
* Automatiser la création d'une page web dynamique avec Python.

**Pipeline de données**

Le projet est divisé en trois scripts Python distincts qui s'exécutent à la suite :

1. **`1_musee.py`:** Interroge l'API pour récupérer la liste des départements du musée et cibler celui des "Peintures Européennes".
2. **`2_europeanPaintings.py`:** Récupère une sélection d'œuvres, interroge l'API pour obtenir leurs détails précis (Titre, Artiste, URL de l'image), et sauvegarde ces données brutes dans le fichier `ma_data.json`.
3. **`3_site.py`:** Lit le fichier JSON et génère automatiquement le fichier final `index.html` contenant le design et la structure de la galerie web.