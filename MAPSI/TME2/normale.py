# -*- coding: utf-8 -*-
"""
Created on Mon Sep 28 11:22:41 2015

@author: 3501124
"""

import numpy as np
import matplotlib.pyplot as plt

def normale ( k, sigma ):
    if k % 2 == 0:
        raise ValueError ( 'le nombre k doit etre impair' )
    x = np.linspace(-2*sigma, 2*sigma, k)
    y=[]
    for i in x:    
        y.append( 1/(np.sqrt(np.pi*2*sigma)) * np.exp(-1/2*(i/sigma)*(i/sigma)))
    return (x,np.array(y))

x,y=normale(31,25.5)    
print y
plt.plot(x,y)
plt.show()