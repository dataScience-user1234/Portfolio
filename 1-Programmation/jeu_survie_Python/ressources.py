"""
Module pour gerer les ressources du camp : eau, nourriture et munitions
Contient les fonctions pour ajouter, consommer et vérifier les ressources disponibles
"""

import random

def initialiser_ressources():
    """Initialise les ressources de départ du camp"""
    return {"eau": 10, "nourriture": 10, "munitions": 5}

def afficher_ressources(ressources):
    """Affiche les ressources actuelles du camp"""
    print("\n--- Ressources ---")
    for k, v in ressources.items():
        print(f"{k.capitalize()} : {v}")

def chercher_ressources(ressources, survivants):
    """Ajoute des ressources aléatoirement trouvées lors d'une expédition"""
    eau = sum(1 for _ in survivants)
    nourriture = sum(1 for _ in survivants)
    munitions = sum(1 for _ in survivants if random.random() < 0.5)
    print(f"Vous avez trouvé {eau} eau, {nourriture} nourriture, {munitions} munitions.")
    ressources["eau"] += eau
    ressources["nourriture"] += nourriture
    ressources["munitions"] += munitions
    return ressources

def consommer_ressources(ressources, nb_survivants):
    """Consomme des ressources à chaque tour. Avertit si elles sont insuffisantes."""
    ressources["eau"] -= nb_survivants
    ressources["nourriture"] -= nb_survivants
    if ressources["eau"] < 0 or ressources["nourriture"] < 0:
        print("Les survivants manquent de ressources ! Ils perdent de la vie.")
        ressources["eau"] = max(0, ressources["eau"])
        ressources["nourriture"] = max(0, ressources["nourriture"])
    return ressources
