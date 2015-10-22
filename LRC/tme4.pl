

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


