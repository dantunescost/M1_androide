(defrule TequilaSunrise "Tequila Sunrise alors ingredients et proportions"
	(tequila_sunrise True)
	=>
	(assert (tequila True))
	(assert (jus_d_orange True))
	(assert (proportion_tequila Faible))
	(assert (proportion_jus_d_orange Forte))
)
(defrule LagonBleu "Lagon Bleu alors ingredients et proportions"
	(lagon_bleu True)
	=>
	(assert (vodka True))
	(assert (jus_de_citron True))
	(assert (curacao_bleu True))
	(assert (proportion_vodka Faible))
	(assert (proportion_jus_de_citron Faible))
	(assert (proportion_curacao_bleu Faible))
)
(defrule KirVinBlanc "Kir au vin blanc-) alors ingredients et proportions"
	(tequila_sunrise True)
	=>
	(assert (tequila True))
	(assert (jus_d_orange True))
	(assert (proportion_tequila Faible))
	(assert (proportion_jus_d_orange Forte))
)
