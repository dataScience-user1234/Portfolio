database <- read.csv("~/Downloads/database.csv")
View(database)

# Assignation des variables quantitatives
# Ces variables quantitatives sont sélectionnées car elles représentent des mesures clés utilisées pour analyser les tendances 
# et effectuer des statistiques descriptives pertinentes.
quantitative_vars <- database[, c("age", "age_entree_SD", "annee_naissance", "duree_SD", "stage_duree_pour_trouver")]

# La fonction str() permet d'examiner la structure des données, notamment les types des colonnes ("chr", "num", "int").
str(database)

# Assignation des colonnes à analyser à l'aide d'un vecteur
# Ce vecteur liste les colonnes pour lesquelles les statistiques descriptives seront calculées.
colonnes_a_analyser <- c("age", "annee_naissance", "age_entree_SD", "duree_SD", "stage_duree_pour_trouver")


# Ce tableau résume les statistiques descriptives principales pour chaque colonne spécifiée.
summary_table <- data.frame(
  Moyenne = sapply(colonnes_a_analyser, function(col) mean(database[[col]], na.rm = TRUE)),
  Variance = sapply(colonnes_a_analyser, function(col) var(database[[col]], na.rm = TRUE)),
  Écart_Type = sapply(colonnes_a_analyser, function(col) sd(database[[col]], na.rm = TRUE)),
  Médiane = sapply(colonnes_a_analyser, function(col) median(database[[col]], na.rm = TRUE)),
  Q1 = sapply(colonnes_a_analyser, function(col) quantile(database[[col]], 0.25, na.rm = TRUE)),
  Q3 = sapply(colonnes_a_analyser, function(col) quantile(database[[col]], 0.75, na.rm = TRUE)),
  Min = sapply(colonnes_a_analyser, function(col) min(database[[col]], na.rm = TRUE)),
  Max = sapply(colonnes_a_analyser, function(col) max(database[[col]], na.rm = TRUE))
)

# Affichage du tableau des données statistiques
print(summary_table)

# La fonction unique() est utilisée pour lister les valeurs distinctes présentes dans la colonne `pertinence_SD`.
unique(database$pertinence_SD)

# La fonction table() sert à calculer la fréquence de chaque catégorie dans la colonne `pertinence_SD`.
table_pertinence <- table(database$pertinence_SD)

# La fonction barplot() est utilisée pour visualiser les effectifs des catégories sous forme de diagramme en barres.
table_pertinence
barplot(
  table_pertinence,
  main = "Répartition de la Pertinence du BUT SD",
  ylab = "Effectif",
  col = "lightblue",
  border = "black",
  las = 2
)

# Répartition des genres
table(database$genre)

# On constate qu'il y a 43 Hommes et 8 Femmes
# On utilise la fonction barplot() pour le diagramme en barre
genre <- table(database$genre)
genre
barplot(
  genre,
  main = "Diagramme en barres des genres",
  xlab = "Genre",
  ylab = "Effectifs",
  col = c("red", "blue")
)

# Répartition des choix d'options
choix <- table(database$option_SD)
choix
# La fonction pie() est utilisée pour représenter les proportions des choix d'options sous forme de camembert.
pie(
  choix,
  main = "Camembert des options",
  col = c("red", "blue", "yellow")
)


# La fonction boxplot() visualise la distribution des données ainsi que les valeurs atypiques éventuelles pour la durée pour trouver un stage.
# C'est une boîte à moustache
boxplot(
  database$stage_duree_pour_trouver,
  main = "Boxplot de la durée pour trouver un stage",
  ylab = "Durée (en mois)",
  col = "lightgreen"
)


# Ce tableau fournit un résumé des statistiques descriptives pour la durée de recherche de stage,
# avec une présentation ordonnée des résultats.
# Ca vient compléter la boîte à moustache
statistiques_stage <- data.frame(
  Statistique = c("Médiane", "Maximum", "Minimum", "1er Quartile (Q1)", "3e Quartile (Q3)"),
  Valeur = c(
    median(database$stage_duree_pour_trouver, na.rm = TRUE),
    max(database$stage_duree_pour_trouver, na.rm = TRUE),
    min(database$stage_duree_pour_trouver, na.rm = TRUE),
    quantile(database$stage_duree_pour_trouver, 0.25, na.rm = TRUE),
    quantile(database$stage_duree_pour_trouver, 0.75, na.rm = TRUE)
  )
)

# Affichage des statistiques
print(statistiques_stage)
