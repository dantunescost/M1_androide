
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 28 11:22:41 2015

@author: 3501124
"""

import numpy as np
import matplotlib.pyplot as plt

def proba_affine ( k, slope ):
    if k % 2 == 0:
        raise ValueError ( 'le nombre k doit etre impair' )
    if abs ( slope  ) > float(2) / ( k * k ):
        raise ValueError ( 'la pente est trop raide : pente max = ' +
        str ( 2. / ( k * k ) ) )
        
    elif slope==0 :
      y= [ (1/k) for i in range(k) ]
      y =np.array(y)
      print y
      return y

    else:
        y = [ 1/k + (i-(k-1)/2 )*slope for i in range(k) ]
        print y        
        return np.array(y)
        
x=proba_affine(11,-0.00001)
plt.plot(x)
plt.show()

