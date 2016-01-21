# -*- coding: utf-8 -*-
"""
Created on Sun Oct  4 15:47:22 2015

@author: daniel
"""

import numpy as np
import matplotlib.pyplot as plt
import math 

def read_file ( filename ):
    """
    Lit un fichier USPS et renvoie un tableau de tableaux d'images.
    Chaque image est un tableau de nombres réels.
    Chaque tableau d'images contient des images de la même classe.
    Ainsi, T = read_file ( "fichier" ) est tel que T[0] est le tableau
    des images de la classe 0, T[1] contient celui des images de la classe 1,
    et ainsi de suite.
    """
    # lecture de l'en-tête
    infile = open ( filename, "r" )    
    nb_classes, nb_features = [ int( x ) for x in infile.readline().split() ]

    # creation de la structure de données pour sauver les images :
    # c'est un tableau de listes (1 par classe)
    data = np.empty ( 10, dtype=object )  
    filler = np.frompyfunc(lambda x: list(), 1, 1)
    filler( data, data )

    # lecture des images du fichier et tri, classe par classe
    for ligne in infile:
        champs = ligne.split ()
        if len ( champs ) == nb_features + 1:
            classe = int ( champs.pop ( 0 ) )
            data[classe].append ( map ( lambda x: float(x), champs ) )    
    infile.close ()

    # transformation des list en array
    output  = np.empty ( 10, dtype=object )
    filler2 = np.frompyfunc(lambda x: np.asarray (x), 1, 1)
    filler2 ( data, output )

    return output

def display_image ( X ):
    """
    Etant donné un tableau X de 256 flotants représentant une image de 16x16
    pixels, la fonction affiche cette image dans une fenêtre.
    """
    # on teste que le tableau contient bien 256 valeurs
    if X.size != 256:
        raise ValueError ( "Les images doivent être de 16x16 pixels" )

    # on crée une image pour imshow: chaque pixel est un tableau à 3 valeurs
    # (1 pour chaque canal R,G,B). Ces valeurs sont entre 0 et 1
    Y = X / X.max ()
    img = np.zeros ( ( Y.size, 3 ) )
    for i in range ( 3 ):
        img[:,i] = X

    # on indique que toutes les images sont de 16x16 pixels
    img.shape = (16,16,3)

    # affichage de l'image
    plt.imshow( img )
    plt.show ()

#chargement des images dans trainingData    
trainingData = read_file("2015_tme3_usps_train.txt")


#affichage de la 3ieme image de la classe 2
#display_image(trainingData[1][2])

#affichage de la 2ieme image de la classe 9
#display_image(trainingData[8][1])
    
####################### Question 2 ##########################    

def learnML_class_parameters (train):
    m = np.array(np.zeros(256));
    sigma2 = np.array(np.zeros(256));
    
    #on calcule les moyennes
    for i in range(256):
        for j in range(len(train)):
            m[i] += train[j][i]
        m[i] = m[i] / len(train)
    
    #on calcule les variances
    for i in range(256):
        for j in range(len(train)):
            sigma2[i] += (train[j][i]-m[i])**2
        sigma2[i] = sigma2[i] / len(train)
    
    return (m , sigma2)
    
#print learnML_class_parameters(trainingData[1])
    
    
####################### Question 3 ##########################

def learnML_all_parameters(train):
    listeRes = []
    #on parcours chaque classe et on concatene les resultats obtenus dans la liste 
    for i in range(len(train)):
        listeRes.append(learnML_class_parameters(train[i]))
        
    return listeRes
    
    

####################### Question 4 ##########################


def log_likelihood(image , parameters):
    l = 0.0;
    for i in range(256):
        sigma2=parameters[1][i]
        #si sigma² est nul alors on ajoute rien au résultat, sinon on ajoute la log-vraissemblance
        if sigma2 != 0:
            m = parameters[0][i]
            l += (-0.5) * np.log(2*math.pi*sigma2) - 0.5*(image[i] - m)**2/sigma2
    
    return l
    
parameters = learnML_all_parameters(trainingData)
test_data = read_file ( "2015_tme3_usps_test.txt" )
log_likelihood ( test_data[2][3], parameters[1] )
    
    
display_image(test_data[4][1])
print [ log_likelihood ( test_data[4][1], parameters[i] ) for i in range ( 10 ) ]



####################### Question 5 ##########################    
    
def log_likelihoods(image , parameters):
    res = np.array(np.zeros(10))
    for i in range(10):
        res[i] = log_likelihood(image,parameters[i])
     
    return res
 
log_likelihoods ( test_data[0][0], parameters)    
    
    
    
####################### Question 6 ##########################    

def classify_image(image , parameters):
    res= log_likelihoods(image , parameters)
    max=0
    for i in range(9):
        if res[max]<res[i+1]:
            max=i+1
            
    return max
    
print classify_image( test_data[1][5], parameters )
print classify_image( test_data[4][1], parameters )
    



####################### Question 7 ########################## 
    
    
def classify_all_images(all_imgs , parameters):
    t =[[0.0 for i in range(10)] for j in range(10)]
    
    for i in range(len(all_imgs)):
        for j in range(len(all_imgs[i])):
            probable_class = classify_image(all_imgs[i][j], parameters)
            t[i][probable_class]+=1.0/len(all_imgs[i])
    
    return t
    
t = classify_all_images(test_data , parameters)
#print t    


####################### Question 8 ##########################

     
from mpl_toolkits.mplot3d import Axes3D

def dessine ( classified_matrix ):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    x = y = np.linspace ( 0, 9, 10 )
    X, Y = np.meshgrid(x, y)
    ax.plot_surface(X, Y, classified_matrix, rstride = 1, cstride=1 )   
    plt.show()
    
dessine(t)
    
    
    
    
    