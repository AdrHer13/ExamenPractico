
;En este punto he decidido empezar con Weka así que no habrán commits hasta acabar weka

;;; -------- ---------

(deffacts BH 	(Robot mostrador 0 pesoPortado 50 pesoMax)
		(Posiciones mostrador 1 2 3 4)
		(Tarea 1 30 peso 1 a mostrador)
		(Tarea 2 20 peso 2 a mostrador)
		(Tarea 3 20 peso 3 a mostrador)
		(Tarea 4 40 peso mostrador a 2)
)

;;; -------- ---------

(defrule comprobar-coger-en-lugar
	(declare (salience 15))
	?f  <-  (Robot ?pos ?peso pesoPortado ?pesoMax pesoMax $?paquetes)
		(Tarea ?n ?pesoObjeto peso ?pos a ?pos2)
		
	(test (<= (+ ?peso ?pesoObjeto) ?pesoMax))
	(test (not (member$ ?n $?paquetes)))

	 =>

	(retract ?f)
	(assert (Robot ?pos (+ ?peso ?pesoObjeto) pesoPortado ?pesoMax pesoMax $?paquetes ?n))
)

(defrule comprobar-dejar-en-lugar
	(declare (salience 20))
	?f  <-  (Robot ?pos ?peso pesoPortado ?pesoMax pesoMax $?paquetes1 ?n $?paquetes2)
	?f2  <-	(Tarea ?n ?peso2 peso ?pos2 a ?pos)
		
	(test (>= ?peso ?peso2))

	 =>

	(retract ?f)
	(retract ?f2)
	(assert (Robot ?pos (- ?peso ?peso2) pesoPortado ?pesoMax pesoMax))
)

(defrule moverse-derecha
	(declare (salience 10))
	?f  <-  (Robot ?pos ?peso pesoPortado ?pesoMax pesoMax $?paquetes)
		(Posiciones $?resto1 ?pos ?pos2 $?resto2)
	
	=>
	
	(retract ?f)
	(assert (Robot ?pos2 ?peso pesoPortado ?pesoMax pesoMax $paquetes))
)

(defrule moverse-izquierda
	(declare (salience 10))
	?f  <-  (Robot ?pos ?peso pesoPortado ?pesoMax pesoMax $?paquetes)
		(Posiciones $?resto1 ?pos ?pos2 $?resto2)
	
	=>
	
	(retract ?f)
	(assert (Robot ?pos2 ?peso pesoPortado ?pesoMax pesoMax $?paquetes))
)
