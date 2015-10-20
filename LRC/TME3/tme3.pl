
revise(X):-serieux(X),etudiant(X).
fait_devoir(X):-consciencieux(X),etudiant(X).
reussi(X):-revise(X),etudiant(X).
serieux(X):-fait_devoir(X).

consciencieux(pascal).
consciencieux(zoe).
etudiant(pascal).
etudiant(zoe).

non(0,1).
non(1,0).

not(
