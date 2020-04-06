; Joan Ciprià - 20863920E

(deffacts examen
    (servir mesa 2 platos 2)
    (servir mesa 3 platos 3)
    (recoger mesa 3 platos 4)
    (recoger mesa 2 platos 1)
    (cocina 0 platos 5)
    (mesa 1 platos 0)
    (mesa 2 platos 0)
    (mesa 3 platos 1)
    (mesa 4 platos 0)
    (robot 0 platos 0)
)

; Coger todos los platos posibles mientras el robot este en cocina
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

; --- IDA ---
; Ir hacia la derecha hasta el tope, y servir las mesas que lo requieran
(defrule servirMesa
    ?s <- (servir mesa ?mesa platos ?platos)
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

; --- VUELTA ---
; Ir a la izquierda y recoger todas las mesas que lo requieran
(defrule recogerMesa
    ?s <- (recoger mesa ?mesa platos ?platos)
    ?m <- (mesa ?numMesa platos ?munPlatosMesa)
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (<= ?platos (- 4 ?numPlatosRobot)))
    (test (= ?pos ?mesa))
    =>
    (retract ?s)
    (retract ?m)
    (retract ?r)
    (assert (mesa ?mesa platos (- ?munPlatosMesa ?platos)))
    (assert (robot ?pos platos (+ ?numPlatosRobot ?platos)))
)

(defrule irIzquierda
    ?r <- (robot ?pos platos ?numPlatosRobot)
    (test (> ?pos 0))
    =>
    (retract ?r)
    (assert (robot (- ?pos 1) platos ?numPlatosRobot))
)

; To do: Dejar platos en cocina
; (defrule dejarPlato ...

; Fin cuando la cocina tenga 6 platos (to do: cuando no haya servicios/recoger que hacer)
(defrule fin
    (cocina 0 platos 6)
    => (halt)
)