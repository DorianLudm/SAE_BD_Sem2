-- Inserts
insert into UTILISATEUR(idUt,pseudoUt,emailUT,mdpUt,activeUt,idRole) values
	(874520,'IUTO','iuto1@info.univ-orleans.fr','IUTO','O',2);

insert into OBJET(idOb,nomOb,descriptionOb,idCat,idUt) values
	(734514,'Canapé clic-clac','Très beau et ayant peu servi',1,847);

insert into VENTE(idVe,prixBase,prixMin,debutVe,finVe,idSt,idOb) values
	(378421543,40,80,STR_TO_DATE('23/3/2023:00:00:00','%d/%m/%Y:%h:%i:%s'),DATE_ADD(STR_TO_DATE('30/3/2023:23:59:59','%d/%m/%Y:%h:%i:%s'), INTERVAL 8 DAY),2,734514);