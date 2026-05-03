
# Lecture des deux fichiers CSV
phase1 = read.csv("phase_1.csv", sep = ";", stringsAsFactors = FALSE)
phase2 = read.csv("phase_2.csv", sep = ";", stringsAsFactors = FALSE)

# Correction des dates
phase1$Jour = as.Date(phase1$Jour, format = "%d/%m/%y")
phase2$Jour = as.Date(phase2$Jour, format = "%Y/%m/%d")

# Correction des virgules en points pour Poids
phase1$Poids = as.numeric(gsub(",", ".", phase1$Poids))
phase2$Poids = as.numeric(gsub(",", ".", phase2$Poids))

# Correction des virgules en points pour Graisse dans phase deux
phase2$Graisse = as.numeric(gsub(",", ".", phase2$Graisse_.))

# Fonction de conversion qui prend en compte toutes les heures
extraire_heure = function(h) {
  if(is.na(h) || h == "") return(NA)
  
  morceaux = strsplit(h, "h")[[1]]
  
  # Extraction de l'heure
  heure = as.numeric(morceaux[1])
  
  # Extraction des minutes
  # Si aucune minute apres le h, on met 0 par defaut
  if(length(morceaux) < 2 || morceaux[2] == "") {
    minute = 0
  } else {
    minute = as.numeric(morceaux[2])
  }
  
  # Conversion en heure numerique
  return(heure + minute / 60)
}

# Application sur les deux fichiers
phase1$HeureNum = sapply(phase1$Heure, extraire_heure)
phase2$HeureNum = sapply(phase2$Heure, extraire_heure)

# Verification
head(phase1[, c("Heure", "HeureNum")], 20)
head(phase2[, c("Heure", "HeureNum")], 20)

# Etape deux Estimation de la variation moyenne du poids dans une journee

# Selection des lignes valides dans la phase un
# On garde uniquement les lignes avec Poids et HeureNum non manquants
phase1_valide = phase1[!is.na(phase1$Poids) & !is.na(phase1$HeureNum), ]

# Application du lissage LOESS selon le tutoriel pratique un
modele_loess = loess(Poids ~ HeureNum, data = phase1_valide, span = 0.6)
# Ajout des valeurs lissees dans la table
phase1_valide$PoidsLisse = modele_loess$fitted

# Tri des donnees pour tracer une courbe continue
phase1_trie = phase1_valide[order(phase1_valide$HeureNum), ]

# Affichage d'un apercu des resultats
head(phase1_trie[, c("HeureNum", "Poids", "PoidsLisse")], 15)

# Graphique LOESS propre
plot(phase1_trie$HeureNum, phase1_trie$Poids,
     xlab = "Heure numerique",
     ylab = "Poids",
     main = "Lissage du poids dans la journee par LOESS")

lines(phase1_trie$HeureNum, phase1_trie$PoidsLisse, col = "red", lwd = 2)



# Etape trois Correction des poids de la phase deux pour enlever l'effet de l'heure

# Moyenne de la serie lisse de la premiere phase
moyenne_lissee = mean(phase1_valide$PoidsLisse, na.rm = TRUE)

# Valeur lisse de reference pour chaque heure de la phase deux
phase2$PoidsLisse = predict(modele_loess,
                            newdata = data.frame(HeureNum = phase2$HeureNum))

# Ecart entre la valeur lisse a cette heure et la moyenne sur la journee
phase2$EcartHeure = phase2$PoidsLisse - moyenne_lissee

# Poids corrige qui correspond au poids moyen de la journee
phase2$PoidsCorrige = phase2$Poids - phase2$EcartHeure

# Verification des premiers resultats
head(phase2[, c("Jour", "Heure", "Poids", "PoidsLisse", 
                "EcartHeure", "PoidsCorrige")], 10)



# Etape quatre Calcul de la masse grasse en kilogramme pendant la seconde phase

# Conversion du pourcentage en proportion
phase2$GraisseProportion = phase2$Graisse / 100

# Masse grasse en kilogramme
phase2$MasseGrasseKg = phase2$PoidsCorrige * phase2$GraisseProportion

# Verification des premiers resultats
head(phase2[, c("Jour", "PoidsCorrige", "Graisse", 
                "GraisseProportion", "MasseGrasseKg")], 10)


#ETAPE  Evolution de la masse grasse pendant la phase deux

plot(phase2$Jour, phase2$MasseGrasseKg, type = "l",
     xlab = "Jour", ylab = "Masse grasse (kg)",
     main = "Evolution de la masse grasse pendant la phase deux")

# Test de chow pour valider notre intuition

library(gap)

y = phase2$MasseGrasseKg
x = 1:length(y)
n = length(y)

chow_pvalues = rep(NA, n)

for(t0 in 2:(n-2)){
  x1 = matrix(x[1:t0], ncol = 1)
  y1 = y[1:t0]
  x2 = matrix(x[-(1:t0)], ncol = 1)
  y2 = y[-(1:t0)]
  res = chow.test(y1, x1, y2, x2)
  chow_pvalues[t0] = res[4]
}

# POINT DE CASSURE AUTOMATIQUE
index_cassure = which.min(chow_pvalues)
index_cassure


# Graphique des log p-values
plot(log(chow_pvalues), main = "Test de cassure sur la masse grasse",
     xlab = "Index du jour", ylab = "log(p-value)")


# Graphique de la masse grasse avec cassure indiquee

plot(phase2$Jour, phase2$MasseGrasseKg, type = "l",
     xlab = "Jour", ylab = "Masse grasse (kg)",
     main = "Evolution de la masse grasse avec cassure detectee")

# Jour de cassure detecte
index_cassure = 10
abline(v = phase2$Jour[index_cassure], col = "red", lwd = 2)




# Point de cassure détecté automatiquement


index_cassure = 10   # résultat du test de Chow


# Séparation des données en deux segments


data_avant = phase2[1:index_cassure, ]
data_apres = phase2[index_cassure:nrow(phase2), ]


# Ajustement des deux modèles linéaires

# modèle avant casure
reg_avant = lm(MasseGrasseKg ~ Jour, data = data_avant)
# modèle après casure
reg_apres = lm(MasseGrasseKg ~ Jour, data = data_apres)


# Représentation graphique claire


plot(phase2$Jour, phase2$MasseGrasseKg, pch = 16,
     xlab = "Jour", ylab = "Masse grasse (kg)",
     main = "Deux regressions lineaires (cassure = t0)")

lines(data_avant$Jour, predict(reg_avant), col = "blue", lwd = 3)
lines(data_apres$Jour, predict(reg_apres), col = "red", lwd = 3)

abline(v = phase2$Jour[index_cassure], col = "black", lwd = 2, lty = 2)

legend("topright", legend = c("Avant cassure", "Apres cassure"),
       col = c("blue","red"), lty = 1, lwd = 3)

# Créer les 3 jours futurs
jours_futurs = seq(max(phase2$Jour) + 1, by = 1, length.out = 3)

# Prédictions (en utilisant le modèle après cassure)
predictions = predict(reg_apres,
                      newdata = data.frame(Jour = jours_futurs))

predictions

# Quantité de masse grasse perdue supplémentaire


mg_actuelle = tail(phase2$MasseGrasseKg, 1)
mg_future = tail(predictions, 1)

perte_supplementaire = mg_actuelle - mg_future
perte_supplementaire

