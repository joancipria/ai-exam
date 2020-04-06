(deffacts examen
    (servicio mesa 3 platos 3)
    (cocina 0 platos 5)
    (mesa 1 platos 0)
    (mesa 2 platos 0)
    (mesa 3 platos 1)
    (mesa 4 platos 0)
    (robot 0 platos 0)
)

(defrule cogerPlato
    ?c <- (cocina 0 platos ?numPlatosCocina)
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (= ?pos 0))
    (test (< ?numPlatosRobot 4))
    =>
    (retract ?c)
    (retract ?r)
    (assert (cocina 0 platos (- ?numPlatosCocina 1))) 
    (assert (robot ?pos platos (+ ?numPlatosRobot 1)))
)

(defrule servirMesa
    ?s <- (servicio mesa ?mesa platos ?platos)
    ?m <- (mesa ?numMesa platos ?munPlatosMesa)
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (>= ?numPlatosRobot ?platos))
    (test (= ?pos ?mesa))
    =>
    (retract ?s)
    (retract ?m)
    (retract ?r)
    (assert (mesa ?mesa platos (+ ?munPlatosMesa ?platos)))
    (assert (robot ?pos platos (- ?numPlatosRobot ?platos)))
)

(defrule irDerecha
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (< ?pos 4))
    =>
    (retract ?r)
    (assert (robot (+ ?pos 1) platos ?numPlatosRobot))
)

(defrule irIzquierda
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (> ?pos 0))
    =>
    (retract ?r)
    (assert (robot (- ?pos 1) platos ?numPlatosRobot))
)

(defrule recogerMesa
    ?m <- (mesa ?numMesa platos ?munPlatosMesa)
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (<= ?munPlatosMesa (- 4 ?numPlatosRobot)))
    =>
    (retract ?m)
    (retract ?r)
    (assert (mesa ?numMesa platos 0))
    (assert (robot ?pos platos ?munPlatosMesa))
)

(defrule fin
    (cocina 0 platos 6)
    => (halt)
)