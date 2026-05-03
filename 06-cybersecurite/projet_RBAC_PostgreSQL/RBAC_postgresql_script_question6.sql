-- 6. Ce script crée les utilisateurs, rôles, les associations entre eux, et les privilèges

-- (a) Création des comptes utilisateurs
CREATE USER utilisateur_medecin WITH PASSWORD 'medecin1';
CREATE USER utilisateur_nurse WITH PASSWORD 'nurse2';
CREATE USER utilisateur_reception WITH PASSWORD 'reception3';
CREATE USER utilisateur_pharmacien WITH PASSWORD 'pharmacien4';

-- (b) Création des rôles
CREATE ROLE role_medecin;
CREATE ROLE role_nurse;
CREATE ROLE role_reception;
CREATE ROLE role_pharmacien;

-- (c) Attribution des rôles aux utilisateurs
GRANT role_medecin TO utilisateur_medecin;
GRANT role_nurse TO utilisateur_nurse;
GRANT role_reception TO utilisateur_reception;
GRANT role_pharmacien TO utilisateur_pharmacien;

-- (d) Attribution de rôles à d'autres rôles (si on souhaite regrouper plusieurs rôles dans un super rôle)
CREATE ROLE role_hopital;
GRANT role_medecin TO role_hopital;
GRANT role_nurse TO role_hopital;
GRANT role_reception TO role_hopital;
GRANT role_pharmacien TO role_hopital;

-- (e) Attribution des privilèges à chaque rôle
-- Les médecins peuvent consulter et insérer des diagnostics et examiner des patients
GRANT SELECT, INSERT ON diagnosis TO role_medecin;
GRANT SELECT, INSERT ON examine TO role_medecin;

-- Les infirmiers peuvent consulter et insérer dans la table patient
GRANT SELECT, INSERT ON patient TO role_nurse;

-- Les réceptionnistes peuvent insérer et lire les rendez-vous
GRANT SELECT, INSERT ON appointment TO role_reception;

-- Les pharmaciens peuvent voir et insérer les achats de médicaments
GRANT SELECT, INSERT ON purchase TO role_pharmacien;
