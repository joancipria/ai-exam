(deffacts examen
    (cocina 0 platos 5)
    (mesa 1 platos 0)
    (mesa 2 platos 0)
    (mesa platos 0)
    (mesa 4 platos 0)
    (robot pos 0 platos 0)
)

(defrule cogerPlato
    ?m <- (mesa ?numMesa platos ?munPlatos)
)

defrule fin(
    (cocina 0 platos 6)
    =>
    (halt)
)