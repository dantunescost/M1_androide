:- dynamic pas_de_contradiction/0.
    
%%	%%%%%%%%%%%%%%%
%
% Representations :
% Graphe : (ListeIntervalles,ListeRelations)
% Relations : rel(IntervalleI,IntervalleJ,Rij)
%
%%	%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ajouter(+RelationIJ,+Graphe,+NouvelGraphe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajout d'une nouvelle relation dans un graphe

% 4 cas sont à distinguer suivant que les deux intervalles impliqués 
% dans la relation considérée sont déjà dans le graphe ou non

%% Cas 1 : les 2 intervalles sont déjà dans le graphe
% il faut vérifier que cette nouvelle information est compatible avec les informations déjà présentes
% si c'est le cas, il faut faire la mise à jour puis propager
% sinon, il faut signaler une contradiction
ajouter(rel(Ii,Ij,Rij),(Intervalles,Relations),NewGraphe):-

	member(Ii,Intervalles),member(Ij,Intervalles), % la paire était déjà présente dans le graphe
	extraire(Ii,Ij,Relations,RestRelations,ExistingRij), % extraction des informations précédentes sur cette paire

%	write('Found both: '),write(Ii),write(' and '),write(Ij),write(' with rels: '),write(Relations),nl,

	intersection(Rij,ExistingRij,NewRij), % mise à jour de la relation : calcul d'intersection
	
	% 2 cas à distinguer :
	% si les informations sont compatibles ou non,
	% c'est-à-dire si la conjonction avec la relation précédemment disponible produit un ensemble vide ou non
	(   length(NewRij,L),L>0, % si le résultat est non vide
	    % on propage la mise à jour NewRij dans le graphe où on l'a ajoutée
	    propager(rel(Ii,Ij,NewRij),(Intervalles,[rel(Ii,Ij,NewRij)|RestRelations]),NewGraphe),!
	;
	% si le résultat est vide
	% une contradiction temporelle est signalée
	    write('Contradiction temporelle pour '),write(rel(Ii,Ij,Rij)),
	    write(' (avant meme  la propagation !). La relation n\'a pas ete ajoutee.'),nl,nl,
	    NewGraphe=(Intervalles,Relations) % et on ne change pas le graphe
	),!.


%% Cas 2 : seul l'intervalle Ii était déjà dans le graphe
ajouter(rel(Ii,Ij,Rij),(Intervalles,Relations),NewGraphe):-

	member(Ii,Intervalles), % Ij n'existait pas avant dans le graphe

%	write('Found just Ii: '),write(Ii),write(' but not	'),write(Ij),nl,

	% on propage cette nouvelle relation dans le graphe où
	% on ajoute Ij dans la liste des noeuds
	% on ajoute la relation à la liste des relations
	propager(rel(Ii,Ij,Rij),([Ij|Intervalles],[rel(Ii,Ij,Rij)|Relations]),NewGraphe),!.

%% Cas 3 : seul l'intervalle Ij était déjà dans le graphe (symétrique du précédent)
ajouter(rel(Ii,Ij,Rij),(Intervalles,Relations),NewGraphe):-
    
	member(Ij,Intervalles), % Ii n'existait pas avant dans le graphe

%	write('Did not find Ii: '),write(Ii),write(' but found	'),write(Ij),nl,

	% on propage cette nouvelle relation dans le graphe où
	% on ajoute Ii dans la liste des noeuds
	% on ajoute la relation à la liste des relations
	propager(rel(Ii,Ij,Rij),([Ii|Intervalles],[rel(Ii,Ij,Rij)|Relations]),NewGraphe),!.

%% Cas 4 :  aucun des deux intervalles n'existait avant dans le graphe
% alors on ajoute Ii et Ij dans la liste des noeuds
% et on ajoute la relation à la liste des relations
ajouter(rel(Ii,Ij,Rij),(Intervalles,Relations),([Ii,Ij|Intervalles],[rel(Ii,Ij,Rij)|Relations]))
%:-
%	write('Did not find: '),write(Ii),write(' nor Ij '),write(Ij),nl
	.
	
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extraire(+Ii,+Ik,+Relations,-RestRelations,-Rik)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prédicat auxilaire pour le prédicat ajouter
% étant donné deux intervalles Ii et Ik et une liste de relation Relations
% on décompose Relations en extrayant Rik et en mettant de côté le reste, dans RestRelations
% Si aucune relation entre Ii et Ik n'est pour le moment dans la liste Relations, on définit
% Rik = [toutes] (valeur par défaut)


%% Cas 1 : la liste de Relations est vide
% on ne trouve donc pas Rik : 
% on unifie Rik à la liste de toutes les possibilités
% et la liste des relations restantes à la liste vide
extraire(_,_,[],[],[<,=,>,d,dt,e,et,m,mt,o,ot,s,st]).

%% Cas 2 : Rik est la premier élément de la liste de Relations : on l'a trouvée
extraire(Ii,Ik,[rel(Ii,Ik,Rik)|RestRelations],RestRelations,Rik).

%% Cas 3 : on a dans le graphe la relation transposée, entre Ik et Ii : 
% alors la relation qu'on cherche est la transposition de la liste identifiée
extraire(Ii,Ik,[rel(Ik,Ii,Rki)|RestRelations],RestRelations,Rik):-
	transposeListe(Rki,Rik).

%% Cas 4 : le premier élément de la liste ne correspond à aucun des cas précédents,
% on passe récursivement à la suite en stockant ce premier élément dans la liste du reste des relations
extraire(Ii,Ik,[rel(Ir,Ip,Rrp)|RestRelations],[rel(Ir,Ip,Rrp)|NouvRestRelations],Rel):-
	extraire(Ii,Ik,RestRelations,NouvRestRelations,Rel).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% propager(+Rij, +GrapheInitial,-GrapheFinal)
% Algorithme d'Allen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% utilisé dans le prédicat ajouter
% étant donné une nouvelle contrainte Rij et un graphe initial,
% effectue la mise à jour du graphe par propagation

%% Cas 1 : on fait l'hypothèse que tout va bien et que cette relation ne va pas provoquer de contradiction temporelle
% utilise une composante dynamique de prolog
propager(Rij,GrapheInitial,GrapheFinal):-
    assert(pas_de_contradiction),
    % on initialise la pile des relations à traiter à Rij et on commence à la traiter
    traitementPile([Rij],GrapheInitial,GrapheFinal),
    pas_de_contradiction.

%% Cas 2 : si le précédent a échoué (parce qu'on a fait l'hypothèse qu'il n'y
% avait pas de contradiction mais qu'on en a trouvé une)
% alors on le signale et on ne change pas le graphe fourni
propager(Rij,Graphe,Graphe):-
    write('Contradiction temporelle pour '),write(Rij),write(' La relation n\'a pas ete ajoutee'),nl,nl.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% traitementPile(+Pile,+GrapheInitial,-GrapheFinal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% traite une pile de relations à mettre à jour dans un graphe initial 

%% quand la pile est vide, on a fini, le graphe final est le même que le graphe fourni comme GrapheInitial
traitementPile([],Graphe,Graphe).

%% traitement récursif de la pile
traitementPile([rel(Ii,Ij,Rij)|Pile],(Intervalles,Relations),GrapheFinal):-
    
    %% traitement du premier élément de la pile :
    % mise à jour de toutes les relations qui font intervenir Ii ou Ij
    % (qui correspondent aux noeuds voisins de Ii et Ij dans le graphe)
    % ce sont les seuls à éventuellement nécessiter une mise à jour quand on traite Rij
    traitementVoisins(Ii,Ij,Rij,Pile,NewPile,Intervalles,Relations,NewRelations),

    %% appel récursif : sur la pile mise à jour, avec le graphe mis à jour
    traitementPile(NewPile,(Intervalles,NewRelations),GrapheFinal).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% traitementVoisins(+Ii,+Ij,+Rij,+Pile,-NewPile,+Intervalles,+Relations,-NewRels)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% traitement des voisins de Ii et Ij, pour tenir compte de la relation Rij
% mise à jour de toutes les relations qui font intervenir Ii ou Ij
% (qui correspondent aux noeuds voisins de Ii et Ij dans le graphe)
% ce sont les seuls à éventuellement nécessiter une mise à jour quand on traite Rij

%%% Principe 
% C'est l'implémentation de la boucle "pour tout k dans [1, n]" de l'algorithme d'Allen :
% on parcourt récursivement la liste des noeuds du graphe, Intervalles

%%% Paramètres
% Ii, Ij, Rij :  la relation qu'on propage

% Pile : liste actuelle des relations qui seront à traiter par la
% suite, elle est nécessaire pour éventuellement pouvoir lui ajouter
% de nouveaux éléments, dans une mise à jour donnant la variable
% NewPile

% Intervalles : la liste des noeuds du graphe qu'on parcourt récursivement
% Relations : la liste des relations contenues dans le graphe

% NewRels : les relations mises à jour


%% Cas 1 :  Si la liste des noeuds est vide
% (qui correspond aussi au cas où on a traité récursivement tous les noeuds)
% la nouvelle pile est égale à la pile courante
% la nouvelle liste de relations est égale à la liste de relations courante
traitementVoisins(_,_,_,Pile,Pile,[],Rels,Rels).

%% Cas 2 : si le prochain noeud à traiter est le noeud Ii
% on le saute (on traite les noeuds distincts de Ii et Ij)
% et on passe récursivement au prochain noeud à traiter
traitementVoisins(Ii,Ij,Rij,Pile,NewPile, [Ii|Rest], Relations, NewRels):-
	traitementVoisins(Ii,Ij,Rij,Pile,NewPile, Rest, Relations, NewRels).

%% Cas 3 : si le prochain noeud à traiter est le noeud Ij
% comme dans le cas 2 : on le saute et on passe récursivement au prochain noeud à traiter
traitementVoisins(Ii,Ij,Rij,Pile, NewPile, [Ij|Rest], Relations, NewRels):-
	traitementVoisins(Ii,Ij,Rij,Pile, NewPile, Rest, Relations, NewRels).

%% Cas 4 : un nouveau noeud à traiter, Ik
traitementVoisins(Ii,Ij,Rij,Pile,NewPile, [Ik|Rest],Relations,NewRels):-


    % Etape 1 : on extrait la relation entre Ii et Ik
    extraire(Ii,Ik,Relations,RestR,Rik),
    % ainsi que la relation entre Ik et Ij
    extraire(Ik,Ij,RestR,RestRelations,Rkj),

    % Etape 2 : on transpose
    transposeListe(Rik,Rki),
    transposeListe(Rkj,Rjk),

    % Etape 3 : on calcule les nouvelles relations obtenues par composition
    compositionListe(Rij,Rjk,RikIntermediaire),
    compositionListe(Rki,Rij,RkjIntermediaire),

    intersection(Rik,RikIntermediaire,NouvRik),
    intersection(Rkj,RkjIntermediaire,NouvRkj),

    % Etape 4 : vérification de non contradiction
    test_vide(NouvRkj), test_vide(NouvRik),

    % Etape 5 : mise à jour des relations
    % on vérifie s'il est nécessaire d'empiler
    verification_et_addition(Ii,Ik,Rik,NouvRik,Pile,NewPileLoc),
    verification_et_addition(Ik,Ij,Rkj,NouvRkj,NewPileLoc,NewPileLoc2),
    % on met à jour les relations et on fait l'appel récursif pour passer au noeud suivant
    traitementVoisins(Ii, Ij, Rij, NewPileLoc2, NewPile, Rest,
		      [rel(Ik,Ij,NouvRkj)|[rel(Ii,Ik,NouvRik)|RestRelations]], NewRels).

    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test_vide(L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si la liste est vide (de longueur 0), alors on a une contradiction temporelle
% donc on retire l'hypothèse faite précédemment de non contradiction
test_vide(R):- length(R,0), retractall(pas_de_contradiction),fail,!.
test_vide(R):- length(R, T), T>0.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verification_et_addition(Ii,Ik,Rik,NouvRik,Pile, NewPile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% pour verifier si une etape de la propagation de contraintes a cause
% de modifications qui doivent être sauvegardees dans le graphe et
% propagees à leur tour
%
% si la nouvelle valeur est la même que l'ancienne, on ne change rien
verification_et_addition(_, _, Rik, Rik, Pile, Pile):-!.
% sinon, on empile
verification_et_addition(Ii, Ik, _, NewRik, Pile, [rel(Ii, Ik, NewRik)|Pile]).

