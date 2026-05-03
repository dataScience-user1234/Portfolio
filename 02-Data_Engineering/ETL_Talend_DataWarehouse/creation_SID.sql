-- Création de la table Dimension Client
CREATE TABLE public.dim_client (
    codecli character varying(5) PRIMARY KEY,
    societe character varying(36),
    fonction character varying(23),
    ville character varying(15),
    pays character varying(11)
);

-- Création de la table Dimension Produit
CREATE TABLE public.dim_produit (
    refprod smallint PRIMARY KEY,
    nomprod character varying(32),
    nofour smallint,
    codecateg smallint,
    nomcateg character varying(25),
    descriptioncateg character varying(34)
);

-- Création de la table Dimension Employe
CREATE TABLE public.dim_employe (
    noemp smallint PRIMARY KEY,
    nom character varying(9),
    prenom character varying(8),
    fonction character varying(22),
    ville character varying(8),
    pays character varying(11)
);

-- Création de la table Dimension Messager
CREATE TABLE public.dim_messager (
    nomess smallint PRIMARY KEY,
    nommess character varying(16)
);

-- Création de la table de Faits Ventes
CREATE TABLE public.fait_ventes (
    nocom integer,
    refprod smallint,
    codecli character varying(5),
    noemp smallint,
    qte smallint,
    prixunit numeric(6,2),
    remise numeric(3,2),
    montant_ht numeric(12,2),
    PRIMARY KEY (nocom, refprod),
    FOREIGN KEY (codecli) REFERENCES public.dim_client(codecli),
    FOREIGN KEY (refprod) REFERENCES public.dim_produit(refprod),
    FOREIGN KEY (noemp) REFERENCES public.dim_employe(noemp)
);

-- Création de la table de Faits Livraisons
CREATE TABLE public.fait_livraisons (
    nocom integer PRIMARY KEY,
    codecli character varying(5),
    nomess smallint,
    dateenv date,
    dateobjliv date,
    port numeric(8,2),
    villeliv character varying(15),
    paysliv character varying(11),
    FOREIGN KEY (codecli) REFERENCES public.dim_client(codecli),
    FOREIGN KEY (nomess) REFERENCES public.dim_messager(nomess)
);