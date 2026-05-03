**Stéganographie : Dissimulation de message dans une image**

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>

Ce projet porte sur la stéganographie, une technique consistant à dissimuler un message à l'intérieur d'un autre média, ici une image, de manière totalement invisible à l'œil nu.

**Contexte et Travail Effectué**

J'ai développé un script en Python permettant d'appliquer la méthode du bit de poids faible (LSB - Least Significant Bit). Le principe consiste à transformer un message textuel en binaire, puis à modifier le dernier bit du canal rouge de chaque pixel de l'image pour y injecter l'information. 

Le travail a consisté à :
* Concevoir un algorithme de conversion de texte en flux binaire (8 bits par caractère).
* Implémenter la fonction d'insertion du message dans les pixels de l'image support sans dégrader sa qualité visuelle.
* Intégrer un marqueur de fin de message spécifique pour permettre une extraction précise.
* Créer la fonction de décodage capable de lire les bits de poids faible et de reconstituer le message original à partir de l'image modifiée.

**Outils Utilisés**
* **Python :** Langage utilisé pour le développement de l'outil.
* **Pillow (PIL) :** Bibliothèque pour le traitement et la manipulation d'images.
* **Numpy :** Pour la gestion optimisée des pixels sous forme de tableaux.

**Contenu du dossier**
* `tp4.py` : Le script Python complet incluant les fonctions de dissimulation et d'extraction.
* `image1.jpg` : L'image d'origine avant traitement.
* `image_changee.jpg` : L'image contenant le message secret "Bonjour, je suis Abdallah Remmide :)".

<div align="center">
  <img height="50" width="100%" src="https://raw.githubusercontent.com/Sabyasachi-Seal/Sabyasachi-Seal/ouput/divider.gif">
</div>