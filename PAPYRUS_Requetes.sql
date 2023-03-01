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
SELECT a.DESART,(SELECT a.SALART-a.QTEART FROM ARTICLE a)AS diference
FROM ARTICLE a
WHERE a.QTEART LIKE '%Pré-imprimé facture%';
-- ==============================================================================================
-- 4.	Calculer le nombre de commandes pass�es en 2007
--      et le nombre de fournisseurs concern�s.
SELECT COUNT(*)
FROM COMMANDE c
WHERE YEAR (c.DATCOM)='2007';
-- ==============================================================================================
-- 5.	Quels sont les fournisseurs situ�s dans les d�partements 75, 78, 92 ? 
--      L'affichage sera effectu� par d�partement croissant puis par ordre alphab�tique
SELECT   NOMFOUR, ADRFOUR  
FROM FOURNISSEUR
WHERE ADRFOUR LIKE '%75%' OR ADRFOUR LIKE '%78%'OR ADRFOUR LIKE '%92%'
ORDER BY  ADRFOUR,NOMFOUR;
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
SELECT  DISTINCT f.NUMFOUR, f.NOMFOUR 
FROM FOURNISSEUR f  JOIN COMMANDE c ON c.NUMFOUR = f.NUMFOUR

-- Si en plus on veut en plus afficher le nombre de commandes
SELECT DISTINCT f.NUMFOUR , f.NOMFOUR  ,COUNT(*) AS NbCMD
FROM FOURNISSEUR f  JOIN COMMANDE c ON f.NUMFOUR =c.NUMFOUR  
GROUP BY f.NUMFOUR
-- ==============================================================================================
-- 8.	Calculer le total de chaque commande. 
--      Pour chaque commande, afficher le num�ro de commande, le total
--      les trier par total d�croissant.

-- ==============================================================================================
-- 9.	Lister les commandes dont le montant est sup�rieur � 1500.

-- ==============================================================================================
-- 10. Calculer le CA r�alis� avec chaque fournisseur
 
-- ==============================================================================================
-- 11.	Compter le nombre de commandes pass�es par fournisseur. 
--      Pour chaque fournisseur, afficher le num�ro du fournisseur, la raison sociale. 
--      Trier les r�sultats par nombre de commandes d�croissant.

-- ==============================================================================================
-- 12.	Lister les fournisseurs susceptibles de livrer au moins 2 produits

-- ==============================================================================================
-- 13.	Trouver la liste des fournisseurs susceptibles de fournir
--      les produits I100 et I105


-- ==============================================================================================
-- 14.	Le fournisseur 00120 vous informe de ses nouveaux tarifs pour 2008 : ils augmentent tous de 5%. 
--      Mettre � jour la table tarif suite � cette information.

-- ==============================================================================================
-- 15.	On vous livre 100 unit�s du produit I105, vous vous empressez de mettre � jour la fiche stock.

-- ==============================================================================================
 --                                                    END_OF_FILE
-- ==============================================================================================



