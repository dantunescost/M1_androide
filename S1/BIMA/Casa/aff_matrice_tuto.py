# -*- coding: utf-8 -*-
"""
Created on Sun Sep 27 16:35:35 2015

@author: daniel
"""

import numpy as np;
import matplotlib.pyplot as pl;

C = np.random.rand(100,200)  #création d'une grande matrice

pl.figure()
pl.imshow(C)
pl.colorbar()
pl.show()

a=np.random.rand(1000)
pl.hist(a)

savefig('figtuto.pdf')