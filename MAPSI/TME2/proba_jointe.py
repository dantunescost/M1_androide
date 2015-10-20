# -*- coding: utf-8 -*-
"""
Created on Mon Sep 28 12:36:21 2015

@author: 3501124
"""

import numpy as np
import matplotlib.pyplot as plt

def pxy(t1,t2):
    ret =[]
    for i in range(len(t1)):
        r =[]
        for j in range(len(t2)):
            r.append(t1[i]*t2[j])
        ret.append(r)
    
    return np.array(ret)

PA = np.array ( [0.2, 0.7, 0.1] )
PB = np.array ( [0.4, 0.4, 0.2] )
pab = pxy(PA,PB)
print pab



from mpl_toolkits.mplot3d import Axes3D

def dessine ( P_jointe ):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    x = np.linspace ( -3, 3, P_jointe.shape[0] )
    y = np.linspace ( -3, 3, P_jointe.shape[1] )
    X, Y = np.meshgrid(x, y)
    ax.plot_surface(X, Y, P_jointe, rstride=1, cstride=1 )
    ax.set_xlabel('A')
    ax.set_ylabel('B')
    ax.set_zlabel('P(A) * P(B)')
    plt.show ()
    
dessine(pab)
