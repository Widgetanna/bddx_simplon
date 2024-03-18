--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)

SELECT *
FROM potion

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)

SELECT  nb_points, nom_categ 
FROM categorie 
WHERE nb_points = 3;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)

SELECT nom_village AS villages_de_plus_de_35_huttes 
FROM village 
WHERE nb_huttes > 35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)

SELECT num_trophee AS numeros_de_trophee_pris_en_mai_et_juin
FROM trophee
WHERE EXTRACT(YEAR FROM date_prise) = 2052 
AND EXTRACT(MONTH FROM date_prise)= 5
OR EXTRACT(MONTH FROM date_prise)= 6;

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)

SELECT habitant.nom AS nom_des_habitants_commençant_par_a_et_contenant_lettre_r
FROM habitant
WHERE nom like 'A%r%';

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)

SELECT DISTINCT h.num_hab AS num_des_habitants_ayant_bu_les_potions_1_3_ou4
FROM habitant h
JOIN absorber a ON a.num_hab = h.num_hab
WHERE a.num_potion IN (1, 3, 4);
 
--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)

SELECT t.num_trophee, t.date_prise, c.nom_categ, h.nom 
FROM trophee t 
JOIN categorie c on t.code_cat  = c.code_cat 
JOIN habitant h ON t.num_preneur = h.num_hab;


--8. Nom des habitants qui habitent à Aquilona. (7 lignes)

SELECT nom AS habitants_de_Aquilna
from habitant h
JOIN village v ON h.num_village  = v.num_village
WHERE v.nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)

select h.nom AS nom_des_habitants_avec_des_trophee_de_categorie_Bouclier_de_Legat
from habitant h 
JOIN trophee t ON h.num_hab = t.num_preneur  
JOIN categorie c ON t.code_cat = c.code_cat 
WHERE c.nom_categ = 'Bouclier de Légat';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)

SELECT p.lib_potion AS potions_fabriquees_par_panoramix, formule, constituant_principal 
FROM fabriquer f 
JOIN potion p ON p.num_potion = f.num_potion 
JOIN habitant h ON h.num_hab = f.num_hab
WHERE h.nom = 'Panoramix';


--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)

SELECT DISTINCT p.lib_potion AS potion_absorbees_par_homeopatix 
FROM absorber a 
JOIN potion p ON p.num_potion = a.num_potion 
JOIN habitant h ON h.num_hab = a.num_hab 
WHERE h.nom = 'Homéopatix';


--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)

SELECT DISTINCT h.nom AS habitants_ayant_bu_potion_fabriquee_par_habitant_3
FROM absorber a 
JOIN habitant h on h.num_hab = a.num_hab 
JOIN fabriquer f on f.num_potion = a.num_potion
WHERE f.num_hab = 3;


--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)

SELECT DISTINCT h.nom AS habitants_ayant_absorbé_potion_fabriqué_par_Amnésix
FROM habitant h
JOIN absorber a ON a.num_hab = h.num_hab
JOIN fabriquer f ON f.num_potion = a.num_potion 
JOIN habitant h2 ON h2.num_hab = f.num_hab
WHERE h2.nom = 'Amnésix';


--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)

SELECT nom AS Habitants_sans_qualite
FROM habitant
WHERE num_qualite IS NULL;


--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)

SELECT DISTINCT h.nom AS nom_habitantayant_consomme_potion_en_fevrier_52
FROM habitant h 
JOIN absorber a ON a.num_hab = h.num_hab 
JOIN potion p ON p.num_potion = a.num_potion 
WHERE p.lib_potion = 'Potion magique n°1'
AND EXTRACT(YEAR FROM a.date_a) = 2052
AND EXTRACT(MONTH FROM a.date_a) = 2;

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
 
 SELECT nom, age
 FROM habitant h
 ORDER BY nom ASC;


--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)

SELECT nom_resserre, nom_village 
FROM village v
JOIN resserre r ON r.num_village = v.num_village 
ORDER BY r.superficie DESC;

--***
--18. Nombre d'habitants du village numéro 5. (4)

SELECT COUNT(num_hab) AS nombre_habitants_village_cinq
FROM habitant
WHERE num_village = 5;


--19. Nombre de points gagnés par Goudurix. (5)

SELECT SUM(c.nb_points) AS nombre_de_points_gagnes
FROM categorie c 
JOIN trophee t ON t.code_cat = c.code_cat 
JOIN habitant h ON h.num_hab = t.num_preneur 
WHERE h.nom = 'Goudurix';



--20. Date de première prise de trophée. (03/04/52)

SELECT TO_CHAR(MIN(date_prise), 'DD/MM/YYYY') AS date_prise_trophee
FROM trophee;


--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)

select sum(quantite) AS nombre_louches_de_potion
from absorber a
where a.num_potion = 2;

--22. Superficie la plus grande. (895)

SELECT max(superficie) AS la_plus_grande_superficie
FROM resserre;

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

SELECT v.nom_village, COUNT(h.num_hab) AS nombre_abitants
from habitant h 
join village v on v.num_village = h.num_village 
GROUP BY v.nom_village;


--24. Nombre de trophées par habitant (6 lignes)

SELECT h.nom, COUNT(t.num_trophee) AS nombre_de_trophees
FROM trophee t 
JOIN habitant h ON h.num_hab = t.num_preneur 
GROUP BY h.nom;


--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)

SELECT p.nom_province, 
       SUM(h.age) / COUNT(h.num_hab) AS moyenne_age
FROM province p 
JOIN village v on v.num_province = p.num_province 
JOIN habitant h on h.num_village = v.num_village 
GROUP BY p.nom_province;

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)

SELECT h.nom AS nom,COUNT(a.quantite) AS nombre
FROM potion p 
JOIN absorber a ON a.num_potion = p.num_potion
JOIN habitant h ON h.num_hab = a.num_hab 
GROUP BY h.nom;


--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

select nom as bu_plus_de_2_louches_potion_Zen 
from habitant h
join absorber a on h.num_hab = a.num_hab 
join potion p on a.num_potion = p.num_potion
where p.lib_potion = 'Potion Zen' and a.quantite  > 2;



--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
SELECT nom_village AS villages_avec_ressere
FROM village v
JOIN resserre r on r.num_village  = v.num_village


--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)

SELECT nom_village  AS villages_avec_plus_grande_nombre_huttes
FROM village v 
WHERE nb_huttes = (SELECT MAX(nb_huttes) FROM village);

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).

SELECT h.nom AS habitants_avec_plus_de_trophees
FROM habitant h
JOIN (
    SELECT num_preneur, COUNT(*) AS nb_trophees
    FROM trophee
    GROUP BY num_preneur
) AS trophees_par_habitant ON h.num_hab = trophees_par_habitant.num_preneur
WHERE trophees_par_habitant.nb_trophees > (
    SELECT COUNT(*) 
    FROM trophee
    WHERE num_preneur = (
        SELECT num_hab 
        FROM habitant 
        WHERE nom = 'Obélix'
    )
) AND h.nom != 'Obélix';

 -- version2

SELECT h.nom AS habitants_avec_plus_de_trophees
 FROM habitant h
 JOIN trophee t ON h.num_hab = t.num_preneur
 GROUP BY h.num_hab, h.nom
 HAVING COUNT(t.num_trophee) > (
    SELECT COUNT(*)
    FROM trophee
    WHERE num_preneur = (SELECT num_hab FROM habitant WHERE nom = 'Obélix')
) AND h.nom != 'Obélix';







