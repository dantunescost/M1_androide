# -*- coding: utf-8 -*-
"""
Created on Sun Nov 29 22:56:58 2015

@author: daniel
"""

import numpy as np;
import matplotlib.pyplot as plt;

def tirage ( m ):
    x = np.rand()
    y = np.rand()
    x = (x-0.5)*2*m
    y = (y-0.5)*2*m
    return x, y
    
def monteCarlo ( n ):
    x = np.zeros(n)
    y = np.zeros(n)
    for i in range(n):
        x[i], y[i] = tirage( 1 )
    return np.pi , x, y
    
    
plt.figure()

# trace le carré
plt.plot([-1, -1, 1, 1], [-1, 1, 1, -1], '-')

# trace le cercle
x = np.linspace(-1, 1, 100)
y = np.sqrt(1- x*x)
plt.plot(x, y, 'b')
plt.plot(x, -y, 'b')

# estimation par Monte Carlo
pi, x, y = monteCarlo(int(1e4))

# trace les points dans le cercle et hors du cercle
dist = x*x + y*y
plt.plot(x[dist <=1], y[dist <=1], "go")
plt.plot(x[dist>1], y[dist>1], "ro")
plt.show()
