%%% singeBananes %%%
% Déclaration des prédicats (domain)
pred(situe(Y,X)):-position(Y),object(X).
pred(niveau(X,Y)):-object(X),level(Y).
pred(possede(X,Y)):-object(X;Y).
pred(mainsVides).
% Déclaration des actions (domain)
action(seDeplace(X,Y)):-position(X;Y).
% Préconditions
pre(seDeplace(X,Y),situe(singe,X)):-action(seDeplace(X,Y)).
pre(seDeplace(X,Y),niveau(singe,bas)):-action(seDeplace(X,Y)).
% Effets
del(seDeplace(X,Y),situe(singe,X)):-action(seDeplace(X,Y)).
add(seDeplace(X,Y),situe(singe,Y)):-action(seDeplace(X,Y)).
action(prend(Y,X,Z)):-position(Y),object(X),level(Z).
% Préconditions
pre(prend(Y,X,Z),mainsVides):-action(prend(Y,X,Z)).
pre(prend(Y,X,Z),situe(singe,Y)):-action(prend(Y,X,Z)).
pre(prend(Y,X,Z),situe(X,Y)):-action(prend(Y,X,Z)).
pre(prend(Y,X,Z),niveau(singe,Z)):-action(prend(Y,X,Z)).
pre(prend(Y,X,Z),niveau(X,Z)):-action(prend(Y,X,Z)).
% Effets
del(prend(Y,X,Z),mainsVides):-action(prend(Y,X,Z)).
add(prend(Y,X,Z),possede(singe,X)):-action(prend(Y,X,Z)).
del(prend(Y,X,Z),situe(X,Y)):-action(prend(Y,X,Z)).
del(prend(Y,X,Z),niveau(X,Z)):-action(prend(Y,X,Z)).
action(depose(Y,X,Z)):-position(Y),object(X),level(Z).
% Préconditions
pre(depose(Y,X,Z),possede(singe,X)):-action(depose(Y,X,Z)).
pre(depose(Y,X,Z),situe(singe,Y)):-action(depose(Y,X,Z)).
pre(depose(Y,X,Z),niveau(singe,Z)):-action(depose(Y,X,Z)).
% Effets
add(depose(Y,X,Z),mainsVides):-action(depose(Y,X,Z)).
del(depose(Y,X,Z),possede(singe,X)):-action(depose(Y,X,Z)).
add(depose(Y,X,Z),situe(X,Y)):-action(depose(Y,X,Z)).
add(depose(Y,X,Z),niveau(X,Z)):-action(depose(Y,X,Z)).
action(monteCaisse(Y)):-position(Y).
% Préconditions
pre(monteCaisse(Y),situe(singe,Y)):-action(monteCaisse(Y)).
pre(monteCaisse(Y),niveau(singe,bas)):-action(monteCaisse(Y)).
pre(monteCaisse(Y),situe(caisse,Y)):-action(monteCaisse(Y)).
pre(monteCaisse(Y),niveau(caisse,bas)):-action(monteCaisse(Y)).
% Effets
add(monteCaisse(Y),niveau(singe,haut)):-action(monteCaisse(Y)).
del(monteCaisse(Y),niveau(singe,bas)):-action(monteCaisse(Y)).
% Déclaration des objets
object(singe;bananes;caisse).
position(a;b;c).
level(haut;bas).
% Etat initial
init(situe(singe,a)).
init(situe(bananes,b)).
init(situe(caisse,c)).
init(niveau(singe,bas)).
init(niveau(caisse,bas)).
init(niveau(bananes,haut)).
init(mainsVides).
% But
but(possede(singe,bananes)).
