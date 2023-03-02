-- 1.	Quelles sont les num�ros de commandes adress�es au fournisseur 00120 ? 
--      Les trier de la plus r�cente � la plus ancienne
SELECT c.NUMCOM ,f.ADRFOUR,c.DATCOM  
FROM FOURNISSEUR f JOIN COMMANDE c ON f.NUMFOUR =c.NUMFOUR 
WHERE f.NUMFOUR ='00120'
ORDER BY c.DATCOM DESC ;
-- ==============================================================================================
-- 2.	Afficher les produits ayant un stock inf�rieur ou �gal au stock d'alerte
SELECT a.DESART 
FROM ARTICLE a
WHERE a.QTEART<=a.SALART;
-- ==============================================================================================
-- 3.	Afficher tous les produits qui sont des pr�-imprim�s. 
--      Pour chacun d'entre eux, calculer l'�cart entre la quantit� en stock et le seuil d'alerte.
 SELECT *, QTEART -SALART AS ecartAlert
FROM ARTICLE 
WHERE CODCAT='PRE'
-- ==============================================================================================
-- 4.	Calculer le nombre de commandes pass�es en 2007
--      et le nombre de fournisseurs concern�s.
SELECT COUNT(DISTINCT NUMFOUR)
FROM COMMANDE c
WHERE YEAR (c.DATCOM)=2007;
-- ==============================================================================================
-- 5.	Quels sont les fournisseurs situ�s dans les d�partements 75, 78, 92 ? 
--      L'affichage sera effectu� par d�partement croissant puis par ordre alphab�tique
SELECT *FROM FOURNISSEUR f 
WHERE ADRFOUR REGEXP '(75|78|92)[0-9]{3}'; -- regex.
-- ==============================================================================================
-- 6.	Trouver les fournisseurs susceptibles de fournir le produit I100. 
--      Afficher le num�ro, la raison sociale du fournisseur et le prix pratiqu�.
--      Trier les r�sultats du moins cher au plus cher.
SELECT f.NUMFOUR , NOMFOUR , t.PRUTAR 
from FOURNISSEUR f
join TARIF t on t.NUMFOUR = f.NUMFOUR 
join ARTICLE a on t.REFART = a.REFART 
WHERE a.REFART = 'I100'ORDER by t.PRUTAR ;
 
-- ==============================================================================================
-- 7.	Afficher le num�ro et la raison sociale des fournisseurs 
--      auxquels des commandes ont �t� pass�es.
SELECT  DISTINCT f.NUMFOUR, f.NOMFOUR, (
    SELECT DISTINCT COUNT(*) AS NbCMD
FROM  COMMANDE c
WHERE c.NUMFOUR= f.NUMFOUR   
) 
FROM FOURNISSEUR f  JOIN COMMANDE c ON c.NUMFOUR = f.NUMFOUR

-- Si en plus on veut en plus afficher le nombre de commandes
SELECT DISTINCT f.NUMFOUR , f.NOMFOUR  ,COUNT(*) AS NbCMD
FROM FOURNISSEUR f  JOIN COMMANDE c ON f.NUMFOUR =c.NUMFOUR  
GROUP BY f.NUMFOUR
-- ==============================================================================================
-- 8.1	Calculer le total de chaque commande. 
--      Pour chaque commande, afficher le num�ro de commande, le total
--      les trier par total d�croissant.
SELECT l.NUMCOM, QTELIG, sum(l.QTELIG * t.PRUTAR) AS Total  
FROM  LIGNE l JOIN ARTICLE a ON a.REFART =l.REFART 
JOIN TARIF t ON l.REFART =t.REFART 
GROUP  BY NUMCOM 
ORDER  BY Total DESC;
-- Q8.2 Mettre à jour le total de chaque commande.

-- ==============================================================================================
-- 9.	Lister les commandes dont le montant est sup�rieur � 1500.
SELECT l.NUMCOM, QTELIG, sum(l.QTELIG * t.PRUTAR) AS Total  
FROM  LIGNE l JOIN ARTICLE a ON a.REFART =l.REFART 
JOIN TARIF t ON l.REFART =t.REFART 
GROUP BY NUMCOM 
HAVING  sum(l.QTELIG * t.PRUTAR)>1500
-- ==============================================================================================
-- 10. Calculer le CA r�alis� avec chaque fournisseur
 SELECT NUMFOUR , sum(TOTCOM)
FROM COMMANDE
GROUP BY NUMFOUR
-- ==============================================================================================
-- 11.	Compter le nombre de commandes pass�es par fournisseur. 
--      Pour chaque fournisseur, afficher le num�ro du fournisseur, la raison sociale. 
--      Trier les r�sultats par nombre de commandes d�croissant.
SELECT DISTINCT f.NUMFOUR ,f.NOMFOUR,COUNT(*) AS NbCMD
FROM FOURNISSEUR f  JOIN COMMANDE c  ON f.NUMFOUR =c.NUMFOUR 
GROUP BY f.NUMFOUR, f.NOMFOUR
ORDER BY COUNT(*) DESC
-- ==============================================================================================
-- 12.	Lister les fournisseurs susceptibles de livrer au moins 2 produits
 SELECT f.NOMFOUR, COUNT(a.REFART)  
 FROM FOURNISSEUR f JOIN COMMANDE c  ON f.NUMFOUR =c.NUMFOUR 
 JOIN LIGNE l  ON l.NUMCOM = c.NUMCOM 
 JOIN ARTICLE a  ON a.REFART  = l.REFART 
 GROUP  BY f.NOMFOUR 
 HAVING  COUNT(a.REFART)>2;

-- ==============================================================================================
-- 13.	Trouver la liste des fournisseurs susceptibles de fournir
--      les produits I100 et I105
 SELECT f.NUMFOUR , f.NOMFOUR 
from FOURNISSEUR f 
join TARIF t on f.NUMFOUR = t.NUMFOUR 
WHERE t.REFART = 'I100' or t.REFART = 'I105'GROUP by f.NUMFOUR;

-- ==============================================================================================
-- 14.	Le fournisseur 00120 vous informe de ses nouveaux tarifs augmentent tous de 5%. 
--      Mettre � jour la table tarif suite � cette information.
UPDATE  TARIF 
SET PRUART= PRUART *1.05;
WHERE NUMFOUR= '00120';

-- ==============================================================================================
-- 15.	On vous livre 100 unit�s du produit I105, vous vous empressez de mettre � jour la fiche stock.
UPDATE ARTICLE
SET QTEART = QTEART+100
WHERE  REFART = 'I105'
-- ==============================================================================================
 --                                                    END_OF_FILE
-- ==============================================================================================



