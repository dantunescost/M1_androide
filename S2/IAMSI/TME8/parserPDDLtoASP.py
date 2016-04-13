# -*- coding: utf-8 -*-
"""
Created on Thu Apr  7 16:03:27 2016

@author: Wolfrom & Antunes
"""



######################################################
######################################################
######################################################
######################################################
#######
#######         TO-DO : gérer constantes dans precondition et effet (check [0] isUpperCase)
#######                 les fichiers problem aussi (facile)
#######
######################################################
######################################################
######################################################
######################################################








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
                for k in dict:
                    lv = dict[k]
                    temp = k+"("
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
            for k in dict:
                lv = dict[k]
                temp = k+"("
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
                    if s[j-1][0] == '?':
                        res+=','+pred[1].upper()
                    else:
                        res+=pred[1].upper()
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
                    if s[j-1][0] == '?':
                        res+=','+pred[1].upper()
                    else:
                        res+=pred[1].upper()
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



print parseDomain('./SatPlan2006_LinuxBin/blockWorld-domain.pddl')

