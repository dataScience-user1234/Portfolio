**Régression sur Données Réelles : Analyse des Loyers à Aurillac**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé en équipe dans le cadre de la SAE 2.03 du BUT Science des Données. L'objectif était d'appliquer des méthodes de modélisation statistique sur un jeu de données réel pour comprendre et prédire le marché immobilier local.

**Contexte et Travail Effectué**

Notre étude s'est concentrée sur l'identification des facteurs influençant le loyer mensuel des logements à Aurillac. En utilisant le langage R, nous avons d'abord exploré un jeu de données de 92 logements, ce qui nous a permis de réaliser des visualisations et de construire deux modèles statistiques : une régression linéaire simple (basée uniquement sur la superficie) et une régression linéaire multiple (intégrant la superficie, le nombre de pièces et le quartier).

Pour aller plus loin et tester la robustesse de notre modèle final, nous avons mené notre propre enquête auprès des étudiants de notre promotion pour constituer un second jeu de données. Nous avons ensuite utilisé notre modèle pour prédire leurs loyers et calculé la marge d'erreur entre nos prédictions et la réalité, ce qui nous a permis de tirer des conclusions objectives sur les limites de notre modélisation.

**Contenu du dossier**

* `rapport.pdf` : Notre compte-rendu détaillant l'analyse exploratoire, la comparaison des modèles de régression et l'évaluation des erreurs de prédiction.
* `script.r` : Le script R contenant l'importation des données, la création des graphiques, l'entraînement des modèles et les tests sur les nouvelles données.
* `nettoyage.py` : Le script Python développé pour nettoyer, formater et préparer les données brutes issues de notre questionnaire avant leur analyse dans R.
* `donne.csv` : Le jeu de données initial fourni (92 logements) utilisé pour l'entraînement de nos modèles.
* `Appartement_Etudiant_Promo.csv` : Les réponses brutes issues du questionnaire que nous avons diffusé aux étudiants.
* `Appartement_Etudiant_Promo_nettoye.csv` : Le jeu de données de l'enquête après traitement par notre script Python, prêt pour l'étape de prédiction.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>