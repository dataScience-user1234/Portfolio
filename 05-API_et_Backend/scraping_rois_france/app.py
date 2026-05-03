import streamlit as st
import pandas as pd
import plotly.express as px


st.set_page_config(page_title="SAE Monarchie Française", layout="wide")


@st.cache_data
def load_data():
    return pd.read_csv("rois_france_final.csv")

df = load_data()


st.title(" Analyse Data : La Lignée des Rois de France")
st.markdown("""
Cette application présente les données collectées par Web Scraping sur Wikipédia. 
Elle met en avant la généalogie et la chronologie des monarques.
""")


st.divider()
m1, m2, m3, m4 = st.columns(4)
m1.metric("Total Monarques", len(df))
m2.metric("Moyenne Enfants", round(df['Nb_Enfants'].mean(), 1))
m3.metric("Record Enfants", int(df['Nb_Enfants'].max()))
m4.metric("Début de l'Histoire", f"An {int(df['Annee_Debut'].min())}")


st.divider()
col_left, col_right = st.columns([2, 1])

with col_left:
    st.subheader(" Frise Chronologique des Règnes")
    
    fig_chrono = px.scatter(df, 
                            x="Annee_Debut", 
                            y="Nom",
                            size="Nb_Enfants", 
                            color="Nb_Enfants",
                            hover_data=["Pere", "Mere"],
                            title="Répartition temporelle (la taille des points = nombre d'enfants)",
                            color_continuous_scale="Viridis",
                            template="plotly_dark")
    st.plotly_chart(fig_chrono, width='stretch')

with col_right:
    st.subheader(" Top 10 des Familles")
    
    top10 = df.nlargest(10, 'Nb_Enfants')
    fig_bar = px.bar(top10, 
                     x='Nb_Enfants', 
                     y='Nom', 
                     orientation='h',
                     color='Nb_Enfants',
                     color_continuous_scale='Reds',
                     template="plotly_dark")
    fig_bar.update_layout(yaxis={'categoryorder':'total ascending'})
    st.plotly_chart(fig_bar, width='stretch')


st.divider()
st.subheader(" Recherche de Monarque")
selected_roi = st.selectbox("Sélectionnez un nom pour voir les détails :", df['Nom'].unique())

roi_data = df[df['Nom'] == selected_roi].iloc[0]


c1, c2, c3 = st.columns(3)
with c1:
    st.info(f"** Monarque**\n\nNom : {roi_data['Nom']}\n\nDébut de règne : {int(roi_data['Annee_Debut'])}")
with c2:
    st.warning(f"** Ascendance**\n\nPère : {roi_data['Pere']}\n\nMère : {roi_data['Mere']}")
with c3:
    st.success(f"** Descendance ({int(roi_data['Nb_Enfants'])} enfants)**\n\n{roi_data['Enfants_Liste']}")


with st.expander("Voir la base de données brute"):
    st.dataframe(df, width='stretch')