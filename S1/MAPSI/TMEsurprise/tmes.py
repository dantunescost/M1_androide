#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Auteurs: Daniel Antunes et René Traore
Created on Mon Oct 19 10:47:14 2015

@author: 3501124
"""

import numpy as np
import matplotlib.pyplot as plt
import pickle as pkl

# fonction de suppression des 0 (certaines variances sont nulles car les pixels valent tous la même chose)
def woZeros(x):
    y = np.where(x==0., 1e-6, x)
    return y

# Apprentissage d'un modèle naïf où chaque pixel est modélisé par une gaussienne (+hyp. d'indépendance des pixels)
# cette fonction donne 10 modèles (correspondant aux 10 classes de chiffres)
# USAGE: theta = learnGauss ( X,Y )
# theta[0] : modèle du premier chiffre,  theta[0][0] : vecteur des moyennes des pixels, theta[0][1] : vecteur des variances des pixels
def learnGauss (X,Y):
    theta = [(X[Y==y].mean(0),woZeros(X[Y==y].var(0))) for y in np.unique(Y)]
    return (np.array(theta))

# Application de TOUS les modèles sur TOUTES les images: résultat = matrice (nbClasses x nbImages)
def logpobs(X, theta):
    logp = [[-0.5*np.log(mod[1,:] * (2 * np.pi )).sum() + -0.5 * ( ( x - mod[0,:] )**2 / mod[1,:] ).sum () for x in X] for mod in theta ]
    return np.array(logp)

######################################################################
#########################     script      ############################


# Données au format pickle: le fichier contient X, XT, Y et YT
# X et Y sont les données d'apprentissage; les matrices en T sont les données de test
data = pkl.load(file('usps_small.pkl','rb'))

X = data['X']
Y = data['Y']
XT = data['XT']
YT = data['YT']

theta = learnGauss ( X,Y ) # apprentissage

logp  = logpobs(X, theta)  # application des modèles sur les données d'apprentissage
logpT = logpobs(XT, theta) # application des modèles sur les données de test

ypred  = logp.argmax(0)    # indice de la plus grande proba (colonne par colonne) = prédiction
ypredT = logpT.argmax(0)

#print "Taux bonne classification en apprentissage : ",np.where(ypred != Y, 0.,1.).mean()
#print "Taux bonne classification en test : ",np.where(ypredT != YT, 0.,1.).mean()

# La fonction de densite de proba
def f(x,w,b):
    return 1 / (1 + np.exp((-1)*(x.dot(w)+b))) # . T

# La derivee partielle par rapport a wj
def deriveW(X,Y,w,b,index):
    res=0
    for i in range(len(Y)):
        res =  res + X[i][index]*(Y[i]-f(X[i],w,b))        
        
    return res
    

# La derivee partielle par rapport a b
def deriveB(X,Y,w,b):
    res=0
    for i in range(len(Y)):
        res = res + (Y[i]-f(X[i],w,b))        
        
    return res
    
# Mise a jour de w    
def majW(X,Y,w,b,index,epsilon):
    return (w + epsilon * deriveW(X,Y,w,b,index))
    
# Mise  a jour de b    
def majB(X,Y,w,b,epsilon):
    return (b + epsilon * deriveB(X,Y,w,b))
    
# Algorithme de regression statistique
def algo(X,Y):
        
    nb_iter = 12#0
    epsilon = 0.0005
    # Matrice aleatoire de wj
    w = np.random.randn(1,len(X))
    w *= (epsilon*0.7) 
    
    b = epsilon*0.8
    valeurs_L=[]
    L = 0
    for i in range(nb_iter):
        # On calcule la vraissemblance
    
        for idx in range(len(X)):# L = (Y * np.log(np.maximum(f,1e-8)) + (1-Y)*np.log(1-np.minimum(f,1-1e-8))).sum()
            L +=( Y[idx] * np.log(np.maximum(f(X[idx],w,b),1e-6) + (1-Y[idx])*np.log( 1 - np.minimum(f(X[idx],w,b),1-1e-6)))) 
            # On stocke sa valeur        
            w[i] = majW(X,Y,w[i],b,idx,epsilon)         
        
        valeurs_L.append(L)  
        # on met a jour W et b
        b = majB(X,Y,w,b,epsilon)
    
    return valeurs_L

v_L = algo(X,Y)
#fig = plt.figure ()
#plt.plot(v_L)       
#plt.show()       
print v_L
 
    
    
    