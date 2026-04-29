"""
Module pour gérer les attaques de zombies contre le camp.
Contient les fonctions pour simuler les attaques, calculer les combats avec ou sans munitions et appliquer les dégâts aux survivants.
"""

import random

def attaque_horde(survivants, ressources):
    """Gère une attaque de zombies contre le camp."""
    taille_horde = random.randint(3, 7)
    print(f"\nUne horde de {taille_horde} zombies attaque le camp !")

    if ressources["munitions"] >= taille_horde:
        print("Les survivants utilisent leurs munitions pour repousser la horde.")
        ressources["munitions"] -= taille_horde
    else:
        restants = taille_horde - ressources["munitions"]
        ressources["munitions"] = 0
        print(f"Pas assez de munitions ! Les survivants doivent se battre à main nue contre {restants} zombies.")
        for _ in range(restants):
            if survivants:
                cible = random.choice(survivants)
                if random.random() > (cible["precision"] / 10):
                    degats = random.randint(10, 30)
                    cible["sante"] -= degats
                    print(f"{cible['nom']} a été blessé ! -{degats} HP")
                else:
                    print(f"{cible['nom']} esquive l'attaque.")
    return survivants
