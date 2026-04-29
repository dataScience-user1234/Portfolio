"""
Module principal pour gérer le jeu de survie.
Permet de lancer les différentes actions du camp à chaque tour : expédition, recherche de survivants, défense contre les zombies, etc.
"""

from survivants import initialiser_survivants, afficher_survivants, chercher_nouveaux_survivants
from ressources import initialiser_ressources, afficher_ressources, chercher_ressources, consommer_ressources
from zombies import attaque_horde

def boucle_jeu():
    """Boucle principale du jeu de survie."""
    survivants = initialiser_survivants()
    ressources = initialiser_ressources()

    tour = 1
    while survivants:
        print(f"\n--- Tour {tour} ---")
        afficher_survivants(survivants)
        afficher_ressources(ressources)

        print("\nActions disponibles :")
        print("1. Chercher des ressources")
        print("2. Chercher de nouveaux survivants")
        choix = input("Choix de l'action (1 ou 2) : ")

        if choix == "1":
            ressources = chercher_ressources(ressources, survivants)
        elif choix == "2":
            survivants = chercher_nouveaux_survivants(survivants)
        else:
            print("Action invalide. Aucun effet.")

        ressources = consommer_ressources(ressources, len(survivants))
        survivants = attaque_horde(survivants, ressources)
        survivants = [s for s in survivants if s["sante"] > 0]
        tour += 1

    print("\nTous les survivants sont morts. Fin du jeu.")

if __name__ == "__main__":
    boucle_jeu()
