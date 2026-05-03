#!/usr/bin/env python3

import numpy
import hashlib
import time
import string
import random

def generate(alphabet, max_len):
    if max_len <= 0:
        return
    for c in alphabet:
        yield c
    for c in alphabet:
        for next in generate(alphabet, max_len-1):
            yield c + next


if __name__ == "__main__":
# On initialise le générateur pseudo-aléatoire avec l'heure
 numpy.random.seed(int(time.time()))
# Tester la fonction generate
 #for i in generate(string.ascii_lowercase,2):
 # print(i)
 
 alphabet = string.printable # -- modification ici avec string.ascii_lowercase/uppercase/letter
 # index_aleatoire = random.randint(0,51) 
 mdp_secret = random.choice(alphabet) + random.choice(alphabet)
 print(f"Le mot de passe secret choisi au hasard est : {mdp_secret}")

#2 ------ SHA256
#Coder la chaine en octects (bytes) avant de hacher
 mdp_bytes = mdp_secret.encode("utf_8")

#Calculer le haché SHA256 et stockez le
 hashtest = hashlib.sha256(mdp_bytes).hexdigest()
 print(f"Le haché à craquer (hashtest) est : {hashtest}")

#3 ----- Boucle pour trouver le mdp
 print("\nLancement de l'attaque par force brute...")


#4 Démarre le chrono
 start_time = time.time()
 for proposition in generate(string.printable, 2): # -- et ici modification
   proposition_bytes = proposition.encode('utf-8')
   hache_calcule = hashlib.sha256(proposition_bytes).hexdigest()

 # (a) Comparer au haché de test 
   if hache_calcule == hashtest:
 
 # (b) Correspondance trouvée ! 
    print(f"Mot de passe TROUVÉ ! C'était : '{proposition}'")
 
 # Étape 4: Arrêter le chrono et calculer le temps 
    end_time = time.time()
    temps_ecoule = end_time - start_time
    print(f"Temps nécessaire : {temps_ecoule:.6f} secondes")
 
 # Stopper la boucle, on a trouvé 
    break

