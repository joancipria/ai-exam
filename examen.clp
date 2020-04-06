(deffacts examen
    (cocina 0 platos 5)
    (mesa 1 platos 0)
    (mesa 2 platos 0)
    (mesa 3 platos 1)
    (mesa 4 platos 0)
    (robot 0 platos 0)
)

(defrule servirMesa
    ?m <- (mesa ?numMesa platos ?munPlatosMesa)
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (>= ?numPlatosRobot 1))
    =>
    (retract ?m)
    (retract ?r)
    (assert (mesa ?numMesa platos (- ?munPlatosMesa 1)))
    (assert (robot ?pos platos (+ ?numPlatosRobot 1)))
)

(defrule recogerMesa
    ?m <- (mesa ?numMesa platos ?munPlatosMesa)
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (<= ?munPlatosMesa 4))
    (test ( ?numPlatosRobot 4))
    =>
    (retract ?m)
    (retract ?r)
    (assert (mesa ?numMesa platos (- ?munPlatosMesa 1)))
    (assert (robot ?pos platos (+ ?numPlatosRobot 1)))
)

defrule fin(
    (cocina 0 platos 6)
    =>
    (halt)
)