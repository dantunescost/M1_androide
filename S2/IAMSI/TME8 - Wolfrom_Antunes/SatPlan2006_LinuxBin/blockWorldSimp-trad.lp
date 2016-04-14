%%% blockWorldSimp %%%
% Déclaration des prédicats (domain)
pred(on(Y,X)):-block(X).
pred(clear(X)):-object(X).
% Déclaration des actions (domain)
action(moveTo(Y,X,Z)):-block(X;Z).
% Préconditions
pre(moveTo(Y,X,Z),clear(X)):-action(moveTo(Y,X,Z)).
pre(moveTo(Y,X,Z),clear(Z)):-action(moveTo(Y,X,Z)).
pre(moveTo(Y,X,Z),on(X,Y)):-action(moveTo(Y,X,Z)).
% Effets
del(moveTo(Y,X,Z),on(X,Y)):-action(moveTo(Y,X,Z)).
del(moveTo(Y,X,Z),clear(Z)):-action(moveTo(Y,X,Z)).
add(moveTo(Y,X,Z),on(X,Z)):-action(moveTo(Y,X,Z)).
add(moveTo(Y,X,Z),clear(Y)):-action(moveTo(Y,X,Z)).
action(moveToTable(X,Y)):-block(X;Y).
% Préconditions
pre(moveToTable(X,Y),clear(X)):-action(moveToTable(X,Y)).
pre(moveToTable(X,Y),on(X,Y)):-action(moveToTable(X,Y)).
% Effets
del(moveToTable(X,Y),on(X,Y)):-action(moveToTable(X,Y)).
add(moveToTable(X,Y),clear(Y)):-action(moveToTable(X,Y)).
add(moveToTable(X,Y),on(X,t)):-action(moveToTable(X,Y)).
% Déclaration des objets
block(a,b,c,d).
object(a,b,c,d,t).
% Etat initial
init(clear(b)).
init(on(b,a)).
init(clear(c)).
init(on(c,d)).
init(on(a,t)).
init(on(d,t)).
% But
but(on(a,b)).
but(on(b,c)).
but(on(c,d)).
