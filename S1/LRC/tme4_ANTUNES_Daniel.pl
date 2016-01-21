

%%%%%%%%%%% EXERCICE 1 %%%%%%%%%%%%%%%

subs(chat,felin).
subs(lion,felin).
subs(chien,canide).
subs(canide,chien).
subs(souris,mammifere).
subs(felin,mammifere).
subs(canide,mammifere).
subs(mammifere,animal).
subs(canari,animal).
subs(animal,etreVivant).
subs(and(animal,plante),nothing).

subs(and(animal,some(aMaitre)),pet).
subs(pet,some(aMaitre)).
subs(some(aMaitre),all(aMaitre,humain)).
subs(chihuahua,and(chien,pet)).

subs(carnivoreExc,all(mange,animal)).
subs(all(mange,animal),carnivoreExc).
subs(herbivoreExc,all(mange,plante)).
subs(all(mange,plante),herbivoreExc).

subs(lion,carnivoreExc).
subs(carnivoreExc,predateur).
subs(animal,some(mange)).
subs(and(all(mange,nothing),some(mange)),nothing).



%%%%%%%%%%% EXERCICE 2 %%%%%%%%%%%%%%%

%% 1. %%

subsS1(C,C).
subsS1(C,D) :- subs(C,D).
subsS1(C,D) :- subs(C,E), subsS1(E,D).

%% 2. %%

% les tests sont reussis.

%% 3. %%

% Le probleme est qu'on a defini subs(chien,canide) et subs(canide,chien), ainsi par transitivité on tombe dans une 
%  boucle infinie ou dans subsS1(chien,souris) :- subs(chien,canide), subs(canide,chien), ...une infinite de fois... , subsS1(E,souris).

%% 4. %% 

subsS(C,C,_).
subsS(C,D,_) :- subs(C,D).
subsS(C,D,L) :- subs(C,E), not(member(E,L)), subsS(E,D,[E|L]).

%% 5. %%

subsS(C,D) :- subsS(C,D,[C]).

%% 6. %%

% les tests sont reussis.

%% 7. %%

% La requete reussi parce qu'on a modelise la phrase 'Tout animal se nourrit' par subs(animal,some(mange)), donc 
% par transitivite souris qui subsume animal, subsume aussi some(mange).

%% 8. %% 

% les tests echous.

%% 9. %% 

% ?- subsS(chat,X).
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

% ?- subsS(X,mammifere).
% X = mammifere ;
% X = souris ;
% X = felin ;
% X = canide ;
% X = chat ;
% X = chat ;
% X = lion ;
% X = lion ;
% X = chien ;
% X = chien ;
% X = souris ;
% X = felin ;
% X = canide ;
% false.


%%%%%%%%%%% EXERCICE 3 %%%%%%%%%%%%%%%

%% 1. %%

subsS(C,and(D,D)) :- subsS(C,D).
subsS(C,and(C,D)) :- subsS(C,D).
subsS(C,and(D,C)) :- subsS(C,D).
subsS(C,and(D1,D2)) :- subsS(C,D1), subsS(C,D2).
subsS(C,and(D1,D2)) :- subsS(X,D1), subsS(Y,D2), subs(C,and(X,Y)). % cette ligne provoque une boucle infinie (on essaye une 
	% unification and(and(and(...))))


%% 2. %%

subsS(and(E,_),E).
subsS(and(_,E),E).
subsS(and(C,_),E) :- subsS(C,E).
subsS(and(_,D),E) :- subsS(D,E).
subsS(and(C,D),E) :- subsS(C,X), subsS(D,Y), subs(and(X,Y),E). % cette ligne provoque une boucle infinie (on essaye une 
	% unification and(and(and(...))))

%% 3. %% 

% Les regles de la question 1 et 2 ne prennent pas en compte le cas ou on teste subsS(and(_,_),and(_,_)), on ajoute donc 
% quelques regles.

subsS(and(A,B),and(A,B)).
subsS(and(A,B),and(B,A)).
subsS(and(A,B),and(C,_)) :- subsS(A,C), subsS(B,C).
subsS(and(A,B),and(_,C)) :- subsS(A,C), subsS(B,C).
subsS(and(A,B),and(C,D)) :- subsS(A,C), subsS(B,D).
subsS(and(A,B),and(D,C)) :- subsS(A,D), subsS(B,C).

%% 4. %% 

% le premier test est bon mais boucle a l'infini apres le 2ieme resultat
% les autres tests sont faux malheureusement...


%%%%%%%%%%% EXERCICE 4 %%%%%%%%%%%%%%%

%% 1. %%

subsS(all(R,C),D) :- subsS(C,X), subsS(all(R,X),D).

%% 2. %% 

% malheureusement j'ai trop d'erreur dans mes codes precedents pour pouvoir tester les resultats