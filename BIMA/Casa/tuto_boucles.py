# -*- coding: utf-8 -*-
"""
Created on Sun Sep 27 16:54:41 2015

@author: daniel
"""

v = np.arange(0,10) # [0, ... , 9]
for i in v:         # pour i allant de 0 à 9
    print i," ", i*2
    
m1=np.random.rand(4,5)
for row in m1:      # pour chaque ligne de m1
                    # row est donc une ligne = array 1D
    print "row", row

    for element in row:
        print element
        
print m1