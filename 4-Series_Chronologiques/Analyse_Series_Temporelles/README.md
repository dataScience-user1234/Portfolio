**Analyse et Prévision de Séries Temporelles (SAE 3-03)**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet a été réalisé dans le cadre de la SAE 3-03 du BUT Science des Données. L'objectif était d'analyser la dynamique de perte de poids d'un patient lors d'un protocole expérimental (régime et thérapie), d'en extraire la tendance réelle, et de modéliser des prévisions.

**Contexte et Méthodologie**

Les données temporelles présentaient une difficulté majeure : les pesées étaient effectuées à des heures aléatoires, introduisant un biais lié à la variation naturelle du poids au cours d'une journée. Pour isoler la véritable perte de masse grasse, nous avons mis en place une méthodologie rigoureuse sous **R** :

*   **Prétraitement et Lissage LOESS :** Utilisation de données à haute fréquence ("Phase 1") pour estimer et modéliser la variation intra-journalière du poids via une régression locale (LOESS).
*   **Désaisonnalisation :** Soustraction de cet effet journalier sur les données de la "Phase 2" pour obtenir le poids corrigé et calculer la masse grasse réelle.
*   **Détection de Rupture Structurelle :** Application du **Test de Chow** (package `gap`) pour prouver statistiquement l'existence d'une cassure de tendance dans la dynamique corporelle (identifiée autour du 2 avril).
*   **Modélisation et Prévision (Forecasting) :** Ajustement de deux modèles de régression linéaire segmentés (avant et après la cassure) pour prévoir la perte de masse grasse (estimée à 1,80 kg) si le régime avait été prolongé de 3 jours.

**Contenu du dossier**

*   `TP_Projet.R` : Le script R contenant les étapes de nettoyage, l'application du LOESS, le test de Chow et les prévisions.
*   `rapport.pdf` : Le rapport d'étude détaillant les problématiques, l'interprétation des graphiques et la conclusion générale.
*   `phase_1.csv` & `phase_2.csv` : Les jeux de données bruts issus du protocole expérimental.
*   `projet.pdf` : Le sujet de l'étude détaillant le contexte du protocole expérimental.

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>