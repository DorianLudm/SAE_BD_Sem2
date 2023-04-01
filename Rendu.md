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
On obtient alors les valeurs suivantes :  
```sql
| idUt | pseudoUt     | emailUT                   | idOb | nomOb                      |
|------|--------------|---------------------------|------|----------------------------|
|   36 | janjencan913 | janjencan913@orange.fr    |  325 | Buffet rouge               |
|   42 | buny         | buny@orange.fr            |  161 | Armoire verte              |
|   80 | julauvy722   | julauvy722@free.fr        |  404 | Cocotte verte              |
|   97 | voige850     | voige850@univ-orleans.fr  |  386 | Commode de qualité         |
|  114 | dyte040      | dyte040@gmail.com         |   40 | Commode jamais servie      |
|  119 | bytupi       | bytupi@free.fr            |  133 | T-shirt comme neuf         |
|  122 | jibypou59    | jibypou59@live.fr         |  163 | Marteau comme neuf         |
|  186 | janbymon768  | janbymon768@orange.fr     |  362 | Chemise de qualité         |
|  199 | laucou28     | laucou28@gmail.com        |  330 | Marteau vert               |
|  216 | vengeji      | vengeji@univ-orleans.fr   |  388 | Tournevis comme neuf       |
|  227 | voipan15     | voipan15@free.fr          |  270 | Casserole rouge            |
|  237 | lipoi        | lipoi@univ-orleans.fr     |   92 | Scie verte                 |
|  253 | jovouka61    | jovouka61@free.fr         |  146 | Pantalon vert              |
|  270 | roito043     | roito043@gmail.com        |  398 | Chaise jaune               |
|  276 | vasen09      | vasen09@gmail.com         |  382 | Marteau jaune              |
|  309 | sonoila2     | sonoila2@live.fr          |  285 | Marteau bleu               |
|  324 | cytisu       | cytisu@gmail.com          |  446 | Robe de qualité            |
|  413 | jive1        | jive1@orange.fr           |  159 | Chapeau bleu               |
|  444 | jacoi81      | jacoi81@live.fr           |  300 | T-shirt vert               |
|  491 | rendauny0    | rendauny0@univ-orleans.fr |  415 | Pantalon comme neuf        |
|  497 | sirausen5    | sirausen5@live.fr         |  112 | Pantalon bleu              |
|  504 | goikifon     | goikifon@orange.fr        |  433 | Cocotte de qualité         |
|  513 | baumurau726  | baumurau726@gmail.com     |  268 | Chemise comme neuve        |
|  610 | gybefou884   | gybefou884@orange.fr      |   54 | Armoire comme neuve        |
|  618 | banfefu434   | banfefu434@live.fr        |  141 | Robot ménager de qualité   |
|  657 | nouke        | nouke@univ-orleans.fr     |   50 | T-shirt jaune              |
|  674 | bende        | bende@univ-orleans.fr     |   59 | T-shirt jaune              |
|  704 | caumon91     | caumon91@gmail.com        |  412 | T-shirt de qualité         |
|  712 | rasouje00    | rasouje00@live.fr         |  315 | Chaise rouge               |
|  732 | senti        | senti@univ-orleans.fr     |  417 | Buffet jamais servi        |
|  747 | renfen40     | renfen40@live.fr          |  277 | Commode jamais servie      |
|  777 | nanjulen119  | nanjulen119@orange.fr     |  261 | Marteau bleu               |
|  792 | fonmenbou2   | fonmenbou2@free.fr        |  183 | Marteau jaune              |
|  818 | corenben     | corenben@orange.fr        |  337 | Armoire bleue              |
|  847 | toisopu452   | toisopu452@free.fr        |    1 | Pantalon de qualité        |
|  861 | kenbon065    | kenbon065@gmail.com       |   84 | Perceuse jamais servie     |
|  898 | janli0       | janli0@gmail.com          |  173 | Chemise bleue              |
|  925 | foitauny10   | foitauny10@orange.fr      |  241 | T-shirt rouge              |
|  933 | necan1       | necan1@orange.fr          |  335 | Chaise rouge               |
|  933 | necan1       | necan1@orange.fr          |  390 | Robot ménager rouge        |
|  989 | gauva911     | gauva911@univ-orleans.fr  |  215 | Scie jamais servie         |
|  991 | ganmi29      | ganmi29@univ-orleans.fr   |  333 | Casserole rouge            |
| 1001 | ght1ordi     | ght1ordi@free.fr          |  512 | Pantalon jaune             |  
```


Il y a alors 46 couples objet-utilisateur qui répondent aux critères de la recherche.  

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

## Synthèse :  
L'ensemble des livrables à été effectué, mais les requêtes auraient pue être perfectionner en les optimisant. En effet, certaines d'entre elles répondent aux problème mais de manière non efficace.

## Analyse :  
La plus grande difficulté rencontrée durant cette SAE était de ne pas se limiter aux connaissances du second semestre, mais de réutilliser notamment les notions vu durant le premier semestre, avec notamment les requêtes imbriquées par IN.  
Grâce à cette SAE, j'ai pu approfondir mes connaissances sur le "GROUP BY", j'ai pu apprendre comment on peu utiliser des résultats de requêtes SQL pour pouvoir faire tout type de graphe, et enfin j'ai pu découvrir la fonction "LIMIT".

## Démonstration de compétences

La SAE à pour but de travailler deux compétences :
- AC14.01 : Mettre à jour et interroger une base de données relationnelle (en requêtes directes ou à travers une application)
- AC14.02 : Visualiser des données  

J'ai pu mettre en oeuvre la compétence 14.02 en utilisant utilisant les données des requêtes en les transformants en graphes. Cette compétence a aussi été travaillé lors de la création des requêtes en utilisants celles-ci dans le terminal.  
La seconde compétence 14.01 à quand à elle était utilisé lors de la création des requêtes ainsi lors de l'ajout de données dans la base de données via les inserts.  


##### Par Ludmann Dorian 1.3b