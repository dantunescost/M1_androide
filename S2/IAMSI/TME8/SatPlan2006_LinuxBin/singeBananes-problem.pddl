(define (problem singeBananes)
	(:domain singeBananes)
	(:objects Singe Bananes Caisse - object A B C - position Haut Bas - level)
	(:init (situe Singe A) (situe Bananes B) (situe Caisse C) (niveau Singe Bas)
		(niveau Caisse Bas) (niveau Bananes Haut) (mainsVides)

	)
	(:goal (possede Singe Bananes))
)
