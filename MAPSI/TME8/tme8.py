#!/usr/bin/python

import numpy as np
import pickle as pkl
import sklearn.linear_model as lin
import sklearn.naive_bayes as nb
import sklearn.cross_validation as cv
from collections import Counter

data = pkl.load(file("/tmp/imagesRedR.pkl","rb"))

# donnees brutes issues de la reference de l'intro
images                   = data['im'] # 100 im : 256x256 pixels x RGB
label_pixel              = data['lab'] # 100 im : 256x256 pixels

# pour le TME, nous travaillerons sur des segments:
segments                = data['seg'] # 100 im : 256x256 pixels => 16x16 segments
label_segments          = data['segLab'] # 100 im : 256 segments x labels
coord_segments          = data['coord'] # 100 im : 256 segments x 4 coordonnees dans l'image
description_segments    = data['feat'] # 100 im: 256 segments x 9 descripteurs RGB
graphes                 = data['graph'] # 100 im: 256 segments x connexions hbgd
labels                 = data['labMeaning'] # signification des etiquettes
#[u'window', u'boat', u'bridge', u'building', u'mountain', u'person', u'plant', u'river', u'road', u'rock', u'sand', u'sea', u'sky', u'sun', u'tree']


# X : 1 segment par ligne
X = np.array([ x for i in range(len(data['feat'])) for x in data['feat'][i]])

# Y : l'etiquette correspondante
Y = np.array([ x for i in range(len(data['segLab'])) for x in data['segLab'][i]])


# definition d'un objet Validation Croisee:
cvk = cv.StratifiedKFold(Y, n_folds=5) # 5 sous-ensembles de donnees
classifier  = lin.LogisticRegression();
k=0
for train_index, test_index in cvk: # parcours des 5 sous-ensembles
    classifier.fit(X[train_index],Y[train_index])
    ypredL = classifier.predict(X[train_index])
    ypredT = classifier.predict(X[test_index])
    print "(RL) iteration ",k," pc good (Learn) ",np.where(ypredL == Y[train_index],1.,0.).sum()/len(train_index)
    print "(RL) iteration ",k," pc good (Test)  ",np.where(ypredT == Y[test_index],1.,0.).sum()/len(test_index)
    k+=1


#apprentissage d'un classifieur
classifier  = lin.LogisticRegression();
classifier2 = nb.MultinomialNB(); # pas propre sur des donnees continues... Mais efficace

classifier.fit(X,Y) # automatiquement multi-classes un-contre-tous
classifier2.fit(X,Y)


# construction des matrices de transistion
def MRFLearn(data):
	nbClass = len(data['labMeaning'])
	Ag=np.ones((nbClass,nbClass))
	Ad=np.ones((nbClass,nbClass))
	Ah=np.ones((nbClass,nbClass))
	Ab=np.ones((nbClass,nbClass))
	for i in range(len(data['segLab'])):
		for j in range(len(data['segLab'][i])):
			if(data['graph'][i][j][0]!=-1):
				Ag[data['segLab'][i][j]][data['segLab'][i][data['graph'][i][j][0]]] += 1
			if(data['graph'][i][j][1]!=-1):
				Ad[data['segLab'][i][j]][data['segLab'][i][data['graph'][i][j][1]]] += 1
			if(data['graph'][i][j][2]!=-1):
				Ah[data['segLab'][i][j]][data['segLab'][i][data['graph'][i][j][2]]] += 1
			if(data['graph'][i][j][3]!=-1):
				Ab[data['segLab'][i][j]][data['segLab'][i][data['graph'][i][j][3]]] += 1
	return  Ag/np.maximum(Ag.sum(1).reshape(nbClass,1),1) ,Ad/np.maximum(Ad.sum(1).reshape(nbClass,1),1), Ah/np.maximum(Ah.sum(1).reshape(nbClass,1),1) ,Ab/np.maximum(Ab.sum(1).reshape(nbClass,1),1)

A = MRFLearn(data)

#Classification par Gibbs Sampling
def GibbsSampling(A,data,classifier):
	# labeling = nbIterationsGibbs x nbNoeuds
	labelEnd = np.array([Counter(labeling[:,j]).most_common(1)[0][0] for j in range(labeling.shape[1])])
	
	classes = np.array([x for x in classifier.predict(X)])
	proba = zeros(len(data['labMeaning']))
	for k in range(20):
		for i in range(len(classes)):
			for j in range(len(data['labMeaning'])):
				if(data['graph'][0]!=0 and data['graph'][1]!=0 and data['graph'][2]!=0 and data['graph'][3]!=0):
					proba[j]=A[0][k][classes[data['graph'][0]]]*A[1][k][classes[data['graph'][1]]]*A[2][k][classes[data['graph'][2]]]*A[3][k][classes[data['graph'][3]]]*classifier.predict_proba(k)
			classes[i]=np.argmax(proba)

	return classes

classes = GibbsSampling(A,data,classifier)








