lig(0..8).
col(0..8).
val(1..9).

% Cases
1{case(L,C,V):val(V)}1 :- lig(L), col(C).

% Grille de depart
case(0,1,7).
case(0,3,6).
case(0,5,3).
case(0,7,1).
case(0,8,4).
case(1,0,8).
case(1,4,9).
case(2,1,6).
case(2,2,3).
case(2,3,2).
case(2,4,1).
case(2,6,8).
case(3,4,3).
case(3,7,5).
case(3,8,9).
case(4,0,6).
case(4,3,9).
case(4,6,4).
case(4,8,1).
case(5,0,9).
case(5,1,2).
case(5,3,4).
case(5,5,1).
case(5,8,8).
case(6,1,5).
case(6,3,8).
case(6,8,3).
case(7,0,4).
case(7,2,1).
case(7,3,3).
case(7,4,6).
case(7,5,2).
case(7,6,7).
case(7,7,8).
case(8,0,3).
case(8,2,6).
case(8,3,1).
case(8,6,9).
case(8,8,2).

% Contrainte sur les lignes
:- case(L,C1,V), case(L,C2,V), C1!=C2.

% Contrainte sur les colonnes
:- case(L1,C,V), case(L2,C,V), L1!=L2.

% Contrainte des regions
:- case(L1,C1,V), case(L2,C2,V), L1/3==L2/3, C1/3==C2/3, L1!=L2.
:- case(L1,C1,V), case(L2,C2,V), L1/3==L2/3, C1/3==C2/3, C1!=C2.


#hide.
#show case/3.



