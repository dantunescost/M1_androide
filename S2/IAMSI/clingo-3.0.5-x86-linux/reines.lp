lig(1..8).
col(1..8).
% On met une reine sur la case (1,1)
% q(1,1).

% Aucune reine sur la case (4,4)
% :- q(4,4).

% Generation d'une reine par ligne
1{q(L,C):col(C)}1 :- lig(L).

% Contrainte sur les colonnes
:- q(L1,C), q(L2,C), L1 != L2.

% Contraintes sur les diagonales
:- q(C1,L1), q(C2,L2), C1-L1==C2-L2, C1!=C2, L1!=L2.
:- q(C1,L1), q(C2,L2), C1+L1==C2+L2, C1!=C2, L1!=L2.

#hide.
#show q/2.


