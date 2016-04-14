% Noeuds du graphe
noeud(1..7).

% Aretes du graphe
arete(1,2).
arete(2,3).
arete(1,3).
arete(2,4).
arete(2,6).
arete(4,5).
arete(3,4).
arete(1,5).
arete(3,5).
arete(3,6).
arete(4,6).
arete(5,6).
arete(5,7).
arete(6,7).

% Couleurs
couleur(1..4).

% On colorie tous les noeuds
1{colorus(N,C):couleur(C)}1 :- noeud(N).

% Contraintes
:- noeud(N1), noeud(N2), arete(N1,N2), colorus(N1,C), colorus(N2,C), N1!=N2.


#hide.
#show colorus/2.
