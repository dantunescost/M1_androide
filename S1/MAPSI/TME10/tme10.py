# -*- coding: utf-8 -*-
"""
Created on Mon Dec  7 10:53:04 2015

"""
import matplotlib.pyplot as plt
import numpy as np

a = 6.
b = -1.
c = 1
N = 100
sig = .4 # écart type


def tirage(a,b,N,sig):
    x = np.random.rand(N)
    epsi = np.random.randn(N) * sig
    y = a*x + b + epsi
    y = np.array(y)
    return (x,y)
    
(x,y) = tirage(a,b,N,sig)

# Estimation de paramètres probabilistes

def estimation(x,y,N):
    ex = np.mean(x)
    ey = np.mean(y)
    cov = np.mean(x*y) - ex*ey
    sig2x = np.mean( (x - ex)**2 )
    a = cov/ sig2x
    b = ey - a * ex
    return (a,b)
    
(a,b) = estimation(x,y,N)
print (a,b)

plt.figure()
plt.plot(x,y,'go')
plt.plot(x,a*x+b,'r')
plt.show()

# Formulation au sens des moindres carrés

def moindre_carrees(x,y):
    X = np.hstack((x.reshape(N,1),np.ones((N,1))))
    A = np.dot(np.transpose(X),X)
    B = np.dot(np.transpose(X),y)
    return np.linalg.solve(A,B)
    
print moindre_carrees(x,y)

#O ptimisation par descente de gradient

wstar = np.linalg.solve(X.T.dot(X), X.T.dot(y)) # pour se rappeler du w optimal

def opti_gradient (X, y):
    eps = 5e-4
    nIterations = 2000
    w = np.zeros(X.shape[1]) # init à 0
    allw = [w]
    for i in xrange(nIterations):
        w = w - 2 * eps * np.dot(np.transpose(X), np.dot(X, w) - y)
        allw.append(w) 
        print w
    allw = np.array(allw)
    return allw    


X = np.hstack((x.reshape(N,1),np.ones((N,1))))
    
allw = opti_gradient(X,y)


# tracer de l'espace des couts
ngrid = 20
w1range = np.linspace(-0.5, 8, ngrid)
w2range = np.linspace(-1.5, 1.5, ngrid)
w1,w2 = np.meshgrid(w1range,w2range)

cost = np.array([[np.log(((X.dot(np.array([w1i,w2j]))-y)**2).sum()) for w1i in w1range] for w2j in w2range])

plt.figure()
plt.contour(w1, w2, cost)
plt.scatter(a, b,c='r')
plt.plot(allw[:,0],allw[:,1],'b+-' ,lw=2 )

def tirageQuad(a,b,c,N,sig):
    x = np.random.rand(N)
    epsi = np.random.randn(N) * sig
    y = a*(x**2) + b*x + c + epsi
    y = np.array(y)
    return (x,y)
    
(x2,y2) = tirageQuad(a,b,c,N,sig)    
j = 0  
ind = x2.argsort()
xt =x2
yt =y2

#for i in ind:
#    x2[j] = xt[i]
#    y2[j] = yt[i]
#    j+=1

plt.figure()
plt.plot(x2[ind],y2[ind],'go')
plt.plot(x2[ind],a*(x2[ind]**2) + b*x2[ind] + c,'r')
plt.show()

