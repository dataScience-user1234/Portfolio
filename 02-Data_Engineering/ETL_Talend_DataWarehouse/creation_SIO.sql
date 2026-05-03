SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: _categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._categorie (
    codecateg smallint,
    nomcateg character varying(25) DEFAULT NULL::character varying,
    description character varying(34) DEFAULT NULL::character varying
);


ALTER TABLE public._categorie OWNER TO postgres;

--
-- Name: _client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._client (
    codecli character varying(5) DEFAULT NULL::character varying,
    societe character varying(36) DEFAULT NULL::character varying,
    contact character varying(23) DEFAULT NULL::character varying,
    fonction character varying(23) DEFAULT NULL::character varying,
    adresse character varying(46) DEFAULT NULL::character varying,
    ville character varying(15) DEFAULT NULL::character varying,
    region character varying(36) DEFAULT NULL::character varying,
    codepostal character varying(36) DEFAULT NULL::character varying,
    pays character varying(11) DEFAULT NULL::character varying,
    tel character varying(17) DEFAULT NULL::character varying,
    fax character varying(36) DEFAULT NULL::character varying
);


ALTER TABLE public._client OWNER TO postgres;

--
-- Name: _commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._commande (
    nocom integer,
    codecli character varying(5) DEFAULT NULL::character varying,
    noemp smallint,
    datecom character varying(10) DEFAULT NULL::character varying,
    dateobjliv character varying(10) DEFAULT NULL::character varying,
    dateenv character varying(10) DEFAULT NULL::character varying,
    nomess smallint,
    port smallint,
    destinataire character varying(34) DEFAULT NULL::character varying,
    adrliv character varying(46) DEFAULT NULL::character varying,
    villeliv character varying(15) DEFAULT NULL::character varying,
    regionliv character varying(36) DEFAULT NULL::character varying,
    codepostalliv character varying(36) DEFAULT NULL::character varying,
    paysliv character varying(11) DEFAULT NULL::character varying
);


ALTER TABLE public._commande OWNER TO postgres;

--
-- Name: _detailcommande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._detailcommande (
    nocom integer,
    refprod smallint,
    prixunit smallint,
    qte smallint,
    remise numeric(3,2) DEFAULT NULL::numeric
);


ALTER TABLE public._detailcommande OWNER TO postgres;

--
-- Name: _employe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._employe (
    noemp smallint,
    nom character varying(9) DEFAULT NULL::character varying,
    prenom character varying(8) DEFAULT NULL::character varying,
    fonction character varying(22) DEFAULT NULL::character varying,
    titrecourtoisie character varying(4) DEFAULT NULL::character varying,
    datenaissance character varying(18) DEFAULT NULL::character varying,
    dateembauche character varying(18) DEFAULT NULL::character varying,
    adresse character varying(30) DEFAULT NULL::character varying,
    ville character varying(8) DEFAULT NULL::character varying,
    region character varying(36) DEFAULT NULL::character varying,
    codepostal character varying(7) DEFAULT NULL::character varying,
    pays character varying(11) DEFAULT NULL::character varying,
    teldom character varying(14) DEFAULT NULL::character varying,
    extension smallint,
    rendcomptea character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._employe OWNER TO postgres;

--
-- Name: _fournisseur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._fournisseur (
    nofour smallint,
    societe character varying(38) DEFAULT NULL::character varying,
    contact character varying(26) DEFAULT NULL::character varying,
    fonction character varying(36) DEFAULT NULL::character varying,
    adresse character varying(46) DEFAULT NULL::character varying,
    ville character varying(14) DEFAULT NULL::character varying,
    region character varying(36) DEFAULT NULL::character varying,
    codepostal character varying(8) DEFAULT NULL::character varying,
    pays character varying(11) DEFAULT NULL::character varying,
    tel character varying(36) DEFAULT NULL::character varying,
    fax character varying(36) DEFAULT NULL::character varying,
    pageaccueil character varying(93) DEFAULT NULL::character varying
);


ALTER TABLE public._fournisseur OWNER TO postgres;

--
-- Name: _messager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._messager (
    nomess smallint,
    nommess character varying(16) DEFAULT NULL::character varying,
    tel character varying(14) DEFAULT NULL::character varying
);


ALTER TABLE public._messager OWNER TO postgres;

--
-- Name: _produit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._produit (
    refprod smallint,
    nomprod character varying(32) DEFAULT NULL::character varying,
    nofour smallint,
    codecateg smallint,
    qteparunit character varying(25) DEFAULT NULL::character varying,
    prixunit numeric(6,2) DEFAULT NULL::numeric,
    unitesstock smallint,
    unitescom smallint,
    niveaureap smallint,
    indisponible smallint
);


ALTER TABLE public._produit OWNER TO postgres;

--
-- Intégration des données des petites tables
--

INSERT INTO public._categorie (codecateg, nomcateg, description) VALUES
(1,	'Boissons',	'Boissons, cafés, thés, bières'),
(2,	'Condiments Sauces',	'Assaisonnements et épices'),
(3,	'Desserts',	'Desserts et friandises'),
(4,	'Produits laitiers','Fromages'),
(5,	'Pâtes et céréales','Pains, biscuits, pâtes & céréales'),
(6,	'Viandes'	,'Viandes préparées'),
(7,	'Produits secs'	,'Fruits secs, raisins, autres'),
(8,	'Poissons et fruits de mer', 'Poissons, fruits de mer, escargots')
;

INSERT INTO public._messager (nomess, nommess, tel ) 
VALUES
(1, 'Speedy Express', '(503) 555-9831'     ),
(2, 'United Package',	'(503) 555-3199'   ),
(3, 'Federal Shipping',	'(503) 555-9931'   )
;

INSERT INTO public._employe (noemp, nom, prenom, fonction, titrecourtoisie, datenaissance, dateembauche, adresse, ville, region, codepostal, pays, teldom, extension, rendcomptea) 
values
(1,'Davolio','Nancy','Représentant(e)','Mlle','08DEC1968:00:00:00','01MAY2012:00:00:00','507 - 20th Ave. E.  Apt. 2A','Seattle','WA','98122','Etats-Unis','(206) 555-9857',5467,'2'),
(2,'Fuller','Andrew','Vice-Président','Dr.','19FEB1972:00:00:00','14AUG2012:00:00:00','908 W. Capital Way','Tacoma','WA','98401','Etats-Unis','(206) 555-9482',3457,''),
(3,'Leverling','Janet','Représentant(e)','Mlle','30AUG1983:00:00:00','01APR2012:00:00:00','722 Moss Bay Blvd.','Kirkland','WA','98033','Etats-Unis','(206) 555-3412',3355,'2'),
(4,'Peacock','Margaret','Représentant(e)','Mme','19SEP1957:00:00:00','03MAY2013:00:00:00','4110 Old Redmond Rd.','Redmond','WA','98052','Etats-Unis','(206) 555-8122',5176,'2'),
(5,'Buchanan','Steven','Chef des ventes','M.','04MAR1975:00:00:00','17OCT2013:00:00:00','14 Garrett Hill','London','unknown_value_please_contact_support','SW1 8JR','Royaume-Uni','(71) 555-4848',345,'2'),
(6,'Suyama','Michael','Représentant(e)','M.','02JUL1983:00:00:00','17OCT2013:00:00:00','Coventry House  Miner Rd.','London','unknown_value_please_contact_support','EC2 7JR','Royaume-Uni','(71) 555-7773',428,'7'),
(7,'Emery','Patrick','Chef des ventes','M.','29MAY1980:00:00:00','02JAN2014:00:00:00','Edgeham Hollow  Winchester Way','London','unknown_value_please_contact_support','RG1 9SP','Royaume-Uni','(71) 555-5598',465,'5'),
(8,'Callahan','Laura','Assistante commerciale','Mlle','09JAN1978:00:00:00','05MAR2014:00:00:00','4726 - 11th Ave. N.E.','Seattle','WA','98105','Etats-Unis','(206) 555-1189',2344,'2'),
(9,'Dodsworth','Anne','Représentant(e)','Mlle','27JAN1986:00:00:00','15NOV2014:00:00:00','7 Houndstooth Rd.','London','unknown_value_please_contact_support','WG2 7LT','Royaume-Uni','(71) 555-4444',452,'5'),
(10,'Suyama','Jordan','Représentant(e)','M.','02JUL1983:00:00:00','21OCT2013:00:00:00','Coventry House  Miner Rd.','London','unknown_value_please_contact_support','EC2 7JR','Royaume-Uni','(71) 555-7773',428,'7')
;
INSERT INTO public._client(codecli, societe, contact, fonction, adresse, ville, region, codepostal, pays, tel, fax)
VALUES ('ALFKI','Alfreds Futterkiste','Maria Anders','Representant(e)','Obere Str. 57','Berlin','unknown_value_please_contact_support','12209','Allemagne','030-0074321','030-0076545')
,('ANATR','Ana Trujillo Emparedados y helados','Ana Trujillo','Proprietaire','Avda. de la Constituci¢n 2222','Mexico D.F.','unknown_value_please_contact_support','5021','Mexique','(5) 555-4729','(5) 555-3745')
,('ANTON','Antonio Moreno Taquer¡a','Antonio Moreno','Proprietaire','Mataderos  2312','Mexico D.F.','unknown_value_please_contact_support','5023','Mexique','(5) 555-3932','unknown_value_please_contact_support')
,('AROUT','Around the Horn','Thomas Hardy','Representant(e)','120 Hanover Sq.','London','unknown_value_please_contact_support','WA1 1DP','Royaume-Uni','(71) 555-7788','(71) 555-6750')
,('BERGS','Berglunds snabbkep','Christina Berglund','Acheteur','Berguvsvegen  8','Lulee','unknown_value_please_contact_support','S-958 22','Suede','0921-12 34 65','0921-12 34 67')
,('BLAUS','Blauer See Delikatessen','Hanna Moos','Representant(e)','Forsterstr. 57','Mannheim','unknown_value_please_contact_support','68306','Allemagne','0621-08460','0621-08924')
,('BLONP','Blondel pere et fils','Frederique Citeaux','Directeur du marketing','24, place Kleber','Strasbourg','unknown_value_please_contact_support','67000','France','88.60.15.31','88.60.15.32')
,('BOLID','B¢lido Comidas preparadas','Mart¡n Sommer','Proprietaire','C/ Araquil, 67','Madrid','unknown_value_please_contact_support','28023','Espagne','(91) 555 22 82','(91) 555 91 99')
,('BONAP','Bon app','Laurence Lebihan','Proprietaire','12, rue des Bouchers','Marseille','unknown_value_please_contact_support','13008','France','91.24.45.40','91.24.45.41')
,('BOTTM','Bottom-Dollar Markets','Elizabeth Lincoln','Chef comptable','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada','(604) 555-4729','(604) 555-3745')
,('BSBEV','Bs Beverages','Victoria Ashworth','Representant(e)','Fauntleroy Circus','London','unknown_value_please_contact_support','EC2 5NT','Royaume-Uni','(71) 555-1212','unknown_value_please_contact_support')
,('CACTU','Cactus Comidas para llevar','Patricio Simpson','Assistant(e) des ventes','Cerrito 333','Buenos Aires','unknown_value_please_contact_support','1010','Argentine','(1) 135-5555','(1) 135-4892')
,('CENTC','Centro comercial Moctezuma','Francisco Chang','Directeur du marketing','Sierras de Granada 9993','Mexico D.F.','unknown_value_please_contact_support','5022','Mexique','(5) 555-3392','(5) 555-7293')
,('CHOPS','Chop-suey Chinese','Yang Wang','Proprietaire','Hauptstr. 29','Bern','unknown_value_please_contact_support','3012','Suisse','0452-076545','unknown_value_please_contact_support')
,('COMMI','Comercio Mineiro','Pedro Afonso','Assistant(e) des ventes','Av. dos Lus¡adas, 23','SÆo Paulo','SP','05432-043','Bresil','(11) 555-7647','unknown_value_please_contact_support')
,('CONSH','Consolidated Holdings','Elizabeth Brown','Representant(e)','Berkeley Gardens  12  Brewery','London','unknown_value_please_contact_support','WX1 6LT','Royaume-Uni','(71) 555-2282','(71) 555-9199')
,('DRACD','Drachenblut Delikatessen','Sven Ottlieb','Acheteur','Walserweg 21','Aachen','unknown_value_please_contact_support','52066','Allemagne','0241-039123','0241-059428')
,('DUMON','Du monde entier','Janine Labrune','Proprietaire','67, rue des Cinquante Otages','Nantes','unknown_value_please_contact_support','44000','France','40.67.88.88','40.67.89.89')
,('EASTC','Eastern Connection','Ann Devon','Assistant(e) des ventes','35 King George','London','unknown_value_please_contact_support','WX3 6FW','Royaume-Uni','(71) 555-0297','(71) 555-3373')
,('ERNSH','Ernst Handel','Roland Mendel','Chef des ventes','Kirchgasse 6','Graz','unknown_value_please_contact_support','8010','Autriche','7675-3425','7675-3426')
,('ESPAC','Lespace','Michel Roudil','Proprietaire','18, Route de Douvres','Courseulles','unknown_value_please_contact_support','14470','France','31.22.32.84','31.22.32.86')
,('ETOUR','Etourdi','Sylvie Chalet','Assistant(e) marketing','47 Quai Hamelin','Caen','unknown_value_please_contact_support','14000','France','31.92.85.65','unknown_value_please_contact_support')
,('FAMIA','Familia Arquibaldo','Aria Cruz','Assistant(e) marketing','Rua Or¢s, 92','SÆo Paulo','SP','05442-030','Bresil','(11) 555-9857','unknown_value_please_contact_support')
,('FISSA','FISSA Fabrica Inter. Salchichas S.A.','Diego Roel','Chef comptable','C/ Moralzarzal, 86','Madrid','unknown_value_please_contact_support','28034','Espagne','(91) 555 94 44','(91) 555 55 93')
,('FOLIG','Folies gourmandes','Martine Rance','Representant(e)','184, chaussee de Tournai','Lille','unknown_value_please_contact_support','59000','France','20.16.10.16','20.16.10.17')
,('FOLKO','Folk och f HB','Maria Larsson','Proprietaire','kergatan 24','Brcke','unknown_value_please_contact_support','S-844 67','Sude','0695-34 67 21','unknown_value_please_contact_support')
,('FRANK','Frankenversand','Peter Franken','Directeur du marketing','Berliner Platz 43','Menchen','unknown_value_please_contact_support','80805','Allemagne','089-0877310','089-0877451')
,('FRANR','France restauration','Carine Schmitt','Directeur du marketing','54, rue Royale','Nantes','unknown_value_please_contact_support','44000','France','40.32.21.21','40.32.21.20')
,('FRANS','Franchi S.p.A.','Paolo Accorti','Representant(e)','Via Monte Bianco 34','Torino','unknown_value_please_contact_support','10100','Italie','011-4988260','011-4988261')
,('FURIB','Furia Bacalhau e Frutos do Mar','Lino Rodriguez','Chef des ventes','Jardim das rosas n. 32','Lisboa','unknown_value_please_contact_support','1675','Portugal','(1) 354-2534','(1) 354-2535')
,('GALED','Galer¡a del gastr¢nomo','Eduardo Saavedra','Directeur du marketing','Rambla de Catalu¤a, 23','Barcelona','unknown_value_please_contact_support','8022','Espagne','(93) 203 4560','(93) 203 4561')
,('GODOS','Godos Cocina T¡pica','Jose Pedro Freyre','Chef des ventes','C/ Romero, 33','Sevilla','unknown_value_please_contact_support','41101','Espagne','(95) 555 82 82','unknown_value_please_contact_support')
,('GOURL','Gourmet Lanchonetes','Andre Fonseca','Assistant(e) des ventes','Av. Brasil, 442','Campinas','SP','04876-786','Bresil','(11) 555-9482','unknown_value_please_contact_support')
,('GREAL','Great Lakes Food Market','Howard Snyder','Directeur du marketing','2732 Baker Blvd.','Eugene','OR','97403','Etats-Unis','(503) 555-7555','unknown_value_please_contact_support')
,('GROSR','GROSELLA-Restaurante','Manuel Pereira','Proprietaire','5¦ Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela','(2) 283-2951','(2) 283-3397')
,('HANAR','Hanari Carnes','Mario Pontes','Chef comptable','Rua do Pao, 67','Rio de Janeiro','RJ','05454-876','Bresil','(21) 555-0091','(21) 555-8765')
,('HILAA','HILARIàN-Abastos','Carlos Hern ndez','Representant(e)','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist¢bal','T chira','5022','Venezuela','(5) 555-1340','(5) 555-1948')
,('HUNGC','Hungry Coyote Import Store','Yoshi Latimer','Representant(e)','City Center Plaza  516 Main St.','Elgin','OR','97827','Etats-Unis','(503) 555-6874','(503) 555-2376')
,('HUNGO','Hungry Owl All-Night Grocers','Patricia McKenna','Assistant(e) des ventes','8 Johnstown Road','Cork','Co. Cork','unknown_value_please_contact_support','Irlande','2967 542','2967 3333')
,('ISLAT','Island Trading','Jerme Firenze','Directeur du marketing','Garden House  Crowther Way','Cowes','Isle of Wight','PO31 7PJ','Royaume-Uni','(198) 555-8888','unknown_value_please_contact_support')
,('KOENE','Kniglich Essen','Philip Cramer','Assistant(e) des ventes','Maubelstr. 90','Brandenburg','unknown_value_please_contact_support','14776','Allemagne','0555-09876','unknown_value_please_contact_support')
,('LACOR','La corne dabondance','Daniel Tonini','Representant(e)','67, avenue de lEurope','Versailles','unknown_value_please_contact_support','78000','France','30.59.84.10','30.59.85.11')
,('LAMAI','La maison dAsie','Annette Roulet','Chef des ventes','1 rue Alsace-Lorraine','Toulouse','unknown_value_please_contact_support','31000','France','61.77.61.10','61.77.61.11')
,('LAUGB','Laughing Bacchus Wine Cellars','Yoshi Tannamuri','Assistant(e) marketing','1900 Oak St.','Vancouver','BC','V3F 2K1','Canada','(604) 555-3392','(604) 555-7293')
,('LAZYK','Lazy K Kountry Store','John Steel','Directeur du marketing','12 Orchestra Terrace','Walla Walla','WA','99362','Etats-Unis','(509) 555-7969','(509) 555-6221')
,('LEHMS','Lehmanns Marktstand','Renate Messner','Representant(e)','Magazinweg 7','Frankfurt a.M.','unknown_value_please_contact_support','60528','Allemagne','069-0245984','069-0245874')
,('LETSS','Lets Stop N Shop','Jaime Yorres','Proprietaire','87 Polk St.  Suite 5','San Francisco','CA','94117','Etats-Unis','(415) 555-5938','unknown_value_please_contact_support')
,('LILAS','LILA-Supermercado','Carlos Gonz lez','Chef comptable','Carrera 52 con Ave. Bol¡var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela','(9) 331-6954','(9) 331-7256')
,('LINOD','LINO-Delicateses','Felipe Izquierdo','Proprietaire','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela','(8) 34-56-12','(8) 34-93-93')
,('LONEP','Lonesome Pine Restaurant','Fran Wilson','Chef des ventes','89 Chiaroscuro Rd.','Portland','OR','97219','Etats-Unis','(503) 555-9573','(503) 555-9646')
,('MAGAA','Magazzini Alimentari Riuniti','Giovanni Rovelli','Directeur du marketing','Via Ludovico il Moro 22','Bergamo','unknown_value_please_contact_support','24100','Italie','035-640230','035-640231')
,('MAISD','Maison Dewey','Catherine Dewey','Assistant(e) des ventes','Rue Joseph-Bens 532','Bruxelles','unknown_value_please_contact_support','B-1180','Belgique','(02) 201 24 67','(02) 201 24 68')
,('MEREP','Mre Paillarde','Jean Fresnire','Assistant(e) marketing','43 rue St. Laurent','Montreal','Quebec','H1J 1C3','Canada','(514) 555-8054','(514) 555-8055')
,('MORGK','Morgenstern Gesundkost','Alexander Feuer','Assistant(e) marketing','Heerstr. 22','Leipzig','unknown_value_please_contact_support','4179','Allemagne','0342-023176','unknown_value_please_contact_support')
,('NORTS','North/South','Simon Crowther','Assistant(e) des ventes','South House  300 Queensbridge','London','unknown_value_please_contact_support','SW7 1RZ','Royaume-Uni','(71) 555-7733','(71) 555-2530')
,('OCEAN','Oceano Atl ntico Ltda.','Yvonne Moncada','Assistant(e) des ventes','Ing. Gustavo Moncada 8585  Piso 20-A','Buenos Aires','unknown_value_please_contact_support','1010','Argentine','(1) 135-5333','(1) 135-5535')
,('OLDWO','Old World Delicatessen','Rene Phillips','Representant(e)','2743 Bering St.','Anchorage','AK','99508','Etats-Unis','(907) 555-7584','(907) 555-2880')
,('OTTIK','Ottilies Kseladen','Henriette Pfalzheim','Proprietaire','Mehrheimerstr. 369','Kln','unknown_value_please_contact_support','50739','Allemagne','0221-0644327','0221-0765721')
,('PARIS','Paris specialites','Marie Bertrand','Proprietaire','265, boulevard Charonne','Paris','unknown_value_please_contact_support','75012','France','(1) 42.34.22.66','(1) 42.34.22.77')
,('PERIC','Pericles Comidas cl sicas','Guillermo Fern ndez','Representant(e)','Calle Dr. Jorge Cash 321','Mexico D.F.','unknown_value_please_contact_support','5033','Mexique','(5) 552-3745','(5) 545-3745')
,('PICCO','Piccolo und mehr','Georg Pipps','Chef des ventes','Geislweg 14','Salzburg','unknown_value_please_contact_support','5020','Autriche','6562-9722','6562-9723')
,('PILOF','Pilote et Fils','Cyril Caroline','Proprietaire','875b  rue Rachel Est','Montreal','Quebec','H2J4K6','Canada','(514) 554-8123','unknown_value_please_contact_support')
,('PRINI','Princesa Isabel Vinhos','Isabel de Castro','Representant(e)','Estrada da sa£de n. 58','Lisboa','unknown_value_please_contact_support','1756','Portugal','(1) 356-5634','unknown_value_please_contact_support')
,('QUEDE','Que Del¡cia','Bernardo Batista','Chef comptable','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Bresil','(21) 555-4252','(21) 555-4545')
,('QUEEN','Queen Cozinha','L£cia Carvalho','Assistant(e) marketing','Alameda dos Canrios, 891','SÆo Paulo','SP','05487-020','Bresil','(11) 555-1189','unknown_value_please_contact_support')
,('QUICK','QUICK-Stop','Horst Kloss','Chef comptable','Taucherstraáe 10','Cunewalde','unknown_value_please_contact_support','1307','Allemagne','0372-035188','unknown_value_please_contact_support')
,('RANCH','Rancho grande','Sergio Gutierrez','Representant(e)','Av. del Libertador 900','Buenos Aires','unknown_value_please_contact_support','1010','Argentine','(1) 123-5555','(1) 123-5556')
,('RATTC','Rattlesnake Canyon Grocery','Paula Wilson','Representant(e)','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis','(505) 555-5939','(505) 555-3620')
,('REGGC','Reggiani Caseifici','Maurizio Moroni','Assistant(e) des ventes','Strada Provinciale 124','Reggio Emilia','unknown_value_please_contact_support','42100','Italie','0522-556721','0522-556722')
,('RICAR','Ricardo Adocicados','Janete Limeira','Representant(e)','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Bresil','(21) 555-3412','unknown_value_please_contact_support')
,('RICSU','Richter Supermarkt','Michael Holz','Chef des ventes','Grenzacherweg 237','Genve','unknown_value_please_contact_support','1203','Suisse','0897-034214','unknown_value_please_contact_support')
,('ROMEY','Romero y tomillo','Alejandra Camino','Chef comptable','Gran V¡a, 1','Madrid','unknown_value_please_contact_support','28001','Espagne','(91) 745 6200','(91) 745 6210')
,('SANTG','Sante Gourmet','Jonas Bergulfsen','Proprietaire','Erling Skakkes gate 78','Stavern','unknown_value_please_contact_support','4110','Norvge','07-98 92 35','07-98 92 47')
,('SAVEA','Save-a-lot Markets','Jose Pavarotti','Representant(e)','187 Suffolk Ln.','Boise','ID','83720','Etats-Unis','(208) 555-8097','unknown_value_please_contact_support')
,('SEVES','Seven Seas Imports','Hari Kumar','Chef des ventes','90 Wadhurst Rd.','London','unknown_value_please_contact_support','OX15 4NB','Royaume-Uni','(71) 555-1717','(71) 555-5646')
,('SIMOB','Simons bistro','Jytte Petersen','Proprietaire','Vinbltet 34','Kbenhavn','unknown_value_please_contact_support','1734','Danemark','31 12 34 56','31 13 35 57')
,('SPECD','Specialites du monde','Dominique Perrier','Directeur du marketing','25, rue Lauriston','Paris','unknown_value_please_contact_support','75016','France','(1) 47.55.60.10','(1) 47.55.60.20')
,('SPLIR','Split Rail Beer & Ale','Art Braunschweiger','Chef des ventes','P.O. Box 555','Lander','WY','82520','Etats-Unis','(307) 555-4680','(307) 555-6525')
,('SUPRD','Suprmes delices','Pascale Cartrain','Chef comptable','Boulevard Tirou, 255','Charleroi','unknown_value_please_contact_support','B-6000','Belgique','(071) 23 67 22 20','(071) 23 67 22 21')
,('THEBI','The Big Cheese','Liz Nixon','Directeur du marketing','89 Jefferson Way  Suite 2','Portland','OR','97201','Etats-Unis','(503) 555-3612','unknown_value_please_contact_support')
,('THECR','The Cracker Box','Liu Wong','Assistant(e) marketing','55 Grizzly Peak Rd.','Butte','MT','59801','Etats-Unis','(406) 555-5834','(406) 555-8083')
,('TOMSP','Toms Spezialitten','Karin Josephs','Directeur du marketing','Luisenstr. 48','Menster','unknown_value_please_contact_support','44087','Allemagne','0251-031259','0251-035695')
,('TORTU','Tortuga Restaurante','Miguel Angel Paolino','Proprietaire','Avda. Azteca 123','Mexico D.F.','unknown_value_please_contact_support','5033','Mexique','(5) 555-2933','unknown_value_please_contact_support')
,('TRADH','TradiÆo Hipermercados','Anabela Domingues','Representant(e)','Av. Ins de Castro, 414','SÆo Paulo','SP','05634-030','Bresil','(11) 555-2167','(11) 555-2168')
,('TRAIH','Trails Head Gourmet Provisioners','Helvetius Nagy','Assistant(e) des ventes','722 DaVinci Blvd.','Kirkland','WA','98034','Etats-Unis','(206) 555-8257','(206) 555-2174')
,('VAFFE','Vaffeljernet','Palle Ibsen','Chef des ventes','Smagslget 45','rhus','unknown_value_please_contact_support','8200','Danemark','86 21 32 43','86 22 33 44')
,('VICTE','Victuailles en stock','Mary Saveley','Assistant(e) des ventes','2, rue du Commerce','Lyon','unknown_value_please_contact_support','69004','France','78.32.54.86','78.32.54.87')
,('VINET','Vins et alcools Chevalier','Paul Henriot','Chef comptable','59 rue de lAbbaye','Reims','unknown_value_please_contact_support','51100','France','26.47.15.10','26.47.15.11')
,('WANDK','Die Wandernde Kuh','Rita Meller','Representant(e)','Adenauerallee 900','Stuttgart','unknown_value_please_contact_support','70563','Allemagne','0711-020361','0711-035428')
,('WARTH','Wartian Herkku','Pirkko Koskitalo','Chef comptable','Torikatu 38','Oulu','unknown_value_please_contact_support','90110','Finlande','981-443655','981-443655')
,('WELLI','Wellington Importadora','Paula Parente','Chef des ventes','Rua do Mercado, 12','Resende','SP','08737-363','Bresil','(14) 555-8122','unknown_value_please_contact_support')
,('WHITC','White Clover Markets','Karl Jablonski','Proprietaire','305 - 14th Ave. S.  Suite 3B','Seattle','WA','98128','Etats-Unis','(206) 555-4112','(206) 555-4115')
,('WILMK','Wilman Kala','Matti Karttunen','Assistant du marketing','Keskuskatu 45','Helsinki','unknown_value_please_contact_support','21240','Finlande','90-224 8858','90-224 8858')
,('WOLZA','Wolski  Zajazd','Zbyszek Piestrzeniewicz','Proprietaire','ul. Filtrowa 68','Warszawa','unknown_value_please_contact_support','01-012','Pologne','(26) 642-7012','(26) 642-7012'
);

INSERT INTO public._produit(
	refprod, nomprod, nofour, codecateg, qteparunit, prixunit, unitesstock, unitescom, niveaureap, indisponible)
	VALUES (1,'Chai',1,1,'10 boites x 20 sacs','90.00',39,0,10,0),
(2,'Chang',1,1,'24 bouteilles (1 litre)','95.00',17,40,25,0)
,(3,'Aniseed Syrup',1,2,'12 bouteilles (550 ml)','50.00',13,70,25,0)
,(4,'Chef Antons Cajun Seasoning',2,2,'48 pots (6 onces)','110.00',53,0,0,0)
,(5,'Chef Antons Gumbo Mix',2,2,'36 boites','106.75',0,0,0,1)
,(6,'Grandmas Boysenberry Spread',3,2,'12 pots (8 onces)','125.00',120,0,25,0)
,(7,'Uncle Bobs Organic Dried Pears',3,7,'12 cartons (1 kg)','150.00',15,0,10,0)
,(8,'Northwoods Cranberry Sauce',3,2,'12 pots (12 onces)','200.00',6,0,0,0)
,(9,'Mishi Kobe Niku',4,6,'18 cartons (500 g)','485.00',29,0,0,1)
,(10,'Ikura',4,8,'12 pots (200 g)','155.00',31,0,0,0)
,(11,'Queso Cabrales',5,4,'1 carton (1 kg)','105.00',22,30,30,0)
,(12,'Queso Manchego La Pastora',5,4,'10 cartons (500 g)','190.00',86,0,0,0)
,(13,'Konbu',6,8,'1 boites (2 kg)','30.00',24,0,5,0)
,(14,'Tofu',6,7,'40 cartons (100 g)','116.25',35,0,0,0)
,(15,'Genen Shouyu',6,2,'24 bouteilles (250 ml)','77.50',39,0,5,0)
,(16,'Pavlova',7,3,'32 boites (500 g)','87.25',29,0,10,0)
,(17,'Alice Mutton',7,6,'20 boites (1 kg)','195.00',0,0,0,1)
,(18,'Carnarvon Tigers',7,8,'1 carton (16 kg)','312.50',42,0,0,0)
,(19,'Teatime Chocolate Biscuits',8,3,'10 boites x 12 pices','46.00',25,0,5,0)
,(20,'Sir Rodneys Marmalade',8,3,'30 boites','405.00',40,0,0,0)
,(21,'Sir Rodneys Scones',8,3,'24 cartons x 4 pices','50.00',3,40,5,0)
,(22,'Gustafs Kneckebrad',9,5,'24 cartons (500 g)','105.00',104,0,25,0)
,(23,'Tunnbrad',9,5,'12 cartons (250 g)','45.00',61,0,25,0)
,(24,'Guaran  Fant stica',10,1,'12 canettes (355 ml)','22.50',20,0,0,1)
,(25,'NuNuCa Nuá-Nougat-Creme',11,3,'20 verres (450 g)','70.00',76,0,30,0)
,(26,'Gumber Gummiberchen',11,3,'100 sacs (250 g)','156.15',15,0,0,0)
,(27,'Schoggi Schokolade',11,3,'100 pices (100 g)','219.50',49,0,30,0)
,(28,'Rassle Sauerkraut',12,7,'25 canettes (825 g)','228.00',26,0,0,1)
,(29,'Thringer Rostbratwurst',12,6,'50 sacs x 30 saucisses','618.95',0,0,0,1)
,(30,'Nord-Ost Matjeshering',13,8,'10 verres (200 g)','129.45',10,0,15,0)
,(31,'Gorgonzola Telino',14,4,'12 cartons (100 g)','62.50',0,70,20,0)
,(32,'Mascarpone Fabioli',14,4,'24 cartons (200 g)','160.00',9,40,25,0)
,(33,'Geitost',15,4,'1 carton (500 g)','12.50',112,0,20,0)
,(34,'Sasquatch Ale',16,1,'24 bouteilles (70 cl)','70.00',111,0,15,0)
,(35,'Steeleye Stout',16,1,'24 bouteilles (1 litre)','90.00',20,0,15,0)
,(36,'Inlagd Sill',17,8,'24 pots (250 g)','95.00',112,0,20,0)
,(37,'Gravad lax',17,8,'12 cartons (500 g)','130.00',11,50,25,0)
,(38,'Cte de Blaye',18,1,'12 bouteilles (75 cl)','1317.50',17,0,15,0)
,(39,'Chartreuse verte',18,1,'1 bouteille (750 cc)','90.00',69,0,5,0)
,(40,'Boston Crab Meat',19,8,'24 boites (4 onces)','92.00',123,0,30,0)
,(41,'Jacks New England Clam Chowder',19,8,'12 canettes (330 ml)','48.25',85,0,10,0)
,(42,'Singaporean Hokkien Fried Mee',20,5,'32 cartons (1 kg)','70.00',26,0,0,1)
,(43,'Ipoh Coffee',20,1,'16 boites (500 g)','230.00',17,10,25,0)
,(44,'Gula Malacca',20,2,'20 cartons (2 kg)','97.25',27,0,15,0)
,(45,'Rgede sild',21,8,'1 carton (1kg)','47.50',5,70,15,0)
,(46,'Spegesild',21,8,'4 boites (250 g)','60.00',95,0,0,0)
,(47,'Zaanse koeken',22,3,'10 boites (4 onces)','47.50',36,0,0,0)
,(48,'Chocolade',22,3,'10 cartons','63.75',15,70,25,0)
,(49,'Maxilaku',23,3,'24 cartons (50 g)','100.00',10,60,15,0)
,(50,'Valkoinen suklaa',23,3,'12 plaquettes (100 g)','81.25',65,0,30,0)
,(51,'Manjimup Dried Apples',24,7,'50 cartons (300 g)','265.00',20,0,10,0)
,(52,'Filo Mix',24,5,'16 boites (2 kg)','35.00',38,0,25,0)
,(53,'Perth Pasties',24,6,'48 pices','164.00',0,0,0,1)
,(54,'Tourtire',25,6,'16 tartes','37.25',21,0,10,0)
,(55,'Pte chinois',25,6,'24 boites x 2 tartes','120.00',115,0,20,0)
,(56,'Gnocchi di nonna Alice',26,5,'24 cartons (250 g)','190.00',21,10,30,0)
,(57,'Ravioli Angelo',26,5,'24 cartons (250 g)','97.50',36,0,20,0)
,(58,'Escargots de Bourgogne',27,8,'24 pices','66.25',62,0,20,0)
,(59,'Raclette Courdavault',28,4,'1 carton (5 kg)','275.00',79,0,0,0)
,(60,'Camembert Pierrot',28,4,'15 unites (300 g)','170.00',19,0,0,0)
,(61,'Sirop derable',29,2,'24 bouteilles (500 ml)','142.50',113,0,25,0)
,(62,'Tarte au sucre',29,3,'48 tartes','246.50',17,0,0,0)
,(63,'Vegie-spread',7,2,'15 pots (625 g)','219.50',24,0,5,0)
,(64,'Wimmers gute Semmelknadel',12,5,'20 sacs x 4 pices','166.25',22,80,30,0)
,(65,'Louisiana Fiery Hot Pepper Sauce',2,2,'32 bouteilles (8 onces)','105.25',76,0,0,0)
,(66,'Louisiana Hot Spiced Okra',2,2,'24 pots (8 onces)','85.00',4,100,20,0)
,(67,'Laughing Lumberjack Lager',16,1,'24 bouteilles (12 onces)','70.00',52,0,10,0)
,(68,'Scottish Longbreads',8,3,'10 sacs x 8 pices','62.50',6,10,15,0)
,(69,'Gudbrandsdalsost',15,4,'1 carton (10 kg)','180.00',26,0,15,0)
,(70,'Outback Lager',7,1,'24 bouteilles (355 ml)','75.00',15,10,30,0)
,(71,'Fltemysost',15,4,'10 cartons (500 g)','107.50',26,0,0,0)
,(72,'Mozzarella di Giovanni',14,4,'24 cartons (200 g)','174.00',14,0,0,0)
,(73,'Rad Kaviar',17,8,'24 pots (150 g)','75.00',101,0,5,0)
,(74,'Longlife Tofu',4,7,'1 carton (5 kg)','50.00',4,20,5,0)
,(75,'Rhanbreu Klosterbier',12,1,'24 bouteilles (0,5 litre)','38.75',125,0,25,0)
,(76,'Lakkalikaari',23,1,'1 bouteille (500 ml)','90.00',57,0,20,0)
,(77,'Original Frankfurter grne Soáe',12,2,'12 boites','65.00',32,0,15,0)
,(78,'Mozzarella di Giovanni',14,4,'10 cartons (200 g)','90.00',50,0,5,0)
,(79,'Rad Kaviar',17,8,'10 pots (150 g)','40.00',150,0,0,0)
,(80,'Calvados',18,1,'1 bouteille (750 cc)','150.00',50,20,10,0)
,(81,'Pave dIsygny',30,4,'15 unites (300 g)','250.00',30,10,0,0)
,(82,'Calvados de Mutrecy',30,1,'1 bouteille (750 cc)','145.00',30,0,10,0)
,(83,'Poire',30,1,'12 bouteilles (75 cl)','300.00',40,5,10,0)
,(84,'Sables dAsnelles',30,3,'4 boites (500 g)','325.50',50,0,0,0);


INSERT INTO public._fournisseur(nofour, societe, contact, fonction, adresse, ville, region, codepostal, pays, tel, fax, pageaccueil)
	VALUES (1,'Exotic Liquids','Charlotte Cooper','Assistant export','49 Gilbert St.','London','unknown_value_please_contact_support','EC1 4SD','Royaume-Uni','(171) 555-2222','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(2,'New Orleans Cajun Delights','Shelley Burke','Acheteur','P.O. Box 78934','New Orleans','LA','70117','Etats-Unis','(100) 555-4822','unknown_value_please_contact_support','Cajun.htm#CAJUN.HTM#'
),(3,'Grandma Kellys Homestead','Regina Murphy','Reprsentant(e)','707 Oxford Rd.','Ann Arbor','MI','48104','Etats-Unis','(313) 555-5735','(313) 555-3349','unknown_value_please_contact_support'
),(4,'Tokyo Traders','Yoshi Nagase','Directeur du marketing','9-8 Sekimai  Musashino-shi','Tokyo','unknown_value_please_contact_support','100','Japon','(03) 3555-5011','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(5,'Cooperativa de Quesos Las Cabras','Antonio del Valle Saavedra','Responsable export','Calle del Rosal 4','Oviedo','Asturias','33007','Espagne','(98) 598 76 54','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(6,'Mayumis','Mayumi Ohno','Chef de produit','92 Setsuko  Chuo-ku','Osaka','unknown_value_please_contact_support','545','Japon','(06) 431-7877','unknown_value_please_contact_support','Mayumis (sur le World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#'
),(7,'Pavlova, Ltd.','Ian Devling','Directeur du marketing','74 Rose St.  Moonie Ponds','Melbourne','Victoria','3058','Australie','(059) 55-5450','(03) 444-6588','unknown_value_please_contact_support'
),(8,'Specialty Biscuits, Ltd.','Peter Wilson','Reprsentant(e)','29 Kings Way','Manchester','unknown_value_please_contact_support','M14 GSD','Royaume-Uni','(161) 555-4448','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(9,'PB Knckebrd AB','Lars Peterson','Assistant(e) des ventes','Kaloadagatan 13','Gteborg','unknown_value_please_contact_support','S-345 67','Sude','031-987 65 43','031-987 65 91','unknown_value_please_contact_support'
),(10,'Refrescos Americanas LTDA','Carlos Diaz','Directeur du marketing','Av. das Americanas 12.890','SÆo Paulo','unknown_value_please_contact_support','5442','Brsil','(11) 555 4640','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(11,'Heli Sáwaren GmbH & Co. KG','Petra Winkler','Chef des ventes','Tiergartenstraáe 5','Berlin','unknown_value_please_contact_support','10785','Allemagne','(010) 9984510','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(12,'Plutzer Lebensmittelgroámrkte AG','Martin Bein','Directeur du marketing international','Bogenallee 51','Frankfurt','unknown_value_please_contact_support','60439','Allemagne','(069) 992755','unknown_value_please_contact_support','Plutzer (sur le World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#'
),(13,'Nord-Ost-Fisch Handelsgesellschaft mbH','Sven Petersen','Responsable export','Frahmredder 112a','Cuxhaven','unknown_value_please_contact_support','27478','Allemagne','(04721) 8713','(04721) 8714','unknown_value_please_contact_support'
),(14,'Formaggi Fortini s.r.l.','Elio Rossi','Reprsentant(e)','Viale Dante, 75','Ravenna','unknown_value_please_contact_support','48100','Italie','(0544) 60323','(0544) 60603','Formaggi.htm#FORMAGGI.HTM#'
),(15,'Norske Meierier','Beate Vileid','Directeur du marketing','Hatlevegen 5','Sandvika','unknown_value_please_contact_support','1320','Norvge','(0)2-953010','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(16,'Bigfoot Breweries','Cheryl Saylor','Responsable de zone','3400 - 8th Avenue  Suite 210','Bend','OR','97101','Etats-Unis','(503) 555-9931','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(17,'Svensk Sjfda AB','Michael Bjrn','Reprsentant(e)','Brovallavgen 231','Stockholm','unknown_value_please_contact_support','S-123 45','Sude','08-123 45 67','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(18,'Aux joyeux ecclsiastiques','Guylne Nodier','Chef des ventes','203, Rue des Francs-Bourgeois','Paris','unknown_value_please_contact_support','75004','France','(1) 03.83.00.68','(1) 03.83.00.62','unknown_value_please_contact_support'
),(19,'New England Seafood Cannery','Robb Merchant','Responsable de zone','Order Processing Dept.  2100 Paul Revere Blvd.','Boston','MA','2134','Etats-Unis','(617) 555-3267','(617) 555-3389','unknown_value_please_contact_support'
),(20,'Leka Trading','Chandra Leka','Propritaire','471 Serangoon Loop, Suite #402','Singapore','unknown_value_please_contact_support','512','Singapour','555-8787','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(21,'Lyngbysild','Niels Petersen','Chef des ventes','Lyngbysild  Fiskebakken 10','Lyngby','unknown_value_please_contact_support','2800','Danemark','43844108','43844115','unknown_value_please_contact_support'
),(22,'Zaanse Snoepfabriek','Dirk Luchte','Chef comptable','Verkoop  Rijnweg 22','Zaandam','unknown_value_please_contact_support','9999 ZZ','Pays-Bas','(12345)1212','(12345) 1210','unknown_value_please_contact_support'
),(23,'Karkki Oy','Anne Heikkonen','Chef de produit','Valtakatu 12','Lappeenranta','unknown_value_please_contact_support','53120','Finlande','(953) 10956','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(24,'Gday, Mate','Wendy Mackenzie','Reprsentant(e)','170 Prince Edward Parade  Hunters Hill','Sydney','NSW','2042','Australie','unknown_value_please_contact_support','(02) 555-4873','Gday Mate (sur le World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#'
),(25,'Ma Maison','Jean-Guy Lauzon','Directeur du marketing','2960 Rue St. Laurent','Montral','Qubec','H1J 1C3','Canada','(514) 555-9022','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(26,'Pasta Buttini s.r.l.','Giovanni Giudici','Acheteur','Via dei Gelsomini, 153','Salerno','unknown_value_please_contact_support','84100','Italie','(089) 6547665','(089) 6547667','unknown_value_please_contact_support'
),(27,'Escargots Nouveaux','Marie Delamare','Chef des ventes','22, rue H. Voiron','Montceau','unknown_value_please_contact_support','71300','France','85.57.00.07','unknown_value_please_contact_support','unknown_value_please_contact_support'
),(28,'Gai pturage','Eliane Noz','Reprsentant(e)','Bat. B  3, rue des Alpes','Annecy','unknown_value_please_contact_support','74000','France','38.76.98.06','38.76.98.58','unknown_value_please_contact_support'
),(29,'Forts drables','Chantal Goulet','Chef comptable','148 rue Chasseur','Ste-Hyacinthe','Qubec','J2S 7S8','Canada','(514) 555-2955','(514) 555-2921','unknown_value_please_contact_support'
),(30,'Aux dlices normands','Danielle Hubert','Chef des ventes','45 rue de Paris','Caen','unknown_value_please_contact_support','14000','France','(1) 02.31.00.68','(1) 02.31.00.62','unknown_value_please_contact_support'
),(31,'Les caribous','Cyril Carolin','Propritaire','148 rue Chasseur','RT Rachel West','Qubec','J3MS 7S8','Canada','(514) 356-4578','(514) 356-4579','unknown_value_please_contact_support'
);

INSERT INTO public._commande(
	nocom, codecli, noemp, datecom, dateobjliv, dateenv, nomess, port, destinataire, adrliv, villeliv, regionliv, codepostalliv, paysliv)
	VALUES (10248,'VINET',5,'01/08/2014','10/08/2014','02/08/2014',3,162,'Vins et alcools Chevalier','59 rue de lAbbaye','Reims','unknown_value_please_contact_support','51100','France'),(10249,'TOMSP',6,'01/08/2014','10/08/2014','02/08/2014',1,58,'Toms Spezialitten','Luisenstr. 48','Mnster','unknown_value_please_contact_support','44087','Allemagne'),(10250,'HANAR',4,'01/08/2014','10/08/2014','05/08/2014',2,329,'Hanari Carnes','Rua do Pao, 67','Rio de Janeiro','RJ','05454-876','Brésil'),(10251,'VICTE',3,'01/08/2014','10/08/2014','02/08/2014',1,207,'Victuailles en stock','2, rue du Commerce','Lyon','unknown_value_please_contact_support','69004','France'),(10252,'SUPRD',4,'01/08/2014','10/08/2014','02/08/2014',2,256,'Suprèmes délices','Boulevard Tirou, 255','Charleroi','unknown_value_please_contact_support','B-6000','Belgique'),(10253,'HANAR',3,'01/08/2014','10/08/2014','10/08/2014',2,291,'Hanari Carnes','Rua do Pao, 67','Rio de Janeiro','RJ','05454-876','Brésil'),(10254,'CHOPS',5,'01/08/2014','10/08/2014','02/08/2014',2,115,'Chop-suey Chinese','Hauptstr. 31','Bern','unknown_value_please_contact_support','3012','Suisse'),(10255,'RICSU',9,'01/08/2014','10/08/2014','02/08/2014',3,742,'Richter Supermarkt','Starenweg 5','Genve','unknown_value_please_contact_support','1204','Suisse'),(10256,'WELLI',3,'01/08/2014','10/08/2014','11/08/2014',2,70,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brésil'),(10257,'HILAA',4,'01/08/2014','10/08/2014','15/08/2014',3,410,'HILARIàN-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Cristḃbal','T chira','5022','Venezuela'),(10258,'ERNSH',1,'01/08/2014','10/08/2014','02/08/2014',1,703,'Ernst Handel','Kirchgasse 6','Graz','unknown_value_please_contact_support','8010','Autriche'),(10259,'CENTC',4,'01/08/2014','10/08/2014','02/08/2014',3,16,'Centro comercial Moctezuma','Sierras de Granada 9993','México D.F.','unknown_value_please_contact_support','5022','Mexique'),(10260,'OTTIK',4,'01/08/2014','10/08/2014','22/08/2014',1,275,'Ottilies Kseladen','Mehrheimerstr. 369','Kln','unknown_value_please_contact_support','50739','Allemagne'),(10261,'QUEDE',4,'01/08/2014','10/08/2014','02/08/2014',2,15,'Que DelḂcia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brésil'),(10262,'RATTC',8,'01/08/2014','10/08/2014','02/08/2014',3,241,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis'),(10263,'ERNSH',9,'01/08/2014','10/08/2014','24/08/2014',3,730,'Ernst Handel','Kirchgasse 6','Graz','unknown_value_please_contact_support','8010','Autriche'),(10264,'FOLKO',6,'01/08/2014','10/08/2014','02/08/2014',3,18,'Folk och f HB','kergatan 24','Brcke','unknown_value_please_contact_support','S-844 67','Sude'),(10265,'BLONP',2,'01/08/2014','10/08/2014','02/08/2014',1,276,'Blondel pre et fils','24, place Kléber','Strasbourg','unknown_value_please_contact_support','67000','France'),(10266,'WARTH',3,'01/08/2014','10/08/2014','12/08/2014',3,129,'Wartian Herkku','Torikatu 38','Oulu','unknown_value_please_contact_support','90110','Finlande'),(10267,'FRANK',4,'01/08/2014','10/08/2014','02/09/2014',1,1043,'Frankenversand','Berliner Platz 43','Mnchen','unknown_value_please_contact_support','80805','Allemagne'),(10268,'GROSR',8,'01/08/2014','10/08/2014','02/09/2014',3,331,'GROSELLA-Restaurante','5Ḋ Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela'),(10269,'WHITC',5,'01/08/2014','10/08/2014','02/09/2014',1,23,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','Etats-Unis'),(10270,'WARTH',1,'01/08/2014','10/08/2014','02/09/2014',1,683,'Wartian Herkku','Torikatu 38','Oulu','unknown_value_please_contact_support','90110','Finlande'),(10271,'SPLIR',6,'01/08/2014','10/08/2014','02/09/2014',2,23,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','Etats-Unis'),(10272,'RATTC',6,'01/08/2014','10/08/2014','09/08/2014',2,490,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis'),(10273,'QUICK',3,'01/08/2014','10/08/2014','10/09/2014',3,380,'QUICK-Stop','Taucherstraáe 10','Cunewalde','unknown_value_please_contact_support','1307','Allemagne'),(10274,'VINET',6,'01/08/2014','10/08/2014','02/09/2014',1,30,'Vins et alcools Chevalier','59 rue de lAbbaye','Reims','unknown_value_please_contact_support','51100','France'),(10275,'MAGAA',1,'01/08/2014','10/08/2014','02/09/2014',1,135,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo','unknown_value_please_contact_support','24100','Italie'),(10276,'TORTU',8,'01/08/2014','10/08/2014','02/08/2014',3,69,'Tortuga Restaurante','Avda. Azteca 123','México D.F.','unknown_value_please_contact_support','5033','Mexique'),(10277,'MORGK',2,'01/08/2014','10/08/2014','12/08/2014',3,629,'Morgenstern Gesundkost','Heerstr. 22','Leipzig','unknown_value_please_contact_support','4179','Allemagne'),(10278,'BERGS',8,'01/08/2014','10/08/2014','12/08/2014',2,463,'Berglunds snabbkp','Berguvsvgen  8','Lule','unknown_value_please_contact_support','S-958 22','Sude'),(10279,'LEHMS',8,'01/08/2014','10/08/2014','12/08/2014',2,129,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.','unknown_value_please_contact_support','60528','Allemagne'),(10280,'BERGS',2,'01/08/2014','10/08/2014','12/08/2014',1,45,'Berglunds snabbkp','Berguvsvgen  8','Lule','unknown_value_please_contact_support','S-958 22','Sude'),(10281,'ROMEY',4,'01/08/2014','10/08/2014','12/08/2014',1,15,'Romero y tomillo','Gran VḂa, 1','Madrid','unknown_value_please_contact_support','28001','Espagne'),(10282,'ROMEY',4,'01/08/2014','10/08/2014','12/08/2014',1,63,'Romero y tomillo','Gran VḂa, 1','Madrid','unknown_value_please_contact_support','28001','Espagne'),(10283,'LILAS',3,'01/08/2014','10/08/2014','12/08/2014',2,424,'LILA-Supermercado','Carrera 52 con Ave. BolḂvar #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),(10284,'LEHMS',4,'01/08/2014','10/08/2014','12/08/2014',1,383,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.','unknown_value_please_contact_support','60528','Allemagne'),(10285,'QUICK',1,'01/08/2014','10/08/2014','12/08/2014',2,384,'QUICK-Stop','Taucherstraáe 10','Cunewalde','unknown_value_please_contact_support','1307','Allemagne'),(10286,'QUICK',8,'01/08/2014','10/08/2014','12/08/2014',3,1146,'QUICK-Stop','Taucherstraáe 10','Cunewalde','unknown_value_please_contact_support','1307','Allemagne'),(10287,'RICAR',8,'01/08/2014','03/08/2014','02/08/2014',3,64,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brésil'),(10288,'REGGC',4,'01/08/2014','15/08/2014','02/08/2014',1,37,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia','unknown_value_please_contact_support','42100','Italie'),(10289,'BSBEV',7,'01/08/2014','15/08/2014','02/08/2014',3,114,'Bs Beverages','Fauntleroy Circus','London','unknown_value_please_contact_support','EC2 5NT','Royaume-Uni'),(10290,'COMMI',8,'01/08/2014','15/08/2014','02/08/2014',1,398,'Comércio Mineiro','Av. dos LusḂadas, 23','SÆo Paulo','SP','05432-043','Brésil'),(10291,'QUEDE',6,'01/08/2014','10/08/2014','12/08/2014',2,32,'Que DelḂcia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brésil'),(10292,'TRADH',1,'01/08/2014','15/08/2014','02/08/2014',2,7,'TradiÆo Hipermercados','Av. Inès de Castro, 414','SÆo Paulo','SP','05634-030','Brésil'),(10293,'TORTU',1,'01/08/2014','15/08/2014','02/08/2014',3,106,'Tortuga Restaurante','Avda. Azteca 123','México D.F.','unknown_value_please_contact_support','5033','Mexique'),(10294,'RATTC',4,'01/08/2014','15/08/2014','02/08/2014',2,736,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis'),(10295,'VINET',2,'01/08/2014','15/08/2014','02/08/2014',2,6,'Vins et alcools Chevalier','59 rue de lAbbaye','Reims','unknown_value_please_contact_support','51100','France'),(10296,'LILAS',6,'01/08/2014','15/08/2014','02/08/2014',1,1,'LILA-Supermercado','Carrera 52 con Ave. BolḂvar #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),(10297,'BLONP',5,'01/08/2014','15/08/2014','02/08/2014',2,29,'Blondel pre et fils','24, place Kléber','Strasbourg','unknown_value_please_contact_support','67000','France'),(10298,'HUNGO',6,'01/08/2014','15/08/2014','02/08/2014',2,841,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork','unknown_value_please_contact_support','Irlande'),(10299,'RICAR',4,'01/08/2014','15/08/2014','02/08/2014',2,149,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brésil'),(10300,'MAGAA',2,'01/08/2014','15/08/2014','02/08/2014',2,88,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo','unknown_value_please_contact_support','24100','Italie'),(10301,'WANDK',8,'01/08/2014','15/08/2014','02/08/2014',2,225,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart','unknown_value_please_contact_support','70563','Allemagne'),(10302,'SUPRD',4,'01/08/2014','10/08/2014','02/08/2014',2,31,'Suprèmes délices','Boulevard Tirou, 255','Charleroi','unknown_value_please_contact_support','B-6000','Belgique'),(10303,'GODOS',7,'01/08/2014','10/08/2014','02/08/2014',2,539,'Godos Cocina TḂpica','C/ Romero, 33','Sevilla','unknown_value_please_contact_support','41101','Espagne'),(10304,'TORTU',1,'01/08/2014','10/08/2014','02/08/2014',2,319,'Tortuga Restaurante','Avda. Azteca 123','México D.F.','unknown_value_please_contact_support','5033','Mexique'),(10305,'OLDWO',8,'01/08/2014','10/08/2014','02/08/2014',3,1288,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','Etats-Unis'),(10306,'ROMEY',1,'01/08/2014','10/08/2014','02/08/2014',3,38,'Romero y tomillo','Gran VḂa, 1','Madrid','unknown_value_please_contact_support','28001','Espagne'),(10307,'LONEP',2,'01/08/2014','10/08/2014','02/08/2014',2,3,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','Etats-Unis'),(10308,'ANATR',7,'01/08/2014','10/08/2014','02/08/2014',3,8,'Ana Trujillo Emparedados y helados','Avda. de la Constituciḃn 2222','México D.F.','unknown_value_please_contact_support','5021','Mexique'),(10309,'HUNGO',3,'01/08/2014','10/08/2014','02/08/2014',1,236,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork','unknown_value_please_contact_support','Irlande'),(10310,'THEBI',8,'01/08/2014','10/08/2014','02/08/2014',2,88,'The Big Cheese','89 Jefferson Way  Suite 2','Portland','OR','97201','Etats-Unis'),(10311,'DUMON',1,'01/08/2014','10/08/2014','12/08/2014',3,123,'Du monde entier','67, rue des Cinquante Otages','Nantes','unknown_value_please_contact_support','44000','France'),(10312,'WANDK',2,'01/08/2014','10/08/2014','12/08/2014',2,201,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart','unknown_value_please_contact_support','70563','Allemagne'),(10313,'QUICK',2,'01/08/2014','10/08/2014','12/08/2014',2,10,'QUICK-Stop','Taucherstraáe 10','Cunewalde','unknown_value_please_contact_support','1307','Allemagne'),(10314,'RATTC',1,'01/08/2014','10/08/2014','12/08/2014',2,371,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis'),(10315,'ISLAT',4,'01/08/2014','10/08/2014','12/08/2014',2,209,'Island Trading','Garden House  Crowther Way','Cowes','Isle of Wigth','PO31 7PJ','Royaume-Uni'),(10316,'RATTC',1,'01/08/2014','10/08/2014','22/08/2014',3,751,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis'),(10317,'LONEP',6,'01/08/2014','10/08/2014','22/08/2014',1,63,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','Etats-Unis'),(10318,'ISLAT',8,'01/08/2014','10/08/2014','22/08/2014',2,24,'Island Trading','Garden House  Crowther Way','Cowes','Isle of Wigth','PO31 7PJ','Royaume-Uni'),(10319,'TORTU',7,'01/08/2014','15/08/2014','22/08/2014',3,322,'Tortuga Restaurante','Avda. Azteca 123','México D.F.','unknown_value_please_contact_support','5033','Mexique'),(10320,'WARTH',5,'01/08/2014','10/08/2014','22/08/2014',3,173,'Wartian Herkku','Torikatu 38','Oulu','unknown_value_please_contact_support','90110','Finlande'),(10321,'ISLAT',3,'01/08/2014','10/08/2014','22/08/2014',2,17,'Island Trading','Garden House  Crowther Way','Cowes','Isle of Wigth','PO31 7PJ','Royaume-Uni'),(10322,'PERIC',7,'01/08/2014','10/08/2014','02/08/2014',3,2,'Pericles Comidas cl sicas','Calle Dr. Jorge Cash 321','México D.F.','unknown_value_please_contact_support','5033','Mexique'),(10323,'KOENE',4,'01/08/2014','15/08/2014','02/08/2014',1,24,'Kniglich Essen','Maubelstr. 90','Brandenburg','unknown_value_please_contact_support','14776','Allemagne'),(10324,'SAVEA',9,'01/08/2014','15/08/2014','02/08/2014',1,1071,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','Etats-Unis'),(10325,'KOENE',1,'01/08/2014','15/08/2014','02/08/2014',3,324,'Kniglich Essen','Maubelstr. 90','Brandenburg','unknown_value_please_contact_support','14776','Allemagne'),(10326,'BOLID',4,'01/08/2014','15/08/2014','02/08/2014',2,390,'Bḃlido Comidas preparadas','C/ Araquil, 67','Madrid','unknown_value_please_contact_support','28023','Espagne'),(10327,'FOLKO',2,'01/08/2014','15/08/2014','02/08/2014',1,317,'Folk och f HB','kergatan 24','Brcke','unknown_value_please_contact_support','S-844 67','Sude'),(10328,'FURIB',4,'01/08/2014','15/08/2014','02/08/2014',3,435,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa','unknown_value_please_contact_support','1675','Portugal'),(10329,'SPLIR',4,'01/08/2014','15/08/2014','02/08/2014',2,958,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','Etats-Unis'),(10330,'LILAS',3,'01/08/2014','15/08/2014','02/08/2014',1,64,'LILA-Supermercado','Carrera 52 con Ave. BolḂvar #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),(10331,'BONAP',9,'01/08/2014','15/08/2014','02/08/2014',1,51,'Bon app','12, rue des Bouchers','Marseille','unknown_value_please_contact_support','13008','France'),(10332,'MEREP',3,'01/08/2014','15/08/2014','02/08/2014',2,264,'Mre Paillarde','43 rue St. Laurent','Montréal','Québec','H1J 1C3','Canada'),(10333,'WARTH',5,'01/08/2014','05/08/2014','02/08/2014',3,3,'Wartian Herkku','Torikatu 38','Oulu','unknown_value_please_contact_support','90110','Finlande'),(10334,'VICTE',8,'01/08/2014','05/08/2014','02/08/2014',2,43,'Victuailles en stock','2, rue du Commerce','Lyon','unknown_value_please_contact_support','69004','France'),(10335,'HUNGO',7,'01/08/2014','06/08/2014','02/08/2014',2,211,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork','unknown_value_please_contact_support','Irlande'),(10336,'PRINI',7,'01/08/2014','05/08/2014','02/08/2014',2,78,'Princesa Isabel Vinhos','Estrada da sa£de n. 58','Lisboa','unknown_value_please_contact_support','1756','Portugal'),(10337,'FRANK',4,'01/08/2014','05/08/2014','02/08/2014',3,541,'Frankenversand','Berliner Platz 43','Mnchen','unknown_value_please_contact_support','80805','Allemagne'),(10338,'OLDWO',4,'01/08/2014','01/08/2014','02/08/2014',3,421,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','Etats-Unis'),(10339,'MEREP',2,'01/08/2014','01/08/2014','02/08/2014',2,78,'Mre Paillarde','43 rue St. Laurent','Montréal','Québec','H1J 1C3','Canada'),(10340,'BONAP',1,'01/08/2014','05/08/2014','02/08/2014',3,832,'Bon app','12, rue des Bouchers','Marseille','unknown_value_please_contact_support','13008','France'),(10341,'SIMOB',7,'01/08/2014','15/08/2014','02/08/2014',3,134,'Simons bistro','Vinbltet 34','Kbenhavn','unknown_value_please_contact_support','1734','Danemark'),(10342,'FRANK',4,'01/08/2014','15/08/2014','02/08/2014',2,274,'Frankenversand','Berliner Platz 43','Mnchen','unknown_value_please_contact_support','80805','Allemagne'),(10343,'LEHMS',4,'01/08/2014','10/08/2014','02/08/2014',1,552,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.','unknown_value_please_contact_support','60528','Allemagne'),(10344,'WHITC',4,'01/08/2014','15/08/2014','02/08/2014',2,116,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','Etats-Unis'),(10345,'QUICK',2,'01/08/2014','15/08/2014','02/08/2014',2,1245,'QUICK-Stop','Taucherstraáe 10','Cunewalde','unknown_value_please_contact_support','1307','Allemagne'),(10346,'RATTC',3,'01/08/2014','15/08/2014','02/08/2014',3,710,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','Etats-Unis'),(10347,'FAMIA',4,'01/08/2014','15/08/2014','02/08/2014',3,16,'Familia Arquibaldo','Rua Orḃs, 92','SÆo Paulo','SP','05442-030','Brésil')
;

INSERT INTO public._detailcommande(nocom, refprod, prixunit, qte, remise)
	VALUES (10248,11,70,12,0.00),(10248,42,49,10,0.00), (10248,72,174,5,0.00), (10249,14,93,9,0.00),  (10249,51,212,40,0.00),(10250,41,38,10,0.00),(10250,51,212,35,0.15),(10250,65,84,15,0.15), (10251,22,84,6,0.05), (10251,57,78,15,0.05), (10251,65,84,20,0.00), (10252,20,324,40,0.05),(10252,33,10,25,0.05), (10252,60,136,40,0.00),(10253,31,5,20,0.00), (10253,39,72,42,0.00), (10253,49,80,40,0.00), (10254,24,18,15,0.15),(10254,55,96,21,0.15), (10254,74,40,21,0.00), (10255,2,76,20,0.00), (10255,16,70,35,0.0),  (10255,36,76,25,0.00), (10255,59,220,30,0.00),(10256,53,131,15,0.00),(10256,77,52,12,0.00), (10257,27,176,25,0.00),(10257,39,72,6,0.00), (10257,77,52,15,0.00), (10258,2,76,50,0.20),(10258,5,85,65,0.20), (10258,32,128,6,0.20), (10259,21,40,10,0.00), (10259,37,104,1,0.00), (10260,41,38,16,0.25), (10260,57,78,50,0.00),(10260,6,197,15,0.25), (10260,70,60,21,0.25), (10261,21,40,20,0.00), (10261,35,72,20,0.00), (10262,5,85,12,0.20),  (10262,7,120,15,0.00),(10262,56,152,2,0.00), (10263,16,70,60,0.25),  (10263,24,18,28,0.00), (10263,30,104,60,0.25),(10263,74,40,36,0.25), (10264,2,76,35,0.00),(10264,41,38,25,0.15), (10265,17,156,30,0.00),(10265,70,60,20,0.00), (10266,12,152,12,0.05),(10267,40,74,50,0.00), (10267,59,220,70,0.15),(10267,76,72,15,0.15), (10268,29,495,10,0.00),(10268,72,139,4,0.00), (10269,33,10,60,0.05), (10269,72,139,20,0.05), (10270,36,76,30,0.00),(10270,43,184,25,0.00),(10271,33,10,24,0.00), (10272,20,324,6,0.00), (10272,31,50,40,0.00), (10272,72,139,24,0.00),(10273,10,124,24,0.05),(10273,31,50,15,0.05), (10273,33,10,20,0.00), (10273,40,74,60,0.05), (10273,76,72,33,0.05), (10274,71,86,20,0.00), (10274,72,139,7,0.00),(10275,24,1,12,0.05),  (10275,59,220,6,0.05), (10276,10,124,15,0.00),(10276,13,24,10,0.00), (10277,28,182,20,0.00),(10277,62,197,12,0.00),(10278,44,78,16,0.00), (10278,59,220,15,0.00),(10278,63,17,8,0.00),  (10278,73,60,25,0.00), (10279,17,156,15,0.25),(10280,24,18,12,0.00),   (10282,57,78,2,0.00),  (10283,15,62,20,0.00), (10283,19,36,18,0.00), (10283,60,136,35,0.00),(10283,72,139,3,0.00), (10284,2,176,15,0.25),(10284,44,78,21,0.00), (10284,60,136,20,0.25),(10284,67,56,5,0.25),  (10285,1,72,45,0.20),(10280,55,96,20,0.00), (10280,75,31,30,0.00), (10281,19,36,1,0.00),  (10281,24,18,6,0.00),   (10281,35,72,4,0.00),  (10282,30,104,6,0.00);

