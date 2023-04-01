#### SAE 2.04 – Exploitation d’une base de données, par Ludmann Dorian 1.3b

# Section 3 – Compréhension de la base de données
Retrouver un objet volé peut se retrouver être une tâche fastidieuse, surtout lorsqu'on ne possède que trois informations étant suivantes :  
- L’objet a été mis en vente en début de mois (avant le 15).
- Il a été mis en vente à une somme inférieure à 500€.
- Il a été vendu à plus de 10 fois le prix de vente initial.  

Pour pouvoir retrouver la liste des suspects, objets comme utilisateur, on utilise le script suivant :
```sql
select DISTINCT idUt, pseudoUt, emailUT, idOb, nomOb
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN VENTE v1
where DAY(debutVe) < 15 and prixBase < 500 and idVe in 
(select idVe from ENCHERIR NATURAL JOIN VENTE v2
where montant > prixBase*10 and v1.idVe = v2.idVe)
order by idUt;
```
# Section 4 – Insertion dans la base de données
Pour répondre à la demande faite dans la section 4, il suffit d'ajouter dans la base de données le nouvel utilisateur ainsi que l'objet pour ensuite pouvoir insérer la vente. Comme l'objet ne possède pas de photo, il n'y as pas d'autre insert à ajouter.  
Pour les insérer, on utilise le script suivant :
```sql
-- Inserts
insert into UTILISATEUR(idUt,pseudoUt,emailUT,mdpUt,activeUt,idRole) values
	(874520,'IUTO','iuto1@info.univ-orleans.fr','IUTO','O',2);

insert into OBJET(idOb,nomOb,descriptionOb,idCat,idUt) values
	(734514,'Canapé clic-clac','Très beau et ayant peu servi',1,847);

insert into VENTE(idVe,prixBase,prixMin,debutVe,finVe,idSt,idOb) values
	(378421543,40,80,STR_TO_DATE('23/3/2023:00:00:00','%d/%m/%Y:%h:%i:%s'),DATE_ADD(STR_TO_DATE('30/3/2023:23:59:59','%d/%m/%Y:%h:%i:%s'), INTERVAL 7 DAY),2,734514);
```
# Rendu