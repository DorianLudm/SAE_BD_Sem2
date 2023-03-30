-- Recherche de l'objet volé
-- • L’objet a été mis en vente en début de mois (avant le 15).
-- • Il a été mis en vente à une somme inférieure à 500€.
-- • Il a été vendu à plus de 10 fois le prix de vente initial.
--Vue qui permet d'obtenir toute les ventes qui ont eu pour prix final une offre de plus de 5000€
select DISTINCT idUt, pseudoUt, emailUT, idOb, nomOb
from UTILISATEUR NATURAL JOIN OBJET NATURAL JOIN VENTE
where DAY(debutVe) < 15 and prixBase < 500 and idVe in (select idVe
                                                        from ENCHERIR NATURAL JOIN VENTE
                                                        where montant > prixBase*10)
order by idUt;