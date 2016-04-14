% Variables
position(1..5).
couleur(blanc;vert;jaune;bleu;rouge).
maison(P,C) :- position(P), couleur(C).

nationalite(britannique;suedois;danois;norvegien;allemand).
cigarette(pallmall;dunhill;blend;bluemaster;princess).
boisson(the;cafe;lait;biere;eau).
animal(oiseau;chien;cheval;chat;poisson).

%fait(P,H,N,C,B,A) :- position(P),couleur(H),nationalite(N),cigarette(C),boisson(B),animal(A).
1{fait(P,H,N,C,B,A):couleur(H):nationalite(N):cigarette(C):boisson(B):animal(A)}1 :- position(P).
1{fait(P,H,N,C,B,A):position(P):nationalite(N):cigarette(C):boisson(B):animal(A)}1 :- couleur(H).
1{fait(P,H,N,C,B,A):position(P):couleur(H):nationalite(N):boisson(B):animal(A)}1 :- cigarette(C).
1{fait(P,H,N,C,B,A):position(P):couleur(H):cigarette(C):boisson(B):animal(A)}1 :- nationalite(N).
1{fait(P,H,N,C,B,A):position(P):couleur(H):nationalite(N):cigarette(C):animal(A)}1 :- boisson(B).
1{fait(P,H,N,C,B,A):position(P):couleur(H):nationalite(N):cigarette(C):boisson(B)}1 :- animal(A).


% Faits
:- fait(P,H,N,C,B,A), H==rouge, N!=britannique.
:- fait(P,H,N,C,B,A), N==suedois, A!=chien.
:- fait(P,H,N,C,B,A), N==danois, B!=the.
:- fait(P1,vert,N1,C1,B1,A1), fait(P2,blanc,N2,C2,B2,A2), P1!=P2-1.
:- fait(P,H,N,C,B,A), H==vert, B!=cafe.
:- fait(P,H,N,C,B,A), C==pallmall, A!=oiseau.
:- fait(P,H,N,C,B,A), H==jaune, C!=dunhill.
:- fait(P,H,N,C,B,A), P==3, B!=lait.
:- fait(P,H,N,C,B,A), N==norvegien, P!=1.
:- fait(P1,H1,N1,C1,B1,A1), fait(P2,H2,N2,C2,B2,A2), C1==blend, #abs(P1-P2)==1, A2!=chat.
:- fait(P1,H1,N1,C1,B1,A1), fait(P2,H2,N2,C2,B2,A2), A1==cheval, #abs(P1-P2)==1, C2!=dunhill.
:- fait(P,H,N,C,B,A), C==bluemaster, B!=biere.
:- fait(P,H,N,C,B,A), N==allemand, C!=princess.
:- fait(P1,H1,N1,C1,B1,A1), fait(P2,H2,N2,C2,B2,A2), N1==norvegien, #abs(P1-P2)==1, H2!=bleu.
:- fait(P1,H1,N1,C1,B1,A1), fait(P2,H2,N2,C2,B2,A2), C1==blend, #abs(P1-P2)==1, B2!=eau.



#hide.
#show fait/6.


