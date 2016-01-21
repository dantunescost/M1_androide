%%%%%%%%%%%% Exercice 1 %%%%%%%%%%%%%%%%%
%
% 1. On n'arrive pas a unifier X
% 2. X = a , Y = [b, c] , Z = d
% 3. L = [[b, c], d]
% 4. On n'arrive pas a unifier X et Y
% 5. X = a , Y = [[b, c], d]
% 6. On n'arrive pas a unifier L
% 7. L = [c, d]
% 8. L2 = [c, d|L1]
%
%%%%%%%%%%%% Exercice 2 %%%%%%%%%%%%%%%%%

%% 1. %%

concatene([X1|Q1],Y,Z):-Z=[X1|Z1],concatene(Q1,Y,Z1).
concatene([],Y,Y).

%% 2. %%

inverse([X1|Q1],Z):-inverse(Q1,Z1),concatene(Z1,[X1],Z).
inverse([],[]).

%% 3. %%

supprime([Y|X],Y,Z) :- supprime(X,Y,Z).
supprime([X1|X2],Y,Z) :- X1\==Y , Z=[X1|Z1] , supprime(X2,Y,Z1).
supprime([],_,[]).

%% 4. %%

filtre(X,[],X).
filtre(X,[Y1|Y2],Z) :- supprime(X,Y1,Z1) , filtre(Z1,Y2,Z).

%%%%%%%%%%%% Exercice 3 %%%%%%%%%%%%%%%%%

%% 1. %%

palindrome([]).
palindrome(A) :- inverse(A,B), A==B.

%% 2. %% 

% aide/3 recoit une liste et unifie la liste sans le dernier element (2ieme parametre) ainsi que le dernier element de la liste (3ieme parametre).
aide([X],[],X).
aide([A|[]],L,D) :- L=[A], D=A.
aide([A|Q], [A|B], D) :- aide(Q,B,D).

palindrome2([]).
palindrome2([A|L]) :- aide([A|L],[A|L2],D), A==D, palindrome2(L2). 
