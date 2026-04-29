#tp3
#1
finance <- read.csv("CACPME.csv", row.names = 1)

#2
plot(finance$Dette, finance$Dividende, 
     xlab = "Dette", ylab = "Dividende", 
     main = "Dette vs Dividende", pch = 19)

#3
finance <- finance[!is.na(finance$Dette) & 
                     !is.na(finance$Dividende) & 
                     finance$Dividende > 0, ]

#4

modele_lm <- lm(Dividende ~ Dette, data = finance)
plot(finance$Dette, finance$Dividende, 
     xlab = "Dette", ylab = "Dividende", pch = 19)
abline(modele_lm, col = "blue", lwd = 2)

#5
abline(a = 1.5, b = 0.22, col = "red", lwd = 2)

#6

finance$Dividende - (1.5 + 0.22 * finance$Dette) > 0
#ca renvoie un vecteur de TRUE/FALSE 
#indiquant si l’entreprise verse plus que ce que la droite D prédit

#7
#on cree la variable groupe
finance$groupe <- ifelse(finance$Dividende > (1.5 + 0.22 * finance$Dette),
                         "Groupe 1", "Groupe 2")


#puis on attribue les couleurs
couleurs <- ifelse(finance$groupe == "Groupe 1", "blue", "green")

#le nuage de point par groupe
plot(finance$Dette, finance$Dividende, 
     col = couleurs, pch = 19,
     xlab = "Dette", ylab = "Dividende", 
     main = "Dette vs Dividende avec segmentation par groupe")

abline(a = 1.5, b = 0.22, col = "red", lwd = 2)
#on ajoute la droite

legend("topleft", legend = c("Groupe 1", "Groupe 2"), 
       col = c("blue", "green"), pch = 19)
#on rajoute la legende pour que ce soit plus clair


#8
#on cree les deux modèles
res_lm_groupe1 <- lm(Dividende ~ Dette, data = finance[finance$groupe == "Groupe 1", ])
res_lm_groupe2 <- lm(Dividende ~ Dette, data = finance[finance$groupe == "Groupe 2", ])
#et on trace les deux droites de régression

#9
pred_g1 <- predict(res_lm_groupe1, newdata = finance)
pred_g2 <- predict(res_lm_groupe2, newdata = finance)

#10
dist_g1 <- abs(finance$Dividende - pred_g1)
dist_g2 <- abs(finance$Dividende - pred_g2)

#11
finance$profil <- ifelse(dist_g1 < dist_g2, "Profil 1", "Profil 2")

#12
finance$distance_au_modele <- pmin(dist_g1, dist_g2)


#13
#on trace les distances
plot(finance$distance_au_modele,
     main = "Distance au modèle le plus proche",
     ylab = "Distance", xlab = "Entreprise", pch = 19)

#puis on calcul le seuil à 90%
seuil <- quantile(finance$distance_au_modele, 0.9)

#on définti la nouvelle variable atypique
finance$atypique <- finance$distance_au_modele > seuil

#on trace alors le nuage de points final
col_atypique <- ifelse(finance$atypique, "red", "blue")
plot(finance$Dette, finance$Dividende,
     col = col_atypique, pch = 19,
     main = "Dette vs Dividende avec entreprises atypiques",
     xlab = "Dette", ylab = "Dividende")

#avec les droites de régression en noir
abline(res_lm_groupe1, col = "black", lwd = 2)
abline(res_lm_groupe2, col = "black", lwd = 2)

