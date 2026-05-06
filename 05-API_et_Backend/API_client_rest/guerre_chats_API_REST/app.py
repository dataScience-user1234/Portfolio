from datetime import datetime, timedelta
from typing import List
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from jose import JWTError, jwt
from passlib.context import CryptContext
from sqlmodel import Session, select
from contextlib import asynccontextmanager

#on importe tout ce qu'on a créé dans database.py
from database import create_db_and_tables, engine, User, Armee, Chat, Arme



#clé secrète pour signer les tokens
SECRET_KEY = "super_cle_secrete_de_la_guerre_des_chats"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30 #expire dans 30 minutes

#hache les mots de passe
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
#l'url que swagger va utiliser pour se connecter
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

@asynccontextmanager
async def lifespan(app: FastAPI):
    create_db_and_tables()
    yield

app = FastAPI(lifespan=lifespan)



app.add_middleware( #pour autoriser le client à parler avec l'api python
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)



#fonctions pour l'authentifaction

def hacher_mdp(mot_de_passe: str):
    return pwd_context.hash(mot_de_passe)

def verifier_mdp(mot_de_passe_clair, mot_de_passe_hache):
    return pwd_context.verify(mot_de_passe_clair, mot_de_passe_hache)

def creer_token(data: dict):
    a_encoder = data.copy()
    expiration = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    a_encoder.update({"exp": expiration})
    return jwt.encode(a_encoder, SECRET_KEY, algorithm=ALGORITHM)



def get_utilisateur_courant(token: str = Depends(oauth2_scheme)):
    erreur_auth = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Identifiants non valides ou token expiré",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        #on décrypte le token pour retrouver le nom d'utilisateur
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise erreur_auth
    except JWTError:
        raise erreur_auth
        
    
    
    with Session(engine) as session: #on cherche l'utilisateur dans la base de données
        user = session.exec(select(User).where(User.username == username)).first()
        if user is None:
            raise erreur_auth
        return user




#on s'inscrit
@app.post("/inscription")
def inscription(username: str, mot_de_passe: str):
    with Session(engine) as session:
        #puis on verifie si c'est deja pris
        user_existe = session.exec(select(User).where(User.username == username)).first()
        if user_existe:
            raise HTTPException(status_code=400, detail="Ce nom d'utilisateur est déjà pris.")
        
        #et on sauvegarde ici avec le hachage
        nouveau_user = User(username=username, hashed_password=hacher_mdp(mot_de_passe))
        session.add(nouveau_user)
        session.commit()
        return {"message": f"Compte {username} créé ! Vous pouvez vous connecter."}



@app.post("/token") #on se connecte
def login(form_data: OAuth2PasswordRequestForm = Depends()):
    with Session(engine) as session:

        user = session.exec(select(User).where(User.username == form_data.username)).first()
        #on verifie s'il existe
        if not user or not verifier_mdp(form_data.password, user.hashed_password):
            raise HTTPException(status_code=400, detail="Identifiant ou mot de passe incorrect")
        
        #et si c'est bon il a son ticket
        token_acces = creer_token(data={"sub": user.username})
        return {"access_token": token_acces, "token_type": "bearer"}




#pour associer/ modifier une armée
@app.post("/mon-armee/")
def creer_ou_modifier_mon_armee(nom: str, description: str, user_actuel: User = Depends(get_utilisateur_courant)):
    with Session(engine) as session:
        # On cherche s'il a deja une armée
        armee = session.exec(select(Armee).where(Armee.user_id == user_actuel.id)).first()
        
        if armee:
            #si oui on met a jour
            armee.nom = nom
            armee.description = description
        else:#sinon on la crée
            armee = Armee(nom=nom, description=description, user_id=user_actuel.id)
            
        session.add(armee)
        session.commit()
        session.refresh(armee)
        return armee

#ajouter un chat a son armée 
@app.post("/chats/recruter")
def recruter_chat(name: str, race: str, age: int, user_actuel: User = Depends(get_utilisateur_courant)):
    with Session(engine) as session:
        armee = session.exec(select(Armee).where(Armee.user_id == user_actuel.id)).first()
        if not armee:
            raise HTTPException(status_code=400, detail="Créez d'abord une armée avant de recruter des chats !")
            
        nouveau_chat = Chat(name=name, race=race, age=age, armee_id=armee.id)
        session.add(nouveau_chat)
        session.commit()
        session.refresh(nouveau_chat)
        return nouveau_chat

# pour supprimer un chat , et c'est securisée
@app.delete("/chats/{chat_id}")
def virer_chat(chat_id: int, user_actuel: User = Depends(get_utilisateur_courant)):
    with Session(engine) as session:
        chat = session.get(Chat, chat_id)
        if not chat:
            raise HTTPException(status_code=404, detail="Chat introuvable")
        


        armee_du_chat = session.get(Armee, chat.armee_id) #on verifie
        if not armee_du_chat or armee_du_chat.user_id != user_actuel.id:
            raise HTTPException(status_code=403, detail="Interdit ! Ce chat ne fait pas partie de ton armée.")
            
        session.delete(chat)
        session.commit()
        return {"message": f"Le chat {chat.name} a été renvoyé de l'armée."}

#armes pour les chats
@app.put("/chats/{chat_id}/equiper/{arme_id}")
def equiper_arme(chat_id: int, arme_id: int, user_actuel: User = Depends(get_utilisateur_courant)):
    with Session(engine) as session:
        chat = session.get(Chat, chat_id)
        arme = session.get(Arme, arme_id)
        
        if not chat or not arme:
            raise HTTPException(status_code=404, detail="Chat ou Arme introuvable")
            

        armee_du_chat = session.get(Armee, chat.armee_id) #on verifie encore, c'est securisée
        if not armee_du_chat or armee_du_chat.user_id != user_actuel.id:
            raise HTTPException(status_code=403, detail="Tu ne peux pas équiper le chat d'un autre joueur !")
            
        chat.arme_id = arme.id
        session.add(chat)
        session.commit()
        return {"message": f"{chat.name} est maintenant équipé avec {arme.nom} !"}



@app.post("/armes/")
def forger_arme_publique(nom: str, degats: int):

    with Session(engine) as session:
        nouvelle_arme = Arme(nom=nom, degats=degats)
        session.add(nouvelle_arme)
        session.commit()
        session.refresh(nouvelle_arme)
        return nouvelle_arme

@app.get("/armees/")
def voir_toutes_armees():
    with Session(engine) as session:
        return session.exec(select(Armee)).all()

@app.get("/chats/")
def voir_tous_chats():
    with Session(engine) as session:
        return session.exec(select(Chat)).all()

@app.get("/armes/")
def voir_toutes_armes():
    with Session(engine) as session:
        return session.exec(select(Arme)).all()