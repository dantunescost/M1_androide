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
import random  


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
            estChezEnnemi = (indice_courant < n)
        else:
            estChezEnnemi = (indice_courant >= n)
    # mise à jour du camp au trait
    if trait == 'SUD':
        nouvelle_pos['trait'] = 'NORD'
    else:
        nouvelle_pos['trait'] = 'SUD'
    return nouvelle_pos
    
    
    
#---------------------------------- NOS FONCTIONS --------------------------------
# Test si un coup est jouable dans la position donnee pour la case nombre.
# Verifie simplement la presence de graines.
# Ne teste pas si la position resultante sera legale.
def coupJouable(position,nombre):
    n = position['taille']
    tab = position['tablier']
    joueur = position['trait']
    if nombre >= 1 and nombre <= n:
        # Ce test permet d'acceder a la case correspondante a la representation du tablier donnee.
        if (joueur == 'SUD' and tab[nombre-1] > 0) or (joueur == 'NORD' and tab[2*n - nombre] > 0):
            return True
        
    return False
    

# Verifie si un coup est autorise dans la position donnee.
# On test d'abord si le coup est jouable a l'aide de la fonction precedente.
# Si le coup est jouable, on effectue le coup sur une copie de la position pour verifier
# que la position resultante est legale.
# Renvoie False si le coup n'est pas autorise
# Sinon, la fonction renvoie la position obtenue en jouant le coup donne
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
        # Les cases du joueur 'SUD' vont de 0 a n-1
        # Les cases du joueur 'NORD' vont de n a 2*n-1
        if joueur == 'NORD':  
            i += n
            m += n
        while i < m and tab[i] == 0: # On teste si toutes les cases de l'adversaire sont vides
            i+=1
        if i == m:
            return False
        return positionTest
        


# Detecte la fin de la partie, pour les raisons suivantes :
#       - Un joueur a capture suffisamment de graines et remporte la partie.
#       - Le joueur actuel ne dispose d'aucun coup autorise.
# Renvoie False si la partie n'est pas terminee.
# Sinon, affiche le vainqueur ainsi que son nombre de graines puis renvoie True.        
def positionTerminale(position):
    n = position['taille']
    joueur = position['trait']
    # Si un des deux joueurs a capture suffisamment de graines (25 pour un tablier de taille 6)
    if position['graines']['SUD'] >= (n*4)+1: 
        print 'Le grand vainqueur est le joueur SUD. Félicitations vous gagnez avec '+str(position['graines']['SUD'])+' graines!'
        print 'Le joueur NORD a obtenu le score honorable de '+str(position['graines']['NORD'])+' graines!'
        return True
    if position['graines']['NORD'] >= (n*4)+1:
        print 'Le grand vainqueur est le joueur NORD. Félicitations vous gagnez avec '+str(position['graines']['NORD'])+' graines!'
        print 'Le joueur SUD a obtenu le score honorable de '+str(position['graines']['NORD'])+' graines!'
        return True
    
    # Ajout d'une regle lorsqu'un joueur ne peut plus jouer
    # On test egalement si le joueur courant ne dispose d'aucun coup autorise 
    i=1    
    while not coupAutorise(position,i) and i<=6:
        i+=1
    if i > 6: # Si c'est le cas, le joueur adverse gagne les graines restantes et par conséquence, la partie
        if joueur == 'NORD':
            position['graines']['SUD'] += (2*n*4) - position['graines']['SUD'] -position['graines']['NORD']
            print 'Le grand vainqueur est le joueur SUD. Félicitations vous gagnez avec '+str(position['graines']['SUD'])+' graines!'
            print 'Le joueur NORD a obtenu le score honorable de '+str(position['graines']['NORD'])+' graines!'
        else:
            position['graines']['NORD'] += (2*n*4) - position['graines']['SUD'] -position['graines']['NORD']
            print 'Le grand vainqueur est le joueur NORD. Félicitations vous gagnez avec '+str(position['graines']['NORD'])+' graines!'
            print 'Le joueur SUD a obtenu le score honorable de '+str(position['graines']['NORD'])+' graines!'
        return True
    return False
    
    
# Fonction identique a la precedente, les affichages sont retires pour les evaluations de MiniMax et ALphaBeta
def positionTerminaleMinimax(position):
    n = position['taille']
    joueur = position['trait']
    if position['graines']['SUD'] >= (n*4)+1:
        return True
    if position['graines']['NORD'] >= (n*4)+1:
        return True
    i=1    
    while not coupAutorise(position,i) and i<=6:
        i+=1
    if i > 6:
        if joueur == 'NORD':
            position['graines']['SUD'] += (2*n*4) - position['graines']['SUD'] -position['graines']['NORD']
        else:
            position['graines']['NORD'] += (2*n*4) - position['graines']['SUD'] -position['graines']['NORD']
        return True
    return False
    


# Permet a deux joueurs humains de jouer une partie via l'interface console.
# Le tablier est affiche, puis les joueurs entrent leurs coups tour à tour.
# Il sera demande d'entree à nouveau le coup si il n'est pas valide.
def moteurHumains(taille = 6):
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
        
       
# Joue un coup aleatoire sur la position donnee.
def choixAleatoire(position): 
    # On teste si la partie est finie
    if positionTerminale(position):
        return 0
    n = position['taille']
    # On tire un coup aleatoire jusqu'a trouve un coup autorise
    colonne = random.randint(1,n)
    positionTest = coupAutorise(position, colonne)
    while not positionTest:        
        colonne = random.randint(1,n)
        positionTest = coupAutorise(position, colonne)
    return positionTest
    
    
# Permet a un joueur humain de se mesurer a une IA jouant aleatoirement.
def moteurAleatoire(campCPU, taille=6):
    position = initialise(taille)
    
    # Si l'IA joue en premier
    if campCPU == 'SUD':
        position = choixAleatoire(position)
    
    # On boucle en faisant jouer le joueur puis l'IA a tour de role
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
        print "L'ordinateur Aleatoire va jouer."
        position = choixAleatoire(position)
        

# Fonction d'evaluation pour MiniMax et AlphaBeta, version fournie dans l'enonce a l'exercice 2.
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
        

# Fonction qui cherche le meilleur coup possible a la position donnee en appliquant
# le MiniMax jusqu'a atteindre la profondeur donnee.
def evalueMinimax(position,prof):
    (coup,valeur) = (0,0)
    # Si on a atteint la profondeur maximale ou que la partie se termine a cette position,
    # on envoie la valeur de l'evaluation de la position.
    if prof == 0 or positionTerminaleMinimax(position):
        return (0,evaluation(position))
    
    minus_inf = None
    plus_inf = "inf"
    n = position['taille'] + 1
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
        
        
# Fonction qui recupere le coup optimal du MiniMax sur la position et la profondeur donnees 
def choixMinimax(position,prof):
    if positionTerminale(position):
        return 0
    (coup,valeur) = evalueMinimax(position,prof)
    return coup
    
    
# Permet d'affronter l'IA exploitant l'algorithme MiniMax pour choisir ses coups.
def moteurMinimax(campCPU, prof, taille=6):
    position = initialise(taille)
    
    # Si l'IA joue en premier
    if campCPU == 'SUD':
        coup = choixMinimax(position,prof)
        position = joueCoup(position,coup)
        
    # On boucle en faisant jouer le joueur puis l'IA a tour de role
    while not positionTerminale(position):
        affichePosition(position)        
        print 'Le joueur '+position['trait']+' va jouer.'
        saisie = input("Entrez votre coup: ")
        positionT = coupAutorise(position,saisie)
        while not positionT:
            saisie = input ("Coup invalide, veuillez rejouer:")
            positionT = coupAutorise(position,saisie)
        position = positionT
        affichePosition(position)        
        coup = choixMinimax(position,prof)
        if coup <> 0:
            print "L'ordinateur MiniMax va jouer le coup : " + str(coup)
            position = joueCoup(position,coup)
        else:
            print "L'ordinateur ne peut plus jouer!"
        
        
# Fonction qui cherche le meilleur coup possible a la position donnee en appliquant
# AlphaBeta jusqu'a atteindre la profondeur donnee.
def evalueAlphaBeta(position,prof,alpha,beta,feval = 1):
    (coup,valeur) = (0,0)
    
    # Si on a atteint la profondeur maximale ou que la partie se termine a cette position,
    # on envoie la valeur de l'evaluation de la position.
    if prof == 0 or positionTerminaleMinimax(position):
        # On verifie quelle fonction d'evaluation utiliser (celle de l'exercice 2 est par defaut)
        if feval: 
            return (0,evaluation(position))
        else:
            return (0,evaluationbis(position))
        
    n = position['taille'] + 1
    bestCoup = 0
    if position['trait'] == 'SUD':
        i = 1
        while i < n and alpha < beta: 
            child = coupAutorise(position,i)
            if child:
                (coup,valeur) = evalueAlphaBeta(child,prof-1,alpha,beta)
                if valeur > alpha : 
                    alpha = valeur
                    bestCoup = i
            i += 1
        return (bestCoup,alpha)
    else:
        i = 1
        while i < n and alpha < beta:
            child = coupAutorise(position,i)
            if child:
                (coup,valeur) = evalueAlphaBeta(child,prof-1,alpha,beta)
                if valeur < beta : 
                    beta = valeur
                    bestCoup = i
            i += 1
        return (bestCoup,beta)
        

# Fonction qui recupere le coup optimal d'AlphaBeta sur la position et la profondeur donnees 
def choixAlphaBeta(position,prof,feval = 1):
    if positionTerminale(position):
        return 0
    # On verifie quelle fonction d'evaluation utiliser (celle de l'exercice 2 est par defaut)
    if feval: 
        (coup,valeur) = evalueAlphaBeta(position,prof,None,"inf")
    else:
        (coup,valeur) = evalueAlphaBeta(position,prof,None,"inf",0)
    return coup
    
    
# Permet d'affronter l'IA exploitant l'algorithme AlphaBeta pour choisir ses coups.
def moteurAlphaBeta(campCPU, prof, taille = 6):
    position = initialise(taille)
    
    # Si l'IA joue en premier
    if campCPU == 'SUD':
        affichePosition(position)        
        coup = choixAlphaBeta(position,prof)
        print "L'ordinateur AlphaBeta va jouer le coup : " + str(coup)
        position = joueCoup(position,coup)
        
    # On boucle en faisant jouer le joueur puis l'IA a tour de role
    while not positionTerminale(position):
        affichePosition(position)        
        print 'Le joueur '+position['trait']+' va jouer.'
        saisie = input("Entrez votre coup: ")
        positionT = coupAutorise(position,saisie)
        while not positionT:
            saisie = input ("Coup invalide, veuillez rejouer:")
            positionT = coupAutorise(position,saisie)
        position = positionT
        affichePosition(position)        
        coup = choixAlphaBeta(position,prof)
        if coup <> 0:
            print "L'ordinateur AlphaBeta va jouer le coup : " + str(coup)
            position = joueCoup(position,coup)
        else:
            print "L'ordinateur ne peut plus jouer!"
    


# Pour aller plus loin :

# Permet de tester une partie entre 2 IA avec differentes profondeurs pour Alpha-Beta.
# Note : prof1 est utilisee par l'IA au 'SUD'
#        prof2 est utilisee par l'IA au 'NORD'
# La variable affiche permet d'afficher ou non le tablier ainsi que les coups choisis par les IA.
# Dans tous les cas, le vainqueur et le nombre de tours sont indiques.
def moteurIAvsIA(prof1 = 8, prof2 = 8, affiche = False, taille = 6):
    position = initialise(taille)
    nbTours = 0
    while not positionTerminale(position):
        nbTours = nbTours + 1
        if position['trait'] == 'SUD':
            prof = prof1
            feval = 0
        else:
            prof = prof2
            feval = 1
        coup = choixAlphaBeta(position,prof,feval)  
        if coup <> 0:
            if affiche:
                affichePosition(position) 
                print "L'ordinateur " + position['trait'] + " va jouer le coup : " + str(coup)
            position = joueCoup(position,coup)
        else:
            print "L'ordinateur ne peut plus jouer!"

    print "La partie a dure : " + str(nbTours) + " tours !"
    
# Fonction d'evaluation ameliorée
def evaluationbis(position):
    n = position['taille']
    tab = position['tablier']
    if position['graines']['SUD'] >= (n*4)+1:
        return 1000
    if position['graines']['NORD'] >= (n*4)+1:
        return -1000
    cases12sud = 0
    cases12nord = 0    
    voisinMangable1 = False
    voisinMangable2 = False
    for i in range(0,n-1):
        if tab[i] == 1 or tab[i] == 2:
            if voisinMangable1:
                cases12sud += 2
            else:
                cases12sud += 1
            voisinMangable1 = True
        else:
            voisinMangable1 = False
        if tab[i+n] == 1 or tab[i+n] == 2:
            if voisinMangable2:
                cases12nord += 2
            else:
                cases12nord += 1
            voisinMangable2 = True
        else:
            voisinMangable2 = False
    return 2*position['graines']['SUD'] + cases12nord - 2*position['graines']['NORD'] - cases12sud
# ------------------------- TESTS
    
#moteurMinimax('NORD',6)
#moteurAlphaBeta('SUD',9)
moteurIAvsIA(7,7,True)
# ------------------------- FIN TEST















