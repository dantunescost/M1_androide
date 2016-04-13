(define (domain blockWorld)
	(:requirements :strips :typing)
	(:types block)
	(:predicates
		(on ?x - block ?y - block)
		(ontable ?x - block)
		(clear ?x - block)
		(handempty)
		(holding ?x - block))
	(:action pick-up ;;; action qui ramasse un bloc pose sur la table
		:parameters (?x - block)
		:precondition (and (clear ?x) (ontable ?x) (handempty))
		:effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding?x))
	)
	(:action stack ;;; action qui depose un bloc sur un autre bloc
		:parameters (?x - block ?y - block)
		:precondition (and (holding ?x) (clear ?y))
		:effect (and (handempty) (on ?x ?y) (clear ?x) (not (holding ?x)) (not (clear ?y)))
	)
	(:action unstack ;;; action qui retire un bloc qui est sur un autre bloc
		:parameters (?x - block ?y - block)
		:precondition (and (on ?x ?y) (clear ?x) (handempty))
		:effect (and (holding ?x) (clear ?y) (not (handempty)) (not (clear ?x)) (not (on ?x ?y)))
	)
	(:action put-down ;;; action qui depose un bloc sur la table
		:parameters (?x - block)
		:precondition (holding ?x)
		:effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x)))
	)
)

