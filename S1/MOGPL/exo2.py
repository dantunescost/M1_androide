# -*- coding: utf-8 -*-
"""
Created on Mon Oct 19 16:57:59 2015

@author: 3501124
"""
from gurobipy import *

nbcon = 2
nbvar = 3

lignes = range(nbcon)
colonnes = range(nbvar)

a = [[1,2,3], [3,1,1]]
b = [8,5]

c = [7,3,4]
m = Model("exo2")     
        
# declaration variables de decision
x = []
for i in colonnes:
    x.append(m.addVar(vtype=GRB.INTEGER, lb=0, name="x%d" % (i+1)))

# maj du modele pour integrer les nouvelles variables
m.update()

obj = LinExpr();
obj =0
for j in colonnes:
    obj += c[j] * x[j]
        
# definition de l'objectif
m.setObjective(obj,GRB.MINIMIZE)

# Definition des contraintes
for i in lignes:
    m.addConstr(quicksum(a[i][j]*x[j] for j in colonnes) >= b[i], "Contrainte%d" % i)


# Resolution
m.optimize()


print ""                
print 'Solution optimale:'
for j in colonnes:
    print 'x%d'%(j+1), '=', x[j].x
print ""
print 'Valeur de la fonction objectif :', m.objVal