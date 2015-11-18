%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TME 4 - LRC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                      %
%     de Toldi Melchior, de Bézenac Emmanuel                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T BOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subs(chat, felin).
subs(lion, felin).

subs(chien,canide).
subs(canide,chien).


subs(souris, mammifere).
subs(felin, mammifere).
subs(canide, mammifere).

subs(animal, etreVivant).
subs(mammifere, animal).
subs(canari,  animal).

subs(and(mammifere,plante), nothing).
subs( and(animal, some(aMaitre)),pet).
subs(pet, some(aMaitre)).

subs(some(aMaitre), all(aMaitre, humain)).
subs(chihuahua, and(chien, pet)).


% carnivoreExc mange uniquement des animaux
subs(carnivoreExc, all(mange, animal)).
% tout ce qui mange uniquement des animaux sont des carnivoresExc
subs(all(mange,animal), carnivoreExc).

% herbivoreExc mange uniquement des plantes
subs(herbivoreExc, all(mange, plante)).
% tout ce qui mange uniquement des plantes est un herbivore
subs(all(mange, plante), herbivoreExc).

subs(lion, carnivoreExc).
subs(carnivoreExc, predateur).

% pour tout animal, il existe quelque chose tel que lanimal le mange
subs(animal, some(mange)).

% on ne peut pas manger rien et manger quelque chose
subs(and(all(mange,nothing),some(mange)),nothing).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A BOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inst(felix, chat).
inst(pierre, homme).
inst(princesse, chihuahua).
inst(marie, humain).
inst(jerry, souris).
inst(titi, canari).

instR(felix, aMaitre, pierre).
instR(princesse, aMaitre, chihuahua).
instR(felix, mange, jerry).
instR(felix, mange, titi).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------------------------------------ QUESTION 1 --------------------------------------%
subsS1(C,C).
subsS1(C,D):-subs(C,D).
subsS1(C,E):-subs(C,D),subs(D,E). 

% ------------------------------------ QUESTION 2 --------------------------------------%
	% tests
	% subsS1(canari,animal) .
	% subsS1(chat,etreVivant).

% ------------------------------------ QUESTION 3 --------------------------------------%
	% subsS1(chien,souris).
	% Le problème posé par la requête subsS(chien,souris) est qu'on tombe assez rapidement
	% dans une boucle infinie, en effet prolog va faire une association entre D et 'canide'
	% puis entre D et 'chien' au tour suivant et ainsi de suite. Il ne pourra jamais 
	% conclure.



% ------------------------------------ QUESTION 4 --------------------------------------%

subsS1(C,C,_).
subsS1(C,D,_):-subs(C,D). 
subsS1(C,D,L):-subs(C,X),not(member(X,L)),append(L,[X],L2),subsS1(X,D,L2).

% ------------------------------------ QUESTION 5 --------------------------------------%
%subsS1(C,D):-subsS1(C,D,[]).

% ------------------------------------ QUESTION 6 --------------------------------------%
	% tests
	% subsS(canari,animal) .
	% subsS(chat,etreVivant).
	% subsS(chien,canide).
	% subsS(chien,chien).

% ------------------------------------ QUESTION 7 --------------------------------------%
	% subsS(souris,some(mange)).
	% Some(mange) est percu comme une tautologie car tout les animaux mangent ( pour tout 
	% animal, il existe quelque chose tel que lanimal le mange) et la souris est subsumé
	% par animal.

% ------------------------------------ QUESTION 8 --------------------------------------%
	%tests
	% subsS(chat,humain).
	% subsS(chien,souris).

% ------------------------------------ QUESTION 9 --------------------------------------%
	% Pour subsS(chat,X) on est censé avoir : X = félin, mammifere, animal, etreVivant 
	% ainsi que some(mange)

	% Le script nous retourne
	% X = chat ;
	% X = felin ;
	% X = felin ;
	% X = mammifere ;
	% X = mammifere ;
	% X = animal ;
	% X = animal ;
	% X = etreVivant ;
	% X = some(mange) ;
	% X = etreVivant ;
	% X = some(mange) ;
	% false.
	
	% Pour subsS(X,animal) on est censé avoir : X = chat, lion, canari, lion, chien, canide
	% felin, souris, mammifere, animal, etreVivant 

	% Le script nous retourne
	% X = animal ;
	% X = mammifere ;
	% X = canari ;
	% X = chat ;
	% X = chat ;
	% X = lion ;
	% X = lion ;
	% X = chien ;
	% X = chien ;
	% X = canide ;
	% X = canide ;
	% X = souris ;
	% X = souris ;
	% X = felin ;
	% X = felin ;
	% X = canide ;
	% X = canide ;
	% X = mammifere ;
	% X = canari ;
	% false.


% --------------------------------------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICE 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------------------------------------ QUESTION 1 --------------------------------------%
% On redefinit le predicat subs pour pouvoir prendre des intersections en compte
subsS(C,D):-subsS(C,D,[]).

% Partie analogue a la question 3 de lexercice 2.

subsS(C,C,_).
subsS(C,D,_):-subs(C,D).
subsS(C,D,L):-subs(C,X),not(member(X,L)),append(L,[X],L2),subsS(X,D,L2).


% Partie rajoutée:

% Cas darret
subsS(C,and(C,C),_).

% Cas triviaux 
subsS(C,and(D,D),L):-subsS(C,D,L).
subsS(C,and(C,D2),L):-subsS(C,D2,L).
subsS(C,and(D1,C),L):-subsS(C,D1,L).

% Recursivite: on cherche un couple (X,Y) qui satisfait les règles suivantes
%Notez que l'on a choisi de parcourir les X/Y tels que subs(X/Y,D1) en partant de D1 plutot de que C
subsS(C,and(D1,D2),L):-subsS(X,D1,L),subsS(Y,D2,L),subs(C,and(X,_)),subs(C,and(_,Y)).
subsS(C,and(D1,D2),L):-subsS(X,D1,L),subsS(Y,D2,L),subs(C,and(_,X)),subs(C,and(Y,_)).

%Remarque: Il faut absolument que C soit subsumé par D1, et aussi par D2.

% --------------------------------------------------------------------------------------%
% AUTRE FACON DE FAIRE: TESTE LA SUBSOMBTION EN PARTANT DE D POUR ACCEDER A C
% Remarque: Elle boucle en et les resultats de l'unification sont des and(and(and...
% subsss(C,C,_).
% subsss(C,D,_):-subs(C,D). 
% subsss(C,D,L):-subs(X,D),not(member(X,L)),append(L,[X],L2),subsss(C,X,L2).
%
% Partie analogue a la question 1 
% subsss(C,and(C,C),_).
% subsss(C,and(D,D),L):-subsss(C,D,L).
% subsss(C,and(C,D2),L):-subsss(C,D2,L).
% subsss(C,and(D1,C),L):-subsss(C,D1,L).
% subsss(C,and(D1,D2),L):-subsss(X,D1,L),subsss(Y,D2,L),subs(C,and(X,_)),subs(C,and(_,Y)).
% subsss(C,and(D1,D2),L):-subsss(X,D1,L),subsss(Y,D2,L),subs(C,and(_,X)),subs(C,and(Y,_)).
% subsss(C,and(D1,D2),L):-subsss(C,and(D2,D1),L).
% --------------------------------------------------------------------------------------%



% ------------------------------------ QUESTION 2 --------------------------------------%

%Ces regles répondent aux requetes d'intersection du type subs(and(.,.),.).
%Les réponses aux questions 2 bouclent l'infini lorsque  la partie rajoutée de la question 1 est active, et inversement.
% Pour éxécuter une requete, il faut donc au préalable retirer les règles rajoutées de la questions 1.

%Cas d'arret:
subsS(and(C,_),C,_).
subsS(and(_,C),C,_).
%Cas triviaux:
subsS(and(C1,_),D,L):-subs(X,D),subsS(C1,X,L).
subsS(and(_,C2),D,L):-subs(X,D),subsS(C2,X,L).
% On cherche X tel que C subsume X et qu'il existe une règle tel que and(X,..) subsume D 
subsS(and(C1,_),D,L):-subsS(C1,X,L),subs(and(X,_),D).
% Pour que les requetes soient exhaustives, on traite le 2eme cas suivant:
subsS(and(_,C2),D,L):-subsS(C2,X,L),subs(and(_,X),D).

%subsS(and(C1,C2),D,L):-subsS(C1,X,L),subsS(C2,Y,L),subs(and(X,C2),D),subs(and(C1,Y),D).

%Remarque: dans ce cas, il suffit que C1 (ou C2) soit subsumé par D pour que ça soit vrai.

% --------------------------------------------------------------------------------------%



% ------------------------------------ QUESTION 3 --------------------------------------%
%Il faudrait aussi traiter les cas ou on a subs(and(.,.),and(.,.))

%Cas d'arret:
subsS(and(C1,C2),and(C1,C2),_).
subsS(and(C1,C2),and(C2,C1),_).
%Récursivité:
subsS(and(C1,_),and(D1,_),L):-subsS(C1,D1,L).
subsS(and(_,C2),and(D1,_),L):-subsS(C2,D1,L).
subsS(and(C1,_),and(_,D2),L):-subsS(C1,D2,L).
subsS(and(_,C2),and(_,D2),L):-subsS(C2,D2,L).

%Il faut que chaque membre de gauche soit subsumé par au moins un membre de droite pour  que la règle puisse être vérifée.

% --------------------------------------------------------------------------------------%

% ----------------------------------- REMISE EN FORME ----------------------------------%

%Remarque: Les subsS des questions précédentes ont étés traités plus ou moins indépendamment (En tout cas le 1ere). On peut observer que les règles des différentes questions (surtout valable pour les questions 1 et 2) ne sont plus satisfaisantes lorsqu'elles sont utilisées en même temps. Il est néenmoins nécéssaire (pour des requêtes plus complexes) que ces règles fonctionnent simultanément. Voici alors une tentative: Nous essayons de détecter les règles inutiles des questions précédentes pour tenter d'épurer au maximum le code, donc de simplifier sa compréhension, et surtout, d'éliminer le plus possible les cas les règles qui pourraient boucler.

subsT(C,D):-subsT(C,D,[]).
subsT(C,C,_).
subsT(C,D,_):-subs(C,D). 
subsT(C,D,L):-subs(C,X),not(member(X,L)),append(L,[X],L2),subsT(X,D,L2).


% Cas triviaux pour subs(and(. , .),and( ., .))
% C1 = D1 et C2 = D2. OK.
subsT(and(C1,C2),and(C1,C2),_).
% C1 = D2 et C2 = D1. OK.
subsT(and(C1,C2),and(C2,C1),_).
% Chaque membre de gauche est au moins subsumé par un membre de droite. 
subsT(and(C1,C2),and(D1,_),L):-subsT(C1,D1),subsT(C2,D1,L).
subsT(and(C1,C2),and(_,D2),L):-subsT(C1,D2),subsT(C2,D2,L).
subsT(and(C1,C2),and(D1,D2),L):-subsT(C1,D1),subsT(C2,D2,L).
subsT(and(C1,C2),and(D1,D2),L):-subsT(C1,D2),subsT(C2,D1,L).


%Ces regles répondent aux requetes d'intersection du type subs(.,and(.,.)).
subsT(C,and(C,C),_).
subsT(C,and(D,D),L):-subsT(C,D,L).
subsT(C,and(C,D2),L):-subsT(C,D2,L).
subsT(C,and(D1,C),L):-subsT(C,D1,L).
subsT(C,and(D1,D2),L):-subsT(C,D1,L),subsT(C,D2,L).
subsT(C,and(D1,D2),L):-subs(C,X),not(member(X,L)),append(L,[X],L2),subsT(X,and(D1,D2),L2).


%Ces regles répondent aux requetes d'intersection du type subs(and(.,.),.).
subsT(and(C,_),C,_).
subsT(and(_,C),C,_).
subsT(and(C1,C2),D,L):-subs(C1,X),not(member(X,L)),append(L,[X],L2),subsT(and(X,C2),D,L2).
subsT(and(C1,C2),D,L):-subs(X,C2),not(member(X,L)),append(L,[X],L2),subsT(and(C1,X),D,L2).
subsT(and(C1,_),D,L):-subsT(C1,D,L).
subsT(and(_,C2),D,L):-subsT(C2,D,L).

%Remarque: pour la suite des questions, nous utiliserons subsT comme subsTitution de subsS.

% --------------------------------------------------------------------------------------%

% ------------------------------------ QUESTION 4 --------------------------------------%
        % Tests
        % subsT(chihuahua, and(mammifere, some(aMaitre))). True
        % subsT(and(chien, some(aMaitre)),pet). True
        % subsT(chihuahua, and(pet, chien)). True
 
 
 
% --------------------------------------------------------------------------------------%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICE 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------------------------------------ QUESTION 1 --------------------------------------%

subsT(all(R,C),D,L):-subs(C,X),subsT(all(R,X),D,L).

%subsT(all(R,C),all(R,C),_).
%subsT(all(R,C),all(R,D),L):-subsT(C,D,L).
%subsT(all(R,C),all(R,D),L):-subs(C,X),not(member(X,L)),append(L,[X],L2),subsT(all(R,X),all(R,D),L2).

% --------------------------------------------------------------------------------------%



% ------------------------------------ QUESTION 2 --------------------------------------%
% Cette règle semble nécéssaire pour effectuer la requete subs(and(carnivoreExc,herbivoreExc), nothing).
subsT(X,and(all(R,C),all(R,D)),L):-subsT(X,all(R,and(C,D)),L).

% --------------------------------------------------------------------------------------%



% ------------------------------------ QUESTION 4 --------------------------------------%

subsT(all(R,inst(I,C)),all(R,C),L).
subsT(all(R,inst(I,C)),all(R,D),L ):-subs(C,X),not(member(X,L)),append(L,[X],L2),subsT(all(R,inst(I,X)),all(R,D),L2).
% --------------------------------------------------------------------------------------%



% ------------------------------------ QUESTION 5 --------------------------------------%
% some(R) peut etre percu comme un atome. Il n'est donc pas nécéssaire de faire davantage, car subsT(some(R),some(T)) peut se résoudre comme prolog va directement faire l'unification. Et subsT cherche d'emblée dans la base de règles s'il existe une règle unifable avec some(R).

% --------------------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICE 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*

Montrons que l'ensemble de règles énoncées ci dessus est complet pour le langage FL- .
On rappelle les constructeurs présents dans le langage FL- :
        -Intersection ( and(X,Y) )
        -Quantification existentielle ( some(R) )
        -Quantification universelle  ( all(R,X) )
 
Considérons que tous les termes de la T-Box appartiennent au langage donné.
Considérons la requête subsT(C,D) avec C et D appartenant aussi au langage FL- et avec C subsumé par D, l'ensemble de règles est complet si il peut prouver que c'est vrai.
Les cas simples (deux concepts atomiques) ont été traité dans le deuxième exercices, la récursivité était la clé. Nous avons ensuite traité les intersections dans l'exercice trois, la récursivité permet ici de traiter des cas à n intersections de chaque coté de la subsomption.  Puis dans l'exercice 4 nous prenons en compte les deux constructeurs restants, les quantificateurs existentiels et universels, ici aussi la récursivité permet de traiter les imbrications.
 

    Étant donné que les trois  constructeurs sont considérés l'ensemble de règles produit est complet pour le langage FL- (et non pour les autres langages, par exemple pour AL cela ne fonctionnerait pas car nous n'avons pas pris en compte la négation atomique)
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICE 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------------------------------------ QUESTION 1 & 2 & 3 ------------------------------%
instI(I,D):-inst(I,C),subsT(C,D).
%Remarque: Fonctionne aussi pour la question 3.

        % Tests
        % instI(felix,mammifere). True
        % instI(princesse,pet). True

 
% --------------------------------------------------------------------------------------%



% ------------------------------------ QUESTION 4 --------------------------------------%
%On teste pour tous les X qui sont subsumés pas C
%La fonction boucle a l'infini, meme en y ajoutant une liste, et une condition par rapport aux éléments de celle-ci.
instI(I,all(R,C)):-subsT(X,C),not(contrexAll(I,R,X)).

contrexAll(I,R,C):-instR(I,R,I2),not(inst(I2,C)).
% --------------------------------------------------------------------------------------%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




