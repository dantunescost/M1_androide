pere(pai,filho).
mere(mae,filho).


parent(X,Y):-mere(X,Y).
parent(X,Y):-pere(X,Y).

parent(X,Y,Z):-pere(X,Z),mere(Y,Z).

grandPere(A,B) :- pere(A,C), parent(C,B).
frereOuSoeur(A,B) :- mere(M,A), mere(M,B).
frereOuSoeur(A,B) :- pere(P,A), pere(P,B).

ancetre(X,Y) :- parent(X,Y).
ancetre(X,Y) :- ancetre(X,P), pere(P,Y).
ancetre(X,Y) :- ancetre(X,M), mere(M,Y).