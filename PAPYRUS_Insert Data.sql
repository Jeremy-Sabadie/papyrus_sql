INSERT INTO PRODUIT
(REFPROD, DESIG, STOCK, ALERT) VALUES
('I100', 'Papier 1 ex continu', 550, 100),
('I105', 'Papier 2 ex continu', 5, 75),
('I108', 'Papier 3 ex continu', 550, 100),
('I110', 'Papier 4 ex continu', 12, 10),
('P220', 'Pr�-imprim� commande', 500, 500),
('P230', 'Pr�-imprim� facture', 250, 500),
('P240', 'Pr�-imprim� bulletin paie', 3000, 500),
('P250', 'Pr�-imprim� bon livraison', 2500, 500),
('P270', 'Pr�-imprim� bon fabrication', 2500, 500),
('R080', 'Ruban Epson 850', 2, 10),
('R132', 'Ruban Epson 950', 5, 5),
('B002', 'Bande magn�tique 6250', 12, 20),
('B001', 'Bande magn�tique 1200', 40, 30),
('D035', 'CD R slim 80', 40, 25),
('D050', 'CD R-W 80', 4, 5);


INSERT INTO FOURNISSEUR (NUFOUR, RAISOC, ADRES, CDPOST, VILLE, CONTACT)
VALUES
(00120, 'GROBRIGAN', '20 rue du papier', '92200', 'PAPERCITY', 'GEORGES'),
(00540, 'ECLIPSE', null, '78250', 'BUGVILLE', null),
(08700, 'MEDICIS', '120 rue des plantes', '75014', 'PARIS', 'LISON'),
(09120, 'DISCOBOL', '11 rue de la r�publique', '85100', 'LA ROCHE SUR YON', null),
(09150, 'DEPANPAP', '17 Rue Stine', '59000', 'LILLES', 'JEAN'),
(09180, 'HURRYTAPE', '68, bd des octets', '04044', 'DUMPVILLE', null)
;

INSERT INTO COMMANDE (NUCOM, DTCOM, NUFOUR) 
VALUES
(070001, '2007/02/10', 00120),
(070002, '2007/03/01', 00540),
(070003, '2007/04/25', 09180),
(070004, '2007/04/30', 09150),
(070005, '2007/05/05', 00120),
(070006, '2007/06/06', 09120),
(070007, '2007/10/02', 08700),
(070008, '2007/10/02', 00540),
(070009, '2007/10/12', 00120),
(070010, '2007/10/12', 09180);


INSERT INTO LIGNE_COMMANDE (NUCOM, REFPROD, QTECOM , PU)
VALUES
(070001, 'I100', 100, 10),
(070001, 'I105', 200, 10),
(070001, 'I108', 100, 10),
(070001, 'D035', 200, 5),
(070001, 'P220', 100, 10),
(070001, 'P240', 300, 20),
(070002, 'I105', 100, 20),
(070003, 'B001', 10, 20),
(070003, 'B002', 10, 30),
(070004, 'I100', 100, 14),
(070004, 'I105', 200, 15),
(070005, 'I100', 100, 10),
(070005, 'P220', 100, 10),
(070006, 'I110', 50, 10),
(070007, 'P230', 150, 20),
(070007, 'P220', 100, 25),
(070008, 'I105', 50, 20),
(070009, 'I100', 50, 10),
(070009, 'P220', 100, 10),
(070010, 'B001', 200, 20),
(070010, 'B002', 200, 30);

INSERT into TARIF (REFPROD, NUFOUR, PUACH)
values
('I100', 00120, 10),
('I100', 00540, 11),
('I100', 08700, 12),
('I100', 09120, 13),
('I100', 09150, 14),
('I105', 00120, 10),
('I105', 00540, 20),
('I105', 08700, 15),
('I108', 00120,5),
('I108',09120,10),
('I110', 09180,5),
('I110', 09120, 10),
('D035', 00120, 5),
('D035', 09120,6),
('I105', 09120, 10),
('P220', 00120, 10),
('P230', 00120,20),
('P240',00120,20),
('P250', 09120, 10),
('P220', 08700,20),
('P230', 08700,25),
('R080', 09120,30),
('R132', 09120,30),
('B001', 09180,20),
('B002', 09180,30);

COMMIT;
