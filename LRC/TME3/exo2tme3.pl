
concatene([X1|Q1],Y,Z):-Z=[X1|Z1],concatene(Q1,Y,Z1).
concatene([],Y,Y).

inverse([X1|Q1],Z):-inverse(Q1,Z1),concatene(Z1,[X1],Z).
inverse([],[]).

supprime().
