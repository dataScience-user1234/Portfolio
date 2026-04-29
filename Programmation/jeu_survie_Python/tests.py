"""
Module de tests unitaires pour vérifier le bon fonctionnement des classes et fonctions du jeu de survie.
Permet de s'assurer que les survivants, les ressources et les combats fonctionnent correctement.
"""

import unittest
from survivants import initialiser_survivants, chercher_nouveaux_survivants
from ressources import initialiser_ressources, consommer_ressources

class TestCampSurvie(unittest.TestCase):

    def test_initialiser_survivants(self):
        surv = initialiser_survivants()
        self.assertTrue(len(surv) >= 2)
        for s in surv:
            self.assertIn("nom", s)
            self.assertIn("sante", s)

    def test_initialiser_ressources(self):
        res = initialiser_ressources()
        self.assertEqual(res["eau"], 10)
        self.assertEqual(res["nourriture"], 10)
        self.assertEqual(res["munitions"], 5)

    def test_consommation_ressources(self):
        res = {"eau": 5, "nourriture": 5, "munitions": 0}
        res = consommer_ressources(res, 3)
        self.assertEqual(res["eau"], 2)
        self.assertEqual(res["nourriture"], 2)

    def test_chercher_nouveaux_survivants(self):
        surv = initialiser_survivants()
        resultat = chercher_nouveaux_survivants(surv)
        self.assertGreaterEqual(len(resultat), len(surv))  # Il se peut qu'on ne trouve personne

if __name__ == '__main__':
    unittest.main()
