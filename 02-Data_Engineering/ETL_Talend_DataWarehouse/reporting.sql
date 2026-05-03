-- =========================================================
-- REQUÊTES DE REPORTING - SERVICE FINANCES
-- =========================================================

-- 1. Chiffre d'affaires global
CREATE OR REPLACE VIEW public.vw_ca_global AS
SELECT SUM(montant_ht) AS chiffre_affaires_total
FROM fait_ventes;

-- 2. Chiffre d'affaires moyen par société et par pays
CREATE OR REPLACE VIEW public.vw_ca_moyen_societe_par_pays AS
SELECT pays,
       COUNT(societe) AS nb_societes,
       SUM(ca_societe) AS ca_total,
       AVG(ca_societe) AS ca_moyen_par_societe
FROM (
    SELECT c.pays, c.societe, SUM(f.montant_ht) AS ca_societe
    FROM fait_ventes f
    JOIN dim_client c ON f.codecli = c.codecli
    GROUP BY c.pays, c.societe
) t
GROUP BY pays
ORDER BY AVG(ca_societe) DESC;

-- 3. Chiffre d'affaires par catégorie de produit
CREATE OR REPLACE VIEW public.vw_ca_par_categorie AS
SELECT p.codecateg, p.nomcateg,
       SUM(f.montant_ht) AS chiffre_affaires
FROM fait_ventes f
JOIN dim_produit p ON f.refprod = p.refprod
GROUP BY p.codecateg, p.nomcateg
ORDER BY SUM(f.montant_ht) DESC;

-- 4. Chiffre d'affaires par fonction d'employé
CREATE OR REPLACE VIEW public.vw_ca_par_fonction AS
SELECT e.fonction,
       SUM(f.montant_ht) AS chiffre_affaires
FROM fait_ventes f
JOIN dim_employe e ON f.noemp = e.noemp
GROUP BY e.fonction
ORDER BY SUM(f.montant_ht) DESC;

-- 5. Chiffre d'affaires par société et par pays
CREATE OR REPLACE VIEW public.vw_ca_par_societe_pays AS
SELECT c.pays, c.societe,
       SUM(f.montant_ht) AS chiffre_affaires
FROM fait_ventes f
JOIN dim_client c ON f.codecli = c.codecli
GROUP BY c.pays, c.societe
ORDER BY c.pays, SUM(f.montant_ht) DESC;

-- =========================================================
-- REQUÊTES DE REPORTING - SERVICE LOGISTIQUE
-- =========================================================

-- 6. Coût de livraison et taux de retard par transporteur
CREATE OR REPLACE VIEW public.vw_cout_vs_retard_transporteur AS
SELECT m.nommess AS transporteur,
       COUNT(l.nocom) AS nb_livraisons,
       ROUND(AVG(l.port), 2) AS frais_port_moyen,
       ROUND(100.0 * SUM(CASE WHEN l.dateenv > l.dateobjliv THEN 1 ELSE 0 END) / COUNT(l.nocom), 2) AS taux_retard_pourcent
FROM fait_livraisons l
JOIN dim_messager m ON l.nomess = m.nomess
GROUP BY m.nommess;

-- 7. Statut des délais de livraison
CREATE OR REPLACE VIEW public.vw_delais_livraison_statut AS
SELECT nocom, dateenv, dateobjliv,
       dateenv - dateobjliv AS retard_jours,
       CASE
           WHEN dateenv > dateobjliv THEN 'Retard'
           WHEN dateenv = dateobjliv THEN 'A l heure'
           ELSE 'En avance'
       END AS statut_livraison
FROM fait_livraisons;

-- 8. Frais de port par pays
CREATE OR REPLACE VIEW public.vw_frais_port_par_pays AS
SELECT paysliv,
       COUNT(nocom) AS nb_livraisons,
       SUM(port) AS frais_port_total,
       ROUND(AVG(port), 2) AS frais_port_moyen
FROM fait_livraisons
GROUP BY paysliv;

-- 9. Frais de port par transporteur
CREATE OR REPLACE VIEW public.vw_frais_port_par_transporteur AS
SELECT m.nommess AS transporteur,
       COUNT(l.nocom) AS nb_livraisons,
       SUM(l.port) AS frais_port_total,
       ROUND(AVG(l.port), 2) AS frais_port_moyen
FROM fait_livraisons l
JOIN dim_messager m ON l.nomess = m.nomess
GROUP BY m.nommess;