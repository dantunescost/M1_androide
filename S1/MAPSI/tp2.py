#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 28 10:49:16 2015

@author: 3501124
""" 
import numpy as np

def bernouilli(p):
    r = np.random.rand(1)
    print r    
    if r > p:
        return 0
    else :
        return 1

print bernouilli(0.5)

    


