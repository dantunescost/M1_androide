
concatene([X1|Q1],Y,Z):-Z=[X1|Z1],concatene(Q1,Y,Z1).
concatene([],Y,Y).

inverse([X1|Q1],Z):-inverse(Q1,Z1),concatene(Z1,[X1],Z).
inverse([],[]).

supprime([Y|X],Y,Z) :- supprime(X,Y,Z).
supprime([X1|X2],Y,Z) :- X1\==Y , Z=[X1|Z1] , supprime(X2,Y,Z1).
supprime([],_,[]).

filtre(X,[],X).
filtre(X,[Y1|Y2],Z) :- supprime(X,Y1,Z1) , filtre(Z1,Y2,Z).