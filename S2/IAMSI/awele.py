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
    buffer = 'col:'
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
    if position['graines']['SUD'] >= 25 or position['graines']['NORD'] >= 25:
        return True
    i=1    
    while not coupAutorise(position,i) and i<=6:
        i+=1
    if i > 6:
        return True
    
    
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
        
def choixAleatoire(position):    
    n = position['taille']
    tab = position['tablier']
    joueur = position['trait']
    i = 0
    m = n
    if joueur == 'NORD':  
        i += n
        m += n
                
    
    
# ------------------------- POUR VOIR COMMENT CA MARCHE:
    
moteurHumains(6)
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
