(define (domain blockWorldSimp)
	(:requirements :strips :typing)
	(:types block object)
	(:predicates
		(on ?x - block ?y - object)
		(clear ?x - object))
	(:action moveTo ;;; action qui ramasse un bloc pose sur un objet et le depose sur un bloc
		:parameters (?x - block ?y - object ?z - block)
		:precondition (and (clear ?x) (clear ?z) (on ?x ?y))
		:effect (and (not (on ?x ?y)) (not (clear ?z)) (on ?x ?z) (clear ?y))
	)
	(:action moveToTable ;;; action qui ramasse un bloc pose sur un bloc et le depose sur la table
		:parameters (?x - block ?y - block)
		:precondition (and (clear ?x) (on ?x ?y))
		:effect (and (not (on ?x ?y)) (clear ?y) (on ?x T))
	)
)
