#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 28 10:49:16 2015

@author: 3501124
""" 
import numpy as np
import matplotlib.pyplot as plt

def bernouilli(p):
    r = np.random.rand(1)
    if r > p:
        return 0
    else :
        return 1


def binomiale(n,p):
    cpt=0
    for i in range(n):
        cpt += bernouilli(p)
    return cpt

def galton(n):
    a = np.zeros(1000)
    for i in range(1000):
        a[i]=(binomiale(n,0.5))
    print a
    return a
n=100
tab = galton(n)

plt.hist (tab , n )