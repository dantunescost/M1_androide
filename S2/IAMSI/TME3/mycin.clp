(defrule eruption_1 "eruption avec peu de boutons"
	(boutons Peu)
	=>
	(assert (eruption_cutanee True))
)
(defrule eruption_2 "eruption avec beaucoup de boutons"
	(boutons Beaucoup)
	=>
	(assert (eruption_cutanee True))
)
(defrule exantheme_1 "exantheme avec eruption cutanee"
	(eruption_cutanee True)
	=>
	(assert (exantheme True))
)
(defrule exantheme_2 "exantheme avec rougeurs"
	(rougeurs True)
	=>
	(assert (exantheme True))
)
(defrule febrile_1 "febrile avec forte fievre"
	(forte_fievre True)
	=>
	(assert (febrile True))
)
(defrule febrile_2 "febrile avec sensation de froid"
	(sensation_de_froid True)
	=>
	(assert (febrile True))
)
(defrule suspect_1 "signe suspect avec amygdales rouges"
	(amygdales_rouges True)
	=>
	(assert (signe_suspect True))
)
(defrule suspect_2 "signe suspect avec taches rouges"
	(taches_rouges True)
	=>
	(assert (signe_suspect True))
)
(defrule suspect_3 "signe suspect avec peau qui pele"
	(peau_qui_pele True)
	=>
	(assert (signe_suspect True))
)
(defrule rougeole_1 "rougeole si on a un etat febrile, les yeux douloureux et un exantheme"
	(febrile True)
	(yeux_douloureux True)
	(exantheme True)
	=>
	(assert (rougeole True))
)
(defrule rougeole_2 "rougeole si on a une forte fievre et un signe suspect"
	(signe_suspect True)
	(forte_fievre True)
	=>
	(assert (rougeole True))
)
(defrule not_rougeole "pas de rougeole si peu de boutons et peu de fievre"
	(boutons Peu)
	(forte_fievre False)
	?f <- (rougeole True)
	=>
	(assert (rougeole False))
	(retract ?f)
)
(defrule douleur_1 "mal aux yeux signifie douleur"
	(yeux_douloureux True)
	=>
	(assert (douleur True))
)
(defrule douleur_2 "mal au dos signifie douleur"
	(dos_douloureux True)
	=>
	(assert (douleur True))
)
(defrule grippe "grippe si dos douloureux et etat febrile"
	(dos_douloureux True)
	(etat_febrile True)
	=>
	(assert (grippe True))
)
(defrule varicelle "varicelle est la quand pustules et demangeaisons se rencontrent"
	(rougeole False)	
	(pustules True)
	(demangeaisons True)
	=>
	(assert (varicelle True))
)
(defrule rubeole "rubeole = peau seche + inflammation ganglions - pustules - sensation de kalt"
	(rougeole False)
	(pustules False)
	(sensation_de_froid False)
	(peau_seche True)
	(inflammation_ganglions True)
	=>
	(assert (rubeole True))
)

(deffacts symptomes
	(taches_rouges True)
	(boutons Peu)
	(sensation_de_froid True)
	(forte_fievre True)
	(yeux_douloureux True)
	(amygdales_rouges True)
	(peau_seche True)
	(peau_qui_pele True)
)
