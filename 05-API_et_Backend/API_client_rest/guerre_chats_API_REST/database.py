from typing import Optional
from sqlmodel import Field, SQLModel, create_engine, Session

#table des Utilisateurs 
class User(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    username: str = Field(unique=True, index=True) #le pseudo doit être unique
    hashed_password: str #on ne sauvegarde pas le mot de passe en clair 

#table de l'armée
class Armee(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    nom: str
    description: str
    #clé étrangere
    #on relie l'armée à un utilisateur
    user_id: Optional[int] = Field(default=None, foreign_key="user.id")

#tables des armes
class Arme(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    nom: str
    degats: int

#tables des chats
class Chat(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    name: str
    race: str
    age: int
    #clés etrangeres
    armee_id: Optional[int] = Field(default=None, foreign_key="armee.id")
    arme_id: Optional[int] = Field(default=None, foreign_key="arme.id")

#configuration de la base de données SQLite
sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, echo=True)

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)




if __name__ == "__main__":
    create_db_and_tables()
    print("Base de données et tables créées avec succès !")