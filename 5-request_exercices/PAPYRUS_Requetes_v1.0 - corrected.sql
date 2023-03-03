-- 1.	Quelles sont les num�ros de commandes adress�es au fournisseur 00120 ? 
--      Les trier de la plus r�cente � la plus ancienne
select NUCOM, DTCOM, NUFOUR
from COMMANDE 
where NUFOUR = 00120
order by DTCOM desc;
-- ==============================================================================================

-- 2.	Afficher les produits ayant un stock inf�rieur ou �gal au stock d'alerte
select * 
from ARTICLE 
where QTEART  <=SALART;
-- ==============================================================================================

-- 3.	Afficher tous les produits qui sont des pr�-imprim�s. 
--      Pour chacun d'entre eux, calculer l'�cart entre la quantit� en stock et le seuil d'alerte.
select REFART , DESART , QTEART , SALART , SALART  - QTEART AS ecart
from ARTICLE a 
where DESART  like '%Pré-imprimé%';
-- ==============================================================================================
-- 4.	Calculer le nombre de commandes pass�es en 2007
--      et le nombre de fournisseurs concern�s.
select  count(NUMCOM) as "nBofOrder", 
		count(distinct NUMFOUR) as "Nb Fournisseurs"
from 	COMMANDE
where 	YEAR(DATCOM) = 2007 ;
-- ==============================================================================================

-- 5.	Quels sont les fournisseurs situ�s dans les d�partements 75, 78, 92 ? 
--      L'affichage sera effectu� par d�partement croissant puis par ordre alphab�tique


-- whith a fonction:

select SUBSTR('12100', 1, 2) ;

select SUBSTR(CDPOST, 1, 2)
from FOURNISSEUR ;

select * 
FROM FOURNISSEUR
where SUBSTR(CDPOST, 1, 2) IN ('75', '78', '92') ;
-- ============whith_regex:======================
where WHERE ADRFOUR REGEXP '(75|78|92)[0-9]{3}'; 
-- ==============================================================================================

-- 6.	Trouver les fournisseurs susceptibles de fournir le produit I100. 
--      Afficher le num�ro, la raison sociale du fournisseur et le prix pratiqu�.
--      Trier les r�sultats du moins cher au plus cher.

SELECT DISTINCT  f.NOMFOUR,a.REFART , t.PRUTAR 
FROM COMMANDE c  JOIN LIGNE l  ON l.NUMCOM = c.NUMCOM 
				JOIN  ARTICLE a  ON a.REFART = l.REFART
				JOIN FOURNISSEUR f ON f.NUMFOUR =c.NUMFOUR
				JOIN  TARIF t ON t.REFART = a.REFART 
				WHERE l.REFART ='I100'
				 ORDER BY  t.PRUTAR ASC 
-- ==============================================================================================

-- 7.	Afficher le num�ro et la raison sociale des fournisseurs 
--      auxquels des commandes ont �t� pass�es.
select distinct f.NUMFOUR , f.NOMFOUR 
from FOURNISSEUR f join COMMANDE c on f.NUMFOUR  = c.NUMFOUR; 

 -- Pas besoin de distinct car les fournissers sont uniques dans la table FOURNISSEUR
select NUMFOUR ,NOMFOUR 
from FOURNISSEUR
where NUMFOUR  in (select NUMFOUR  from COMMANDE) ;

-- Si en plus on veut en plus afficher le nombre de commandes
select f.NUMFOUR , f.NOMFOUR , count(c.NUMCOM)
from FOURNISSEUR f join COMMANDE c on f.NUMFOUR  = c.NUMFOUR  
group by f.NUMFOUR , f.NOMFOUR  ;
-- ==============================================================================================

-- 8.	Calculer le total de chaque commande. 
--      Pour chaque commande, afficher le num�ro de commande, le total
--      les trier par total d�croissant.
SELECT  l.NUMCOM,t.PRUTAR * l.QTELIG AS totalCMD 
FROM LIGNE l JOIN ARTICLE a  ON l.REFART = a.REFART
			JOIN  COMMANDE c ON l.NUMCOM = c.NUMCOM
			JOIN  TARIF t ON t.REFART = a.REFART 
GROUP BY l.NUMCOM
ORDER  BY totalCMD;
-- ==============================================================================================

-- 9.	Lister les commandes dont le montant est sup�rieur � 1500.
SELECT  l.NUMCOM,t.PRUTAR * l.QTELIG AS totalCMD 
FROM LIGNE l JOIN ARTICLE a  ON l.REFART = a.REFART
			JOIN  COMMANDE c ON l.NUMCOM = c.NUMCOM
			JOIN  TARIF t ON t.REFART = a.REFART 
GROUP BY l.NUMCOM
HAVING  totalCMD>1500;
-- ==============================================================================================

-- 10. Calculer le CA r�alis� avec chaque fournisseur
-- ====================NEED_TO_UPDATE_TOTCOM_OF_THE_COMMANDE_TABLE ========================================
 UPDATE  COMMANDE
SET TOTCOM =(SELECT  l.NUMCOM,t.PRUTAR * l.QTELIG AS totalCMD 
FROM LIGNE l JOIN ARTICLE a  ON l.REFART = a.REFART
			JOIN  COMMANDE c ON l.NUMCOM = c.NUMCOM
			JOIN  TARIF t ON t.REFART = a.REFART and c.NUMFOUR = t.NUMFOUR
GROUP BY l.NUMCOM);
-- ===========================================THEN_CALCULATION_OF_THE_CA===================================================
SELECT f.NOMFOUR, SUM(c.TOTCOM) AS CA_FOUR 
FROM COMMANDE c JOIN FOURNISSEUR f  ON c.NUMFOUR = f.NUMFOUR 
GROUP BY f.NOMFOUR; 
-- ==============================================================================================
-- 11.	Compter le nombre de commandes pass�es par fournisseur. 
--      Pour chaque fournisseur, afficher le num�ro du fournisseur, la raison sociale. 
--      Trier les r�sultats par nombre de commandes d�croissant.
SELECT f.NUMFOUR , f.NOMFOUR , COUNT(*) AS numberOfOrder 
FROM FOURNISSEUR f  JOIN COMMANDE c ON c.NUMFOUR = f.NUMFOUR
 GROUP  BY f.NOMFOUR
 ORDER  BY numberOfOrder; 
-- ==============================================================================================

-- 12.	Lister les fournisseurs susceptibles de livrer au moins 2 produits
Select f.NUFOUR, f.RAISOC, count(*) as NbProduits
from FOURNISSEUR f join TARIF t on f.NUFOUR = t.NUFOUR
group by f.NUFOUR, f.RAISOC 
having count(*) >= 2; 
-- ==============================================================================================

-- 13.	Trouver la liste des fournisseurs susceptibles de fournir
--      les produits I100 et I105
SELECT DISTINCT FOURNISSEUR.NUMFOUR, FOURNISSEUR.NOMFOUR
FROM FOURNISSEUR
INNER JOIN TARIF ON TARIF.NUMFOUR = FOURNISSEUR.NUMFOUR AND TARIF.REFART IN ('I100', 'I105');
-- ==============================================================================================

-- 14.	Le fournisseur 00120 vous informe de ses nouveaux tarifs pour 2008 : ils augmentent tous de 5%. 
--      Mettre � jour la table tarif suite � cette information.
UPDATE TARIF
SET PRUTAR = PRUTAR * 1.05
WHERE NUMFOUR = '00120';
-- ==============================================================================================

-- 15.	On vous livre 100 unit�s du produit I105, vous vous empressez de mettre � jour la fiche stock.
UPDATE ARTICLE 
SET QTEART = QTEART + 100
WHERE REFART = 'I105';
-- ==============================================================================================
--											END_OF_FILE
-- ==============================================================================================





