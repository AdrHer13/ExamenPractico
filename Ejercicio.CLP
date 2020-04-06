(deffacts BH 	(Robot mostrador 0 pesoPortado 50 pesoMax)
		(Posiciones mostrador 1 2 3 4)
		(Tarea 30 peso 1 a mostrador)
		(Tarea 20 peso 2 a mostrador)
		(Tarea 20 peso 3 a mostrador)
		(Tarea 40 peso mostrador a 2)
)

;;; -------- ---------
;

(defrule comprobar-tarea-en-lugar

	?f  <-  (Robot ?pos ?peso pesoPortado ?pesoMax pesoMax)
		(Tarea ?pesoObjeto peso ?pos a ?pos2)

	 =>
		(halt)
)