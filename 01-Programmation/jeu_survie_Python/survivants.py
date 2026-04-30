"""
Module pour gérer les survivants du camp.
Définit la classe Survivant avec ses caractéristiques et ses méthodes liées à la santé et aux combats.
"""

import random

def initialiser_survivants():
    """Crée une liste de survivants avec leurs statistiques."""
    return [
        {"nom": "Abdallah", "force": 5, "precision": 7, "sante": 100},
        {"nom": "Julve", "force": 6, "precision": 6, "sante": 100},
    ]

def afficher_survivants(survivants):
    """Affiche les informations des survivants."""
    print("\n--- Survivants ---")
    for s in survivants:
        print(f"{s['nom']} - Santé: {s['sante']} - Force: {s['force']} - Précision: {s['precision']}")

def chercher_nouveaux_survivants(survivants):
    """Tente de trouver un nouveau survivant et l'ajoute au groupe."""
    if random.random() < 0.5:
        nouveau = {
            "nom": random.choice(["Nicoli", "Chawinga", "Sawa"]),
            "force": random.randint(4, 7),
            "precision": random.randint(4, 8),
            "sante": 100
        }
        print(f"Un nouveau survivant a rejoint le camp : {nouveau['nom']}")
        survivants.append(nouveau)
    else:
        print("Aucun survivant trouvé.")
    return survivants
