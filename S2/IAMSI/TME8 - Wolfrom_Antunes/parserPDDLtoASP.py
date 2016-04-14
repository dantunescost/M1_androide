# -*- coding: utf-8 -*-
"""
Created on Thu Apr  7 16:03:27 2016

@author: Wolfrom & Antunes
"""

from subprocess import *


def parseDomain(fileName):
    res = ""
    file = open(fileName,"r")
    titre = file.readline().split()
    res += "%%% " + titre[2][:len(titre[2])-1] + " %%%\n"
    res += "% Déclaration des prédicats (domain)\n"
    t = file.readline()
    while t[1:] != '(:predicates\n':
        t = file.readline()
    while t[1:] != ')\n':
        t = file.readline()
        if t[1:] != ')\n':
            s = t.split()
            name = s[0][1:].replace(")","")
            dict = {}
            for i in range(1,len(s),3):
                if i == len(s)-3:
                    type = s[i+2][:len(s[i+2])-1]
                else:                
                    type = s[i+2]
                var = s[i][1:]
                if dict.has_key(type):
                    dict[type].append(var.upper())
                else:
                    dict[type] = []
                    dict[type].append(var.upper())
            if dict:
                res+="pred("+name+"("
                temp = ''
                for k in dict:
                    lv = dict[k]
                    temp += k+"("
                    for v in lv:
                        temp+=v+';'
                        res+=v+','
                    temp = temp[:len(temp)-1]
                    temp+="),"
                res = res[:len(res)-1]
                temp = temp[:len(temp)-1]+".\n"
                res+=")):-"+temp
            else:
                res+="pred("+name+").\n"
    
    res += "% Déclaration des actions (domain)\n"
    while t != ')\n':
        t = file.readline()
        if t != ')\n':
            s = t.split()
            name = s[1]
            res+='action('+name+'('
            t = file.readline().replace('(', '').replace(')', '')
            s = t.split()
            dict = {}
            for i in range(1,len(s),3):
                type = s[i+2]
                var = s[i][1:]
                if dict.has_key(type):
                    dict[type].append(var.upper())
                else:
                    dict[type] = []
                    dict[type].append(var.upper())
            name+='('
            temp = ''
            for k in dict:
                lv = dict[k]
                temp += k+"("
                for v in lv:
                    temp+=v+';'
                    res+=v+','
                    name+=v+','
                temp = temp[:len(temp)-1]
                temp+="),"
            res = res[:len(res)-1]
            name = name[:len(name)-1]+')'
            temp = temp[:len(temp)-1]+".\n"
            res+=")):-"+temp
            actName = 'action(' + name + ').\n'

            res+='% Préconditions\n'            
            
            t = file.readline().replace('(', '').replace(')', '')
            s = t.split()
            start = 1
            if s[1] == 'and':
                start = 2
            for j in range(start,len(s)):
                pred = s[j]
                if pred[0] == '?':
                    if s[j-1][0] == '?' or s[j-1][0].isupper():
                        res+=','+pred[1].upper()
                    else:
                        res+=pred[1].upper()
                elif pred[0].isupper():
                    if s[j-1][0] == '?' or s[j-1][0].isupper():
                        res+=','+pred.lower()
                    else:
                        res+=pred.lower()
                else:
                    if(j != start):
                        if res[len(res)-1] == '(':
                            res = res[:len(res)-1]+'):-'+actName
                            res+='pre('+name+','+pred+'('
                        else:    
                            res+=')):-'+actName
                            res+='pre('+name+','+pred+'('
                    else:
                        res+='pre('+name+','+pred+'('
            if res[len(res)-1] == '(':
                res = res[:len(res)-1]+'):-'+actName
            else:
                res+=')):-'+actName
            
            res +='% Effets\n'
            t = file.readline().replace('(', '').replace(')', '')
            s = t.split()
            start = 1
            if s[1] == 'and':
                start = 2
            add = True
            for j in range(start,len(s)):
                pred = s[j]
                if pred[0] == '?':
                    if s[j-1][0] == '?' or s[j-1][0].isupper():
                        res+=','+pred[1].upper()
                    else:
                        res+=pred[1].upper()
                elif pred[0].isupper():
                    if s[j-1][0] == '?' or s[j-1][0].isupper():
                        res+=','+pred.lower()
                    else:
                        res+=pred.lower()
                else:
                    if pred == 'not':
                        add = False
                    else:
                        if(j != start):
                            if res[len(res)-1] == '(':
                                res = res[:len(res)-1]+'):-'+actName
                                if add:
                                    res+='add('+name+','+pred+'('
                                else:
                                    res+='del('+name+','+pred+'('
                                add = True
                            else:
                                if not( (j-1==start) and (s[j-1]=='not') ):                           
                                    res+=')):-'+actName
                                if add:
                                    res+='add('+name+','+pred+'('
                                else:
                                    res+='del('+name+','+pred+'('
                                add = True
                        else:
                            if add:
                                res+='add('+name+','+pred+'('
                            else:
                                res+='del('+name+','+pred+'('
                            add = True
            if res[len(res)-1] == '(':
                res = res[:len(res)-1]+'):-'+actName
            else:
                res+=')):-'+actName
                
            file.readline()
        
    return res

def parseProblem(fileName):
    res = ""
    file = open(fileName,"r")
    file.readline()
    file.readline()
    res += "% Déclaration des objets\n"
    obj = file.readline().replace('(', '').replace(')', '')
    s = obj.split()
    l = []
    i = 1
    while i < len(s):
        word = s[i]
        if word[0] == '-':
            type = s[i+1]
            res += type + '('
            for j in range(len(l)):
                res += l[j].lower() + ';'
            res = res[:len(res)-1]+').\n'
            del l[:]
            i += 1
        else:
            l.append(word)
        i += 1
    
    res += '% Etat initial\n'
    init = file.readline().replace('(', '').replace(')', '')
    s = init.split()
    i = 1
    while i < len(s):
        word = s[i]
        if word[0].islower():
            res += 'init(' + word
            if i!=len(s)-1 and s[i+1][0].isupper():
                res += '('
            while i+1<len(s) and s[i+1][0].isupper() : 
                if s[i][0].isupper():
                    res += ','+s[i+1].lower()
                else:
                    res += s[i+1].lower()
                i += 1
            if s[i][0].isupper():
                res += ')).\n'
            else:
                res += ').\n'
            i += 1
            
    res += '% But\n'
    init = file.readline().replace('(', '').replace(')', '')
    s = init.split()
    i = 1
    if s[1] == 'and':
        i = 2
    while i < len(s):
        word = s[i]
        if word[0].islower():
            res += 'but(' + word
            if i!=len(s)-1 and s[i+1][0].isupper():
                res += '('
            while i+1<len(s) and s[i+1][0].isupper() : 
                if s[i][0].isupper():
                    res += ','+s[i+1].lower()
                else:
                    res += s[i+1].lower()
                i += 1
            if s[i][0].isupper():
                res += ')).\n'
            else:
                res += ').\n'
            i += 1
    
            
    return res

# Exercice 5
#res = parseDomain('./SatPlan2006_LinuxBin/singeBananes-domain.pddl')
#res += parseProblem('./SatPlan2006_LinuxBin/singeBananes-problem.pddl')
#res += parseDomain('./SatPlan2006_LinuxBin/blockWorld-domain.pddl')
#res += parseProblem('./SatPlan2006_LinuxBin/blockWorld-problem.pddl')
#file = open('./SatPlan2006_LinuxBin/blockWorld-trad.lp', 'w')
#print res
#file.write(res)



# Exercice 6 question 7-8
i = 1
ok = False
filename = "./clingo-3.0.5-x86-linux/ex6q7.lp"
file = open(filename, 'w')
while not ok and i<3000:
    file = open(filename, 'w')
    res = '#const n = ' + str(i) + '.\n\n'
    res += parseDomain('./SatPlan2006_LinuxBin/blockWorld-domain.pddl')
    res += parseProblem('./SatPlan2006_LinuxBin/blockWorld-problem.pddl')
    res += 'time(0..n).\n'
    res += 'holds(P,0):-init(P),pred(P).\n'
    res += ':- perform(A,T), pre(A,P), not holds(P,T).\n'
    res += 'holds(X,T+1):-perform(A,T),add(A,X),time(T).\n'
    res += 'holds(X,T+1):-holds(X,T),perform(A,T), time(T),not del(A,X).\n'
    res += '1{perform(A,T): action(A)}1:-time(T),T<n.\n'
    res += ':-but(X), not holds(X,n).\n\n'
    
    file.write(res)
    file.close()
    commande = ["./clingo-3.0.5-x86-linux/clingo",filename]
    out=Popen(commande,stdout=PIPE)
    (sout,serr)=out.communicate()
    if sout.find('UNSATISFIABLE') != -1:
        print 'UNSAT avec n=' + str(i)
        i += 1
        file = open(filename, 'w')
        file.truncate(0)
        file.close()
    else:
        ok = True
        print 'Résultat, SAT en : ' + str(i) + ' pas de temps.'
        
    
    
    
file.close()
    

