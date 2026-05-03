Bonjour,

Voici notre projet SAE sur les monarques de France.

Pour pouvoir tester le tableau de bord directement et sans conflit de versions, on a prévu un environnement virtuel. Voici les commandes à taper dans le terminal pour tout lancer chez vous :

1. Créer l'environnement virtuel vide :
   python3 -m venv .venv

2. L'activer :
   - Windows : .\.venv\Scripts\activate
   - Mac/Linux : source .venv/bin/activate

3. Installer les dépendances :
   pip install -r requirements.txt

4. Lancer le tableau de bord :
   python3 -m streamlit run app.py

À noter : le fichier "rois_france_final.csv" est déjà inclus dans le dossier, le dashboard s'affichera donc immédiatement. Si vous souhaitez tester notre script de collecte depuis zéro, vous pouvez lancer "python ROI.py" au préalable.

Merci !