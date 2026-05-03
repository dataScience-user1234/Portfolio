import requests
import matplotlib.pyplot as plt
import statistics as stat

url = "https://archive-api.open-meteo.com/v1/archive"

annees = [2023, 2013, 2003, 1993, 1983]


liste_moyennes = []

for annee in annees:
    params = {
    "latitude" : "44.916672",
    "longitude" : "2.45",
    "start_date" : f"{annee}-01-01",
    "end_date" : f"{annee}-12-31",
    "daily" : "temperature_2m_mean"   
}
    req = requests.get(url, params=params).json()
    moyenne_actuelle = stat.mean(req['daily']['temperature_2m_mean'])

    #on l'ajoute à la liste
    liste_moyennes.append(moyenne_actuelle)
    print(f"Année {annee} : {moyenne_actuelle}")

plt.plot(annees, liste_moyennes, label = "Témperature moyenne à Aurillac \nde 1983 à 2023")

plt.legend()
plt.grid(True)

plt.savefig("graphique_aurillac.png")
plt.show
