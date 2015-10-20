# -*- coding: utf-8 -*-
"""
Created on Mon Oct 19 16:22:12 2015

@author: 3501124
"""

from numpy import arange,array,ones,linalg
from pylab import plot,show

xi = array([4,17,37,55,88,14])
A = array([xi , ones(6)])

y = [11,25,46,48,65,97]

w = linalg.lstsq(A.T,y)[0]




line = w[0]*xi+w[1]
plot(xi,line,'r-',xi,y,'o')
show()