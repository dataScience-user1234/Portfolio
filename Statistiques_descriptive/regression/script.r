#importation des donne
data <- read.csv("donne.csv")

#vérification des donne
str(data)
summary(data)
head(data)

# Conversion de 'quartier' en facteur
data$quartier <- as.factor(data$quartier)

# Visualisations
hist(data$loyer, main = "Répartition des loyers", xlab = "Loyer")
boxplot(loyer ~ quartier, data = data, main = "Loyer selon le quartier")

# Régression simple : Loyer ~ Superficie
mod1 <- lm(loyer ~ superficie, data = data)
summary(mod1)

# Régression multiple : Loyer ~ Superficie + Nb pièces + Quartier
mod2 <- lm(loyer ~ superficie + nb_pieces + quartier, data = data)
summary(mod2)

# Comparaison des modèles
anova(mod1, mod2)


etudiants <- read.csv("Appartement_Etudiant_Promo_nettoye.csv")

# Vérifier la structure
str(etudiants)


# Convertir 'quartier' en facteur avec les mêmes niveaux que dans ton modèle
etudiants$quartier <- as.factor(etudiants$quartier)
levels(etudiants$quartier) <- levels(data$quartier)


# Prédire le loyer avec mod2
pred <- predict(mod2, newdata = etudiants)

# Comparer prédictions et loyers réels
comparaison <- data.frame(
  loyer_reel = etudiants$loyer,
  loyer_pred = pred
)

# Calculer l'erreur
comparaison$erreur <- comparaison$loyer_reel - comparaison$loyer_pred
print(comparaison)

rmse <- sqrt(mean(comparaison$erreur^2))
print(paste("Erreur quadratique moyenne (RMSE) :", round(rmse, 2)))

