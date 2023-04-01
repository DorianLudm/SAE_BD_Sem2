-- Recherche de l'objet volé
-- • L’objet a été mis en vente en début de mois (avant le 15).
-- • Il a été mis en vente à une somme inférieure à 500€.
-- • Il a été vendu à plus de 10 fois le prix de vente initial.
select DISTINCT idUt, pseudoUt, emailUT, idOb, nomOb
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN VENTE v1
where DAY(debutVe) < 15 and prixBase < 500 and idVe in (select idVe
                                                        from ENCHERIR NATURAL JOIN VENTE v2
                                                        where montant > prixBase*10 and v1.idVe = v2.idVe)
order by idUt;