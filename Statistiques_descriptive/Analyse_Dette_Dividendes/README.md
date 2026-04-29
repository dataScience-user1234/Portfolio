**Analyse Statistique : Dette et Dividendes des Entreprises**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre d'un TP d'analyse statistique. L'objectif était d'étudier le comportement financier d'un panel d'entreprises, et plus particulièrement la relation entre leur niveau d'endettement et les dividendes versés.

**Contexte et Travail Effectué**

Pour cette étude, j'ai manipulé un jeu de données comportant les indicateurs financiers de 119 entreprises. En utilisant le langage R, j'ai d'abord procédé au nettoyage des données (suppression des valeurs manquantes et des dividendes nuls) avant de tracer une première régression linéaire globale.

Pour affiner l'analyse, j'ai segmenté les entreprises en deux groupes distincts à l'aide d'une droite experte. J'ai ensuite ajusté deux modèles de régression séparés pour modéliser le comportement spécifique de chaque groupe. Enfin, en calculant la distance de chaque entreprise par rapport à ces modèles, j'ai pu leur attribuer un profil statistique précis et isoler les cas atypiques (les 10 % d'entreprises les plus éloignées des prédictions) nécessitant une étude plus approfondie.

**Contenu du dossier**

* `Rapport.pdf` : Mon compte-rendu détaillant la démarche d'analyse, les graphiques générés, la méthode de segmentation et l'interprétation des résultats.
* `tp3.R` : Le script R contenant l'intégralité du code pour le nettoyage, la création des modèles, les calculs de distance et la détection des valeurs atypiques.
* `CACPME.csv` : Le jeu de données financier brut utilisé pour cette étude.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>