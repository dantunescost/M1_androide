et(0,0,0).
et(1,0,0).
et(0,1,0).
et(1,1,1).

ou(0,0,0).
ou(1,0,1).
ou(0,1,1).
ou(1,1,1).

non(1,0).
non(0,1).



circuit(X,Y,R) :- et(X,Y,A), non(A,B), non(X,C), xor(B,C,D), non(D,R).

table(A,B,C,D) :- circuit(0,0,A), circuit(0,1,B), circuit(1,0,C), circuit(1,1,D).