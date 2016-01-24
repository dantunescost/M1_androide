# -*- coding: utf-8 -*-
# - - - - - - - - - - -
# IAMSI - 2016
# joueur d'Awélé
# - - - - -
# REM: ce programme a été écrit en Python 3.4
# 
# En salle machine : utiliser la commande "python3"
# - - - - - - - - - - -

# - - - - - - - - - - - - - - - INFORMATIONS BINOME
# GROUPE DE TD : Groupe 2
# NOM, PRENOM  : Wolfrom Matthieu
# NOM, PRENOM  : Antunes Daniel 
# - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - TYPES UTILISES
# POSITION : dictionnaire non vide qui contient différentes informations sur
#            une position d'Awélé, associées au nom de leur champ.
# COUP : valeur entière comprise entre 1 et le nombre de colonnes du tablier

# - - - - - - - - - - - - - - - INITIALISATION
def initialise(n):
    """ int -> POSITION
        Hypothèse : n > 0
        initialise la position de départ de l'awélé avec n colonnes avec 4 dans chaque case.
    """
    position = dict()                                 # initialisation
    position['tablier'] = [4 for k in range(0, 2*n)]  # on met 4 graines dans chaque case
    position['taille'] = n                            # le nombre de colonnes du tablier
    position['trait'] = 'SUD'                         # le joueur qui doit jouer: 'SUD' ou 'NORD'
    position['graines'] = {'SUD':0, 'NORD':0}         # graines prises par chaque joueur
    return position

# - - - - - - - - - - - - - - - AFFICHAGE (TEXTE)
def affichePosition(position):
    """ POSITION ->
        affiche la position de façon textuelle
    """
    print('* * * * * * * * * * * * * * * * * * * *')
    n = position['taille']
    buffer = 'col:       '
    for i in range(0,n):
        buffer += ' ' + str(i+1) + ' \t'
    print(buffer)
    print('\t\tNORD (prises: '+str(position['graines']['NORD'])+')')
    print('< - - - - - - - - - - - - - - -')
    buffer = ''
    for i in range(2*n-1,n-1,-1):   # indices n..(2n-1) pour les cases NORD
        buffer += '\t[' + str(position['tablier'][i]) + ']'
    print(buffer)
    buffer = ''
    for i in range(0,n):            # indices 0..(n-1) pour les cases SUD
        buffer += '\t[' + str(position['tablier'][i]) + ']'
    print(buffer)
    print('- - - - - - - - - - - - - - - >')
    print('\t\tSUD (prises: '+str(position['graines']['SUD'])+')')
    print('-> camp au trait: '+position['trait']);

# - - - - - - - - - - - - - - - CLONAGE
import copy
def clonePosition(position):
    """ POSITION -> POSITION
        retourne un clone de la position
        (qui peut être alors modifié sans altérer l'original donc).
    """
    leclone = dict()
    leclone['tablier'] = copy.deepcopy(position['tablier'])
    leclone['taille']  = position['taille']
    leclone['trait']   = position['trait']
    leclone['graines'] =  copy.deepcopy(position['graines'])
    return leclone

# - - - - - - - - - - - - - - - JOUE UN COUP
def joueCoup(position,coup):
    """ POSITION * COUP -> POSITION
        Hypothèse: coup est jouable.

        Cette fonction retourne la position obtenue une fois le coup joué.
    """
    nouvelle_pos = clonePosition(position)   # on duplique pour ne pas modifier l'original
    n = nouvelle_pos['taille']
    trait = nouvelle_pos['trait']
    # on transforme coup en indice
    if trait == 'SUD':
        indice_depart = coup-1
    else:
        indice_depart = 2*n-coup
    # retrait des graines de la case de départ
    nbGraines = nouvelle_pos['tablier'][indice_depart]
    nouvelle_pos['tablier'][indice_depart] = 0
    # on sème les graines dans les cases à partir de celle de départ
    indice_courant = indice_depart
    while nbGraines > 0:
        indice_courant = (indice_courant + 1) % (2*n)
        if (indice_courant != indice_depart):              # si ce n'est pas la case de départ
            nouvelle_pos['tablier'][indice_courant] += 1   # on sème une graine
            nbGraines -= 1
    # la case d'arrivée est dans le camp ennemi ?
    if (trait == 'NORD'):
        estChezEnnemi = (indice_courant < n)
    else:
        estChezEnnemi = (indice_courant >= n)
    # réalisation des prises éventuelles
    while estChezEnnemi and (nouvelle_pos['tablier'][indice_courant] in range(2,4)):
        nouvelle_pos['graines'][trait] += nouvelle_pos['tablier'][indice_courant]
        nouvelle_pos['tablier'][indice_courant] = 0
        indice_courant = (indice_courant - 1) % (2*n)
        if (trait == 'NORD'):
            estChezEnnemi = (indice_courant <= n)
        else:
            estChezEnnemi = (indice_courant > n)
    # mise à jour du camp au trait
    if trait == 'SUD':
        nouvelle_pos['trait'] = 'NORD'
    else:
        nouvelle_pos['trait'] = 'SUD'
    return nouvelle_pos
    
    
    
#---------------------------------- NOS FONCTIONS --------------------------------
# Test si un coup est jouable dans la position donnee pour la case nombre. 
# Ne teste pas si la position resultante sera legale.
def coupJouable(position,nombre):
    n = position['taille']
    tab = position['tablier']
    joueur = position['trait']
    if nombre >= 1 and nombre <= n:
        if (joueur == 'SUD' and tab[nombre-1] > 0) or (joueur == 'NORD' and tab[2*n - nombre] > 0):
            return True
        
    return False
    

def coupAutorise(position,coup):
    if not coupJouable(position, coup):
        return False
    else:
        positionTest = clonePosition(position)
        positionTest = joueCoup(positionTest, coup)
        n = positionTest['taille']
        m = n
        tab = positionTest['tablier']
        joueur = positionTest['trait']
        i = 0
        if joueur == 'NORD':  
            i += n
            m += n
        while tab[i] == 0 and i < m:
            i+=1
        if i == m:
            return False
        return positionTest
        
def positionTerminale(position):
    n = position['taille']
    joueur = position['trait']
    if position['graines']['SUD'] >= (n*4)+1:
        print 'Le grand vainqueur est le joueur SUD. Félicitations vous gagnez avec '+`position['graines']['SUD']`+' graines!'
        return True
    if position['graines']['NORD'] >= (n*4)+1:
        print 'Le grand vainqueur est le joueur NORD. Félicitations vous gagnez avec '+`position['graines']['NORD']`+' graines!'
        return True
    i=1    
    while not coupAutorise(position,i) and i<=6:
        i+=1
    if i > 6:
        if joueur == 'NORD':
            position['graines']['SUD'] += (2*n*4) - position['graines']['SUD'] -position['graines']['NORD']
            print 'Le grand vainqueur est le joueur SUD. Félicitations vous gagnez avec '+`position['graines']['SUD']`+' graines!'
        else:
            position['graines']['NORD'] += (2*n*4) - position['graines']['SUD'] -position['graines']['NORD']
            print 'Le grand vainqueur est le joueur NORD. Félicitations vous gagnez avec '+`position['graines']['NORD']`+' graines!'
        return True
    return False
    
    
def moteurHumains(taille):
    position = initialise(taille)
    while not positionTerminale(position):
        affichePosition(position)        
        print 'Le joueur '+position['trait']+' va jouer.'
        saisie = input("Entrez votre coup: ")
        positionT = coupAutorise(position,saisie)
        while not positionT:
            saisie = input ("Coup invalide, veuillez rejouer: ")
            positionT = coupAutorise(position,saisie)
        position = positionT
        
import random         

def choixAleatoire(position): 
    if positionTerminale(position):
        return 0
    n = position['taille']
    colonne = random.randint(1,n)
    positionTest = coupAutorise(position, colonne)
    while not positionTest:        
        colonne = random.randint(1,n)
        positionTest = coupAutorise(position, colonne)
    return positionTest
    
def moteurAleatoire(taille, campCPU):
    position = initialise(taille)
    if campCPU == 'SUD':
        position = choixAleatoire(position)
    while not positionTerminale(position):
        affichePosition(position)        
        print 'Le joueur '+position['trait']+' va jouer.'
        saisie = input("Entrez votre coup: ")
        positionT = coupAutorise(position,saisie)
        while not positionT:
            saisie = input ("Coup invalide, veuillez rejouer: ")
            positionT = coupAutorise(position,saisie)
        position = positionT
        affichePosition(position)        
        print "L'ordinateur va jouer."
        position = choixAleatoire(position)
        
        
def evaluation(position):
    n = position['taille']
    tab = position['tablier']
    if position['graines']['SUD'] >= (n*4)+1:
        return 1000
    if position['graines']['NORD'] >= (n*4)+1:
        return -1000
    cases12sud = 0
    cases12nord = 0    
    for i in range(0,n-1):
        if tab[i] == 1 or tab[i] == 2:
            cases12sud += 1
        if tab[i+n] == 1 or tab[i+n] == 2:
            cases12nord += 1
    return 2*position['graines']['SUD'] + cases12nord - 2*position['graines']['NORD'] - cases12sud
        

def evalueMinimax(position,prof):
    (coup,valeur) = (0,0)
    if prof == 0 or positionTerminale(position):
        return (0,evaluation(position))
    
    minus_inf = None
    plus_inf = "inf"
    n = position['taille']
    bestCoup = 0
    if position['trait'] == 'SUD':
        bestValue = minus_inf
        for i in range(1,n):
            child = coupAutorise(position,i)
            if child:
                (coup,valeur) = evalueMinimax(child,prof-1)
                if valeur > bestValue : 
                    bestValue = valeur
                    bestCoup = i
        return (bestCoup,bestValue)
    else:
        bestValue = plus_inf
        for i in range(1,n):
            child = coupAutorise(position,i)
            if child:
                (coup,valeur) = evalueMinimax(child,prof-1)
                if valeur < bestValue : 
                    bestValue = valeur
                    bestCoup = i
        return (bestCoup,bestValue)
        

def choixMinimax(position,prof):
    if positionTerminale(position):
        return 0
    (coup,valeur) = evalueMinimax(position,prof)
    return coup
    
def moteurMinimax(taille, campCPU, prof):
    position = initialise(taille)
    if campCPU == 'SUD':
        coup = choixMinimax(position,prof)
        position = joueCoup(position,coup)
    while not positionTerminale(position):
        affichePosition(position)        
        print 'Le joueur '+position['trait']+' va jouer.'
        saisie = input("Entrez votre coup: ")
        positionT = coupAutorise(position,saisie)
        while not positionT:
            saisie = input ("Coup invalide, veuillez rejouer: ")
            positionT = coupAutorise(position,saisie)
        position = positionT
        affichePosition(position)        
        print "L'ordinateur va jouer."
        coup = choixMinimax(position,prof)
        position = joueCoup(position,coup)
    
    
# ------------------------- POUR VOIR COMMENT CA MARCHE:
    
moteurMinimax(6,'NORD',5)
#maPosition = initialise(6)
#affichePosition(maPosition)
#maPosition2 = joueCoup(maPosition,1) # SUD joue
#maPosition2 = joueCoup(maPosition2,1) # NORD joue
##maPosition2 = joueCoup(maPosition2,2) # SUD joue
##maPosition2 = joueCoup(maPosition2,4) # NORD joue
##maPosition2 = joueCoup(maPosition2,3) # SUD joue
##maPosition2 = joueCoup(maPosition2,2) # NORD joue
##maPosition2 = joueCoup(maPosition2,5) # SUD joue
#affichePosition(maPosition2)
#print("------\nPartie sur un tablier réduit pour tester:")
##maPosition = initialise(3)
#affichePosition(maPosition)
#maPosition2 = joueCoup(maPosition,1) # SUD joue
#maPosition2 = joueCoup(maPosition2,1) # NORD joue
#maPosition2 = joueCoup(maPosition2,3) # SUD joue
#maPosition2 = joueCoup(maPosition2,3) # NORD joue
#maPosition2 = joueCoup(maPosition2,1) # SUD joue
#maPosition2 = joueCoup(maPosition2,1) # NORD joue
#affichePosition(maPosition2)
# ------------------------- FIN TEST
